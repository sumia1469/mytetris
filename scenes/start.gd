extends Node2D


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
	BgMusic.stop_music_intro()
	$AnimationPlayer.play("Start/FadeOut")
	$AnimationPlayer.play("Start/ButtonEffect")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/tile_map.tscn")


func _on_options_pressed() -> void:
	$AnimationPlayer.play("Start/FadeOut")
	$AnimationPlayer.play("Start/ButtonEffect")
	await $AnimationPlayer.animation_finished
	pass # Replace with function body.
