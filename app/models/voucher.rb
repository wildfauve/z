class Voucher
  
  include Mongoid::Document

  field :unit, :type => Integer
  field :burned, :type => Boolean
  
  embedded_in :member, :inverse_of => :vouchers
  belongs_to :trigger

end