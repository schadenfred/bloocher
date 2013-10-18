namespace 'db:development:create' do 

  task producers: :environment do 

    Faker::Bloocher.producers.each do |producer_name|
      producer = Producer.new(
        name: producer_name
      )
      producer.save!

      small_notice("producer: #{producer.name}")
    end
  end
end