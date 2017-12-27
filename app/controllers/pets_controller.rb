class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    end
    #moramo shraniti spremembe lastnika v podatkovno bazo
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    #binding.pry
    erb :'/pets/edit'

  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    if !params[:owner][:name].empty? && params[:owner_name].empty?
      @pet.owner = Owner.find_by(name: params[:owner][:name])
    else
      @owner = Owner.create(name: params[:owner_name])
      @pet.owner = @owner
    end
    @pet.update(name: params[:pet][:name])
    #binding.pry
    redirect to "pets/#{@pet.id}"
  end
end
