require ('PG')

class Bounty

  attr_accessor(:name, :species, :bounty_value, :last_known_location)
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value'].to_i
    @last_know_location = options['last_known_location']

  end

  def save()
    db = PG.connect({
      dbname: 'bounties',
      host: 'localhost'
      })
    sql_insert = "
      INSERT INTO bounties
      (
        name,
        species,
        bounty,
        last_known_location
      )
      VALUES
      (
        $1, $2, $3, $4
      )
      RETURNING id"
    values = [
      @name,
      @species,
      @bounty,
      @last_known_location
    ]

    db.prepare("save", sql_insert) #it runs a save method with the statement I gave it

    array_of_hashes = db.exec_prepared("save", values) # db_exec executes the sql statement and gets back the id because whe are asking returning id or returning * all.

    first_item_hash = array_of_hashes[0]

    @id = first_item_hash["id"].to_i()

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
    bounties = db.exec_prepared("all", values)
    db.close()
    bounties_as_objects = bounties.map {|bounty| Bounty.new(bounty)}
    return bounties_as_objects
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
        last_known_location
      ) =
      (
        $1, $2, $3, $4
      ) WHERE id = $5
    "
    values = [@name, @species, @bounty, @last_known_location, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def find(id)
    db = PG.connect({
      dbname: 'bounties',
      host: 'localhost'
      })
    sql = "SELECT * FROM bounties WHERE id = $1"
    value = [@id]
    db.prepare("all", sql)
    bounties = db.exec_prepared("all", values)
    db.close()
    bounties_as_objects = bounties.map {|bounty| Bounty.new(bounty)}
      if bounty[:id] = id
      end
    return bounty
  end

end
