#!/bin/sh
echo "Starting script..."
# GENERATE APP
cd ~/code/JavaProScript
rails new $1 --skip-active-storage --skip-action-mailbox -T
cd $1
echo "Adding bootstrap and its depedencies..."
# FRONTEND
yarn add bootstrap
yarn add jquery popper.js
# Gemfile
echo "Loading gems..."
echo "gem 'autoprefixer-rails'" >> Gemfile
echo "gem 'font-awesome-sass', '~> 5.6.1'" >> Gemfile
echo "gem 'simple_form'" >> Gemfile
bundle install
rails generate simple_form:install --bootstrap
echo "Importing Lewagon's stylesheets..."
rm -rf app/assets/stylesheets
curl -L https://github.com/lewagon/stylesheets/archive/master.zip > stylesheets.zip
unzip stylesheets.zip -d app/assets && rm stylesheets.zip && mv app/assets/rails-stylesheets-master app/assets/stylesheets

cat > config/webpack/environment.js <<- EOM
const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
) 

module.exports = environment
EOM
# app/javascript/packs/application.js
echo "import 'bootstrap';" >> app/javascript/packs/application.js

echo "End of script!"