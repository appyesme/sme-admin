#!/bin/bash

# Define constant for Firebase hosting target
HOSTING_TARGET="admin-sme"

# Clean and get dependencies
flutter clean
flutter pub get

# Generate files and build Flutter web app
sh generate_env.sh
dart run build_runner build --delete-conflicting-outputs
flutter build web

# Display a success message
echo "$(tput bold)$(tput setaf 2)Flutter web build is ready.$(tput sgr0)"

# Prompt user for Firebase deployment
read -p "Do you want to deploy the app to Firebase Hosting? (yes/no): " response
if [[ "$response" =~ ^(yes|y)$ ]]; then
    firebase deploy --only hosting:$HOSTING_TARGET
else
    echo "$(tput bold)$(tput setaf 3)Deployment skipped. You can deploy later using 'firebase deploy --only hosting:$HOSTING_TARGET'.$(tput sgr0)"
fi
