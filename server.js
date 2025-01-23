const http = require('http'),
      fs   = require('fs'),
      port = 3000;

const server = http.createServer( function( request,response ) {
  //I added this mod so that the server redirects correctly even after form submit
  switch (request.url.split('?')[0]) {
    case '/':
      sendFile(response, 'index.html');
      break;
    case '/index.html':
      sendFile(response, 'index.html');
      break;
    case '/styles.css':
      sendFile(response, 'styles.css');
      break;
    case '/hobby':
      sendFile(response, 'hobby.html');
      break;
    case '/hobby.html':
      sendFile(response, 'hobby.html');
      break;
    case '/priv/static/dot_game.mjs':
    case '/app':
      response.setHeader("content-type", "text/javascript")
      sendFile(response, "./priv/static/todo_app.mjs");
      break;
    case '/mainjs':
      response.setHeader("content-type", "text/javascript")
      sendFile(response, "./main.js");
      break;
    default:
      response.end( '404 Error: File Not Found' );
  }
});

server.listen( process.env.PORT || port );

const sendFile = function( response, filename ) {
   fs.readFile( filename, function( err, content ) {
     response.end( content, 'utf-8' );
   });
}

console.log("started at http://localhost:3000")
