class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :products, through: :taggings

  def self.tagged_with(name)
    Tag.find_by_name!(name).products
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end
end
