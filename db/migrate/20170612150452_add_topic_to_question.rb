class AddTopicToQuestion < ActiveRecord::Migration[5.0]
  def change
  	add_reference :questions, :topic, index: true
  end
end
