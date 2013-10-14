require "test_helper"

describe Carousel do 

  subject { Carousel.new }

  describe "db" do 

    describe "columns and types" do 

      it { must have_db_column(:carousable_type).of_type(:string) }
      it { must have_db_column(:carousable_id).of_type(:integer) }
      it { must have_db_column(:image_id).of_type(:integer) }
    end

    describe "indexes" do 

      it { must have_db_index([:carousable_id, :carousable_type]) }
      it { must have_db_index(:image_id) }
    end
  end

  describe "associations" do 

    it { must belong_to(:image) }
    it { must belong_to(:carousable) }
  end
end