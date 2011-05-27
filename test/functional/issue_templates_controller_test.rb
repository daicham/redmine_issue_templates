require File.dirname(__FILE__) + '/../test_helper'

class IssueTemplatesControllerTest < ActionController::TestCase
  # テスト時に読み込むテストデータ
  # fixtureの中身を変更したら 'rake test:plugins:setup_plugin_fixtures' を実行する必要がある。
  fixtures :projects, :users, :roles, :members, :enabled_modules, :issue_templates

  # テストの前に自動的に実行される。
  def setup
    @controller = IssueTemplatesController.new
    @request    = ActionController::TestRequest.new
    # ユーザID1のユーザでテストを実行する
    @request.session[:user_id] = 1
    @response   = ActionController::TestResponse.new
    @request.env["HTTP_REFERER"] = '/'
    # project_id 1のプロジェクトでissue_templatesモジュールを有効にする。
    @project = Project.find(1)
    @project.enabled_modules << EnabledModule.new(:name => 'issue_templates')
    @project.save!
  end

  context "create" do
    setup do
      
    end

    # 新規作成画面をgetで呼んだとき
    should "return new template instance when request is get" do
      get :create, :id => 1
      assert_response :success

      # @issute_templateにはproject_idにだけ値が設定されていること
      template = assigns(:issue_template)
      assert_not_nil template
      assert template.title.blank?
      assert template.description.blank?
      assert template.note.blank?
      assert_equal(1, template.project_id)
    end

    # 新規作成をPOSTで呼んだときの成功パターン
    should "insert new template record when request is post" do
      count = IssueTemplate.find(:all).length
      post :create, :id => 1, :issue_template => {:title => "newtitle", :note => "note", :description => "description"}
      assert_response :redirect
      # テンプレートの数が増えていること。
      assert_equal(count + 1, IssueTemplate.find(:all).length)

      # @issute_templateにpostで指定した値が設定されていること
      template = assigns(:issue_template)
      assert_not_nil template
      assert_equal("newtitle", template.title)
      assert_equal("note", template.note)
      assert_equal("description", template.description)
      assert_equal(1, template.project_id)
    end

    # 新規作成をPOSTで呼んだときの失敗パターン
    should "not be able to save if title is empty" do
      count = IssueTemplate.find(:all).length
      post :create, :id => 1, :issue_template => {:title => "", :note => "note", :description => "description"}
      assert_response :success
      # テンプレートの数が増えていないこと
      assert_equal(count, IssueTemplate.find(:all).length)
    end
  end
end
