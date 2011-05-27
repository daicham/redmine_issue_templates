class CreateIssueTemplates < ActiveRecord::Migration
  def self.up
    create_table :issue_templates do |t|

      t.column :project_id, :integer

      t.column :title, :string

      t.column :note, :string

      t.column :description, :text

      t.column :updated_at, :datetime

    end
  end

  def self.down
    drop_table :issue_templates
  end
end
