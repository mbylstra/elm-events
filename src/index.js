// pull in desired CSS/SASS files
require( './bower_components/foundation-sites/dist/foundation.css');
require( './styles/app.scss' );

var Elm = require( './Main' );
Elm.Main.embed( document.getElementById( 'main' ) );
