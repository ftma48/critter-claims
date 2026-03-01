extends Node

enum PlanType {
	ESSENTIAL,
	PREMIER
}

enum Character {
	BUNNY,
	SEAGULL
}

var tv_seen = false
var window_seen = false
var current_webpage: WebPageData = null
var plan_type: PlanType = PlanType.ESSENTIAL
var current_character: Character
