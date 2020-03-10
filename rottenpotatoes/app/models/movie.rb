class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def same_director_movies
    if (!self.director or self.director.empty?)
      raise Movie::DirectorFieldEmpty
    end
    Movie.where(director: self.director)
  end
  
  class Movie::DirectorFieldEmpty < StandardError
  end
  
end
