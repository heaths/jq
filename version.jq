# Copyright 2025 Heath Stewart.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
module {version: "0.2.0", homepage: "https://github.com/heaths/jq"};

# toversion parses semvers for use in comparisons.
# based on https://stackoverflow.com/a/75770668/462376.
def toversion:
  # ignore build metadata e.g., "+g123abc"
  sub("\\+.*$"; "")
  # split version and patch metadata e.g., ["1.2.3","beta.1"]
  | capture("^(?<v>[^-]+)(?:-(?<p>.*))?$") | [.v, .p // empty]
  # split each element into nested arrays by dots e.g., [[1,2,3],["beta",1]]
  | map(split(".") | map(tonumber? // .))
  # use empty object if patch metadata missing since it sorts after array e.g., [[1,2,3],{}]
  | .[1] |= (. // {});
