class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create_director
    # params hash looks like this:
    	
    #{"the_director"=>"tr", "director_dob"=>"0099-02-21", "director_bio"=>"retr", "director_image"=>"rtrt", "controller"=>"directors", "action"=>"create_director"}

    # Table name: directors
    #
    #  id         :integer          not null, primary key
    #  bio        :text
    #  dob        :date
    #  image      :string
    #  name       :string

    new_dir = Director.new
    new_dir.name = params.fetch("the_director")
    new_dir.bio = params.fetch("director_bio")
    new_dir.dob = params.fetch("director_dob")
    new_dir.image = params.fetch("director_image")

    new_dir.save

    redirect_to("/directors")

  end

end
