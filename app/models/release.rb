# == Schema Information
#
# Table name: releases
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  label       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  project_id  :integer
#  state       :integer
#

class Release < ActiveRecord::Base
  include AASM

  belongs_to              :project
  has_and_belongs_to_many :components

  before_create           :set_label

  validates :name, presence: true

  scope :ordered, -> { order(:name) }

  enum state: {
    inactive: 0,
    active:   1
  }

  aasm column: :state, enum: true, whiny_transitions: false do
    state :inactive, initial: true
    state :active, before_enter: :deactivate_previous

    event :activate do
      transitions from: :inactive, to: :active
    end

    event :deactivate do
      transitions from: :active, to: :inactive
    end

  end

  def deactivate_previous
    ap Release.active.to_a
    Release.active.each { |r| r.deactivate! }
  end

  protected
  def set_label
    label ||= name
  end

end
