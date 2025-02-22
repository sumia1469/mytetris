extends AudioStreamPlayer

const intro_music = preload("res://asset/introBg.ogg")
const start_music = preload("res://asset/play.ogg")
func _play_music(music : AudioStream, volumn = 0.0):
	if stream == music :
		return 
	stream = music
	volume_db = volumn
	play()
	
func play_music_intro():
	_play_music(intro_music)

func stop_music_intro():
	stop()
	
func play_fx(stream:AudioStream, volumn = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volumn_db = volumn
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	fx_player.queue_free()
	
