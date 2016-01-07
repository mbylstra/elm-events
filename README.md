# Elm Events
View website at http://mbylstra.github.io/elm-events.

## Contributors
Submit a pull request or just file an issue if you'd like to add an event.

This website uses https://github.com/pmdesgn/elm-webpack-starter.
See below for instructions on how to use it:

# elm-webpack-starter

A simple Webpack setup for writing [Elm](http://elm-lang.org/) apps:

* Dev server with live reloading
* Support for CSS/SCSS, with Autoprefixer
* Bundling and minification for deployment
* Basic app scaffold, integrating Elm's official [StartApp](https://github.com/evancz/start-app) package
* A snippet of example code to get you started!

### Install:
```
git clone git@github.com:mbylstra/elm-events.git
cd elm-webpack-starter
npm install
```

If you haven't done so yet, install Elm globally:
```
npm install -g elm
```

Install Elm's `start-app` package:
```
elm package install evancz/start-app
```

### Serve locally:
```
npm start
```
* Access app at `http://localhost:8080/`
* Get coding!
* Browser will refresh automatically on any file changes..


### Build & bundle for prod:
```
npm run build
```

* Files are saved into the `/dist` folder
* To check it, open `dist/index.html`
* To publish the `/dist` folder to your repo's `gh-pages`, commit any changes then:
```
git subtree push --prefix dist origin gh-pages
open http://<your-github-account>.github.io/elm-webpack-starter/
```
