module ApplicationHelper
	def login_helper
	  if user_signed_in? 
        link_to "Log out", destroy_user_session_path  
      else 
        link_to "Log in", user_session_path  
        link_to "Sign up", new_user_registration_path  
      end 
	end
end
