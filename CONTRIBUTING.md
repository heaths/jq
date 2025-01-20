# Contributing

## Prerequisites

* [`jq` 1.7](https://jqlang.github.io/jq/download/) or newer is recommended. Other versions have not been tested.

## Testing

Be sure to add tests for new functions and run them within this file directory:

```bash
jq --run-tests version.test
```

Test files may contain comments prefaced with `#` and lines consistenting of:

1. The jq program.
2. The input.
3. One or more lines of output.
4. Blank line or end of file.

You should import modules instead of including to avoid potential conflicts.
