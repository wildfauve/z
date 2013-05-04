class TriggersController < ApplicationController
  
  def index
    @triggers = Trigger.all
  end
  
  def show
    @trigger = Trigger.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end    
  end
  
  def new
    @trigger = Trigger.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /types/1/edit
  def edit
    @trigger = Trigger.find(params[:id])
  end

  # POST /types
  # POST /types.json
  def create
#    Rails.logger.info(">>>Type Controller>>CREATE: #{params.inspect}, #{request.format}")
    @trigger = Trigger.create_it(params[:trigger])
    respond_to do |format|
      if @trigger.valid?
        format.html { redirect_to triggers_path }
        format.json
      else
        format.html { render action: "new" }
        format.json
      end
    end
  end

  def update
    @trigger = Trigger.find(params[:id])
    @trigger.update_it(params[:trigger])
    respond_to do |format|
      if @trigger.valid?
        format.html { redirect_to triggers_path }
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

end
