class @AssetUpload
  constructor: (e, owner) ->
    self = this
    @files = e.target.files

    _.each @files, (file) ->
      self.upload_file file, owner

  upload_file: (file, owner) ->
    reader = new FileReader()
    reader.onload = (e) =>
      @sendToServer file, reader, owner
    reader.readAsBinaryString file

  sendToServer: (file, reader, owner) ->
    Meteor.call 'createAsset', reader.result, file.name, file.size, file.type, owner
