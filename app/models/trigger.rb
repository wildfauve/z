class Trigger
  
  include Mongoid::Document
  
  field :name, :type => String
  field :earn_on_free, :type => Boolean
  field :threshold, :type => Integer
  field :auto_burn, :type => Boolean
  field :auto_voucher, :type => Boolean
  field :adjustment, :type => Integer
  field :potential_voucher_on_threshold, :type => Boolean
  field :voucher_value, :type => Integer
  
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