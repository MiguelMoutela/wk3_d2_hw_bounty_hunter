require('pry')

require_relative('models/bounty.rb')

Bounty.delete_all()

bounty_1 = Bounty.new(
  {
    'name' => 'Zumbav',
    'species' => 'Bhebon',
    'bounty_value' =>'346',
    'last_known_location' => 'Utis'
  }
)

bounty_2 = Bounty.new(
  {
    'name' => 'Dakeer',
    'species' => 'Hurmorane',
    'bounty_value' =>'3464',
    'last_known_location' => 'Banton'
  }
)

bounty_3 = Bounty.new(
  {
    'name' => 'Fuclibbon',
    'species' => 'Selubmorane',
    'bounty_value' =>'67645',
    'last_known_location' => 'Khepri'
  }
)

bounty_4 = Bounty.new(
  {
    'name' => 'Apawulf',
    'species' => 'Veni',
    'bounty_value' =>'8765',
    'last_known_location' => 'Ventos'
  }
)

binding.pry
nil
