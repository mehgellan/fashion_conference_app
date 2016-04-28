# <img src="https://cloud.githubusercontent.com/assets/7833470/10423298/ea833a68-7079-11e5-84f8-0a925ab96893.png" width="60"> Active Record

<img src="https://media.giphy.com/media/vjmSleUsnXU8o/giphy.gif" width="400" title="The files are in the computer!" alt="Zoolander Screenshot">

In this lab we will explore the "M" in our "MVC" (Model View Controller) Rails architecture by building an application for a fashion conference.

Lab Goals:
* Generate `Speaker` and `Talk` models
* Use ActiveRecord ORM methods to create and query records
* Write a seed file and run the `db:seed` task to populate the database with records
* Add methods to models for validations and rich behavior

## A Rails App with Speakers

1. **Create a new rails application**

  We're using the `rails new` command on the command-line to auto-magically create and configure our Rails application.

  Try typing `rails --help` in your Terminal, and you'll see this informative output:

  ```bash
      Usage:
        rails new APP_PATH [options]
  ```

  Let's try it out!


  ``` bash
  # rails new APP_PATH [options]
  rails new conference_app -T -d=postgresql
  cd conference_app
  ```

  > We are using the `-T` (aka `--skip-test-unit`) and `-d postgresql` (aka `--database=postgresql`) options today -- postgresl is our preferred database. We'll talk about tests another day.

  Stop and commit!
  ``` bash
  git add . -A # add everything
  git commit -m "inital commit, rails application boilerplate"
  ```

  Take a moment to look around at your new app's file structure.  In particular, check out `db/schema.rb`.

1. **Generate a `Speaker` model.**

  ``` bash
  rails generate model speaker first:string last:string email:string
  git diff # show the files you just created!
  ```

  > `rails g` is shorthand for `rails generate`

  Examine the following new files:  
  * `app/models/speaker.rb`
  * `db/migrate/1234566789_create_speakers.rb`

  And take another look at your updated `db/schema.rb`!


  Stop and commit. Then run `git diff` to see what changed.

1. **Set up the database.**
  Next, create your application database:
  ```bash
  rake db:create # create a new database on your machine
  rake db:migrate # instruct your database to read and execute migration files
  ```

  > You may see errors if postgresql isn't configured/linked correctly on your machine. Flag down an instructor for help. As a last resort, download and then launch Postgres.app. You will see an elephant in your menu if it's running.

  Stop and commit! Then run `git diff` to see what changed.

1. **Launch the Rails console.**

  The Rails console is a Ruby REPL (like `pry` or `irb`) that comes with Rails and knows about your Rails app.

  ```bash
  rails console
  # or
  rails c
  ```

1. **Confirm that your model exists.**  
  ```ruby
  Speaker
   #=> Speaker(id: integer, first: string, last:string, email:string, created_at: datetime, updated_at: datetime)
  ```

  (You may need to "connect" to your database in the Rails console the first time you do this. Just follow the instructions Rails gives in the console.)

  > Note that we never told our database to add fields for `id`, `created_at` and `updated_at`. These are added automatically, and we generally won't interact with them directly.



1. **Create your first Speaker record!**
  ``` ruby
  # reminder: create = new + save
  Speaker.create({first: "Leroy", last: "Brown"})
  Speaker.count
  Speaker.all  
  ```

  > **Pro-Tip**: Remember, when you're working in the console/repl `up-arrow` is your friend! (That and "hanging a dot" + "double-tabbing").



## Record Creation and Query Challenges


  **Create and query Speaker records in the Rails console.**

  Here's some data to play with:
  ```ruby
  speakers_data = [
      {:first=>"Cory", :last=>"Fauver", :email=>"cory@example.com"},
      {:first=>"Juliana", :last=>"Lopker", :email=>"juliana@example.com"},
      {:first=>"Will", :last=>"Cauthen", :email=>"will@example.com"},
      {:first=>"Nick", :last=>"Brennan", :email=>"nick@example.com"}
  ]
  ```

