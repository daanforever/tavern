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

  # Container present?
  # |\_ (yes) Found container by Id?
  # |  |\_ (yes) Container started?
  # |  | |\_(no) Container.start
  # |  | | \_ Container started?
  # |  | |  \_ (no) Set error state
  # |  |  \_(yes) Update status
  # |   \_ (no) Proceed as new container
  # |
  #  \_ (no) Image present?
  #   |\_ (no) Create image
  #   |\_ (yes) Good
  #   |/ 
  #    \_ Create container
  #     \_ Start container
  #      \_ Update status

  def start!

    logger.info("Instance#start!: id:'#{self.id}', image:'#{self.image.name}:#{self.image.release.name}', host:'#{self.host.url}' ")

    if docker.container.exist?

      if docker.container.running?
        logger.info("Instance#start!: instance id:#{self.id} already running")
        self.running!
      elsif docker.container.start
        logger.info("Instance#start!: instance id:#{self.id} started!")
        self.running!
      else
        logger.error("Instance#start!: instance id:#{self.id} run error!")
        self.failed! unless self.failed?
      end

    else # container doesn't exist

      if docker.image.exist?
        logger.info("Instance#start!: image #{self.image.name} exist")
      else # image doesn't exist
        logger.info("Instance#start!: image #{self.image.name} not exists")
        if docker.image.pull
          logger.info("Instance#start!: pulling image #{self.image.name} complete")
        else
          logger.error("Instance#start!: pulling image #{self.image.name} error!")
          self.failed! unless self.failed?
        end
      end

      if docker.image.exist?
        if docker.container.start
          logger.info("Instance#start!: instance id:#{self.id} started!")
          self.running!
        else
          logger.error("Instance#start!: instance id:#{self.id} run error!")
          self.failed! unless self.failed?
        end
      else
        logger.error("Instance#start!: skipped without image for instance id:#{self.id}")
        self.failed! unless self.failed?
      end

    end


  end

  def stop!
    self.stopped! if docker.container.stop
  end

#
###############################################################################


  def docker
    @docker ||= Docker::Shell.new( instance: self )
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
