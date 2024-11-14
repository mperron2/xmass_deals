ActiveAdmin.register Product do
  permit_params :name, :price, :description, :in_stock, :category_id, :image

  remove_filter :image_attachment, :image_blob

  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image) : ""
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :category
    column :price
    column :description
    column :in_stock
    column :image do |product|
      if product.image.attached?
        image_tag url_for(product.image), size: "50x50"
      end
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :category
      row :price
      row :description
      row :in_stock
      row :created_at
      row :updated_at
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), size: "200x200"
        end
      end
    end
  end

  filter :order_items_id
end
