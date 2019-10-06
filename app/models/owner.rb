
class Owner < ActiveRecord::Base
  has_many :autos
  has_many :buyers, :through => :autos

  def slug
    name.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    return Owner.all.find{|owner| owner.slug == slug}
  end
end
