class Property < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude

  RANDOM_ADJECTIVES = %w(beautiful nice lovely spacious large cozy unique trendy)
  RANDOM_HOME = %w(home mansion condo lot apartment shack flat house)
  HOME_BASE = { :latitude => 0.0, :longitude => 0.0 }

  attr_accessible :name, :latitude, :longitude, :bedroom_count

  # Generates a dummy Property value and saves it to the DB
  def self.search(query)
    if query.blank?
      find(:all)
    else
      find(:all, :conditions => ["name LIKE ?", "%#{query}%"])
    end
  end

  def self.generate
    property = Property.new
    property.assign_attributes({
      :name => "#{RANDOM_ADJECTIVES.sample} #{RANDOM_HOME.sample}",
      :bedroom_count => rand(8) + 1,
      :latitude => HOME_BASE[:latitude] + (rand() * 50 - 25),
      :longitude => HOME_BASE[:longitude] + (rand() * 50 - 25)
    })
    property.save!
    property
  end
end
