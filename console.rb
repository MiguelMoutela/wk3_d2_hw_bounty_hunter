require('pry')

require_relative('models/bounties.rb')

PizzaOrder.delete_all()

bounty_1 = Bounty.new(
  {
    'name' => 'Zumbav',
    'species' => 'Bhebon',
    'bounty' => '346',
    'last_known_location' => 'Utis'
  }
)

bounty_2 = Bounty.new(
  {
    'name' => 'Dakeer',
    'species' => 'Hurmorane',
    'bounty' =>'3464',
    'last_known_location' => 'Banton'
  }
)

bounty_3 = Bounty.new(
  {
    'name' => 'Fuclibbon',
    'species' => 'Selubmorane',
    'bounty' =>'67645',
    'last_known_location' => 'Khepri'
  }
)

bounty_4 = Bounty.new(
  {
    'name' => 'Apawulf',
    'species' => 'Veni',
    'bounty' =>'8765',
    'last_known_location' => 'Ventos'
  }
)

binding.pry
nil
