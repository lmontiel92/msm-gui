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

    the_director = Director.new
    the_director.name = params.fetch("the_director")
    the_director.bio = params.fetch("director_bio")
    the_director.dob = params.fetch("director_dob")
    the_director.image = params.fetch("director_image")

    the_director.save

    redirect_to("/directors")

  end

  def destroy
    the_id = params.fetch("the_id")

    matching_records = Director.where({ :id => the_id })

    the_director = matching_records.at(0)

    the_director.destroy

    redirect_to("/directors")
  end

  def update_director
    # Get the ID out of params
    dir_id = params.fetch("the_id")

    # Look up the existing record
    matching_records = Director.where({ :id => dir_id })
    the_director = matching_records.at(0)

    # Overwrite each column with the values from user inputs
    the_director.name = params.fetch("the_director")
    the_director.bio = params.fetch("director_bio")
    the_director.dob = params.fetch("director_dob")
    the_director.image = params.fetch("director_image")

    # Save

    the_director.save

    # Redirect to the directors details page
    redirect_to("/directors/#{the_director.id}")
  end

end
