# Copyright 2025 Heath Stewart.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
module {version: "0.1.0", homepage: "https://github.com/heaths/jq"};

def table:
  type as $type
  | flatten as $input
  | $input[0]? | type as $subtype
  | if $type=="array" and ($subtype=="object" or $subtype=="null") then
    $input | first | map_values(scalars) | keys_unsorted as $keys
    | $keys, ($input[] as $values | [$keys[] | $values[.]])
  else
    error("expected array, got \($type)" + if $type == "array" then " of \($subtype)" else "" end)
  end;
