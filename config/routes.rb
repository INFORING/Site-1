LandingPage::Application.routes.draw do
resources :items
resources :offers
resources :preorders
resources :faqs
resources :features
resources :reviews
resources :subscribers

root 'pages#home'

match '/admin_panel',  to: 'pages#admin_panel', via: 'get', as: :admin_panel
match 'item/change_show', to: 'items#show_item', via: 'put', as: :show_item
match 'offer/change_position', to: 'offers#offer_position', via: 'put', as: :offer_position
match 'items/create_preorder', to: 'items#preorder_create', via: 'post', as: :preorder_create
match 'preorder_update', to: 'items#preorder_update', via: 'put', as: :preorder_update
match 'faq/change_show', to: 'faqs#show_faq', via: 'put', as: :show_faq
match 'review/change_show', to: 'reviews#show_review', via: 'put', as: :show_review
match 'subscribe', to: 'subscribers#subscribe', via: 'get', as: :subscribe
match 'item/new_order', to: 'items#order_new', via: 'get', as: :order_new
match 'item/send_order', to: 'items#order_create', via: 'get', as: :order_create
match 'admin/signin', to: 'pages#admin_signin', via: 'get', as: :admin_signin
match 'admin_session_create', to: 'pages#admin_session_create', via: 'post', as: :admin_session
match 'admin_session_destroy', to: 'pages#admin_session_destroy', via: 'get', as: :admin_session_destroy
match 'feedback', to: 'pages#feedback', via: 'get', as: :feedback
match 'update_options', to: 'pages#update_options', via: 'put', as: :update_options
match 'update_password', to: 'pages#update_password', via: 'put', as: :update_password
match 'show_picture', to: 'pages#show_picture', via: 'get', as: :show_picture
match 'subscriber/destroy/:id', to: 'subscribers#unsubscribe',via: 'get', as: :unsubscribe 
match 'offer/new_order', to: 'offers#order_new', via: 'get', as: :offer_order_new
match 'offer/send_order', to: 'offers#order_create', via: 'get', as: :offer_order_create

end