* Create 3 new speakers in the Rails Console.
    <details><summary>solution</summary>

    ```ruby
    Speaker.create(speakers_data)
    ```
  </details>
* Delete the last speaker you created.
    <details><summary>solution</summary>

    ```ruby
    Speaker.last.destroy
    ```
  </details>
  
* Find only the first speaker.
    <details><summary>solution</summary>

    ```ruby
    Speaker.first
    ```
  </details>
  
* Find only the last two speakers.
    <details><summary>solution</summary>

    ```ruby
    Speaker.last 2
    ```
  </details>
  
* Find a speaker by id (try id `1`).
    <details><summary>solution</summary>

    ```ruby
    Speaker.find_by_id 1
    # or
    Speaker.find_by id: 1
    ```
  </details>
  
* Find a speaker by first name.
    <details><summary>solution</summary>

    ```ruby
    Speaker.find_by_first_name "Nick"
    # or
    Speaker.find_by(first_name: "Nick")
    ```
  </details>
  
* Sort by last name (alphabetically).
    <details><summary>solution</summary>

    ```ruby
    Speaker.order(:last_name)
    ```
  </details>
  
* Update the email of the last speaker you created.
    <details><summary>solution</summary>

    ```ruby
    Speaker.last.update(email: "newemail@example.com")
    ```
  </details>
  
* Delete all the speakers you created.
    <details><summary>solution</summary>

    ```ruby
    Speaker.destroy_all
    ```
  </details>


**Resources**:

* ActiveRecord partial method list

    * Class Methods: `all`,  `create`, `count`, `delete_all`, `destroy_all`, `find`, `first`, `last`, `order`, ...

    * Instance Methods:  `delete`, `destroy`,  `save`, `update`, ...
  
