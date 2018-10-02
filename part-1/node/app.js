var express = require("express");
var app = express();

var msg = process.env.MESSAGE || "Knative on OpenShift";

app.get("/", function(req, res, next) {
  res.status(200).send(msg);
});

app.listen(8080, function() {
  console.log("App started in port 8080");
});
