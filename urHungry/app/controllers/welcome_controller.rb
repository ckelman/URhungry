class WelcomeController < ApplicationController
  def index
    set_admins
  end
  
  def about
  end
  
  def contact
  end
  
  
  private
  
  def set_admins
    
    User.where(email: 'ckelman@u.rochester.edu').each do |use|
      use.is_admin = true
      use.save
    end
    
    User.where(email: 'whonore@u.rochester.edu').each do |use|
      use.is_admin = true
      use.save
    end
    
    User.where(email: 'juvina@u.rochester.edu').each do |use|
      use.is_admin = true
      use.save
    end
    
    User.where(email: 'akallel@u.rochester.edu').each do |use|
      use.is_admin = true
      use.save
    end
    
    User.where(email: 'tsebring@u.rochester.edu').each do |use|
      use.is_admin = true
      use.save
    end
    
  end
  
end
