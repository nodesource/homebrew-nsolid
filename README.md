![N|Solid](/images/nsolid-homebrew.png)

# N|Solid on Homebrew

Install [N|Solid](https://nodesource.com/products/nsolid) on macOS via [Homebrew](https://brew.sh). Now you can easily install and manage the only Node.js platform built for mission-critical applications.

## Usage

### Installation

First, add the `nsolid` tap:

```bash
brew tap nodesource/nsolid
```

You can install the N|Solid Runtime in its `Jod`, `iron`, `hydrogen` variants:

To install the `jod` version of N|Solid Runtime:

```bash
brew install nsolid-jod
```

To install the `iron` version of N|Solid Runtime:

```bash
brew install nsolid-iron
```

To install the `hydrogen` version of N|Solid Runtime:

```bash
brew install nsolid-hydrogen
```

If you simply want to install N|Solid without specifying a variant, use:

```bash
brew install nsolid
```

To set `nsolid` to be an alias of a specific version (e.g., `nsolid-hydrogen`):

```bash
ln -s ../Formula/nsolid-hydrogen.rb Aliases/nsolid
```

> **Note:** If you previously installed `nsolid`, you'll need to `brew unlink nsolid` to allow the installation, and then run `brew link nsolid-jod`. You can follow the same process to unlink `nsolid-jod` and then link `nsolid` back.

> **Note:** If you don't want Homebrew to attempt to overwrite preexisting `node`, `npm`, and `npx` files in `/usr/local/bin`, add `--without-node` to your N|Solid install command.

To set `nsolid` to alias a specific variant, simply change the symlink creation command. For instance, if you want `nsolid` to point to the `jod` variant, use `nsolid-jod.rb` in the symlink command.

### Upgrading

To update your version of N|Solid, simply run the upgrade command:

```bash
brew upgrade nsolid-jod
```

or

```bash
brew upgrade nsolid-iron
```

or

```bash
brew upgrade nsolid-hydrogen
```

### Managing Versions

You can switch between N|Solid versions using the `switch` command:

```bash
brew list --versions nsolid
brew switch nsolid <version>
```

---

If you have N|Solid installed via the Developer Bundle, **please uninstall it before installing from Homebrew**. You can uninstall by running:

```bash
sudo /usr/local/nsolid/uninstall
```
