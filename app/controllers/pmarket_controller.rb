require_dependency 'randomizer'

class MarketModel1
  attr :marketers, true
  attr :data, true
  attr :num_marketers
  attr :num_clients
  
  MONTHS = 14
  
  THRESHOLD = 10000
  SMS_INCOME = 0.04
  
  TOTAL_MAX_MARKETERS = 10000
  TOTAL_MAX_CLIENTS = 100000
  
      
  def initialize
    @marketers = [ Marketer1.new(4,self), Marketer1.new(4,self), Marketer1.new(4,self) ]
    @month = 1
#    @num_marketers, @num_clients = @marketers.size, 0
  end
  
  def all_marketers
    @_all_marketers ||= @marketers.inject([]){ |ret, x| ret+=x.all_marketers }
  end
  
  def all_clients
    @_all_clients ||= @marketers.inject([]){ |ret, x| ret+=x.all_clients }
  end
  
  def yo!
    @marketers.each{ |x| x.perform! }
  end
  
  def flush!
    @_all_marketers = @_all_clients = nil
  end
  
end


class Client1
  attr :plan, true  
  attr :num_sms

#  INCOMES = [22.0,24.0,26.0,28.0]
#  INCOMES = [22.0,24.0,26.0,28.0]
  INCOMES = [22.0,24.0,26.0,28.0]
#  INCOMES = [1.0,10.0,100.0,1000.0]
  ROUND = [0,0,0,0,1,2]
  
  SMS_SPEED = 50
  SMS_MAX = 1000
  SMS_TARIFF = 0
    
  def initialize
    @@token ||= 0
    @plan = ROUND[ (@@token+=1) % ROUND.size ]
    @num_sms = 0
  end
  
  def income_noro
    INCOMES[@plan]
  end
  
  def income_sms
    SMS_TARIFF + @num_sms * MarketModel1::SMS_INCOME
  end
  
  def perform!
    @num_sms += SMS_SPEED
    @num_sms = SMS_MAX if @num_sms > SMS_MAX
  end
end


class Marketer1
  attr :level, true
  attr :market_model, true
  attr :cnt_marketers, true
  attr :name
  
  PROD_CLIENTS = 5
  MAX_CLIENTS = 12
  
  PROD_MARKETERS = 1
  MAX_MARKETERS = 4
  
  THRASH_SUM = [10,20,30,40,50]  
  COMMISSIONS = [0.5,0.55,0.6,0.65,0.7]
    
  TOTAL_MAX_MARKETERS = 20
  TOTAL_MAX_CLIENTS = 200
    
  attr :clients, true
  attr :marketers, true
  
  def initialize(level, _market_model)
    raise 'kokotina' unless _market_model.is_a? MarketModel1
    @name = Randomizer.name
    @level, @clients, @marketers = level, [], []
    @market_model = _market_model
    @cnt_marketers = 0
  end
  
  # -- tree --

  def all_marketers
    ret = [self]
    marketers.map{ |x| ret += x.all_marketers }
    ret
  end
  
  def all_clients
    ret = clients    
    marketers.map{ |x| ret += x.all_clients }
    ret    
  end
  
  def perform!
    @marketers.each{ |x| x.perform! }
    # add people
    
#    market_model.flush!
    num_marketers = market_model.all_marketers.size
    num_clients = market_model.all_clients.size
    
    PROD_CLIENTS.times do
      @clients << Client1.new if @clients.size < MAX_CLIENTS
    end if num_clients < MarketModel1::TOTAL_MAX_CLIENTS
    
    # PROD_MARKETERS.times do
    #    @marketers << Marketer1.new(0,market_model) if @marketers.size < MAX_MARKETERS
    # end if num_marketers < MarketModel1::TOTAL_MAX_MARKETERS
    
    if num_marketers < MarketModel1::TOTAL_MAX_MARKETERS
      @cnt_marketers += PROD_MARKETERS
      @cnt_marketers = MAX_MARKETERS if @cnt_marketers > MAX_MARKETERS
      (@cnt_marketers - @marketers.size).ceil.times do
        @marketers << Marketer1.new(0,market_model)
      end
    end

    
    # set new level if needed
    new_level = 0
    THRASH_SUM.each{ |x| new_level += 1 if x<(clients.size+marketers.size) }
    @level = new_level if @level < new_level    
    # perform clients
    @clients.each{ |x| x.perform! }
  end  
  
  
  # -- income --
      
  def income_noro
    clients.inject(0) { |sum,x| sum += x.income_noro }
  end
  
  def income_sms
    clients.inject(0) { |sum,x| sum += x.income_sms }
  end

  # -- multi-level --
  
  def income(_method)
    income_direct(_method) + income_indirect(_method)
  end
  
  def income_direct(_method)
    self.send(_method)
  end  

  def income_indirect(_method)
    ret = 0
    for m in @marketers
      next if COMMISSIONS[m.level] >= COMMISSIONS[level]
      ret += m.send(_method)
    end
    ret
  end

  def comm_direct(_method)
    send(_method) * COMMISSIONS[level]
  end
        
  def comm_indirect(_method)
    ret = 0
    for m in @marketers
      next if COMMISSIONS[m.level] >= COMMISSIONS[level]
      ret += m.send(_method)*( COMMISSIONS[level]-COMMISSIONS[m.level] )
    end
    ret
  end
    
  def comm(_method)
    comm_direct(_method) + comm_indirect(_method)
  end
  
  # -- sms --
  
  def num_sms
    @clients.inject(0){ |ret,x| ret += x.num_sms }
  end
      
end



class PmarketController < ApplicationController
  
  def index
    load 'pmarket_controller.rb' if params[:x].blank?
    
    for k,v in params[:x]||{}
      mod = k.split('::').first.constantize
      con = k.split('::').last
      
      if v =~ /,/
        v = v.split(',').map{ |x| ( x.to_f == x.to_i ? x.to_i : x.to_f ) }
      else
        v = v.to_f
        v = v.to_i if v.to_i == v
      end
      
      mod.const_set(con, v)
    end
    
    render :action=>'pmarket'  
  end
  
end
