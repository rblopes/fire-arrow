extends Theme

const GOAL_LOCATION_HINT_BUTTON_DESCRIPTION_LABEL_THEME_TYPE: String = "GoalLocationHintButtonDescriptionLabel"
const HINT_GROUP_HEADING_BUTTON_THEME_TYPE: String = "HintGroupHeadingButton"


func set_goal_location_hint_button_description_label_font_color(color: Color) -> void:
	set_color("font_color", GOAL_LOCATION_HINT_BUTTON_DESCRIPTION_LABEL_THEME_TYPE, color)


func set_hint_group_heading_button_font_colors(color: Color) -> void:
	set_color("font_color", HINT_GROUP_HEADING_BUTTON_THEME_TYPE, color)
	set_color("font_disabled_color", HINT_GROUP_HEADING_BUTTON_THEME_TYPE, color)
	set_color("font_focus_color", HINT_GROUP_HEADING_BUTTON_THEME_TYPE, color)
	set_color("font_hover_color", HINT_GROUP_HEADING_BUTTON_THEME_TYPE, color)
	set_color("font_hover_pressed_color", HINT_GROUP_HEADING_BUTTON_THEME_TYPE, color)
	set_color("font_pressed_color", HINT_GROUP_HEADING_BUTTON_THEME_TYPE, color)
