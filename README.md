# jq Modules

These are handy [jq] modules that can be imported and used in your jq expressions e.g.,

```bash
echo '[{"num":1,"desc":"one"},{"num":2,"desc":"two"}]' |
  jq -r 'include "heaths/table"; table'
```

## Install

You can install this wherever you like, but to import it without specifying the whole path,
you should clone this repo into `~/.jq`:

```bash
mkdir -p ~/.jq
git clone https://github.com/heaths/jq ~/.jq/heaths
```

## Functions

### table

`table` formats an array of objects as tab-separated values you can use with `column -t` or write to a `.csv` file.
The first row is used to identify scalar values' key names used for the header row and to select the same values for every row.

`table` automatically flattens input so you do not need to pass `--slurp` or `-s`.

```bash
echo '[{"num":1,"desc":"one","sib":[0,2]},{"num":2,"desc":"two","sib":[1,3]}]' |
  jq -r 'include "heaths/table"; table'
```

```text
num     desc
1       one
2       two
```

### table_rows

`table_rows` works exactly like `table` but without printing the header row. The first row is still used to identity scalar values.

```bash
echo '[{"num":1,"desc":"one","sib":[0,2]},{"num":2,"desc":"two","sib":[1,3]}]' |
  jq -r 'include "heaths/table"; table'
```

```text
1       one
2       two
```

### toversion

`toversion` parses [semantic versions](https://semver.org) into an array suitable for sorting.

```bash
cat <<'EOF' | jq -r 'include "heaths/version"; . | sort_by(toversion)'
[
    "0.1.0",
    "1.2.3-beta1",
    "2.4-beta.0",
    "1.2.3",
    "1.2.3-beta.1",
    "1.2.3-beta+abcd1234",
    "1.2.3-alpha",
    "0.2.0",
    "2.3.4"
]
EOF
```

```text
[
  "0.1.0",
  "0.2.0",
  "1.2.3-alpha",
  "1.2.3-beta+abcd1234",
  "1.2.3-beta.1",
  "1.2.3-beta1",
  "1.2.3",
  "2.3.4",
  "2.4-beta.0"
]
```

You can also use it to get the latest version using `max_by`.

```bash
cat <<'EOF' | jq -r 'include "heaths/version"; . | max_by(toversion)'
[
  "1.0.0",
  "0.1.0",
  "1.0.0-beta.0"
]
EOF
```

```text
"1.0.0"
```

### release

`release` and `release($pre)` can be used to filter versions. `$pre` is `false` by default and will only show release semvers - those without patch metdata.

```bash
versions='["0.1.0","1.0.0-beta.1","0.2.0","1.0.0"]'
echo $versions | jq -r 'import "heaths/version" as v; .[] | select(v::toversion | v::release)'
```

```text
"0.1.0"
"0.2.0"
"1.0.0"
```

```bash
echo $versions | jq -r 'import "heaths/version" as v; .[] | select(v::toversion | v::release(true))'
```

```text
"0.1.0"
"1.0.0-beta.1"
"0.2.0"
"1.0.0"
```

## License

This project is licensed under the [MIT license](LICENSE.txt).

[jq]: https://jqlang.github.io/jq
