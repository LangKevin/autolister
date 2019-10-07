class Auto < ActiveRecord::Base
  belongs_to :owner
  has_many :auto_buyers
  has_many :buyers, through: :auto_buyers

  def slug
    name.downcase.gsub(" ","-")
  end
  def name
    return year + ' ' + make + ' ' + model + ' ' + price
  end
  def self.find_by_slug(slug)
    return Auto.all.find { |auto| auto.slug == slug }
  end
end
