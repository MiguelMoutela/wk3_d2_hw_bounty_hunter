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

  def save()
    db = PG.connect({
      dbname: 'bounties',
      host: 'localhost'
      })
    sql = "
      INSERT INTO bounties
      (
        name,
        species,
        bounty,
        last_know_location
      )
      VALUES
      (
        $1, $2, $3, $4
      )
      RETURNING *
    "
    values = [
      @name,
      @species,
      @bounty,
      @last_know_location
    ]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i()
    db.close()
  end

  def self.all
    db = PG.connect({
      dbname: 'bounties',
      host: 'localhost'
      })
    sql = "SELECT * FROM bounties"
    values = []
    db.prepare("all", sql)
    orders = db.exec_prepared("all", values)
    db.close()
    orders_as_objects = orders.map {|order| Bounty.new(order)}
    return orders_as_objects
  end

  def self.delete_all()
    db = PG.connect({
      dbname: 'bounties',
      host: 'localhost'
    })
    sql = "DELETE FROM bounties"
    values = []
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all", values)
    db.close()
  end

  def delete()
    db = PG.connect({
      dbname: 'bounties',
      host: 'localhost'
    })
    sql = "DELETE FROM bounties WHERE ID = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def update
    db = PG.connect({
      dbname: 'bounties',
      host: 'localhost'
      })
    sql = "
      UPDATE bounties
      SET (
        name,
        species,
        bounty,
        last_know_location
      ) =
      (
        $1, $2, $3, $4
      ) WHERE id = $5
    "
    values = [@name, @species, @bounty, @last_know_location, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

end
