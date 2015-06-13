. ./config.sh

INSTALLDIR=pwd

# TODO:
# Tilda/quake - and add to autostart - and import config
# Something like Launchy for Linux
# Good generic light code editor like np++ (no not sublame) - textadept?
# Find $latest versions for all the shitbags who only provide version-numbered URLs
# Good clipboard manager like clipx
# Can I be bothered with: Lisp(/Scheme/etc)? Rebol? Fancy? ECMAScript/IO? R? Dart? Smalltalk? haXe?

################################################
# ESSENTIALS
################################################

sudo apt-get update
sudo apt-get install -qq git git-core mercurial
sudo apt-get install -qq curl sharutils sed jq autoconf


 
################
# CLEANUP
################
 
cd ~
rm -drf $INSTALLDIR