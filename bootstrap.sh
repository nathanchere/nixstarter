#
# nixstarter bootstrapper
#
# Copy/paste this into a terminal to get started:
#
#   wget -O - https://j.mp/nixstarterbootstrap > bootstrap.sh && sudo chmod +777 bootstrap.sh && ./bootstrap.sh
#

sudo apt-get update
sudo apt-get install -y -q git git-core
cd /tmp
rm -drf /tmp/nixstarter
git clone -q https://github.com/nathanchere/nixstarter.git
cd nixstarter

cat help.txt