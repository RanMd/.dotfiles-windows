iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex
git clone --depth=1 https://github.com/spicetify/spicetify-themes.git
cd spicetify-themes
cp * "$(spicetify -c | Split-Path)\Themes\" -Recurse
