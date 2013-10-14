require 'test_helper'

describe FruitLot do 

  subject { FruitLot.new }

  describe "db" do 

		describe "columns and types" do 

      it { must have_db_column(:brix).of_type(:decimal) }
      it { must have_db_column(:weight).of_type(:decimal) }
      it { must have_db_column(:harvest_date).of_type(:date) }
      it { must have_db_column(:wine_id).of_type(:integer) }
      it { must have_db_column(:vineyards_vintage_id).of_type(:integer) }
		end

    describe "indexes" do 

      it { must have_db_index(:wine_id) }
      it { must have_db_index(:vineyards_vintage_id) }
    end
	end

	describe "associations" do 

    it { must belong_to(:vineyards_vintage) }
    it { must have_many(:fruit_lots_wines) }
    it { must have_many(:wines).through(:fruit_lots_wines) }
	end
end