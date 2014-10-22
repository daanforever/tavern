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
  }

  include AASM

  aasm column: :state, enum: true, whiny_transitions: false do
    state :stopped, initial: true
    state :running
    state :unknown

    event :running do
      transitions from: [:stopped, :unknown], to: :running
    end

    event :stopped do
      transitions from: [:running, :unknown], to: :stopped
    end

    event :unknown do
      transitions from: [:running, :stopped], to: :unknown
    end
  end

  def run!
    return false if self.running?
    connection = Docker::Connection.new(self.host.url, {})
    self.running!
  rescue Exception => e
    errors.add(:instance, e)
    e
  end

  def stop!
    connection = Docker::Connection.new(self.host.url, {})
    self.stopped!
    true
  end

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
