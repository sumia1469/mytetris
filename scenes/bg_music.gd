extends Node

const intro_music = preload("res://asset/introBg.ogg")
const play_music = preload("res://asset/play.ogg")
const play2_music = preload("res://asset/play2.ogg")
const block_effect = preload("res://asset/block1.ogg")
const block2_effect = preload("res://asset/block2.ogg")
const block3_effect = preload("res://asset/block3.ogg")
const block4_effect = preload("res://asset/block4.ogg")
const levelup_sound = preload("res://asset/levelupSound.ogg")  # levelupSound 추가
const loss_effect_sound = preload("res://asset/lossEffect.ogg")  # lossEffectSound 추가

var music_players = []

func _ready():
	# 초기화 시 음악 플레이어를 생성하여 리스트에 추가
	for i in range(4):
		var player = AudioStreamPlayer.new()
		add_child(player)
		music_players.append(player)
	# play_music_intro()

func _play_music(music: AudioStream, loop=false, volume = 0.0):
	var player = AudioStreamPlayer.new()
	add_child(player)
	player.stream = music
	player.volume_db = volume
	player.play()
	player.stream.loop = loop  # 루프 설정
	music_players.append(player)

func play_music_intro():
	_play_music(intro_music, true)
	
func play_music_play():
	_play_music(play2_music, true)    

func stop_music(music: AudioStream):
	for player in music_players:
		if player.stream == music:
			player.stop()
			remove_child(player)
			music_players.erase(player)

func stop_all_music():
	for player in music_players:
		player.stop()
		remove_child(player)
	music_players.clear()

func pause_music(music: AudioStream):
	for player in music_players:
		if player.stream == music:
			player.playing = false  # 일시 중지

func resume_music(music: AudioStream):
	for player in music_players:
		if player.stream == music:
			player.playing = true  # 재개

func play_fx(stream: AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()

	await fx_player.finished
	fx_player.queue_free()

func effect_block_play():
	play_fx(block_effect)   

func effect_block2_play():
	play_fx(block2_effect)   

func effect_block3_play():
	play_fx(block3_effect)   

func effect_block4_play():
	play_fx(block4_effect ,3.0)

func play_levelup_sound():
	play_fx(levelup_sound)  # levelupSound 재생 함수 추가

func play_loss_effect_sound():
	play_fx(loss_effect_sound, -2)  # lossEffectSound 재생 함수 추가
