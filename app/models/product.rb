class Product < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings

  def tags_as_csv
    tags.map(&:label)
  end
end
