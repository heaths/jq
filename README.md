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

## License

This project is licensed under the [MIT license](LICENSE.txt).

[jq]: https://jqlang.github.io/jq
