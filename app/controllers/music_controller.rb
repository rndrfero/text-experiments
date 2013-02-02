require_dependency 'array'

class MusicController < ApplicationController
  layout 'generator'
  # radical acid bluegrass
  # 80s brutal trance
  # brutal psychedelic blues
  # electronic minimal country
  # 80s speed jazz
  # avant-garde aggresive latino
  # atmosperic aggresive downtempo
  # emo mambo
  # synth grunge

  def index
    adjectives = %w{ 60s 70s 80s 90s acid angry acoustic aggresive alternative ambient anti atmosperic avant-garde beach black brutal celtic chemical chiptune christian contemporary cyber dance dark death dirty doom dream easy easy-going electro electronic emo ethereal ethno experimental extreme free freestyle garage gothic gregorian happy hard indie industrial lo-fi maximal melancholic melodic minimal new-age nu political political-incorrect power progressive psychedelic pub radical romantic sad speed spiritual symphonic synth technical thrash vocal world soft commercial indian gangsta emo smooth adult digital old-school new-school funeral hippie viking blackened gipsy brazilian scandinavian carribean german jamaican epic cosmic medevial groove traditional }.uniq    
    gengres = %w{ afrobeat baroque big-beat bluegrass blues bossa-nova boy-band breakbeat breakcore britpop cabaret capoeira-music cha-cha chanson chillout classical core country crossover crustcore darkwave disco dnb downtempo drone drum-and-bass dub easy-listening ebm electro electronica emo ethno film-music folk folklore funky fusion gabber gospel grindcore grunge hardcore hip-hop house industrial jazz latino mambo metal metalcore noise oldies pop punk rap rave reggae rnb rock samba screamo ska stone-rock stonecore techno tekno trance trip-hop mainstream choral dupstep chillstep throat-singing rockabilly psychobilly illbient nintendocore IDM musique-concrete glitch mathcore sludge djent }.uniq    
    
    if rand(2)==1
      str = "#{adjectives.rand} #{adjectives.rand} #{gengres.rand}"
    else 
      str = "#{adjectives.rand} #{adjectives.rand} #{gengres.rand}"
    end

    @string = str
    render :inline=>'', :layout=>true
  end

  
end
