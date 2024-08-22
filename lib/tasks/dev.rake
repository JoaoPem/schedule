namespace :dev do
  desc "Configurando ambiente de desenvolvimeto"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Dropping DB...") {%x(rails db:drop)}
      show_spinner("Creating DB...") {%x(rails db:create)}
      show_spinner("Migrating DB...") {%x(rails db:migrate)}
      show_spinner("Registering Contacts types...") {%x(rails dev:add_kind)}
      show_spinner("Registering Contacts...") {%x(rails dev:add_contact)}
      show_spinner("Registering Phones...") {%x(rails dev:add_phone)}
      show_spinner("Registering Address...") {%x(rails dev:add_address)}
    else
      puts "You aren't in the development environment!"
    end
  end

  desc "Add Contacts"
  task add_contact: :environment do
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind: Kind.all.sample
      )
    end
  end
  

  desc "Add contacts types"
  task add_kind: :environment do
    kinds = %w(Amigo Comercial Conhecido)
    kinds.each do |kind_description|
      Kind.create!(
        description: kind_description
      )
    end
  end  

  desc "Add Phones"
  task add_phone: :environment do
    Contact.all.each do |contact|
      Random.rand(1..5).times do
        contact.phones.create!(number: Faker::PhoneNumber.cell_phone)
      end
    end
  end

  desc "Add Address"
  task add_address: :environment do
    Contact.all.each do |contact|
      Address.create(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end
  end

  private

  def show_spinner(msg_start, msg_end = "Done!!!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

end
