module PmarketHelper
  
  def prc(x)
    "%.2f" % x
  end
  
  def thrsh(x)
    return x if x<MarketModel1::THRESHOLD
    raw "<span style='color: green;'>#{x}</span>"
  end
end
