class User < ApplicationRecord
  # Constants first
  ROLES = %w[super_admin pizza_store_owner pizza_chef].freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enums
  enum :role, {
    super_admin: 0,
    pizza_store_owner: 1,
    pizza_chef: 2
  }

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true

  # Scopes
  scope :by_role, ->(role) { where(role: role) }

  # Instance methods
  def full_name
    "#{first_name} #{last_name}"
  end

  def can_manage_toppings?
    super_admin? || pizza_store_owner?
  end

  def can_manage_pizzas?
    super_admin? || pizza_chef?
  end

  def can_manage_users?
    super_admin?
  end
end
