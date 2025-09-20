# Copyright 2025 Heath Stewart.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
module {version: "0.1.0", homepage: "https://github.com/heaths/jq"};

import "./internal/table" as i;

# Formats an array of objects' scalar values to a tab-separated table with a header row containing key names.
# Usage: echo '[{"foo":"baz","bar":1},{"foo":"qux","bar":2}]' | jq -r 'include "format"; table' | column -t
def table: i::table | @tsv;

# Formats an array of objects' scalar values to a tab-separated table without a header row
# Usage: echo '[{"foo":"baz","bar":1},{"foo":"qux","bar":2}]' | jq -r 'include "format"; table_rows' | column -t
def table_rows: [i::table][1:][] | @tsv;
