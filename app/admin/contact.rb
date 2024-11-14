ActiveAdmin.register Contact do
  permit_params :title, :content

  actions :all, except: [ :new, :destroy ]

  index do
    column :title
    column :content
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :content
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :content
    end
  end
end
