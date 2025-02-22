extends Node

const intro_music = preload("res://asset/introBg.ogg")
const play_music = preload("res://asset/play.ogg")
const play2_music = preload("res://asset/play2.ogg")

var music_player: AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	# play_music_intro()

func _play_music(music: AudioStream, volume = 0.0):
	if music_player.stream == music:
		return
	var stream = music.duplicate()  # 스트림을 복제하여 loop 설정
	stream.loop = true  # 루프 설정
	music_player.stream = stream
	music_player.volume_db = volume
	music_player.play()

func play_music_intro():
	_play_music(intro_music)
	
func play_music_play():
	_play_music(play2_music)    

func stop_music_intro():
	music_player.stop()

func pause_music():
	if music_player.playing:
		music_player.playing = false  # 일시 중지
	else:
		music_player.playing = true  # 재개

func play_fx(stream: AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer.new()
	var fx_stream = stream.duplicate()  # 스트림을 복제하여 loop 설정
	fx_stream.loop = true  # 루프 설정
	fx_player.stream = fx_stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()

	await fx_player.finished
	fx_player.queue_free()
