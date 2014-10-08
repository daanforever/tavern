# == Schema Information
#
# Table name: hosts
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  description    :string(255)
#  url            :string(255)
#  disabled       :boolean
#  info           :text
#  created_at     :datetime
#  updated_at     :datetime
#  environment_id :integer
#

class Host < ActiveRecord::Base
  belongs_to :environment
  has_many   :instances

  before_validation :set_name
  validates :url, presence: true
  # validates :name, uniqueness: true

  protected 
  def set_name
    self.name = URI.parse(self.url).host if self.name.blank?
  end
end
