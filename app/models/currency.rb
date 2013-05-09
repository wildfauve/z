class Currency
  
    include Mongoid::Document
    
    embedded_in :member, :inverse_of => :currencies
    embeds_many :cards
    belongs_to :trigger
    
    field :name, :type => String
    field :points, :type => Integer
    field :card_ct, :type => Integer
    field :total_pts, :type => Integer
    field :voucher_on_next, :type => Boolean
    
    
    def self.findfactory(member, trigger)
      c = member.currencies.where(:trigger_id => trigger.id) #
      if !c.empty? # found a currency to work with
        return c.first
      else
        c = self.new(:name => trigger.currency_name)
        c.trigger_id = trigger.id
        c.points = 0
        c.total_pts = 0
        c.card_ct = 0
        member.currencies << c
        return c
      end
    end
    
    def create_card(qty)
      (1..self.trigger.number_of_vouchers).each do |ct|
        c = Card.new(:unit => trigger.voucher_value)
        self.cards << c
        self.card_ct += 1
      end
      self.total_pts += qty
      self.voucher_on_next = false      
   end 
   
   def create_voucher_on_next
       self.voucher_on_next = true
   end
   
   def burn_card(params)
      card = self.cards.find(params[:card])      
      self.card_ct -= 1
      self.points -= self.trigger.burn_adj
      card.burned = true      
   end
  
   def total_free
      self.cards.inject(0) {|ct, v| ct += v.unit}
   end
   
   def balance
      self.points
   end 
end