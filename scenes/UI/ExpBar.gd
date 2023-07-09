extends TextureProgress


onready var label = $Label
onready var tween = $Tween


# Called when the node enters the scene tree for the first time.
func _ready():
	ExpManager.connect("update_exp_bar", self, "_on_update_exp")


func _on_update_exp(i):
	$FCTManager.show_value(null, i, false, true)
	max_value = ExpManager.levelup_xp
	tween.interpolate_property(self, "value", value, ExpManager.xp, .5)
	tween.start()
	#value = ExpManager.xp
	label.text = "Lvl: " + str(ExpManager.level)
