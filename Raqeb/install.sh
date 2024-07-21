# Define paths
DESKTOP_FILE="$HOME/.local/share/applications/Raqeb.desktop"
ICON_FILE="$HOME/.local/share/icons/hicolor/48x48/apps/RaqebIcon.svg"
SCRIPT_FILE="$HOME/Raqeb/Raqeb.sh"
ICON_SOURCE="$HOME/Raqeb/Icon/RaqebIcon.svg"

# Create the .desktop file
cat <<EOL > $DESKTOP_FILE
[Desktop Entry]
Version=1.0
Type=Application
Name=Raqeb
Comment=System Monitoring Application
Exec=$SCRIPT_FILE
Icon=$ICON_FILE
Terminal=false
Categories=Utility;Application;
EOL

# Make the script executable
chmod +x $SCRIPT_FILE

# Copy the Icon to a standard location
mkdir -p $(dirname $ICON_FILE)
cp $ICON_SOURCE $ICON_FILE

# Ensure correct permissions for the .desktop file
chmod +x $DESKTOP_FILE
