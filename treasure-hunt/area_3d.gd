extends Area3D

signal treasure_collected 

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody3D: 
		emit_signal("treasure_collected")  
		queue_free()  
