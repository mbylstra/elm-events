// Main entrypoint file
require( '../dist/index.html' );

// pull in desired CSS/SASS files
// require( './bower_components/foundation-sites/scss/foundation.scss');
require( './bower_components/foundation-sites/dist/foundation.css');
require( './styles/app.scss' );

var Elm = require( './Main' );
Elm.embed( Elm.Main, document.getElementById( 'main' ) );
