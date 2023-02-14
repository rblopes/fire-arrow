extends Node


func fetch(collection_name: String) -> HintCollection:
	return get_node_or_null(collection_name) as HintCollection
