var fs = require("fs");
var gramatica = require("./gramatica");

fs.readFile("./entrada.txt", (err, data) => {
  if (err) throw err;
  gramatica.parse(data.toString());
});
