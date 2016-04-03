class CreateActorParticipants < ActiveRecord::Migration
  def change
    create_table :actor_participants do |t|

      t.timestamps null: false
    end
  end
end
