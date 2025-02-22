extends TileMap

# 테트로미노들
var i_0 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(3, 1)]
var i_90 := [Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 2), Vector2i(2, 3)]
var i_180 := [Vector2i(0, 2), Vector2i(1, 2), Vector2i(2, 2), Vector2i(3, 2)]
var i_270 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(1, 3)]
var i := [i_0, i_90, i_180, i_270]

var t_0 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var t_90 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var t_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var t_270 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
var t := [t_0, t_90, t_180, t_270]

var o_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_90 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_180 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_270 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o := [o_0, o_90, o_180, o_270]

var z_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)]
var z_90 := [Vector2i(2, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var z_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2), Vector2i(2, 2)]
var z_270 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(0, 2)]
var z := [z_0, z_90, z_180, z_270]

var s_0 := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1)]
var s_90 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(2, 2)]
var s_180 := [Vector2i(1, 1), Vector2i(2, 1), Vector2i(0, 2), Vector2i(1, 2)]
var s_270 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
var s := [s_0, s_90, s_180, s_270]

var l_0 := [Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var l_90 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(2, 2)]
var l_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(0, 2)]
var l_270 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2)]
var l := [l_0, l_90, l_180, l_270]

var j_0 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var j_90 := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(1, 1), Vector2i(1, 2)]
var j_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(2, 2)]
var j_270 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(0, 2), Vector2i(1, 2)]
var j := [j_0, j_90, j_180, j_270]

var shapes := [i, t, o, z, s, l, j]
var shapes_full := shapes.duplicate()

# 그리드 변수
const COLS : int = 10
const ROWS : int = 20

# 이동 변수
const directions := [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.DOWN]
var steps : Array
const steps_req : int = 50
const start_pos := Vector2i(5,1)
var cur_pos:Vector2i
var speed : float
const ACCEL : float = 0.1
var move_delay = 0.0.5  # 이동 속도 조절
var move_timer = 0.0

# 드래그 이동 속도 조절 변수
var drag_move_delay = 0.1
var drag_move_timer = 0.0

# 터치와 드래그 이벤트 구분 변수
var is_dragging = false
var touch_start_position = Vector2()
var last_touch_time = 0.0
var touch_delay = 0.5
var last_drag_time = 0.0
var drag_delay = 0.1

# 게임 조각 변수
var piece_type
var next_piece_type
var rotation_index : int = 0
var active_piece : Array

# 고스트 블록 변수
var ghost_piece : Array
var ghost_pos : Vector2i

# 게임 변수
var score : int
const REWARD : int = 1
var game_running : bool
var initial_score : int = 5  # 초기 점수
var move_limit : int = -1  # 움직임 제한 (-1은 무제한)
var move_count : int = 0  # 현재 움직임 횟수
var level : int = 1  # 현재 레벨
var is_paused = false

# 타일맵 변수
var tile_id : int = 0
var piece_atlas : Vector2i
var next_piece_atlas : Vector2i

# 레이어 변수
var board_layer : int = 0
var active_layer : int = 1
var ghost_layer : int = 2

# 드래그 방향 추적 변수
var drag_direction : String = ""

# 타이머 변수 초기화
var time_left = 10 * 60  # 10분 (초 단위)

# Called when the node enters the scene tree for the first time.
func _ready():
	BgMusic.play_music_play()
	#game satar
	new_game()
	var start_button = $HUD.get_node("StartButton")
	start_button.connect("pressed", Callable(self, "new_game"))
	start_button.focus_mode = Control.FOCUS_NONE  # 🔥 Spacebar 입력 차단

	var pause_button = $HUD.get_node("PauseButton")
	pause_button.connect("pressed", Callable(self, "pause_game"))
	pause_button.focus_mode = Control.FOCUS_NONE
	
	# 터치 이벤트 연결
	set_process_input(true)

