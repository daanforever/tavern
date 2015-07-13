# == Schema Information
#
# Table name: instances
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  disabled       :boolean
#  container      :string(255)
#  properties     :text
#  image_id       :integer
#  component_id   :integer
#  host_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#  state          :integer
#  environment_id :integer
#  options        :text
#

class Instance < ActiveRecord::Base
  belongs_to :image
  belongs_to :component
  belongs_to :host
  belongs_to :environment

  after_initialize :set_properties
  before_save :update_properties
  serialize :properties

  before_validation :set_image
  validates :environment, :host, :component, :image, presence: true

  attr_accessor :volumes, :ports

  enum state: {
    stopped: 0,
    running: 1,
    starting: 2,
    stopping: 3,
    unknown: 4,
    failed: 5
  }

  include AASM

  aasm column: :state, enum: true, whiny_transitions: false do
    state :stopped, initial: true
    state :starting
    state :running
    state :stopping
    state :unknown
    state :failed

    event :starting do
      transitions from: [:stopped,  :unknown], to: :starting
    end

    event :running do
      transitions from: [:starting, :unknown, :failed], to: :running
    end

    event :stopping do
      transitions from: [:running,  :unknown], to: :stopping
    end

    event :stopped do
      transitions from: [:stopping, :unknown, :failed], to: :stopped
    end

    event :unknown do
      transitions from: [:stopped, :starting, :running, :stopping], to: :unknown
    end

    event :failed do
      transitions from: [:starting, :stopping], to: :failed
    end
  end

  def start
    if self.starting! and self.may_running?
      self.delay.start!
    else
      false
    end
  end

  def stop
    if self.stopping! and self.may_stopped?
      self.delay.stop!
    else
      false
    end
  end

###############################################################################
# Delayed jobs

# => Instance

  def start!

    logger.info("Instance#start!: id:'#{self.id}', image:'#{self.image.name}:#{self.image.release.name}', host:'#{self.host.url}' ")

    return self.running! if docker.container.running?
    return self.failed!  unless docker.image.exist? or docker.image.pull

    if docker.container.start
      self.running!
    else
      self.failed! unless self.failed?
    end

  end

  def stop!
    self.stopped! if docker.container.stop
  end

#
###############################################################################


  def docker
    @docker ||= Docker::Shell.new( host: self.host.url, instance: self )
  end

  # def run
  #   return false if self.running?
  #   logger.info connection
  #   self.running!
  # rescue Exception => e
  #   errors.add(:instance, e)
  #   e
  # end

  # def stop
  #   self.stopped!
  #   true
  # end

  def volumes
    @volumes ||= properties.volumes
  end

  protected
    def set_image
      self.image ||= self.component.images.find_by(release: self.environment.release)
    end

    def set_properties
      self.properties ||= OpenStruct.new
      @volumes ||= self.properties.volumes ||= [{external: '', internal: ''}]
      @ports   ||= self.properties.ports   ||= [{public: '', private: ''}]
    end

    def update_properties
      self.properties.volumes = @volumes
      self.properties.ports   = @ports
    end

  # def release
  #   self.component.releases.active.first
  # rescue
  #   errors.add(:image, "Unable to find active release for component '#{self.component.to_s}'")
  #   false
  # end

end
