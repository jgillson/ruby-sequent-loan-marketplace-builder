# ruby_sequent_loan_marketplace_builder

> A proof-of-concept Ruby application using [Rails](https://rubyonrails.org/) and [Sequent](https://www.sequent.io/).

## Up and running (basic development set-up)

**NOTE**: This section describes a typical set up on a machine running MacOS

### Getting Started

1. Create and/or add your local SSH [public] key to your Github account:

   Instructions on how to check and/or add your SSH key can be found here:
    - [Checking for existing SSH keys](https://docs.github.com/en/github/authenticating-to-github/checking-for-existing-ssh-keys)
    - [Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)


2. Install **Homebrew:**

    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```


3. Install brew packages

   ```bash
   brew install autoconf awscli cmake coreutils direnv git gnupg hub imagemagick libffi libxml2 libyaml openssl pinentry pkg-config postgresql shared-mime-info readline mkcert nss
   ```


4. Clone the repository to your local working directory

    ```bash
    git clone git@github.com:jgillson/ruby-sequent-loan-marketplace-builder.git
    ```

5. Set up your GPG key for github:

   [Generating a new GPG key](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key)

   [Adding a GPG key to your github](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/adding-a-new-gpg-key-to-your-github-account)

   Configure git to sign commits using your GPG key:

    * For `zsh`

    ```bash
    export GPG_TTY=$TTY
    ```
    * *or for* `bash`

    ```bash
    export GPG_TTY=$(tty)
    ```

    * Then, for either shell:

    ```bash
    echo "test" | gpg --clearsign
    git config --global user.signingkey <your_signingkey>
    git config --global commit.gpgsign true
    git config --global gpg.program gpg
    ```


6. Use **direnv** to manage project environment variables

   Hook **direnv** into your shell:

    - [zsh](https://github.com/direnv/direnv/blob/master/docs/hook.md#zsh)
    - [bash](https://github.com/direnv/direnv/blob/master/docs/hook.md#bash)

   Setup **direnv** for the project:

   ```bash
   # You can now create a `.envrc` file in the root of a project and drop in any pertinent environment variables
   # Then expose them
   direnv allow
   ```


7. Install **asdf VM** (version manager for managing runtimes)

   > this is an alternative (using a plugin-based approach) for runtime management versus going one-by-one for each platform (e.g., nvm, rvm, rbenv)

   ```bash
   brew install asdf
   ```

   asdf help / list all commands:

   ```bash
   asdf # without arguments
   ```

   _Note: if there are any errors with the `asdf` installation such as:_
   ```bash
   asdf --version
   cat: /usr/local/VERSION: No such file or directory
   ```

   _Add this to your `.zshrc`, `.bashrc` or `.bash_profile`_

   ```bash
   . $(brew --prefix asdf)/asdf.sh
   ```
   then close the terminal and open a new one to refresh the source files.

   Get a Ruby runtime:

   ```bash
   # Install the Ruby plugin:
   asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

   # Or update it if already installed
   asdf plugin-update ruby

   # Install a version of the Ruby runtime and use it:
   asdf list-all ruby
   asdf install ruby <version> # likely doesn't match your system version, please check the project/Gemfile

   # Set/scope the local (project/directory Ruby version)
   asdf local ruby <version> # the one that you likely just installed)
   asdf global ruby system` # you can stick to the system or another installed version of Ruby system-wide/outside this project)
   ```

   Install other runtimes (Python, Elixir, etc) | **NOTE**: not needed for this project:

    - List of available plugins [here](https://asdf-vm.com/#/plugins-all)
    - From CLI:

      ```bash
      asdf plugin-list-all | grep <language/platform>
      ```

8. Install **Docker** (desktop)

- follow instructions [here](https://docs.docker.com/docker-for-mac/install/)
- open `Docker` to ensure helpers like `docker-compose` are installed.


9. Install **Bundler** via a rubygems system update and project dependencies:

   ```bash
   gem update --system 3.2.26
   gem install bundler:2.2.26
   bundle install
   ```
   _Note_: If you get an error like: `"You don’t have write permissions for the /Library/Ruby/Gems/2.7.0 directory."` then you may have missed part of step 9 above. Also quit and reopen your terminal!
   _Note_: If there are any installation errors with the gems when running bundle install, document the config config solutions below:

   ```bash
   gem install debase -v '0.2.5.beta1' -- --with-cflags="-Wno-error=implicit-function-declaration"
   ```


10. Verify that you have a current version of Ruby installed:

     ```
     $ ruby -v
     ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-darwin20]
     ```
    _Note: Sequent requires Ruby version 2.5.0 or later_


11. Verify that you have a current version of Postgres installed:

    ```
    $ pg_config --version
    PostgreSQL 14.1
    ```

12. Start the Dockerized backend services:

    ```
    docker-compose up
    ```

13. Enter the project folder from where you cloned the project in Step 4. and run the following commands:

    ```
    gem install bundler
    bundle install
    rails db:create
    rails db:migrate
    bundle exec rake sequent:db:create_event_store
    bundle exec rake sequent:db:create_event_store RAILS_ENV=test
    bundle exec rake sequent:db:create_view_schema
    bundle exec rake sequent:db:create_view_schema RAILS_ENV=test
    bundle exec rake sequent:migrate:online
    bundle exec rake sequent:migrate:online RAILS_ENV=test
    ```

    _Note: If your database already exists and you just need to create the `event_store` schema and the `view_schema` then run:_

    ```
    bundle exec rake sequent:db:create_event_store
    bundle exec rake sequent:db:create_event_store RAILS_ENV=test
    bundle exec rake sequent:db:create_view_schema
    bundle exec rake sequent:db:create_view_schema RAILS_ENV=test
    bundle exec rake sequent:migrate:online
    bundle exec rake sequent:migrate:online RAILS_ENV=test
    ```

14. Start the app:

    `rails s`

Call the API - the easiest way to do this is to import
[the provided postman collection](ruby-sequent-loan-marketplace-builder.postman_collection.json) into your Postman client.


15. To run tests:

    `bundle exec rake spec`

    ```
    Finished in 3.47 seconds (files took 1.46 seconds to load)
    37 examples, 0 failures
    ```
