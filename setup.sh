. ./config.sh

INSTALLDIR=pwd

# TODO:
# Tilda/quake - and add to autostart - and import config
# Something like Launchy for Linux
# Good generic light code editor like np++ (no not sublame) - textadept?
# Find $latest versions for all the shitbags who only provide version-numbered URLs
# Good clipboard manager like clipx
# Can I be bothered with: Lisp(/Scheme/etc)? Rebol? Fancy? ECMAScript/IO? R? Dart? Smalltalk? haXe?
# install github's `hub` helper

################################################
# ESSENTIALS
################################################

sudo apt-get update
sudo apt-get install -qq git git-core mercurial
sudo apt-get install -qq curl sharutils sed jq autoconf

################################################
# FRAMEWORKS / RUNTIMES
################################################

if [-n "$INSTALL_BASE_MONO"]; then
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
	sudo apt-get update
	sudo apt-get install -qq mono-complete
fi

if [-n "$INSTALL_BASE_JAVA"]; then
	sudo apt-get install -qq openjdk-6-jre openjdk-7-jre
fi



################################################
# GIT CONFIG
################################################

if [-n "$CONFIGURE_GITHUB"]; then
	git config --global user.name "$GITNAME"
	git config --global user.email "$GITEMAIL"
	echo -e 'y'|ssh-keygen -t rsa -b 4096 -C "$GITEMAIL" -f ~/.ssh/id_rsa -N ''
	ssh-add ~/.ssh/id_rsa
	curl -u "$GITUSERNAME" --data "{\"title\":\"DevVm_`date +%Y%m%d%H%M%S`\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" https://api.github.com/user/keys
fi

if [-n "$CONFIGURE_GITALIASES"]; then
	#TODO
fi

################################################
# SHELL
################################################
 
if [-n "$INSTALL_ZSH"]; then
	sudo apt-get install -qq zsh
fi

if [-n "$INSTALL_OHMYZSH"]; then	
	curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
	sudo chsh -s /bin/zsh $LOCALUSERNAME
fi 
 
################
# CLEANUP
################
 
cd ~
rm -drf $INSTALLDIR