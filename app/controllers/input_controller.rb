class InputController < ApplicationController
  layout 'application'

  def index
  end

  def put
    if params[:input].blank?
      flash.now[:notice] = 'prazdny nemozes'
      render :action=>'index'
    else    
      session[:input] ||= []
      session[:input].push params[:input]
      flash[:notice] = 'som pridal'
      redirect_to :action=>'index'
    end
  end
  
  def output
    session[:input] = ['cafe.kinderzimmer.sk'] if session[:input].blank?
    
    @string = session[:input][0]
    session[:input] = session[:input][1..(session[:input].size-1)]

    @no_uppercase = true
    render :action=>'output', :layout=>'generator'
  end
  
  def reset
    session[:input] = nil
    output
  end
  
  
  
end
