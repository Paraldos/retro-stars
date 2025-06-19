extends CPUParticles2D

@onready var sound_effect: SoundEffect = %SoundEffect

func _ready() -> void:
	_start_particles()
	sound_effect._play()

func _start_particles():
	restart()
	one_shot = true

func _on_finished() -> void:
	queue_free()
