require 'test_helper'

class PropertyTest < ActiveSupport::TestCase
  # Normally would use rspec + factory girl
  # Choosing to keep it vanilla for simplicity
  test "should find nearby properties" do
    property = Property.generate
    nearby_property_one = Property.generate
    nearby_property_two = Property.generate

    nearby_property_one.update_attributes({
      :latitude => property.latitude,
      :longitude => property.longitude
    })

    nearby_property_two.update_attributes({
      :latitude => property.latitude - 0.05,
      :longitude => property.longitude + 0.05
    })

    far_away_property = Property.generate
    far_away_property.update_attributes({
      :latitude => property.latitude + 1,
      :longitude => property.longitude + 1
    })

    # Property.near will include the property itself, so add one to the expected size
    assert Property.near([property.latitude, property.longitude], 20, :units => :km).size == 3
    assert Property.near([far_away_property.latitude, far_away_property.longitude], 20, :units => :km).size == 1
    assert Property.near([property.latitude, property.longitude], 1000, :units => :km).size == 4
  end
end
