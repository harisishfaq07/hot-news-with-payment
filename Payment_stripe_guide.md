<!-- Step 1: -->

after devise setup
gem "stripe"
make confiz/initializers/stripe.rb
make app/javascript/credit_card_form.js
appilcation.html.erb => add this line =>  <%= javascript_include_tag "https://js.stripe.com/v2/" %>

<!-- Step 2: -->
make model payment 
make association user and payment

<!-- Step 3: -->
make registrations controller and make its routes
make nested form in registration/new.html.erb  => add all strip things in it

