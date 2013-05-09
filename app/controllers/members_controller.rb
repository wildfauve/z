class MembersController < ApplicationController

  def index
    @members = Member.all.asc(:name)
  end

  def show
    @member = Member.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end    
  end

  def new
    @member = Member.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /types/1/edit
  def edit
    @member = Member.find(params[:id])
  end

  # POST /types
  # POST /types.json
  def create
#    Rails.logger.info(">>>Type Controller>>CREATE: #{params.inspect}, #{request.format}")
    @member = Member.create_it(params[:member])
    respond_to do |format|
      if @member.valid?
        format.html { redirect_to members_path }
        format.json
      else
        format.html { render action: "new" }
        format.json
      end
    end
  end

  def update
    @member = Member.find(params[:id])
    @member.update_it(params[:Member])
    respond_to do |format|
      if @member.valid?
        format.html { redirect_to members_path }
        format.json
      else
        format.html { render action: "edit" }
        format.json
      end
    end
  end


  def destroy
    @type = Type.find(params[:id])
    @type.delete
    Rails.logger.info(">>>TypeController#delete #{@type.errors.inspect} ")         
    respond_to do |format|
      if @type.errors.blank?
        format.html { redirect_to types_path }
        format.json
      else
        format.html { render "show" }
        format.json
      end
    end
  end
  
  def reset
    @member = Member.find(params[:id])
    @member.reset
    respond_to do |format|
      if @member.valid?
        format.html { redirect_to members_path }
        format.json
      else
        format.html { render action: "edit" }
        format.json
      end
    end
  end
  
  def burn
    @member = Member.find(params[:id])
    @member.burn_voucher(@member.vouchers.find(params[:voucher]))
    respond_to do |format|
      if @member.valid?
        format.html { redirect_to members_path }
        format.json
      else
        format.html { render action: "edit" }
        format.json
      end
    end
  end

  def burn_card
    @member = Member.find(params[:id])
    @member.burn_card(:card => params[:card], :currency => params[:currency])
    respond_to do |format|
      if @member.valid?
        format.html { redirect_to members_path }
        format.json
      else
        format.html { render action: "edit" }
        format.json
      end
    end
  end
  

end