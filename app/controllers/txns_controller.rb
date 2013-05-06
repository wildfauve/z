class TxnsController < ApplicationController

  def index
    @txns = Txn.all
  end

  def show
    @txn = Txn.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end    
  end

  def new
    @txn = Txn.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /types/1/edit
  def edit
    @txn = Txn.find(params[:id])
  end

  # POST /types
  # POST /types.json
  def create
#    Rails.logger.info(">>>Type Controller>>CREATE: #{params.inspect}, #{request.format}")
    @member = Member.find(params[:member])
    @txn = Txn.create_it(params[:txn], @member)
    respond_to do |format|
      if @txn.valid?
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
  
  def deleteall
    Txn.all.delete
    respond_to do |format|
      format.html { redirect_to txns_path }
    end    
  end

end