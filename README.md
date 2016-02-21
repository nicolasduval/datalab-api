# datalab-api
Post Production Management REST API.   
*This project is in development, some of the following may still not be applicable*

 
[![Build Status](https://travis-ci.org/nicolasduval/datalab-api.svg?branch=master)](https://travis-ci.org/nicolasduval/datalab-api)
[![Code Climate](https://codeclimate.com/github/nicolasduval/datalab-api/badges/gpa.svg)](https://codeclimate.com/github/nicolasduval/datalab-api)
[![Test Coverage](https://codeclimate.com/github/nicolasduval/datalab-api/badges/coverage.svg)](https://codeclimate.com/github/nicolasduval/datalab-api/coverage)

## Synopsis   

Manage post-production projects, workflow and deliveries.  

## Requirements   
Ruby 2.0.0     
postgreSQL 9.3



## API Documentaion

Visit the [API](http://nicolasduval.github.io/datalab-docs/) documentations.


## Installation

Clone the repository.

```shell
  $ git clone https://github.com/nicolasduval/datalab-api.git
```

Install dependencies

```shell
  $ bundle install
```


Migrate the database

```shell
  $ rake db:migrate
```

Run the server

```shell
  $ rails server
```


## Authorization
The API is secured by an Authorization Token Key.    
Each requests made to the API must have a authorization token in the header.   
`-H "Authorization: Token token='959c3652a091b01687c29677dafcff7b' "`  
To create a new token run the the following command.   

```
  
  $ rake db:create:api_key[username]

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
Requests made to this controllers will not stored in the Database.   

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


## Rake Tasks
```
  rake db:create:api_key[username]        # create new API Key, Usage: db:list:api_key[username]
  rake db:list:api_key                    # List API Keys, Usage: db:list:api_key
  rake db:seeds                           # seeds, Usage: db:seeds
```
## Contributing

1. Create a feature branch with your changes.
2. Write some test cases.
3. Make all the tests pass.
4. Issue a pull request.

## LICENSE

(The MIT License)

Copyright (c) 2016 Nicolas Duval <nduval.dev@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

