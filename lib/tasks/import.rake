# connect to legacy db
# This example uses mysql
class OldDb < ActiveRecord::Base
  self.abstract_class = true
  establish_connection(
      adapter:  'mysql2',
      encoding: 'utf8',
      database: 'dbname',
      username: 'username',
      password: 'password',
      host:     '127.0.0.1',
      port:     '3306')
end

namespace :import do

  desc 'Import legacy User records'
  task :users => :environment do

    # define classes for legacy tables
    class LegacyUser < OldDb
      self.table_name =  'old_users_table_name'
      self.primary_key = 'id'

      def to_model
        ::User.new do |u|
          u.id                  = id # you can preserve the original ids
          u.email               = email
          u.encrypted_password  = password
          u.legacy_password     = true

          # Add any additional fields you may want to import
          u.created_at          = Time.at(created_at)
          u.updated_at          = Time.now
          u.confirmed_at        = Time.now
          u.current_sign_in_ip  = last_ip.to_s
          u.current_sign_in_at  = Time.at(last_login)
        end
      end
    end

    # Import our users
    users = LegacyUser.all
    users.each do |u|
      user = User.new(u.to_model.attributes)
      user.skip_confirmation! # We don't want to send them confirmation emails
      user.save!(validate: false)
    end
  end
end
