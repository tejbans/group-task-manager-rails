class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :due_date, :user_id, :list_id, :user_info
end
