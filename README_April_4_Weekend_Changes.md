### April 4th-6th Weekend Updates
* Added gem for rspec coverage.
* Refactored jam_times controller.
* Dried up friendships#new view and friendships#create.
* Removed emails from users#index and added user#user_name method.
* Removed ternary operator in friendships#all.
* Created User#other_users to move logic from VC to M.
* Minor refactoring of MVC and added some better_error gems.
* Added method Jam#creator to return user object of a jam; created and passed rspec test.
* Added binding_for_caller gem.
* Ddded created_at_formatted method in Jam model to encapsulate logic.
* Ddded partial template for form to create and edit a jam.
* created index_view_header method in User class to move logic from view to model.
* Ddded and passed rspec tests.