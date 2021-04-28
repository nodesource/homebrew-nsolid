![N|Solid](/images/nsolid-homebrew.png)

# N|Solid on Homebrew

Install [N|Solid](https://nodesource.com/products/nsolid) on macOS via [Homebrew](https://brew.sh). You can now easily install and manage the only Node.js platform built for mission-critical applications.

## Usage

### Install

First add the `nsolid` tap:

```bash
$ brew tap nodesource/nsolid
```

The N|Solid Runtime can be installed with or without the N|Solid Console.

To install the N|Solid Runtime and the N|Solid Console together:
```bash
$ brew install nsolid-console
```

And to install the  N|Solid Runtime by itself:
```bash
$ brew install nsolid
```

>**Note:** If you don't want Homebrew to attempt to overwrite preexisting `node`, `npm`, and `npx` files in `/usr/local/bin`, add `--without-node` to your N|Solid install command.

The previous command install N|Solid Runtime based on the latest LTS version. If
you want to install N|Solid Runtime with a diferent LTS, you have available:

```bash
$ brew install nsolid-erbium
```

>**Note:** If you have previously installed `nsolid`, you'll need to `brew unlink nsolid` to let the installation pass and then run`brew link nsolid-erbium`. You can follow the same process to unlink `nsolid-erbium`, then link `nsolid` back.

### Upgrading

To update your version of N|Solid, simply run the upgrade command:

```bash
$ brew upgrade nsolid
$ brew upgrade nsolid-erbium
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
