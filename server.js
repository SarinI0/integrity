#!/usr/bin/env node.js
var express = require('express');  
var request = require('request');

var app = express();  
app.use('/proxy', function(req, res) {  
  var url = req.url.replace('/?url=','');
  console.log(req)
  req.pipe(request(url)).pipe(res);
});

app.listen(process.env.PORT || 3000); 



