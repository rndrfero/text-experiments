require_dependency 'array'

class PoliticsController < ApplicationController
  layout 'generator'

  def index

    pridavne = %w{ new progressive radical united revolutionary islamic christian protestant pro-satan unemployed-people's western eastern modern neo easy-going elite divine buddha's global alternative international tribal national native teenage open-minded traditional critical continental souvereign desctructive constructive woman's }.uniq
    pridavne2 = %w{ liberal conservative democratic social free reforming republican independent people's socialistic national pacifist's worker's islamic christian satanistic buddhistic catholic free free-thinking reform labor fascistic left-wing right-wing eco blessed terroristic technocratic enviromental north-atlantic carribean european african asian american new-age hippie sionistic totalitarian citizen's executive cleptocratic pirate's arab youth fetish mom-turned romantic patriots cryptofascistic }.uniq
    podstatne = %w{ movement party federation action alliance front union act clan organization league association resistance opposition forum foundation brigade council army brotherhood congress programme partnership agency department network volunteers  group society voices council institute platform petition coalition mentoring legislators warfare }.uniq
    spojka = %w{ for against of }
    podstatne2 = %w{ freedom anarchy socialism comunism capitalism nationalism anarcho-capitalism peace war democracy equal-chances nation liberation free-sex unity equality motherland sharia techno-music rock-music heavy-metal ecology planet-earth death-legalization globalization terrorism human-rights nazism fascism prohibition squatting european-union marijuana LSD detox quality-of-life death-penalty imprisonment thrash trans-humanism europe work healthy-living state oppresion mediocracy enlightment fairy-tales totality monarchy africa america asia satanism christianity islam buddhism GMO-food lies YOU! development planet-pluto  technocracy system goverment sustainability change climate-changes wildlife nuclear-weapons censorship love drugs hypocrisy occupation xenofoby sionism pornography republic authority justice criminality TV-fictions taxes majority commerce monopoly wealth private-enterprise tyrrany fake-ideologies crisis free-market kleptocracy conservativism radicalism feminism sexism piracy children vodka independence sadomasochism fetishism mothers poverty economical-growth pan-nationalism atheism paganism national-awakening facebook violence education farmers workers boys-and-girls child-work euthanasy AIDS reformation NATO }.uniq

    if Random.rand(2)==0
      ret = "#{(pridavne+pridavne2).rand} #{podstatne.rand} #{spojka.rand} #{podstatne2.rand}"
    else
#      ret << "#{pridavne.rand} #{pridavne2.rand} #{podstatne.rand}"
      ret = "#{(pridavne+pridavne2).rand} #{podstatne.rand} #{spojka.rand} #{(pridavne+pridavne2).rand} #{podstatne2.rand}"
    end

    @string = ret
    render :inline=>'', :layout=>true
  end

end
