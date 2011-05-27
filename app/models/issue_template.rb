# issute_templates テーブルの1レコードを保持する。
class IssueTemplate < ActiveRecord::Base
  unloadable
  belongs_to :project
  # project_id, title, descriptionは必須
  validates_presence_of :project_id, :title, :description
  # titleは同じproject_idの範囲では一意
  validates_uniqueness_of :title, :scope => :project_id
end
