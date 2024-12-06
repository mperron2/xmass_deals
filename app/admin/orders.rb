ActiveAdmin.register Order do
  controller do
    helper ApplicationHelper
  end

  index do
    selectable_column
    id_column
    column :customer do |order|
      order.customer.name
    end
    column "Customer Email" do |order|
      order.customer.email
    end
    column :status
    column :cost, sortable: :cost do |order|
      number_to_currency(order.cost)
    end
    column "Tax" do |order|
      tax_rate = get_tax_rate(order.customer.province)
      number_to_currency(order.cost * tax_rate)
    end
    column "Grand Total" do |order|
      tax_rate = get_tax_rate(order.customer.province)
      number_to_currency(order.cost + (order.cost * tax_rate))
    end
    column "Products Ordered" do |order|
      ul do
        order.order_items.each do |item|
          li "#{item.product.name} - Quantity: #{item.quantity}"
        end
      end
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :customer do |order|
        order.customer.name
      end
      row "Customer Email" do |order|
        order.customer.email
      end
      row :status
      row :cost do |order|
        number_to_currency(order.cost)
      end
      row "Tax" do |order|
        tax_rate = get_tax_rate(order.customer.province)
        number_to_currency(order.cost * tax_rate)
      end
      row "Grand Total" do |order|
        tax_rate = get_tax_rate(order.customer.province)
        number_to_currency(order.cost + (order.cost * tax_rate))
      end
      row "Products Ordered" do |order|
        ul do
          order.order_items.each do |item|
            li "#{item.product.name} - Quantity: #{item.quantity} (Price: #{number_to_currency(item.price)})"
          end
        end
      end
      row :created_at
    end
  end

  # Filters
  filter :customer_name, as: :string
  filter :status, as: :string
  filter :created_at
end
