# encoding: utf-8

module Randomizer
  
  NAMES = %w{ feri joži tibi Ďuri pali arpi toňo dežo koloman pišta karči lajči mário zolo erik Žigo laci }.uniq
  SURNAMES = %w{ keštefráň mak kolesár balogh tokár lakatoš ujvári Bihari Mezei Rigo Sárközi Šipoš Ujvári Bari Boldy Čonka Farkaš Oláh Radič Adam Bandi Bango Berky Bodi Gábor Gaži Haluška Kotlár Lacko Miži Mezei Orgován Rigo Varadi Žiga Gabčo Girga Horváth Holub Kotlár Mirga Pačan Pokuta Pompa Barčiak Hundi }.sort.uniq
  STREETS = %w{ biela zelena ruzova zlta siva cierna oranzova }.uniq

  # NAMES = %w{ feri jozi tibi }
  # SURNAMES = %w{ lakatos bryndza }
  # STREETS = %w{ novž stara }
  
  
  def self.name
    @@name = NAMES[rand(NAMES.size)].capitalize
    @@surname = SURNAMES[rand(SURNAMES.size)].capitalize
    "#{@@name} #{@@surname}"
  end
  
  def self.address
    STREETS[rand STREETS.size]+' '+rand(100).to_s.capitalize
  end
  
  def self.phone
    rand.to_s[2..11]
  end
  
  def self.email
    "#{self.phone}@example.com"
  end
  
end