require 'spec_helper'

describe VineyardVintage do

	describe "database" do 
		
		describe "columns" do 

			%w[vineyard_id growing_degree_days 
				days_above_100 days_of_frost].each do |column| 
				it { should have_db_column(column.to_sym).of_type(:integer) }
			end

			%w[bud_break bloom_date veraison last_frost].each do |column|
				it { should have_db_column(column.to_sym).of_type(:date) }
			end

			it { should have_db_column(:average_yearly_rel_hum).of_type(:decimal) }
		end
	end

	describe "security" do 

	end

	describe "validations" do 

	end

	describe "associations" do 

		it { should belong_to(:vineyard) }
		it { should have_many(:fruit_lots) }

	end

	describe "methods" do 

		it { should respond_to(:vintage) }

	  Given(:vineyard_vintage) { FactoryGirl.create(:vineyard_vintage) }

		describe "it should have a vintage equal to the veraison year" do 

			Then { vineyard_vintage.vintage.should eq vineyard_vintage.veraison.year }


		end 
	

	end

end
