# == Schema Information
#
# Table name: instances
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  disabled       :boolean
#  port           :integer
#  container      :string(255)
#  properties     :text
#  image_id       :integer
#  component_id   :integer
#  host_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#  state          :integer
#  environment_id :integer
#

class Instance < ActiveRecord::Base
  belongs_to :image
  belongs_to :component
  belongs_to :host
  belongs_to :environment

  validates :environment, :host, :component, :port, :image, presence: true

  enum state: {
    stopped: 0,
    starting: 1,
    running: 2,
    stoping: 3,
    unknown: 4
  }

  include AASM

  aasm column: :state, enum: true, whiny_transitions: false do
    state :stopped, initial: true
    state :starting
    state :running
    state :stoping
    state :unknown

    event :starting! do
      transitions from: :stopped, to: :starting
    end

    event :running! do
      transitions from: [:unknown, :starting], to: :running
    end

    event :stoping! do
      transitions from: :running, to: :stoping
    end

    event :stopped! do
      transitions from: [:unknown, :starting, :stoping], to: :stopped
    end

    event :unknown! do
      transitions from: [:stopped, :starting, :running, :stoping], to: :unknown
    end

  end

  # def release
  #   self.component.releases.active.first
  # rescue
  #   errors.add(:image, "Unable to find active release for component '#{self.component.to_s}'")
  #   false
  # end

end
