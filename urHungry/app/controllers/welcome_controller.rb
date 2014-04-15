class WelcomeController < ApplicationController
  def index
    set_admins
  end
  
  def about
  end
  
  def contact
  end
  
  def search
    quer = params[:search]
    @places = Place.where{ name.matches quer}
    @foods = Food.where{ name.matches quer}
    @reviews = Review.where{ title.matches quer}
    @reviews = (@reviews + Review.where{ body.matches quer}).uniq
    @users = User.where{email.matches quer}
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
