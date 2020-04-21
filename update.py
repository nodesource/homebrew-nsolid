#!/usr/bin/env python
import hashlib
import requests
import re
import boto3
import os
s3 = boto3.client('s3')

versionFile = open('Formula/nsolid.rb').read()
previousVersion = re.search(r'version(.*)', versionFile).group(0).split("\"")[1]
print("Previous Version: " + previousVersion)

nsolidVersion = raw_input("\nNew N|Solid Version:\n")
isSemantic = re.match(r'^(\d+\.)?(\d+\.)?(\*|\d+)$', nsolidVersion)
if not isSemantic:
    print("N|Solid Version doesn't seem to be a Semantic version - Example: 3.0.0")
    exit(1)
print("\nRunning...\n")

print("Downloading files to get SHA256 hash...\n")

# Dubnium Runtime
url = "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/" + nsolidVersion + "/artifacts/bundles/nsolid-bundle-v" + nsolidVersion + "-darwin-x64/nsolid-v" + nsolidVersion + "-dubnium-darwin-x64.tar.gz"
request = requests.get(url)
open('./runtime.tgz', 'wb').write(request.content)
sha256 = hashlib.sha256()
with open('./runtime.tgz', 'rb') as f:
    for block in iter(lambda: f.read(), b''):
        sha256.update(block)
runtimeShaDubnium = sha256.hexdigest()
print("Runtime SHA is: " + runtimeShaDubnium)
os.remove('./runtime.tgz')

# Erbium Runtime
url = "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/" + nsolidVersion + "/artifacts/bundles/nsolid-bundle-v" + nsolidVersion + "-darwin-x64/nsolid-v" + nsolidVersion + "-erbium-darwin-x64.tar.gz"
request = requests.get(url)
open('./runtime.tgz', 'wb').write(request.content)
sha256 = hashlib.sha256()
with open('./runtime.tgz', 'rb') as f:
    for block in iter(lambda: f.read(), b''):
        sha256.update(block)
runtimeShaErbium = sha256.hexdigest()
print("Runtime SHA is: " + runtimeShaErbium)
os.remove('./runtime.tgz')


# Fermium Runtime (default)
url = "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/" + nsolidVersion + "/artifacts/bundles/nsolid-bundle-v" + nsolidVersion + "-darwin-x64/nsolid-v" + nsolidVersion + "-fermium-darwin-x64.tar.gz"
request = requests.get(url)
open('./runtime.tgz', 'wb').write(request.content)
sha256 = hashlib.sha256()
with open('./runtime.tgz', 'rb') as f:
    for block in iter(lambda: f.read(), b''):
        sha256.update(block)
runtimeSha = sha256.hexdigest()
print("Runtime SHA is: " + runtimeSha)
os.remove('./runtime.tgz')

# Console
url = "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/" + nsolidVersion + "/artifacts/bundles/nsolid-bundle-v" + nsolidVersion + "-darwin-x64/nsolid-console-v" + nsolidVersion + "-darwin-x64.tar.gz"
request = requests.get(url)
open('./console.tgz', 'wb').write(request.content)
sha256 = hashlib.sha256()
with open('./console.tgz', 'rb') as f:
    for block in iter(lambda: f.read(), b''):
        sha256.update(block)
consoleSha =sha256.hexdigest()
print("Console SHA is: " + consoleSha)
os.remove('./console.tgz')

print("\nUpdating Files...")
formulae = os.listdir('./Formula')
for formula in formulae:
    with open("./Formula/" + formula, "r") as inFile:
        lines = inFile.readlines()
    with open("./Formula/" + formula, "w") as outFile:
        for line in lines:
            if previousVersion in line:
                updatedLine = line.replace(previousVersion, nsolidVersion)
                outFile.write(updatedLine)
            elif "sha256" in line and formula == "nsolid.rb":
                line = "  sha256 \"" + runtimeSha + "\"\n"
                outFile.write(line)
            elif "sha256" in line and formula == "nsolid-erbium.rb":
                line = "  sha256 \"" + runtimeShaErbium + "\"\n"
                outFile.write(line)
            elif "sha256" in line and formula == "nsolid-dubnium.rb":
                line = "  sha256 \"" + runtimeShaDubnium + "\"\n"
                outFile.write(line)
            elif "sha256" in line and formula == "nsolid-console.rb":
                line = "  sha256 \"" + consoleSha + "\"\n"
                outFile.write(line)
            else:
                outFile.write(line)

print("Update Complete")
