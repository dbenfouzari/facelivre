fs = Npm.require('fs')
mime = Meteor.npmRequire('mime')
WebApp.rawConnectHandlers.use (req, res, next) ->
  re = /^\/uploads\/(.*)$/.exec(req.url)
  if re isnt null # Only handle URLs that start with /uploads/*
    filePath = "C:/Projects/Meteor/facelivre/public/.#uploads/" + re[1]
    type = mime.lookup(filePath)
    data = fs.readFileSync(filePath, data)
    res.writeHead 200,
      "Content-Type": type

    res.write data
    res.end()
  else # Other urls will have default behaviors
    next()
  return
