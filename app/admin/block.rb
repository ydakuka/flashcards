ActiveAdmin.register Block do
  permit_params :title, :user_id

  filter :title
  filter :user_id,  as: :select, collection: proc { User.pluck(:email, :id) }
  filter :cards_id, as: :select, collection: proc { Card.pluck(:original_text, :id) }
  filter :created_at, filters: [:starts_with, :ends_with]
  filter :updated_at, filters: [:starts_with, :ends_with]

  index do
    selectable_column
    column :id
    column :title
    column "Users email", :user_id
    actions
  end

  form title: 'New Block' do
    semantic_errors
    inputs 'Details' do
      input :title
      input :user_id, label: "User email", include_blank: false,
                      as: :select, collection: User.pluck(:email, :id)

    end
    para "Press cancel to return to the list without saving."
    actions
  end
end
