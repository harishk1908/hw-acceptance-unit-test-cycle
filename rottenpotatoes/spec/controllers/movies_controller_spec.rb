require 'rails_helper'

describe MoviesController do
    
    describe 'shows details of a single movie' do
        it 'shows info about the selected movie' do
            movie = double('Movie')
            Movie.should_receive(:find).with('1').and_return(movie)
            get :show, :id => '1'
            expect(response).to render_template(:show)
        end
    end
    
    describe 'allow creating a movie' do
        it 'should create a movie given all params' do
            movie_params = {'director' => '', 'title' => 'Movie Title'}
            movie = double('Movie', :director => '', :title => 'Movie Title')
            Movie.should_receive(:create!).and_return(movie)
            
            post :create, :movie => movie_params
            expect(response).to redirect_to(movies_path)
        end
    end
    
    describe 'allow editing a movie' do
        it 'should get the form to edit a movie given id' do
            movie = double('Movie', :director => '', :title => 'Movie Title')
            Movie.should_receive(:find).with('1').and_return(movie)
            get :edit, :id => '1'
            expect(response).to render_template(:edit)
        end
    end
    
    describe 'allow updating a movie' do
        it 'should update the movie given all params' do
            movie = double('Movie', :director => '', :title => 'Movie Title')
            movie_params = {'director' => '', 'title' => 'Movie Title'}
            Movie.should_receive(:find).with('1').and_return(movie)
            movie.should_receive(:update_attributes!)
            get :update, :id => '1', :movie => movie_params
            expect(response).to redirect_to(movie_path(movie))
        end
    end
    
    describe 'allow deleting a movie' do
        it 'should redirect to movies list after deleting a movie' do
            movie = double('Movie', :director => '', :title => 'Movie Title')
            Movie.should_receive(:find).with('1').and_return(movie)
            movie.should_receive(:destroy)
            delete :destroy, :id => '1'
            expect(response).to redirect_to(movies_path)
        end
    end
    
    describe 'all movies list' do
        it 'should show the list of all movies upon loading the homepage' do
            movies = [double('movie_1'), double('movie_2')]
        end
    end
    
    describe 'enables searching for movies with same director' do
        
        it 'must return movies with the same director' do
            movie_1 = double('Movie', :director => 'Steven Spielberg')
            Movie.should_receive(:find).with('1').and_return(movie_1)
            
            same_director_movies = [double('Movie_2'), double('Movie_3')]
            
            movie_1.should_receive(:same_director_movies).and_return(same_director_movies)
            
            get :same_director, :id => '1'
            
            expect(response).to render_template(:same_director)
        end
        
        
        it 'must redirect to movies list for no director' do
            movie_1 = double('Movie', :director => '', :title => 'Movie Title')
            
            Movie.should_receive(:find).with('1').and_return(movie_1)

            movie_1.should_receive(:same_director_movies).and_raise(Movie::DirectorFieldEmpty)
            
            get :same_director, :id => '1'
            
            expect(response).to redirect_to(movies_path)
        end
    end
end