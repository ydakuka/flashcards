ActiveAdmin.register Card do
  permit_params :original_text, :translated_text, :user_id, :block_id, :image,
                :interval, :repeat, :efactor, :attempt, :quality, :image_cache

  filter :original_text
  filter :translated_text
  filter :user_id,  as: :select, collection: proc { User.pluck(:email, :id) }
  filter :block_id, as: :select, collection: proc { Block.pluck(:title, :id) }
  filter :interval, filters: [:starts_with, :ends_with]
  filter :repeat, filters: [:starts_with, :ends_with]
  filter :efactor, filters: [:starts_with, :ends_with]
  filter :attempt, filters: [:starts_with, :ends_with]
  filter :quality, filters: [:starts_with, :ends_with]

  index do
    selectable_column
    column :id
    column :original_text
    column :translated_text
    column :review_date
    column :interval
    column :repeat
    column :efactor
    column :attempt
    column :quality
    actions
  end

  form title: 'New Card' do |f|
    semantic_errors
    inputs 'Details' do
      input :original_text
      input :translated_text
      input :user_id, label: "User email", include_blank: false,
                      as: :select, collection: User.pluck(:email, :id)
      input :block_id, label: "Block", include_blank: false,
                      as: :select, collection: Block.pluck(:title, :id)
      inputs "Attachment", :multipart => true do
        input :image, as: :file, hint: image_tag(f.object.image)
        input :image_cache, as: :hidden
      end
      inputs 'Other details' do
        input :interval, default: 1
        input :repeat, default: 1
        input :efactor, default: 2.5
        input :attempt, default: 1
        input :quality, default: 5
      end
    end
    para "Press cancel to return to the list without saving."
    actions
  end
end
