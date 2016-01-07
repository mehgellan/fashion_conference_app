#Intro Active Record Models
<img src="https://media.giphy.com/media/vjmSleUsnXU8o/giphy.gif" width="400" title="The files are in the computer!" alt="Zoolander Screenshot">

In this lab we will explore the "M" in our "MVC" (Model View Controller) rails architecture by building an application for a fashion conference:

* Generate `Speaker` and `Talk` models that inherit from `ActiveRecord`
* Play with ActiveRecord ORM methods for creating and querying talk records
* Write a seed task that populates the database with records

####0. The `rails new` command
We will be using the `rails new` command on the command-line to auto-magically scaffold and configure our rails application.

Try typing `rails --help`, and you'll see this informative output:

    Usage:
      rails new APP_PATH [options]

Let's try it out!

####1. Create a new rails application
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

Take a moment to look around!

####2. Create a `Talk` model
``` bash
rails g model talk topic:string duration:integer
git diff # take a look at the files you just created!
```

And take a look at the following files:  
* `app/models/talk.rb`
* `db/migrate/1234566789_create_talks.rb`

Stop and commit! Then run `git diff` to see what changed.

####3. Setup your database
Next, create your application database:
```bash
rake db:create # create a new database on your machine
rake db:migrate # instruct your database what tables it needs to contain
```

> You may see errors if postgres isn't configured/linked correctly on your machine. Flag down an instructor for help. As a last resort, download and then launch Postgres.app. You will see an elephant in your menu if it's running.

Stop and commit! Then run `git diff` to see what changed.

####4. Launch the rails console and create your first talk!
```bash
rails console
# or
rails c
```

**Confirm that your model exists**  
```ruby
Talk
 #=> Talk(id: integer, topic: string, duration: integer, created_at: datetime, updated_at: datetime)
```

> Note that we never told our database to add fields for `id`, `created_at` and `updated_at`. These are added automatically and we generally won't interact with them directly!

(You may need to "connect" to your database in the rails console the first time you do this. Just follow the instructions.)

**Create your first record**!
``` ruby
# reminder: create = new + save
Talk.create({topic: "But why male models?"})
Talk.count
Talk.all
```

> **Pro-Tip**: Remember, when you're working in the console/repl `up-arrow` is your friend! (That and "hanging a dot" + "double-tabbing").

####5. Create and query Talk records

Here's some data to play with:
```ruby
talks_data = [
    {:topic=>"A School for Ants?", :duration=>90},
    {:topic=>"Hansel: He's so hot right now", :duration=>45},
    {:topic=>"Ambi-turning", :duration=>30},
    {:topic=>"Orange Mocha Frappuccino", :duration=>30}
]
```

**Exercises:** 
* Create 3 new Talks in the Rails Console.
* Delete the last talk you created
* Find only the first talk
* Find only the last two talks
* Search by id
* Search by topic
* Sort by topic (alphabetically)
* Sort by duration (shortest to longest)
* Update the topic of the last talk you created
* Delete all the talks you created.

<details>
<summary>**ActiveRecord Base command hints** (Click here)</summary>
**Class Methods**

* create
* count
* all
* find
* first
* last
* update
* destroy_all
* ...

**Instance Methods**

* save
* update
* create_or_update
* delete
* destroy
* ...
</details>

Rails Guides: [Active Record Basics](http://guides.rubyonrails.org/active_record_basics.html), [Active Record Query Interface](http://guides.rubyonrails.org/active_record_querying.html)
Method Reference: http://apidock.com/rails/v4.2.1/ActiveRecord/Base

####6. Can you seed your database?
Take a look at `db/seed.rb`.

Add the following line:
```ruby
p "Hello from seed.rb"
```

Now run the following from your command line (not the console!):
```bash
rake db:seed
# Hello from seed.rb
```

One interesting thing about your `seed.rb` file is that it _already_ knows about all of the models and gems in your rails application environment. Just tell it what data to create!

<details>
<summary>**Can you seed your database with talks?** (Click Here)</summary>
```ruby
    #seed.rb
    talks_data = [
        {:topic=>"Monitored static moderator", :duration=>90},
        {:topic=>"Reactive bottom-line complexity", :duration=>45},
        {:topic=>"Distributed logistical access", :duration=>30},
        {:topic=>"Realigned optimal knowledge base", :duration=>30},
        {:topic=>"Polarised exuding database", :duration=>15}
    ]
    Talk.create(talks_data) # one single database write, 5 talks created
```
</details>

<details>
<summary>**Can you seed your database using FFaker?** (Click Here)</summary>

First: Make sure to add the `ffaker` gem to your `Gemfile` (and don't forget to bundle!).

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
</details>

**Bonus**: Can you create a `Speaker` model and seed it?
