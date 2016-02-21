# datalab-api
Post Production Management REST API.
 
[![Build Status](https://travis-ci.org/nicolasduval/datalab-api.svg?branch=master)](https://travis-ci.org/nicolasduval/datalab-api)
[![Code Climate](https://codeclimate.com/github/nicolasduval/datalab-api/badges/gpa.svg)](https://codeclimate.com/github/nicolasduval/datalab-api)
[![Test Coverage](https://codeclimate.com/github/nicolasduval/datalab-api/badges/coverage.svg)](https://codeclimate.com/github/nicolasduval/datalab-api/coverage)


## Synopsis   
Rails backend API.   
Manage post-production projects, workflow and deliveries.  

## Requirements   
Ruby 2.0.0     
postgreSQL 9.3


## Avalable Models

- Company
- Users
- Project
- ProjectComment
- Delivery
- DeliveryComment
- DeliveryPreset
- Contact
- Notifications
- Issue tracker

## Extra Controllers
- Timecode


## API Documentaion

Visit the [API](http://nicolasduval.github.io/datalab-docs/) documentations.

## Tests
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

