class Buyer < ActiveRecord::Base
  belongs_to :user
  has_many :auto_buyers
  has_many :autos, through: :auto_buyers
  has_many :owners, through: :autos

  def slug
    name.downcase.tr(' ', '-')
  end

  def self.find_by_slug(slug)
    return Buyer.all.find { |buyer| buyer.slug == slug }
  end
end
