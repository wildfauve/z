class Card
  
  include Mongoid::Document

  field :unit, :type => Integer
  field :burned, :type => Boolean
  
  embedded_in :currency, :inverse_of => :cards

end