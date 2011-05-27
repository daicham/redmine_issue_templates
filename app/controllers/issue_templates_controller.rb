# コントローラクラス。アクション用メソッドを定義する。
# アクションが呼ばれると、同じ名前のviewが表示される。
# アクションの中でインスタンス変数(@付きの変数)に値を入れるとview内で参照可能になる。
class IssueTemplatesController < ApplicationController
  unloadable
  before_filter :find_project, :except => [:show, :update, :destroy]
  before_filter :find_object, :only => [:show, :update, :destroy]
  before_filter :authorize, :find_user

  # テンプレート一覧表示
  def index
    @issue_templates = IssueTemplate.find(:all, :conditions => ['project_id = ?', @project.id])
  end

  # テンプレート表示
  def show
  end

  # テンプレート新規作成
  def create
    # IssueTemplateのインスタンス作成
    @issue_template = IssueTemplate.new    
    @issue_template.project = @project
    if request.post?
      # POSTメソッドだったら値が入力されたということ。
      # formに入力された内容をIssueTemplateのインスタンスに設定。
      @issue_template.attributes = params[:issue_template]
      if @issue_template.save
        # 保存に成功した。
        # 成功したというメッセージを設定後、一覧画面に戻る。
        flash[:notice] = l(:notice_successful_create)
        redirect_to :action => "show", :id => @issue_template.id
      end
      # 保存に失敗した場合には再度入力画面が表示される。
    end
  end

  # テンプレート更新
  def update
    if request.post?
      @issue_template.attributes = params[:issue_template]
      if @issue_template.save
        flash[:notice] = l(:notice_successful_update)
        redirect_to :action => "show", :id => @issue_template.id
      end
    end
  end

  # テンプレート削除
  def destroy
    if request.post?
      if @issue_template.destroy
        flash[:notice] = l(:notice_successful_delete)
        redirect_to :action => "index", :id => @project
      end
    end
  end

  # チケット編集画面にテンプレートをロードする
  def load
    @issue_template = IssueTemplate.find(params[:issue_template])
    render :text => @issue_template.description
  end

  private
  def find_user
    @user = User.current
  end

  def find_object
    @issue_template = IssueTemplate.find(params[:id])
    @project = @issue_template.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end

