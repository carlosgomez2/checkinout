class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # User cannot be created without name and last_name
  validates_presence_of :name, :last_name

  has_many :working_days

  # Search function
  def self.search(search)
    key = "%#{search}%"
    if search
      where(["name ILIKE :search OR last_name ILIKE :search OR email ILIKE :search OR gender ILIKE :search", search: key])
    else
      false
    end
  end

  # Display full name
  def full_name
    last_name.capitalize + ', ' + name.capitalize
  end
end
