# ==========================================
# CUT RELEASE
# ==========================================

# Check if all arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <version> <ws_version>"
    echo "Example: $0 '2.0.0' '3.0.0'"
    exit 1
fi

VERSION=$1
CLIENT_VERSION=$2

# Checkout develop
git checkout develop

# Pull the latest
git pull origin develop

# Make branch for the release
git checkout -b "release/$VERSION" || exit 1

# Update file
sed -i 's/version: .*/version: '$VERSION'/' eufy-security-ws/config.yaml
sed -i 's/EUFY_SECURITY_WS_VERSION: .*/EUFY_SECURITY_WS_VERSION: '$CLIENT_VERSION'/' eufy-security-ws/build.yaml

# Add file to the branch and commit
git add eufy-security-ws/config.yaml
git add eufy-security-ws/build.yaml
git commit -m "Add new version"

# Push
git push --set-upstream origin "release/$VERSION"