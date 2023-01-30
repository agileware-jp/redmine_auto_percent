require File.dirname(__FILE__) + '/../test_helper'

class IssueTest < ActiveSupport::TestCase
  fixtures :projects, :users, :trackers, :projects_trackers, :issue_statuses

  def test_update_percent
    issue = Issue.create!(
      project_id: 1, tracker_id: 1, author_id: 3, subject: 'my issue',
      status_id: IssueStatus.find_by!(name: 'New'),
      priority: IssuePriority.create(name: 'Normal'),
    )

    assert_equal 0, issue.done_ratio
    issue.update(status: IssueStatus.find_by!(name: 'Closed'))
    assert_equal 100, issue.reload.done_ratio
  end
end
