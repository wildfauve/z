class Txn
  
  include Mongoid::Document
  
  belongs_to :member
  
  field :order_qty, :type => Integer
  
  def self.create_it(params, mbr)
    txn = self.new(params)
    self.calc_points(txn.order_qty, mbr)
    raise Exceptions::NoMemberError if mbr.nil?
    txn.member = mbr
    txn.save!
#    Rails.logger.info(">>>Type#create_the_type #{type.properties.count}")     
    return txn
  end

  def update_it(params)
    self.attributes = params       
    save!
    return self
  end
  
  def self.calc_points(qty, mbr)
    Rails.logger.info(">>>Txn#calc_points Start Qty: #{qty},  Current Member Points: #{mbr.points}")     
    trigger = Trigger.first
    calc = mbr.balance + qty
    if calc >= trigger.threshold  # have they reached a possible threshold?
      Rails.logger.info(">>>Txn#calc_points reached Threshold")           
      if trigger.earn_on_free
        # dont know yet
      else # dont earn_on_free
        Rails.logger.info(">>>Txn#calc_points Dont Earn On Free") 
        calc += trigger.adjustment
        if calc >= trigger.threshold
          Rails.logger.info(">>>Txn#calc_points reached Threshold with Adjustment")                     
          mbr.add_voucher(qty)
          mbr.update_points(trigger.threshold - qty, true) # remove threshold off the points balance
          if trigger.auto_burn #do we auto burn the voucher
            # what?
          else # they must come in next time to burn
            # what?
          end
        else # haven't reached adjusted threshold
          # what happens here
          mbr.update_points(qty)
          mbr.create_voucher_on_next
        end
      end
    else
      Rails.logger.info(">>>Txn#calc_points Not Threshold just add points")                 
      mbr.update_points(qty)  # just update the points
    end
    return calc
  end
  
  
end