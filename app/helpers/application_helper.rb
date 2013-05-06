module ApplicationHelper
  def mbr_list
		@mbr_list || @mbr_list = Member.all.map{|m| [m.name, m.id]}
	end	
  
end
