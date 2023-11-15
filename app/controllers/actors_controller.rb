class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create_actor
    # params hash looks like this:
    	
    #{"the_actor"=>"tr", "director_dob"=>"0099-02-21", "director_bio"=>"retr", "director_image"=>"rtrt", "controller"=>"directors", "action"=>"create_director"}

    # Table name: actors
    #
    #  id         :integer          not null, primary key
    #  bio        :text
    #  dob        :date
    #  image      :string
    #  name       :string

    the_actor = Actor.new
    the_actor.name = params.fetch("the_actor")
    the_actor.bio = params.fetch("actor_bio")
    the_actor.dob = params.fetch("actor_dob")
    the_actor.image = params.fetch("actor_image")

    the_actor.save

    redirect_to("/actors")

  end

  def destroy
    the_id = params.fetch("the_id")

    matching_records = Actor.where({ :id => the_id })

    the_actor = matching_records.at(0)

    the_actor.destroy

    redirect_to("/actors")
  end

  def update_actor
    # Get the ID out of params
    act_id = params.fetch("the_id")

    # Look up the existing record
    matching_records = Actor.where({ :id => act_id })
    the_actor = matching_records.at(0)

    # Overwrite each column with the values from user inputs
    the_actor.name = params.fetch("the_actor")
    the_actor.bio = params.fetch("actor_bio")
    the_actor.dob = params.fetch("actor_dob")
    the_actor.image = params.fetch("actor_image")

    # Save

    the_actor.save

    # Redirect to the directors details page
    redirect_to("/actors/#{the_actor.id}")
  end


end
