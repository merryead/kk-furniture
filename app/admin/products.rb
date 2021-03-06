# encoding: UTF-8
ActiveAdmin.register Product do
  # form :partial => "form"
  config.per_page = 25

  action_item :only => :show do
    link_to('New Product', new_admin_product_path)
  end

  index do                            
    column :code
    column :name
    column :price do |product|
      div :class => "price" do
        number_to_currency product.price, :unit => "฿"
      end
    end               
    column :detail              
    column :best_seller              
    column :category do |product|
      product.category.name rescue "Other"
    end             
    column :room do |product|
      product.rooms.map{ |room| link_to room.name, admin_room_path(room), target: "_blank" }.join(", ").html_safe
    end  
    default_actions                   
  end

  form :partial => "form"

  controller do
    def create
      params[:rooms] = (params[:rooms].compact rescue nil)
      params[:product][:price] = params[:product][:price].to_s.gsub(/,/, '').to_f

      @product = Product.new(params[:product])
      @product.rooms = Room.where(id: params[:rooms])
      if @product.save
        redirect_to admin_product_path(@product)
      else
        render('new')
      end
    end

    def update
      params[:rooms] = (params[:rooms].compact rescue nil)
      params[:product][:price] = params[:product][:price].to_s.gsub(/,/, '').to_f

      @product = Product.find(params[:id])
      @product.assign_attributes(params[:product]) 
      @product.rooms = Room.where(id: params[:rooms])
      if @product.save
        redirect_to admin_product_path(@product)
      else
        render('edit')
      end
    end
  end


  show do |product|
    attributes_table do
      row :code
      row :name
      row :price do |product|
        div :class => "price" do
          number_to_currency product.price, :unit => "฿"
        end
      end               
      row :detail              
      row :best_seller              
      row :category do |product|
        product.category.present? ? product.category.name : "อื่น ๆ"
      end                
      row :rooms do |product|
        product.rooms.map {|room| link_to room.name, admin_room_path(room) }.join(', ').html_safe
      end  
    end

    render "add_photo"
  end

  member_action :upload_photo, :method => :put do
    product = Product.find(params[:product_id])
    photo = Photo.new
    photo.photo = params[:photo][:photo]
    photo.product = product
    photo.save

    if params[:past_action] == "edit"
      path_direction = edit_admin_product_path(product, anchor: 'photo_panel')
    else
      path_direction = admin_product_path(product, anchor: 'photo_panel')
    end

    redirect_to path_direction
  end

  member_action :delete_photo, :method => :delete do
    photo = Photo.find(params[:photo_id])
    product = photo.product
    photo.destroy

    if params[:past_action] == "edit"
      path_direction = edit_admin_product_path(product, anchor: 'photo_panel')
    else
      path_direction = admin_product_path(product, anchor: 'photo_panel')
    end

    redirect_to path_direction
  end
end
