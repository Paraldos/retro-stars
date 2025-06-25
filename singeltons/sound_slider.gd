extends VBoxContainer

@onready var label: Label = %Label
@onready var h_slider: HSlider = %HSlider

@export var bus_name: String = "Master"

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	label.text = bus_name
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(h_slider.value)
	)