# 터치 이벤트 처리
func _input(event):
	if is_paused :
		return 
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		var pause_button = $HUD.get_node("PauseButton")
		var start_button = $HUD.get_node("StartButton")
		if pause_button.get_global_rect().has_point(event.position) or start_button.get_global_rect().has_point(event.position):
			return 
			
	if event is InputEventScreenTouch:
		if event.pressed:
			print("터치 이벤트 감지됨")
			touch_start_position = event.position
			is_dragging = false
		elif not event.pressed:
			if not is_dragging:
				print("터치 이벤트 종료됨")
				handler_touch(event.position)
			drag_direction = ""  # 드래그가 끝나면 방향 초기화
	elif event is InputEventScreenDrag:
		if not is_dragging and touch_start_position.distance_to(event.position) > 10:
			is_dragging = true
		if is_dragging:
			print("드래그 이벤트 감지됨")
			handler_drag(event.relative)

# 터치 위치에 따라 조작
func handler_touch(position):
	print("터치 위치: ", position)
	rotate_piece()

# 드래그 위치에 따라 조작
func handler_drag(relative):
	print("드래그 상대 위치: ", relative)
	if drag_direction == "":
		if abs(relative.y) > abs(relative.x):
			drag_direction = "down"
		else:
			drag_direction = "side"

	if drag_direction == "down":
		if relative.y > 50:  # 강하게 드래그 시 바로 내림
			if Time.get_ticks_msec() - last_drag_time > drag_delay * 1000:
				drop_piece()
				last_drag_time = Time.get_ticks_msec()
		else:  # 약하게 드래그 시 빠르게 내림
			if drag_move_timer >= drag_move_delay:
				move_piece(Vector2i.DOWN)
				drag_move_timer = 0.0
	elif drag_direction == "side":
		if drag_move_timer >= drag_move_delay:
			if relative.x < 0:
				move_piece(Vector2i.LEFT)
			elif relative.x > 0:
				move_piece(Vector2i.RIGHT)
			drag_move_timer = 0.0

# 새로운 게임 시작
func new_game():
	# 변수 초기화
	level = 1
	initial_score = 5
	move_limit = -1
	start_level()

# 게임 시작 시 타이머 초기화
func start_level():
	# 변수 초기화
	score = initial_score
	speed = 1.0
	game_running = true
	is_paused = false
	steps = [0, 0, 0]  # 0:left 1:right, 2:down
	move_count = 0  # 움직임 횟수 초기화
	time_left = 10 * 60  # 10분 (초 단위)
	# if level > 1:
	#     move_limit = 200 - (level - 1) * 5  # 레벨에 따라 움직임 제한 설정
	# else:
	#     move_limit = -1  # 첫 번째 레벨은 무제한 이동
	$HUD.get_node("GameOverLabel").hide()
	$HUD.get_node("ScoreLabel").text = str(score)
	# if move_limit < 0:
	#     $HUD.get_node("MoveLabel").text = "무제한"
	# else:
	#     $HUD.get_node("MoveLabel").text = str(move_limit)
	$HUD.get_node("LevelLabel").text = str(level)
	# 클리어
	clear_board()
	clear_panel()
	
	# 레벨이 오를 때 하단에 랜덤 블록 추가
	if level > 1:
		add_random_blocks(level - 1)

	piece_type = pick_piece()
	piece_atlas = Vector2i(shapes_full.find(piece_type), 0)
	next_piece_type = pick_piece()
	next_piece_atlas = Vector2i(shapes_full.find(next_piece_type), 0)
	create_piece()
	BgMusic.resume_music(BgMusic.play2_music)


# 타이머 업데이트 및 표시
func _process(delta):
	if game_running:
		move_timer += delta
		drag_move_timer += delta  # 드래그 이동 타이머 업데이트

		# 타이머 업데이트
		time_left -= delta
		if time_left <= 0:
			game_over()
		else:
			var minutes = int(time_left) / 60
			var seconds = int(time_left) % 60
			$HUD.get_node("TimerLabel").text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)

		# 🔥 키 입력을 지속적으로 감지 (빠른 반응)
		if move_timer >= move_delay:
			if Input.is_action_pressed("ui_left"):
				move_piece(Vector2i.LEFT)
			elif Input.is_action_pressed("ui_right"):
				move_piece(Vector2i.RIGHT)
			elif Input.is_action_pressed("ui_down"):
				move_piece(Vector2i.DOWN)
			move_timer = 0.0  # 타이머 초기화
		
		# 🔥 Spacebar 즉시 실행 (한 번만)
		if Input.is_action_just_pressed("ui_accept"):
			drop_piece() 

		if Input.is_action_just_pressed("ui_up"):
			rotate_piece()
			
		# Apply downward movement every frame
		steps[2] += speed

		# Move the piece
		for i in range(steps.size()):
			if steps[i] > steps_req:
				move_piece(directions[i])
				steps[i] = 0  # 이동 후 초기화

