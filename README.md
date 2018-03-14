![N|Solid](/images/nsolid-homebrew.png)

# N|Solid on Homebrew

Install [N|Solid](https://nodesource.com/products/nsolid) on macOS via [Homebrew](https://brew.sh). You can now easily install and manage the only Node.js platform built for mission-critical applications.

## Usage

#### Install

First you need to add our tap:

```bash
$ brew tap nodesource/nsolid
```

Then simply install either the N|Solid Runtime or the N|Solid Console:

```bash
$ brew install nsolid
```

```bash
$ brew install nsolid-console
```

_If you don't want Homebrew to attempt to overwrite preexisting node, npm, and npx file in /usr/local/bin, add `--without-node` to your N|Solid install command._

#### Upgrading

To update your version of N|Solid, simply run the upgrade command:

```bash
$ brew upgrade nsolid
```

```bash
$ brew upgrade nsolid-console
```

---

_If you have N|Solid installed via the Developer Bundle, please uninstall it before installing from Homebrew. You can uninstall by running:_

```
$ sudo /usr/local/nsolid/uninstall
```
