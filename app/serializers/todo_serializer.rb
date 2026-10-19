class TodoSerializer < Oj::Serializer
  attributes :id, :title, :description, :created_at, :updated_at

  belongs_to :user, serializer: UserSerializer
end
