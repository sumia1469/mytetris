extends Node

const intro_music = preload("res://asset/introBg.ogg")
const start_music = preload("res://asset/play.ogg")

var music_player: AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	play_music_intro()

func _play_music(music: AudioStream, volume = 0.0):
	if music_player.stream == music:
		return
	music_player.stream = music
	music_player.volume_db = volume
	music_player.play()

func play_music_intro():
	_play_music(intro_music)

func stop_music_intro():
	music_player.stop()

func play_fx(stream: AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()

	await fx_player.finished
	fx_player.queue_free()
