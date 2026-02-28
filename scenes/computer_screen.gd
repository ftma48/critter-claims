extends Control

@export var webpage: WebPageData

func _ready():
	if webpage:
		$webpage/TitleLabel.text = webpage.title
		$webpage/ContentLabel.text = webpage.title
		$CallButton.visible = webpage.call
