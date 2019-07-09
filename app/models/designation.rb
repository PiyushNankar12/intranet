class Designation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  has_many :users

  validates :name, presence: true, uniqueness: true
end
