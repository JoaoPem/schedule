class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate

  belongs_to :kind do
    link(:related) {contact_kind_url(object.id)}
  end
  has_many :phones do
    link(:related) {contact_phones_url(object.id)}
  end
  has_one :address do
    link(:related) {contact_address_url(object.id)}
  end

  # link(:self) {contact_url(object.id)}
  # link(:kind) {contact_kind_url(object.id)}
  # link(:phones) {contact_phone_url(object.id)}

  meta do 
    {author: "João Pedro M."}
  end

  def attributes(*args)
    h = super
    h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    h
  end
end
