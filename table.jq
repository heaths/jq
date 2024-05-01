# Copyright 2024 Heath Stewart.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
module {version: "0.1.0", homepage: "https://github.com/heaths"};

def _table:
  type as $type
  | flatten as $input
  | $input[0]? | type as $subtype
  | if $type=="array" and ($subtype=="object" or $subtype=="null") then
    $input | first | map_values(scalars) | keys_unsorted as $keys
    | $keys, ($input[] as $values | [$keys[] | $values[.]])
  else
    error("expected array, got \($type)" + if $type == "array" then " of \($subtype)" else "" end)
  end;

# Formats an array of objects' scalar values to a tab-separated table with a header row containing key names.
# Usage: echo '[{"foo":"baz","bar":1},{"foo":qux","bar":2}]' | jq -r 'include "table"; table' | column -t
def table: _table | @tsv;

# Formats an array of objects' scalar values to a tab-separated table without a header row
# Usage: echo '[{"foo":"baz","bar":1},{"foo":qux","bar":2}]' | jq -r 'include "table"; table_row' | column -t
def table_rows: [_table][1:][] | @tsv;

