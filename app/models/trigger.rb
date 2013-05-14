class Trigger
  
  include Mongoid::Document
  
  has_many :txn
  
  field :currency_name, :type => String
  field :earn_on_free, :type => Boolean
  field :threshold, :type => Integer
  field :auto_burn, :type => Boolean
  field :auto_voucher, :type => Boolean
  field :earn_adjustment, :type => Integer
  field :potential_voucher_on_threshold, :type => Boolean
  field :voucher_value, :type => Integer
  field :number_of_vouchers, :type => Integer
  field :burn_adj, :type => Integer  
  field :earn_context, :type => String
  field :expires_in, :type => Date
  
  def self.create_it(params)
    trig = self.new(params)  
    trig.save!
#    Rails.logger.info(">>>Type#create_the_type #{type.properties.count}")     
    return trig
  end

  def update_it(params)
    self.attributes = params       
    save!
    return self
  end
  
  
end