func pick_piece():
	var piece
	if not shapes.is_empty():
		shapes.shuffle()
		piece = shapes.pop_front()
	else:
		shapes = shapes_full.duplicate()
		shapes.shuffle()
		piece = shapes.pop_front()
	return piece
	
func create_piece():
	# 변수 초기화
	steps = [0,0,0]
	cur_pos = start_pos
	active_piece = piece_type[rotation_index]
	draw_piece(active_piece, cur_pos, piece_atlas)
	clear_panel()
	draw_piece(next_piece_type[0], Vector2i(8,-3), next_piece_atlas)
	update_ghost_piece()

func clear_piece():
	for i in active_piece:
		erase_cell(active_layer, cur_pos + i)

func draw_piece(piece, pos, atlas):
	for i in piece:
		set_cell(active_layer, pos + i, tile_id, atlas)

func draw_ghost_piece(piece, pos, atlas):
	for i in piece :
		set_cell(ghost_layer, pos+i, tile_id, atlas)

func clear_ghost_piece():
	for i in ghost_piece:
		erase_cell(ghost_layer, ghost_pos + i)

func update_ghost_piece():
	clear_ghost_piece()
	ghost_piece = active_piece
	ghost_pos = cur_pos
	while can_move_piece(ghost_piece, ghost_pos + Vector2i.DOWN):
		ghost_pos += Vector2i.DOWN
	draw_ghost_piece(ghost_piece, ghost_pos, piece_atlas)

func rotate_piece():
	if can_rotate():
		clear_piece()
		clear_ghost_piece()
		rotation_index = (rotation_index + 1) % 4
		active_piece = piece_type[rotation_index]
		draw_piece(active_piece, cur_pos, piece_atlas)
		update_ghost_piece()
			
func move_piece(dir):
	if can_move(dir):
		clear_piece()
		clear_ghost_piece()
		cur_pos += dir
		draw_piece(active_piece, cur_pos, piece_atlas)
		update_ghost_piece()
	else:
		if dir == Vector2i.DOWN:
			land_piece()
			check_rows()
			piece_type = next_piece_type
			piece_atlas = next_piece_atlas
			next_piece_type = pick_piece()
			next_piece_atlas = Vector2i(shapes_full.find(next_piece_type), 0)
			clear_panel()
			create_piece()
			check_game_over()
			BgMusic.effect_block4_play()
	
func can_move(dir):
	return can_move_piece(active_piece, cur_pos + dir)

func can_move_piece(piece, pos):
	# 이동할 공간이 있는지 확인
	for i in piece:
		if not is_free(pos + i):
			return false
	return true

func can_rotate():
	var temp_rotation_index = (rotation_index + 1) % 4
	var temp_piece = piece_type[temp_rotation_index]

	# 기본 위치에서 회전 가능 여부 확인
	if can_move_piece(temp_piece, cur_pos):
		return true

	# 벽 킥을 적용하여 회전 가능 여부 확인
	var wall_kick_offsets = [
		Vector2i(1,0), #오른쪽으로 한칸이동
		Vector2i(-1,0), #왼쪽으로 한칸이동
		Vector2i(0,1), #위로 한칸이동
		Vector2i(0,-1), #아래로 한칸이동
	]	
	for offset in wall_kick_offsets:
		if can_move_piece(temp_piece, cur_pos + offset):
			clear_piece()
			cur_pos += offset
			return true
	
	return false
	
func is_free(pos):
	return get_cell_source_id(board_layer, pos) == -1

