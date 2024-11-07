pub fn place_location_to_treasure_location(
  place_location: #(String, Int),
) -> #(Int, String) {
  #(place_location.1, place_location.0)
}

pub fn treasure_location_matches_place_location(
  place_location: #(String, Int),
  treasure_location: #(Int, String),
) -> Bool {
  place_location_to_treasure_location(place_location) == treasure_location
}

pub fn count_place_treasures(
  place: #(String, #(String, Int)),
  treasures: List(#(String, #(Int, String))),
) -> Int {
  let #(_, place_location) = place
  let get_treasure_location = fn(treasure: #(_, _)) { treasure.1 }

  let treasure_location_matches_place_location = fn(treasure) {
    treasure_location_matches_place_location(
      place_location,
      get_treasure_location(treasure),
    )
  }

  count_all(treasures, treasure_location_matches_place_location, 0)
}

fn count_all(xs: List(x), predicate: fn(x) -> Bool, acc: Int) -> Int {
  case xs {
    [] -> acc
    [first, ..rest] ->
      count_all(rest, predicate, case predicate(first) {
        False -> acc
        True -> acc + 1
      })
  }
}

pub fn special_case_swap_possible(
  found_treasure: #(String, #(Int, String)),
  place: #(String, #(String, Int)),
  desired_treasure: #(String, #(Int, String)),
) -> Bool {
  let #(found_treasure_name, _) = found_treasure
  let #(place_name, _) = place
  let #(desired_treasure_name, _) = desired_treasure

  case found_treasure_name {
    "Brass Spyglass" -> True
    "Amethyst Octopus" if place_name == "Stormy Breakwater" ->
      case desired_treasure_name {
        "Crystal Crab" | "Glass Starfish" -> True
        _ -> False
      }
    "Vintage Pirate Hat" if place_name == "Harbor Managers Office" ->
      case desired_treasure_name {
        "Model Ship in Large Bottle" | "Antique Glass Fishnet Float" -> True
        _ -> False
      }
    _ -> False
  }
}
