extends CPUParticles2D

func _ready() -> void:
	restart()
	one_shot = true

func _on_finished() -> void:
	queue_free()
