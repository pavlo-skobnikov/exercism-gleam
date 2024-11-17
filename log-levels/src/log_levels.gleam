import gleam/string

/// Destructures the provided log message of the following format (<name> 
/// designates variable data): "[<LOG_LEVEL>]: <LOG_MESSAGE>".
/// Returns a tuple of _log level_ (no brackets and lowercase) and 
/// _log message_ (with trimmed surrounding whitespace). 
fn destructure_message(log_line: String) -> #(String, String) {
  let assert [incoming_log_level, incoming_log_message] =
    string.split(log_line, on: ": ")

  let processed_log_level =
    incoming_log_level
    |> string.drop_left(up_to: 1)
    |> string.drop_right(up_to: 1)
    |> string.lowercase

  let processed_log_message = string.trim(incoming_log_message)

  #(processed_log_level, processed_log_message)
}

pub fn message(log_line: String) -> String {
  let #(_, message) = destructure_message(log_line)

  message
}

pub fn log_level(log_line: String) -> String {
  let #(level, _) = destructure_message(log_line)

  level
}

pub fn reformat(log_line: String) -> String {
  let #(level, message) = destructure_message(log_line)

  message <> " (" <> level <> ")"
}
