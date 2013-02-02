require_dependency 'array'

class ReligionController < ApplicationController
  layout 'generator'
  
  def index
    
    adj = %w{ true divine holy christian islamic budhistic hinduistic pagan celtic original traditional saint catholic orthodox apostolic lutheran evangelical free eternal old new reformed zion united sanctified deeper missionary dark loving old-time national independent joyfull sacred adventist international true-and-living insane infinite bloody radical fanatic neo satanic toxic universal occult bizarre chosen famous infamous endless astral white black red green golden silver violet }
    what = %w{ brotherhood church circle triangle path worshipers warriors sect scholars followers fellowship believers family pilgrims tribe promise keepers witnesses }
    persons = %w{ jesus satan buddha ras-tafari mohhamed god christ jesus-christ st.thomas charls-manson sri-chinmoy jehovah lucifer }
    things = %w{ snake spirit trinity ritual 7th-day 12th-day 13th-day enlightment nirvana satori love freedom money golden-rule six-principles light darkness forest mother-nature earth protocol standard state law hapiness bliss joy life death destiny re-born truth the-sword cross star moon sun stars venus mars stone emptiness voodoo heaven heaven's-gate infinity insanity chaos destruction blood insight latter-day-saints multi-level-marketing technology future TV facebook UFO hell purity equality nine-angels serpent vitality orgasm promise computer propan-butan methamphetamine crystal violence word victory energy }
    
#    isms = %w{ christianity islam buddhism hinduism zen judaism }
    
    # enlighted warriors of satan
    # divine 
    
    index = Random.rand 6
#    ret << "#{index}: &nbsp;&nbsp;&nbsp;&nbsp;"
    ret = ""
    ret << case index
      when 0 then "#{adj.rand} #{what.rand} of #{(persons+things).rand}"
      when 1 then "#{what.rand} of #{adj.rand} #{(persons+things).rand}"
      when 2 then "#{adj.rand} #{things.rand} of #{persons.rand}'s #{what.rand}"
      when 3 then "#{adj.rand} #{things.rand} #{what.rand}"
      when 4 then "#{adj.rand} #{(persons+things).rand} #{things.rand}"
      when 5 then "#{persons.rand}'s #{what.rand} of #{adj.rand} #{things.rand}"
    end
    
#        if Random.rand(2)==0
#        end
    @string = ret
   render :inline=>'', :layout=>true    
  end
end
