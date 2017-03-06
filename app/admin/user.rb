ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :locale

  scope :all
  scope :admin_user

  filter :cards, as: :select, collection: proc { Card.pluck(:original_text, :id) }
  filter :blocks
  filter :current_block
  filter :email
  filter :locale

  index do
    selectable_column
    column :id
    column :email
    column :locale
    actions
  end

  form title: 'New User' do
    semantic_errors
    inputs 'Details' do
      input :email
      input :password
      input :password_confirmation
      input :locale, collection: I18n.available_locales.map(&:to_s), include_blank: false
    end
    para "Press cancel to return to the list without saving."
    actions
  end
end
