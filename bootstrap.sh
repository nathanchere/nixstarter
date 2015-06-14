#
# nixstarter bootstrapper
#
# Copy/paste this into a terminal to get started:
#
#   wget -O - https://j.mp/nixstarterbootstrap > bootstrap.sh && sudo chmod +755 bootstrap.sh && ./bootstrap.sh
#

sudo apt-get update
sudo apt-get install -y -q git git-core
cd /tmp
rm -drf /tmp/nixstarter
git clone -q https://github.com/nathanchere/nixstarter.git
cat /temp/nixstarter/help.txt