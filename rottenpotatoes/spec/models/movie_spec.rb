require 'rails_helper'

describe Movie do
    
    describe 'enable returning the list of all ratings' do
        it 'must contain the list of all ratings' do
            expect(Movie.all_ratings).to include('G', 'PG', 'PG-13', 'NC-17', 'R')
        end
    end
    
    describe 'enables searching for movies with same director' do
        it 'must contain movies with the same director' do
            movie_1 = Movie.create!(:title => 'movie 1', :director => 'director 1')
            movie_2 = Movie.create!(:title => 'movie 2', :director => 'director 1')
            Movie.create!(:title => 'movie 3', :director => 'director 2')
            Movie.create!(:title => 'movie 4')
            
            expect(movie_1.same_director_movies).to include(movie_1, movie_2)
        end
        
        it 'must not contain movies with the other directors' do
            movie_1 = Movie.create!(:title => 'movie 1', :director => 'director 1')
            Movie.create!(:title => 'movie 2', :director => 'director 1')
            movie_3 = Movie.create!(:title => 'movie 3', :director => 'director 2')
            movie_4 = Movie.create!(:title => 'movie 4')
            
            expect(movie_1.same_director_movies).to_not include(movie_3, movie_4)
        end
        
        it 'must raise an exception in case of a blank director' do
            Movie.create!(:title => 'movie 3', :director => 'director 2')
            movie_4 = Movie.create!(:title => 'movie 4')
            
            expect{movie_4.same_director_movies}.to raise_error(Movie::DirectorFieldEmpty)
        end
    end
end