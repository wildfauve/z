class Member
  
  include Mongoid::Document
  
  has_many :txn
  
  field :name, :type => String
  field :points, :type => Integer
  field :vouchers, :type => Integer
  field :total_pts, :type => Integer
  field :voucher_on_next, :type => Boolean
  
  def self.create_it(params)
    mbr = self.new(params)
    mbr.vouchers = 0
    mbr.points = 0
    mbr.total_points = 0  
    mbr.voucher_on_next = false
    mbr.save!
#    Rails.logger.info(">>>Type#create_the_type #{type.properties.count}")     
    return mbr
  end

  def update_it(params)
    self.attributes = params       
    save!
    return self
  end
  
  def balance
    self.points
  end
  
  def update_points(qty, remove=false)
    Rails.logger.info(">>>Mbr#update_points Qty: #{qty}, Current Points: #{self.points}")     
    if remove
      Rails.logger.info(">>>Mbr#update_points remove threshold")
      self.points -= qty
    else
      self.points += qty
      self.total_pts += qty
    end
    Rails.logger.info(">>>Mbr#update_points Points Update: #{self.points}")         
    save!    
  end
  
  def add_voucher(qty)
    Rails.logger.info(">>>Mbr#add_voucher Qty: #{qty}, Current Points: #{self.points}")         
    self.vouchers += 1
    self.total_pts += qty
    self.voucher_on_next = false
    save!
  end
  
  def reset
    self.vouchers = 0
    self.points = 0
    self.total_pts = 0
    self.voucher_on_next = false
    save!
  end
  
  def create_voucher_on_next
    Rails.logger.info(">>>Mbr#voucher_on_next ")             
    self.voucher_on_next = true
    save!
  end
  
  def burn_voucher
    Rails.logger.info(">>>Mbr#burn_voucher")
    raise Exceptions::NoVoucherError if self.vouchers < 1
    self.vouchers -= 1
    self.points -= Trigger.first.voucher_value
    self.save!
  end
  
end