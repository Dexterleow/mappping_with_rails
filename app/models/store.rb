class Store < ActiveRecord::Base
  geocoded_by :adress
  after_validation :geocode

  def self.search(search,type)
    if search

      case type
      when "name"
        where('name LIKE ?', "%#{search}%")
      when "adress"
        where('adress LIKE ?', "%#{search}%")
      when "title"
        where('title LIKE ?', "%#{search}%")
      end
    else
      all
    end
  end


end
