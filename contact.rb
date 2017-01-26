gem 'activerecord', '=4.2.7'
require 'active_record'
require 'mini_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crm-web.sqlite3')


class Contact
  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :note

  @@contacts = []
  @@next_id = 1

  def initialize(first_name, last_name, email, note)
    @id = @@next_id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note

    @@next_id += 1
  end


  def self.create(first_name, last_name, email, note)
    new_contact = Contact.new(first_name, last_name, email, note)
    @@contacts << new_contact
    return new_contact

  end

  def self.all
    @@contacts
  end

  def self.find(by_id)
    @@contacts.each do |contact|
      if contact.id == by_id
        return contact
      end
    end

    contact = nil
  end


  def update(attribute, new_value)
    #self.send("#{attribute}=", new_value)
    if attribute == "email"
      self.email = new_value
    elsif attribute == "first_name"
      self.first_name = new_value
    elsif attribute == "last_name"
      self.last_name = new_value
    elsif attribute == "note"
      self.note = new_value
     end
  end


  def self.find_by(attribute, value)
    @@contacts.each do |contact|
      if contact.send(attribute) == value
        return contact
      end
    end
    nil
  end


  def self.delete_all
    @@contacts = []
    #empties array but does not delete contacts
  end

  def full_name
    "#{first_name} #{last_name}"
  end

def delete
  @@contacts.delete(self)
end


end
