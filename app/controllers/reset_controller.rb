class ResetController < ApplicationController

  def create
    Member.resetall
    Txn.all.delete
    respond_to do |format|
      format.html { redirect_to members_path }
    end
  end



end