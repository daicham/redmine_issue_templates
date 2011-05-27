# Redmine起動時に一度だけ読み込まれる。
# プラグインの初期設定を記述する。
require 'redmine'

# libの下にあるhookの設定を取り込む
require 'issue_templates_issues_hook'

#
# Redmine Plugin ハンズオン用サンプルプラグイン
# 自由に改変、配布してかまいません。
# authorも変えてもらってかまいません。
#
Redmine::Plugin.register :redmine_issue_templates do
  name 'Redmine Issue Templates plugin'
  author 'Haruyuki Iida'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://twitter.com/haru_iida'
  requires_redmine :version_or_higher => '1.0.0'

  # 各アクションの権限定義。ここで定義した権限が管理メニューの「ロールと権限」に表示される。
  project_module :issue_templates do
    permission :edit_issue_templates, {:issue_templates => [:create, :update, :destroy]}
    permission :show_issue_templates, {:issue_templates => [:index, :show, :load]}
  end

  # プロジェクトメニューに追加するTABの定義
  # TABのキャプション、表示位置、TABをクリックした時に呼ばれるアクションなどを定義
  # ここではissue_templates_controllerのindexを呼ぶ設定。
  menu :project_menu, :issue_templates, { :controller => 'issue_templates', :action => 'index' }, :caption => :issue_templates, :after => :issues
end