func land_piece():
	# 각 세그먼트를 활성 레이어에서 제거하고 보드 레이어로 이동
	for i in active_piece:
		erase_cell(active_layer, cur_pos + i)
		set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
	move_count += 1  # 블록이 바닥에 닿았을 때 움직임 횟수 증가
	# if move_limit < 0:
	#     $HUD.get_node("MoveLabel").text = "무제한"
	# else:
	#     $HUD.get_node("MoveLabel").text = str(max(0, move_limit - move_count))  # 남은 움직임 업데이트
	# if move_limit > 0 and move_count >= move_limit:
	#     game_over()  # 움직임 제한 초과 시 게임 오버 처리

func clear_panel():
	for i in range(0, 40) :
		for j in range(-4, 40) : 
			erase_cell(active_layer, Vector2i(i, j))

func check_rows():
	var row : int = ROWS
	while row > 0:
		var count = 0
		for i in range(COLS):
			if not is_free(Vector2i(i+1, row)):
				count += 1
		if count == COLS : 
			shift_row(row)
			score -= REWARD  # 점수 감소
			BgMusic.effect_block2_play()
			$HUD.get_node("ScoreLabel").text = str(score)
			speed += ACCEL
			if score <= 0:
				level += 1
				initial_score += 5  # 다음 레벨의 초기 점수 증가
				# 레벨업 안내 문자와 폭죽 애니메이션 재생
				is_paused = true
				game_running = false
				BgMusic.pause_music(BgMusic.play2_music)
				BgMusic.play_levelup_sound()
				await show_level_up_and_fireworks()
				await get_tree().create_timer(3.0).timeout
				start_level()  # 다음 레벨 시작
				return
		else:
			row -= 1

func shift_row(row):
	var atlas
	for i in range(row, 1, -1):
		for j in range(COLS):
			atlas = get_cell_atlas_coords(board_layer, Vector2i(j+1, i-1))
			if atlas == Vector2i(-1, -1):
				erase_cell(board_layer, Vector2i(j+1, i))
			else :
				set_cell(board_layer, Vector2i(j+1,i), tile_id, atlas)

func clear_board():
	for i in range(ROWS):
		for j in range(COLS):
			erase_cell(board_layer, Vector2i(j + 1, i + 1))

func check_game_over():
	for i in active_piece:
		if not is_free(i + cur_pos):
			land_piece()
			$HUD.get_node("GameOverLabel").show()
			game_running = false
			BgMusic.pause_music(BgMusic.play2_music)
			BgMusic.play_loss_effect_sound()
			
func drop_piece():
	while can_move(Vector2i.DOWN):  # 아래로 이동할 수 있을 때까지 반복
		move_piece(Vector2i.DOWN)

# 레벨업 안내 문자와 폭죽 애니메이션을 동시에 표시하는 함수
func show_level_up_and_fireworks():
	var level_up_label = $HUD.get_node("LevelUpLabel")
	var fireworks = $HUD.get_node("Fireworks")
	
	# 레벨업 안내 문자 표시
	level_up_label.text = "Level Up!"
	level_up_label.show()
	
	# 폭죽 애니메이션 재생
	fireworks.show()
	fireworks.restart()
	
	# 2초 동안 대기
	await get_tree().create_timer(2.0).timeout
	
	# 레벨업 안내 문자와 폭죽 애니메이션 숨기기
	level_up_label.hide()
	fireworks.hide()

# 게임을 일시 중지하는 함수
func pause_game():
	if is_paused:
		is_paused = false
		game_running = true
		$HUD.get_node("PauseButton").text = "중지"
		BgMusic.resume_music(BgMusic.play2_music)
	else:
		is_paused = true
		game_running = false
		$HUD.get_node("PauseButton").text = "돌아가기"
		BgMusic.pause_music(BgMusic.play2_music)

func add_random_blocks(rows):
	for row in range(ROWS - rows, ROWS):
		for col in range(COLS):
			if randi() % 2 == 0:  # 50% 확률로 블록을 추가
				set_cell(board_layer, Vector2i(col + 1, row + 1), tile_id, Vector2i(randi() % 7, 0))

func game_over():
	$HUD.get_node("GameOverLabel").show()
	game_running = false
	BgMusic.pause_music(BgMusic.play2_music)
	BgMusic.play_loss_effect_sound()
