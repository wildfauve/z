module ApplicationHelper
  def mbr_list
		@mbr_list || @mbr_list = Member.all.map{|m| [m.name, m.id]}
	end	
  
  def trigger_list
		@trigger_list || @trigger_list = Trigger.all.map{|t| [t.currency_name, t.id]}
  end
  
end
