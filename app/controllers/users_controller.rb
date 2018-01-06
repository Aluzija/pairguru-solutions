class UsersController < ApplicationController
  def top_ten
    time_range = 1.week.ago..Time.now
    @users = User.select('users.id', 'users.name', 'COUNT(comments.id) AS comments_count')
    .joins(:comments)
    .where('comments.created_at' => time_range)
    .group(:id)
    .order('comments_count DESC')
    .limit(10)
  end
end
