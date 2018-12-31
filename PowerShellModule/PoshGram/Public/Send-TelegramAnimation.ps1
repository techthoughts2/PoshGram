<#
chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
animation 	InputFile or String 	Yes 	Animation to send. Pass a file_id as String to send an animation that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an animation from the Internet, or upload a new animation using multipart/form-data. More info on Sending Files »
duration 	Integer 	Optional 	Duration of sent animation in seconds
width 	Integer 	Optional 	Animation width
height 	Integer 	Optional 	Animation height
thumb 	InputFile or String 	Optional 	Thumbnail of the file sent. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 90. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
caption 	String 	Optional 	Animation caption (may also be used when resending animation by file_id), 0-1024 characters
parse_mode 	String 	Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
disable_notification 	Boolean 	Optional 	Sends the message silently. Users will receive a notification with no sound.
reply_to_message_id 	Integer 	Optional 	If the message is a reply, ID of the original message
reply_markup 	InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply 	Optional 	Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.

#>