#!/usr/bin/env python
import hashlib
import requests
import re
import sys
import os


def display_help():
    print("Usage: update.py NodeVersion-nsolidVersion")
    print("Example: update.py 18.18.2-ns4.9.5")
    print("This script updates the Homebrew formula for the given N|Solid version.")
    print("Make sure to run this script with the correct version format as an argument.")
    print("The script automatically handles downloading and SHA256 calculation for both x64 and arm64 architectures.")
    print("It updates the formula with the new URLs and SHA256 hashes for the specified N|Solid version.")


def download_and_get_sha(url):
    response = requests.get(url, stream=True)
    response.raise_for_status()
    sha256 = hashlib.sha256()
    with open('./runtime.tgz', 'wb') as f:
        for chunk in response.iter_content(chunk_size=8192):
            if chunk:
                f.write(chunk)
                sha256.update(chunk)
    runtime_sha = sha256.hexdigest()
    os.remove('./runtime.tgz')
    return runtime_sha


def update_formula(formula_filename, arch, runtime_url, runtime_sha):
    url_pattern = re.compile(r'url "(.*?)"')
    sha_pattern = re.compile(r'sha256 "(.*?)"')
    updated = False
    with open(formula_filename, "r") as file:
        lines = file.readlines()

    with open(formula_filename, "w") as file:
        for line in lines:
            if f'if Hardware::CPU.{arch}?' in line:
                updated = True
            if updated and 'url' in line:
                line = re.sub(url_pattern, f'url "{runtime_url}"', line)
            elif updated and 'sha256' in line:
                line = re.sub(sha_pattern, f'sha256 "{runtime_sha}"', line)
                updated = False
            file.write(line)


if __name__ == "__main__":
    if len(sys.argv) != 2 or sys.argv[1] in ["-h", "--help"]:
        display_help()
        sys.exit(1)

    nsolid_version = sys.argv[1]
    match = re.match(r'(\d+)\.\d+\.\d+-ns(\d+\.\d+\.\d+)', nsolid_version)
    if not match:
        print("Incorrect N|Solid Version format. Expected format: NodeVersion-nsolidVersion (e.g. 18.18.2-ns4.9.5)")
        exit(1)

    node_version, ns_version = match.groups()
    codenames = {18: "hydrogen", 20: "iron", 22: "jod", 24: "krypton"}
    codename = codenames.get(int(node_version))
    if not codename:
        print("Unsupported Node version for determining codename.")
        exit(1)

    formula_filename = f"Formula/nsolid-{codename}.rb"

    x64_url = f"https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/{nsolid_version}/artifacts/binaries/nsolid-v{ns_version}-{codename}-darwin-x64.tar.gz"
    x64_sha = download_and_get_sha(x64_url)
    update_formula(formula_filename, "intel", x64_url, x64_sha)

    arm_url = f"https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/{nsolid_version}/artifacts/binaries/nsolid-v{ns_version}-{codename}-darwin-arm64.tar.gz"
    arm_sha = download_and_get_sha(arm_url)
    update_formula(formula_filename, "arm", arm_url, arm_sha)

    print("Update Complete")
