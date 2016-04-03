class CreateActorParticipants < ActiveRecord::Migration
  def self.up
    create_table :actor_participants, id: false do |t|
      t.string :actor_id, limit: 20
      t.string :participant_id, limit: 20
      t.timestamps null: false
    end
    execute "ALTER TABLE actor_participants ADD PRIMARY KEY (actor_id, participant_id)"
  end

  def self.down
  	execute "ALTER TABLE actor_participants DROP PRIMARY KEY"
    drop_table :actor_participants
  end
end
