> [!NOTE]
> All of my GitHub repositories have been **archived** and will be migrated to
> Codeberg as I next work on them. This repository either now lives, or will
> live, at:
>
> https://codeberg.org/pbrisbin/stack-ls-snapshots
>
> If you need to report an Issue or raise a PR, and this migration hasn't
> happened yet, send an email to me@pbrisbin.com.

# stack-ls-snapshots

Fetch and list Stackage Snapshots by GHC

## Installation

### Manual

Put `bin/stack-ls-snapshots` on `$PATH`.

### User

```console
PREFIX=$HOME/.local make install
```

### System-wide

```console
sudo make install
```

## Usage

List the maximum LTS per GHC minor version:

```console
% stack-ls-snaphots
lts-19.11,9.0
lts-18.28,8.10
lts-16.31,8.8
lts-14.27,8.6
lts-12.26,8.4
lts-11.22,8.2
lts-9.21,8.0
lts-6.35,7.10
lts-2.22,7.8
```

See the minimum by GHC minor version instead:

```console
% stack-ls-snaphot --first
lts-19.0,9.0
lts-18.9,8.10
lts-16.12,8.8
lts-13.20,8.6
lts-12.15,8.4
lts-10.0,8.2
lts-8.0,8.0
lts-4.0,7.10
lts-1.0,7.8
```

Unique by major GHC version instead:

```console
% stack-ls-snapshots --ghc-major
lts-19.11,9
lts-18.28,8
lts-6.35,7
```

(There's also `--ghc-patch`.)

Do all this with nightly instead:

```console
% stack-ls-snapshots --nightly
nightly-2022-06-13,9.2
nightly-2022-03-17,9.0
nightly-2021-06-14,8.10
nightly-2020-06-16,8.8
nightly-2019-09-21,8.6
nightly-2018-09-28,8.4
nightly-2018-03-12,8.2
nightly-2017-07-25,8.0
nightly-2016-05-25,7.10
nightly-2015-05-04,7.8
```

Use `--printf` to change output formatting:

```console
% stack-ls-snapshots --ghc-major --printf '%s (ghc-%s)\n'
lts-19.11 (ghc-9)
lts-18.28 (ghc-8)
lts-6.35 (ghc-7)
```

## Indirect use-cases

Get the latest nightly:

```console
% stack-ls-snapshots --nightly | head -n 1 | cut -d, -f1
nightly-2022-06-13
```

Get the latest resolver for a minor GHC version:

```console
% stack-ls-snapshots | sed '/^\(.*\),8.10$/!d; s//\1/'
lts-18.28
```

Configure and build a project across all GHC minor versions:

```sh
while IFS=, read -r resolver ghc; do
  stack_yaml=stack-$resolver.yaml
  echo "resolver: $resolver" > "$stack_yaml"
  stack --stack-yaml "$stack_yaml" build
done < <(stack-ls-snapshots)
```

---

[LICENSE](./LICENSE)
