extends Node2D

var is_start_pressed = false  # 게임 시작 버튼 눌림 상태 변수
var is_options_pressed = false  # 옵션 버튼 눌림 상태 변수

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BgMusic.play_music_intro()
	$AnimationPlayer.play("Start/FadeIn")
	await get_tree().create_timer(1.0).timeout
	$StartFadeIn.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_game_start_pressed() -> void:
	if is_start_pressed:
		return  # 이미 눌린 경우 함수 종료
	is_start_pressed = true  # 버튼 눌림 상태 설정

	$AnimationPlayer.play("Start/ButtonEffect")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("Start/FadeOut")
	await $AnimationPlayer.animation_finished
	if BgMusic:
		BgMusic.stop_music(BgMusic.intro_music)
	get_tree().change_scene_to_file("res://scenes/tile_map.tscn")

func _on_options_pressed() -> void:
	if is_options_pressed:
		return  # 이미 눌린 경우 함수 종료
	is_options_pressed = true  # 버튼 눌림 상태 설정

	$AnimationPlayer.play("Start/ButtonEffect")
	await $AnimationPlayer.animation_finished
	if BgMusic:
		BgMusic.stop_music(BgMusic.intro_music)
	pass # Replace with function body.
