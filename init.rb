# Redmine起動時に一度だけ読み込まれる。
# プラグインの初期設定を記述する。
require 'redmine'

# libの下にあるhookの設定を取り込む
require 'issue_templates_issues_hook'

# Original Sources: http://www.r-labs.org/projects/r-labs/wiki/%E3%83%97%E3%83%A9%E3%82%B0%E3%82%A4%E3%83%B3%E3%83%8F%E3%83%B3%E3%82%BA%E3%82%AA%E3%83%B3_%E3%82%B5%E3%83%B3%E3%83%97%E3%83%AB
Redmine::Plugin.register :redmine_issue_templates do
  name 'Redmine Issue Templates plugin'
  author 'Daisuke Takeuchi'
  description 'This is a plugin for Redmine'
  version '0.1.0'
  url 'http://d.hatena.ne.jp/daicham/'
  author_url 'http://twitter.com/daicham'
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

