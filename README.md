# datalab-api (in development)
Post Production Management REST API.   
*This project is in development, some of the following may still not be applicable*

 
[![Build Status](https://travis-ci.org/nicolasduval/datalab-api.svg?branch=master)](https://travis-ci.org/nicolasduval/datalab-api)
[![Code Climate](https://codeclimate.com/github/nicolasduval/datalab-api/badges/gpa.svg)](https://codeclimate.com/github/nicolasduval/datalab-api)
[![Test Coverage](https://codeclimate.com/github/nicolasduval/datalab-api/badges/coverage.svg)](https://codeclimate.com/github/nicolasduval/datalab-api/coverage)


## Synopsis   
Rails backend API.   
Manage post-production projects, workflow and deliveries.  

## Requirements   
Ruby 2.0.0     
postgreSQL 9.3


## Installation

Clone the repository.

` $ git clone https://github.com/nicolasduval/datalab-api.git`  

To create a new token run the the following command.   

```
  
  $ rake db:create:api_key[yout_name]

```

## Authorization
The API is secured by an Authorization Token Key.    
Each requests made to the API mush have a authorization token in the header.   
`-H "Authorization: Token token='959c3652a091b01687c29677dafcff7b' "`  
To create a new token run the the following command.   

```
  
  $ rake db:create:api_key[yout_name]

```


## Access Token Authentication   
Users authentication uses header access-token.   
[See this page for more information on how authentication works](https://github.com/lynndylanhurley/devise_token_auth/blob/master/README.md#conceptual)

#### Sign in request

```

  POST : localhost:3000/api/auth/sign_in/   
  
  URL PARAMETER : 
      email = user@gmail.com
      password = foobar0001 
  
```

#### Responce Headers

The server will return the follwing headers.   

```
  Access-Token: 3HWQefx0qhMlsS6JqpZIGw
  Client: p-ZMDnDLaL8hoe-isPiNlA
  Uid: nduval.dev@gmail.com
  Content-Type: application/json; charset=utf-8 
```

The follwing request made to the server must contains the headers.   
The server will then send back new values for this headers.   




## Database Tables

* [Company](#company)
- Users
- Project
  -  ProjectComment
- Delivery
  - DeliveryComment
  - DeliveryPreset
- Contact
- Notifications
- Issue tracker

## Controllers
Requests made with this controllers are not stored in the Database.   

- Timecode


## Company

##### Attributes
- name
- full_address
- zip_code
- phone_number


## Project

When createing a new project, the record must be associated with a `Company ID` reaord using   
the `company_id:` attribue.


##### Attributes
- company_id
- name
- frame_rate
- color_space
- aspect_ratio
- resolution
- production
- supervisor
- sound_studio
- status

## ProjectComment

When createing a new ProjectComment, the record must be associated with a `Project ID` and `User ID` reaord using   
the `project_id:` and `user_id:` attribues.   

##### Attributes
- project_id
- user_id
- body



## Delivery

When createing a new delivery, the record must be associated with a `Project ID`, and `User ID` reaord using   
the `project_id:` and `user_id:` attribues.


##### Attributes
- user_id
- project_id
- reference
- number
- frame_rate
- resolution
- aspect_ratio
- format
- anamorphic
- color_space
- compression
- subtitles
- audio
- approved
- status
- internal
- assigned_to
- delivery_method
- remarks
- checksum



## DeliveryComment

When createing a new DeliveryComment, the record must be associated with a `Ddlivery ID` and `User ID` reaord using   
the `delivery_id:` and `user_id:` attribues.   

##### Attributes
- delivery_id
- user_id
- body




## API Documentaion

Visit the [API](http://nicolasduval.github.io/datalab-docs/) documentations.

## Test
### Models
#####Relations

```ruby

  describe 'Relations' do
     ...
      it 'has many deliveries' do
          expect(@project).to have_many(:deliveries)
      end
     ...
    end

```

#####Attributes

```ruby

  
  describe "Attributes" do
    ...
    it 'has a name attributes' do 
      expect(@project).to have_attributes name: "my_project"
    end

    it 'has a company name' do
      expect(@project.company.zip_code).to eq '1050'
    end

    it 'has a name attributes' do 
      expect(@project).to have_attributes company_id: @company.id
    end
    ...
  end

```
#####Validations

```ruby 

  describe "Validation" do
    ...
    it "name should be present" do
      expect(@project).to validate_presence_of :name
    end

    it 'validates the associated company' do
      expect(@project).to belong_to(:company)
    end

    it "company_id should be present" do
      expect(@project).to validate_presence_of :company_id
    end

    it "should not be valid" do
      @project = Project.new name: nil
      expect(@project).to_not be_valid
    end
    ...
  end


```

###Controllers

#####Actions

```ruby 
 describe "Actions" do
    ...
    it { expect(@controller).to respond_to(:index) }
    it { expect(@controller).to respond_to(:show) }
    it { expect(@controller).to respond_to(:create) }
    it { expect(@controller).to respond_to(:update) }
    it { expect(@controller).to respond_to(:destroy) }
    ...
  end

```

#####Routing

```ruby 
 describe "Routing" do
    ...
    it 'to routes index' do  
      params = { format: 'json', controller: "#{@version_api}/projects", action: 'index' }
      expect(:get => "/api/projects/").to route_to( params ) 
    end

    it 'to routes show' do  
      params = { format: 'json', controller: "#{@version_api}/projects", action: 'show', id: @project.id.to_s }
      expect(:get => "/api/projects/#{@project.id}").to route_to( params ) 
    end
    ...
end

```

#####Responce

```ruby 
 describe 'Responce' do
    ...
    it "GET /projects/ response 200" do
      get :index, company_id: @company.id, format: :json
      expect(response).to have_http_status(200)
    end
   
    it "GET /projects/:id response 200" do
      get :show, id: @project.id, format: :json
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq( @project.attributes )
    end
    ...
  end

```

