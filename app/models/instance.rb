# == Schema Information
#
# Table name: instances
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  disabled       :boolean
#  public_port    :integer
#  container      :string(255)
#  properties     :text
#  image_id       :integer
#  component_id   :integer
#  host_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#  state          :integer
#  environment_id :integer
#  private_port   :integer
#  options        :text
#

class Instance < ActiveRecord::Base
  belongs_to :image
  belongs_to :component
  belongs_to :host
  belongs_to :environment

  before_validation :set_image
  validates :environment, :host, :component, :public_port, :private_port, :image, presence: true

  serialize :properties

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
    self.starting!
    self.delay.start!
  end

  def stop
    self.stopping!
    self.delay.stop!
  end

###############################################################################
# Delayed jobs

  def start!
    self.running!
    logger.info("Instance#start: name:'#{self.name}', image:'#{self.image.name}', host:'#{self.host.url}' ")
    connection = Docker::Connection.new(self.host.url, {})
    Docker::Container.create({'Image' => self.image.name}, connection)
  end

  def stop!
    self.stopped!
  end

#
###############################################################################


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

  protected
    def set_image
      self.image ||= self.component.images.find_by(release: self.environment.release)
    end

  # def release
  #   self.component.releases.active.first
  # rescue
  #   errors.add(:image, "Unable to find active release for component '#{self.component.to_s}'")
  #   false
  # end

end
