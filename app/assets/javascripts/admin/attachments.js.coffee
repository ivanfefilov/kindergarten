window.dropzoneInit= (autosave) ->
	that = this
	Dropzone.autoDiscover = false
	# grap our upload form by its id
	$("#new_attachment").dropzone
		paramName: 'attachment[file]'
		addRemoveLinks: true
		dictDefaultMessage: 'Нажмите здесь для загрузки фотографий'
		maxFilesize: 10
		maxFiles: 20
		parallelUploads: 20
		addRemoveLinks: true
		dictMaxFilesExceeded: "Вы не можете загрузить больше 20-ти фотографий за один раз"
		dictRemoveFile: "Удалить"
		dictCancelUploadConfirmation: "Отменить загрузку?"

		init: () ->
			thisDropzone = this
			$.getJSON this.element.action, (data) ->
				$.each data, (key,value ) ->
					mockFile = { type: value.type, name: value.file_name, size: value.size }
					thisDropzone.options.addedfile.call(thisDropzone, mockFile)
					thisDropzone.options.thumbnail.call(thisDropzone, mockFile, value.thumb_url)
					$(mockFile.previewElement).find(".dz-remove").attr('id', value.id)
					$(mockFile.previewElement).attr('data-id', value.id)
					$(mockFile.previewElement).attr('data-pos', key+1)
					$(mockFile.previewElement).addClass "dz-success"
					$(mockFile.previewElement).find('.dz-progress').remove();
					thisDropzone.files.push(mockFile)

		accept: (file, done) ->
			if ((file.type).toLowerCase() != "image/jpg" &&
					(file.type).toLowerCase() != "image/gif" &&
					(file.type).toLowerCase() != "image/jpeg" &&
					(file.type).toLowerCase() != "image/png" &&
          (file.type).toLowerCase() != "application/pdf"
          )
				done("Invalid file");
			else
				done();

		maxfilesexceeded: ()->
			return false
		# if the upload was successful
		success: (file, response) ->
			$(file.previewTemplate).find(".dz-remove").attr "id", response.id
			$(file.previewElement).addClass "dz-success"
			return

		removedfile: (file) ->
			thisDropzone = this
			thisTemplate = $(file.previewTemplate)
			id = $(file.previewTemplate).find(".dz-remove").attr("id")
			if not id
				return thisTemplate.remove()
			# make a DELETE ajax request to delete the file
			$.ajax
				type: "DELETE"
				url: thisDropzone.options.url + "/" + id
				success: (data) ->
					thisTemplate.remove()
					console.log data.message
$ ->
	if $('.edit-post').length
		window.dropzoneInit();
		return
