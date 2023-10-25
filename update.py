#!/usr/bin/env python
import hashlib
import requests
import re
import sys
import os


def download_and_get_sha(url):
    request = requests.get(url)
    open('./runtime.tgz', 'wb').write(request.content)
    sha256 = hashlib.sha256()
    with open('./runtime.tgz', 'rb') as f:
        for block in iter(lambda: f.read(), b''):
            sha256.update(block)
    runtimeSha = sha256.hexdigest()
    os.remove('./runtime.tgz')
    return runtimeSha


def display_help():
    print("Usage: update_formula.py NodeVersion-nsolidVersion")
    print("Example: update_formula.py 18.18.2-ns4.9.5")
    print("This script updates the Homebrew formula for the given N|Solid version.")


if len(sys.argv) != 2 or sys.argv[1] in ["-h", "--help"]:
    display_help()
    sys.exit(1)

nsolidVersion = sys.argv[1]
match = re.match(r'(\d+).\d+.\d+-ns\d+.\d+.\d+', nsolidVersion)
if not match:
    print("Incorrect N|Solid Version format. Expected format: NodeVersion-nsolidVersion (e.g. 18.18.2-ns4.9.5)")
    exit(1)

node_version = int(match.group(1))
codenames = {
    18: "hydrogen",
    20: "iron",
    22: "jod"
}

codename = codenames.get(node_version)
if not codename:
    print("Unsupported Node version for determining codename.")
    exit(1)

print("\nRunning...\n")
print(f"Identified codename: {codename}")

formula_filename = f"Formula/nsolid-{codename}.rb"

print("Downloading files to get SHA256 hash...\n")
url = f"https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/{nsolidVersion}/artifacts/bundles/nsolid-bundle-v{nsolidVersion}-darwin-x64/nsolid-v{nsolidVersion}-{codename}-darwin-x64.tar.gz"
runtimeSha = download_and_get_sha(url)
print("Runtime SHA is: " + runtimeSha)

print("\nUpdating Files...")
with open(formula_filename, "r") as inFile:
    lines = inFile.readlines()
with open(formula_filename, "w") as outFile:
    for line in lines:
        if "url" in line:
            line = f'  url "{url}"\n'
        elif "sha256" in line:
            line = f'  sha256 "{runtimeSha}"\n'
        outFile.write(line)

print("Update Complete")
