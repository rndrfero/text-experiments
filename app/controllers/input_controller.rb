class InputController < ApplicationController
  layout 'application'

  def index
  end

  def put
    if params[:input].blank?
      flash.now[:notice] = 'prazdny nemozes'
      render :action=>'index'
    else    
      cache = Rails.cache.read(:input)
      cache ||= []
      cache.push params[:input]
      Rails.cache.write(:input, cache)
      flash[:notice] = 'som pridal'
      redirect_to :action=>'index'
    end
  end
  
  def output
    cache = Rails.cache.read(:input)
    cache = ['cafe.kinderzimmer.sk'] if cache.blank? 
    
    @string = cache[0]
    cache = cache[1..(cache.size-1)]

    Rails.cache.write(:input, cache)

    @no_uppercase = true
    render :action=>'output', :layout=>'generator'
  end
  
  def reset
    Rails.cache.write(:input, nil)
    output
  end
  
  
  
  
end
