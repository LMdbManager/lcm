class CreateImportJobs < ActiveRecord::Migration
  def change
    create_table :import_jobs do |t|
      t.string      :original_filename
      t.string      :temp_filename
      t.datetime    :starttime
      t.datetime    :finishtime

      t.references  :user   #, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
