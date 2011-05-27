# To change this template, choose Tools | Templates
# and open the template in the editor.

class IssueTemplatesIssuesHook < Redmine::Hook::ViewListener
  # チケット編集画面の一番上にテンプレート選択フォームを挿入する。
  render_on :view_issues_form_details_top, :partial => 'issue_templates/issue_select_form'
end
