var fs = require("fs");
var gramatica = require("./gramatica");




var express = require('express');
var morgan = require('morgan');
var app = express();

app.use(morgan('dev'))
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.listen(8080, function () {
  console.log('app listening on port 8080!');
});


app.get('/', function (req, res) {
  fs.readFile("./entrada.txt", (err, data) => {
    if (err) throw err;
    gramatica.parse(data.toString());
    res.json({ msg: "ok" });
  });
  
});