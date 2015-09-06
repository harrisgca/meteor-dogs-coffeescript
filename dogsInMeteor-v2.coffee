Dogs = new Mongo.Collection "dogs"

if Meteor.isClient
  Session.set 'currentTemplate', 'index'
  Session.set 'currentDogId', ""

  Template.body.helpers
    current:->
      Session.get 'currentTemplate'
    dog:->
      Session.get 'currentDogId'
    index:->
      if (Session.get 'currentTemplate') == 'index' then true else false
    new:->
      if (Session.get 'currentTemplate') == 'new' then true else false
    edit:->
      if (Session.get 'currentTemplate') == 'edit' then true else false

  # DOG INDEX
  Template.dogIndex.helpers
    dogs:->
      Dogs.find()

  Template.dogIndex.events
    "click #add-new":->
      Session.set 'currentTemplate','new'
    "click .edit":->
      Session.set "currentTemplate", "edit"
      Session.set "currentDogId", this._id

  #EDIT DOG
  Template.editDog.helpers
    currentDog:->
      id = Session.get 'currentDogId'
      console.log id

      Dogs.findOne
        _id:id

  ##############TODO need to fix findOne function for mongo###########3
  Template.editDog.events
    "click .back":->
      Session.set 'currentTemplate', 'index'
    "submit form":(event)->
      event.preventDefault()
      console.log 'here'
      Dogs.update
        _id: Session.get 'currentDogId'
        $set:
          name:event.target.name.value
          age: event.target.age.value
          breed: event.target.breed.value
      Session.set 'currentTemplate', 'index'
      console.log 'end'
      false

if Meteor.isServer
  Meteor.startup ->
    # code to run on server at starup
