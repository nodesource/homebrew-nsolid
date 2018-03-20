![N|Solid](/images/nsolid-homebrew.png)

# N|Solid on Homebrew

Install [N|Solid](https://nodesource.com/products/nsolid) on macOS via [Homebrew](https://brew.sh). You can now easily install and manage the only Node.js platform built for mission-critical applications.

## Usage

### Install

First add the `nsolid` tap:

```bash
$ brew tap nodesource/nsolid
```

The N|Solid Runtime and the N|Solid Console can be installed separately.

To install the  N|Solid Runtime:
```bash
$ brew install nsolid
```
And to install the N|Solid Console:
```bash
$ brew install nsolid-console
```

>**Note:** If you don't want Homebrew to attempt to overwrite preexisting `node`, `npm`, and `npx` files in `/usr/local/bin`, add `--without-node` to your N|Solid install command.

### Upgrading

To update your version of N|Solid, simply run the upgrade command:

```bash
$ brew upgrade nsolid
```

```bash
$ brew upgrade nsolid-console
```

### Services

You can use Homebrew [Services](https://github.com/Homebrew/homebrew-services) to start and stop N|Solid Console:

```bash
$ brew services start nsolid-console
```

```bash
$ brew services stop nsolid-console
```

### Managing Versions

You can switch between N|Solid versions by using the `switch` command:

```bash
$ brew list --versions nsolid
$ brew switch nsolid <version>
```

---

If you have N|Solid installed via the Developer Bundle, **please uninstall it before installing from Homebrew**. You can uninstall by running:

```
$ sudo /usr/local/nsolid/uninstall
```
