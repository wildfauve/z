class Member
  
  attr_accessor :currency
  
  include Mongoid::Document
  
  has_many :txn
  embeds_many :currencies
  embeds_many :vouchers
  
  field :name, :type => String
  
  def self.create_it(params)
    mbr = self.new(params)
    mbr.save!
#    Rails.logger.info(">>>Type#create_the_type #{type.properties.count}")     
    return mbr
  end
  
  def self.resetall
    self.all.each {|m| m.reset}
  end
  
  def selected_currency=(trigger)
   Rails.logger.info(">>>Member#selected_currency #{@currency.inspect}")          
   @currency = Currency.findfactory(self, trigger)
  end

  def update_it(params)
    self.attributes = params
    save!
    return self
  end
    
  def update_points(qty, remove=false)
    Rails.logger.info(">>>Mbr#update_points Qty: #{qty}, Current Points: #{@currency.points}")     
    if remove
      Rails.logger.info(">>>Mbr#update_points remove threshold")
      @currency.points -= qty
    else
      @currency.points += qty
      @currency.total_pts += qty
    end
    Rails.logger.info(">>>Mbr#update_points Points Update: #{@currency.points}")         
    save!    
  end
  
  def add_voucher(qty, trigger)
    Rails.logger.info(">>>Mbr#add_voucher Qty: #{qty}, Current Points: #{@currency.points}")
    @currency.create_card(qty)
    Rails.logger.info(">>>Mbr#add_voucher currency: #{@currency.inspect}")    
    save!
  end
  
  def reset
    self.currencies = nil
    save!
  end
  
  def create_voucher_on_next(trigger)
    Rails.logger.info(">>>Mbr#voucher_on_next ")             
    @currency.create_voucher_on_next
    save!
  end
    
  def burn_card(params)
    Rails.logger.info(">>>Mbr#burn_card; #{params.inspect}")     
     @currency = self.currencies.find(params[:currency])
     @currency.burn_card(:card => params[:card])
     self.save!
  end
    
end