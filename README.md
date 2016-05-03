# imagewiki-frontend
Imagewiki frontend app built with AngularJS

## Install

##### NVM / NODE

Follow the instructions on this [guide](https://github.com/Devlandia/gulp2ghpages#install-nodejs--npm-via-nvm)

##### Gulp / Yeoman / Bower / CoffeeScript- Globally

    npm install gulp yo bower coffee-script -g

##### After update Node version

    npm rebuild node-sass

## Install dependencies

Inside the repo folder run:

    npm install

then:

    bower install

## Running local server

Gulp will take charge of serving the files locally. Run this:

    gulp serve

## CLI environment parameter

You can set the environment when running gulp tasks adding `--env [environment]` to the CLI command.

For example if you want to serve the files locally but using a local API hosted on port 3100.

    gulp serve --env local

## Deploying the App

The `gulp-gh-pages´ package will deploy the app to Github Pages.

#### Deploying to development website ([imagewiki.github.io](http://imagewiki.github.io))

    gulp deploy

  or

    gulp deploy --env development

The `--env development` is implied here so it's not really necessary adding it.

#### Deploying to production website ([image.wiki](http://image.wiki))

    gulp build --env production
    gulp deploy --env production

Addin the `--env production` will not only change the `API_URL` constant on the Angular App but will also add the `CNAME` file to the build and point the `gh-pages` to a different github repository.