* [Active Record Basics Rails Guide](http://guides.rubyonrails.org/active_record_basics.html)
 
* [Active Record Query Interface Rails Guide](http://guides.rubyonrails.org/active_record_querying.html)

* http://api.rubyonrails.org/classes/ActiveRecord/Base.html

## Seeding Data

1. **Take a look at `db/seed.rb`.**

  Add the following line:
  ```ruby
  p "Hello from seed.rb"
  ```

  Now run the following from your command line (not the console!):
  ```bash
  rake db:seed
  # Hello from seed.rb
  ```

  One interesting thing about your `seed.rb` file is that Rails has set it up to _already_ know about all of the models and gems in your application environment. Just tell it what data to create!

1. **Seed your database with speakers.**

  Create an array of speaker data hashes, with at least three speakers.  Use `Speaker.create` on the array to create all the speakers at once!

  <details>
  <summary>solution</summary>
  ```ruby
      #seed.rb
      speakers_data = [
          {:first=>"Cory", :last=>"Fauver", :email=>"cory@example.com"},
          {:first=>"Juliana", :last=>"Lopker", :email=>"juliana@example.com"},
          {:first=>"Will", :last=>"Cauthen", :email=>"will@example.com"}
      ]
      Speakers.create(speakers_data) # one single database write, 3 speakers created
  ```
  </details>

  Run `rake db:seed` again, and then check all your speakers from inside the Rails console.

1. **Delete old seed records when you seed.**

  Add a line in your seed file to do `Speakers.delete_all` before the new speakers are created.

  <details>
  <summary>solution</summary>
  ```ruby
  #seed.rb
  # before Speakers.create(speakers_data)
  Speakers.destroy_all
  ```
  </details>

  Stop and commit!

1. **Include the [FFaker](https://github.com/ffaker/ffaker) gem in your project.**

  Add the `ffaker` gem to your Gemfile, and then `bundle`.

1. **Update your seed file to use FFaker data.**

  Take a look at the FFaker documentation linked above. Use ``FFaker`` to generate names and email addresses for 10 speakers, and add them to your database.

  > Check out ffaker's [REFERENCE.md](https://github.com/ffaker/ffaker/blob/master/REFERENCE.md) for a comprehensive list of the kind of data available.

  <details>
  <summary>solution</summary>
  ```ruby
  #seed.rb
  speakers_data = []
  10.times do
    speakers_data << {
      first: FFaker::Name.first_name,
      last: FFaker::Name.last_name,
      email: FFaker::Internet.safe_email
    }
  end

  Speaker.create(speakers_data)
  ```
  </details>

  Stop and commit!

## Validations

1. **Add a built-in validator to the `Speaker` model.**

  Rails has built-in validations we can use to validate data before it's saved into the database.
  
  Conference organizers want some way to get in touch with speakers.  Add a validation inside the `Speaker` model class to make sure each speaker has an email address:
  
  ```ruby
  # app/models/speaker.rb
  class Speaker < ActiveRecord::Base
    validates :email, presence: true
  end
  ```

1. **Test the validation in Rails console.**

  Back in your Rails console, try creating a speaker without an email address.  You should see `ROLLBACK` in the Rails console instead of `COMMIT`, meaning there was no change to your database. 
  
  Let's use the Rails console to see what happened:
  
  ```ruby
  > s = Speaker.create({})
     (0.2ms)  BEGIN
     (0.3ms)  ROLLBACK
    => #<Speaker id: nil, first: nil, last: nil, email: nil, created_at: nil, updated_at: nil>
  > s.valid?
    => false
  > s.errors.any?
    => true
  > s.errors.messages
    => {:email=>["can't be blank"]}
  ```
  
  Just as expected, our validation didn't pass, and we got an error message. 
  
  See the Rails Guide on [Validations](http://guides.rubyonrails.org/active_record_validations.html) for more information on using validations, including how to create custom validations.
  
  Stop and commit!

## Model Methods

A Rails model is just a class. We can create instance methods to add behaviors we might want to use in other parts of the app.

1. **Add an instance method to the `Speaker` model.**

  Create a simple instance method using `FFaker` to have the speaker do a little speaking:
  
  ```ruby
  # app/models/speaker.rb
  class Speaker < ActiveRecord::Base
    validates :email, presence: true
    def speechify(blabber_duration=1)
      FFaker::HipsterIpsum.sentence(blabber_duration)
    end
  end
  ```

1. **Use the instance method.**

  In a real Rails app, an instance method might be used in the view.  However, it's a good idea to test it in the Rails console.
  
  ```ruby
  > Speaker.first.speechify 2
      Speaker Load (0.6ms)  SELECT  "speakers".* FROM "speakers"  ORDER BY "speakers"."id" ASC LIMIT 1
    => "American apparel fab trust fund fixie farm-to-table. Blog mixtape retro +1 organic."
  ```

  Stop and commit!
  
## Bonus Challenges: `Talk` model

1. Create a `Talk` model with attributes: `topic` (a string), `duration` (an integer), and `start_time` (a `datetime`).

  <details><summary>solution</summary>
  
  ``` bash
  rails g model talk topic:string duration:integer start_time:datetime
  ```
  </details>

2. Can you create a `Talk` model and seed it?


  ``` bash
  rails g model talk topic:string duration:integer start_time:datetime
  git diff # take a look at the files you just created!
  ```

  ```ruby
  talks_data = [
      {:topic=>"A School for Ants?", :duration=>90, :start_time=>DateTime.now-(1.0/24)},
      {:topic=>"Hansel: He's so hot right now", :duration=>45, :start_time=>Date.now+(23.0/24)},
      {:topic=>"Ambi-turning", :duration=>30, :start_time=>Date.now+(2.0/24)},
      {:topic=>"Orange Mocha Frappuccino", :duration=>30, :start_time=>Date.now+(4.0/24)}
  ]
  ```


  * Select all the speakers with start times in the future

  ```ruby
  #seed.rb
  Talk.destroy_all # super dangerous!

  10.times do
      Talk.create({  # 10 seperate database writes
          topic: FFaker::Company.catch_phrase,
          duration: [30,45,60,90].sample,
      })
  end
  ```
