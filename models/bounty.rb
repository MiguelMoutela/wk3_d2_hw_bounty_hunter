require ('pg')

class Bounty

  attr_accessor(:name, :species, :bounty_value, :last_know_location)
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value'].to_i
    @last_know_location = options['last_know_location']

  end

end
