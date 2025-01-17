# Copyright 2025 Heath Stewart.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
module {version: "0.1.0", homepage: "https://github.com/heaths/jq"};

def toversion:
  # ignore build metadata
  sub("[+].*"; "")
  # ensure "-beta" proceeds "-beta.1"
  | sub("-(?<pre>[0-9A-Za-z-]+)$"; "-\(.pre).0"; "g")
  # ensure releases come after prereleases
  | . + "-zzz"
  | [splits("[-.]")]
  | map(tonumber? // .);
