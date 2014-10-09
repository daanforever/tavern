# == Schema Information
#
# Table name: instances
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  disabled       :boolean
#  port_public    :integer
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

    event :run do
      transitions from: :stopped, to: :running, guard: :run_instance
    end

    event :stop do
      transitions from: :running, to: :stopped, guard: :stop_instance
    end
  end

  protected
    def set_image
      self.image = self.component.images.find_by(release: self.environment.release)
    end

  def run_instance
    Rails.logger.debug("Image: #{image.name}")
    true
  end

  def stop_instance
    true
  end

  # def release
  #   self.component.releases.active.first
  # rescue
  #   errors.add(:image, "Unable to find active release for component '#{self.component.to_s}'")
  #   false
  # end

end
