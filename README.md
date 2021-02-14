# GitHub Action for bvm

1. Downloads and installs [bvm](https://github.com/bvm/bvm).
2. Automatically installs any binaries specified in `.bvmrc.json` files.

## Usage

```
# do this after checking out the repository
- uses: bvm/gh-action@v1.0.0
```

### Mac and Linux - Execute `bvm`

If you wish to execute the `bvm` command, it should just work on Windows, but for Mac and Linux you must source the `bvm-init` shell script in order to set up the environment for that step.

```
- run: |
    . $BVM_INSTALL_DIR/bin/bvm-init
    bvm install https://bvm.land/deno/1.4.4.json
```
