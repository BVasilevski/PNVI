extends Node

@export var total_treasures: int = 5 
var collected_treasures: int = 0
var game_over: bool = false

@onready var timer: Timer = $Timer  
@onready var timer_label: Label = $"../TimerLabel"  
@onready var treasure_label: Label = $"../TreasureCountLabel"  

func _ready():
	timer.start()
	timer.timeout.connect(_on_time_up)  

	set_process(true)

	for treasure in get_tree().get_nodes_in_group("treasures"):
		treasure.connect("treasure_collected", Callable(self, "_on_treasure_collected"))

func _process(delta):
	if game_over:
		return

	var time_left = max(timer.time_left, 0)  
	timer_label.text = "Time Left: " + str(time_left).pad_decimals(1) + 's' 

func _on_treasure_collected():
	if game_over:
		return  

	collected_treasures += 1
	print("Treasures collected: ", collected_treasures)

	treasure_label.text = "Treasures Collected: " + str(collected_treasures) + "/" + str(total_treasures)

	if collected_treasures >= total_treasures:
		_show_win_screen() 

func _on_time_up():
	if collected_treasures < total_treasures:
		_show_lose_screen()

func _show_win_screen():
	game_over = true
	print("You Win!")
	get_tree().change_scene_to_file("res://win_screen.tscn")  

func _show_lose_screen():
	game_over = true
	print("You Lose!")
	get_tree().change_scene_to_file("res://lose_screen.tscn")
