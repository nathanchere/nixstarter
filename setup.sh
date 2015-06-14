. ./config.sh

INSTALLDIR=`pwd`
rm -drf $INSTALLDIR/temp
mkdir $INSTALLDIR/temp
cd $INSTALLDIR/temp

drawHeader() {
	echo " "
	echo "#######################################################################"
	echo "# $1"
	echo "#######################################################################"		
	echo " "
}

# TODO:
# Tilda/quake - and add to autostart - and import config
# Something like Launchy for Linux
# Good generic light code editor like np++ (no not sublame) - textadept?
# Find $latest versions for all the shitbags who only provide version-numbered URLs
# Good clipboard manager like clipx
# Can I be bothered with: Lisp(/Scheme/etc)? Rebol? Fancy? ECMAScript/IO? R? Dart? Smalltalk? haXe?
# install github's `hub` helper

################################################
# APTITUDE REPOS
################################################

drawHeader "Updating aptitude repositories"

if [ -n "$INSTALL_BASE_MONO" ]; then
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
fi

if [ -n "$INSTALL_NODEJS" ]; then
	sudo add-apt-repository -y ppa:chris-lea/node.js
fi

if [ -n "$INSTALL_ERLANG" ]; then
	wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb -O $INSTALLDIR/temp/erlang-solutions_1.0_all.deb && sudo dpkg -i $INSTALLDIR/temp/erlang-solutions_1.0_all.deb
fi

if [ -n "$INSTALL_D" ]; then
	sudo wget http://master.dl.sourceforge.net/project/d-apt/files/d-apt/list -O /etc/apt/sources.lst.d/d-apt.list
fi

sudo apt-get update -qq

drawHeader "Upgrading existing packages"

sudo apt-get upgrade -q -y --force-yes

################################################
# ESSENTIALS
################################################

if [ -n "$INSTALL_UTILS" ]; then
	drawHeader "Installing essential utils"	
	sudo apt-get install -qq git git-core mercurial
	sudo apt-get install -qq curl sharutils sed jq autoconf
fi

################################################
# MISC BUILD DEPENDENCIES
################################################

if [ -n "$INSTALL_BUILDLIBS" ]; then
	drawHeader "Installing build dependencies"
	sudo apt-get install -qq --fix-missing build-essential libssh-dev m4
	sudo apt-get install -qq --fix-missing ncurses-dev libncurses5-dev openssl libssl-dev unzip
	sudo apt-get install -qq --fix-missing libsdl-dev libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl-ttf2.0-dev
	sudo apt-get install -qq --fix-missing libsmpeg-dev libportmidi-dev libavformat-dev libswscale-dev libjpeg-dev libfreetype6-dev
	sudo apt-get install -qq --fix-missing libunwind8
fi

################################################
# FRAMEWORKS / RUNTIMES
################################################

if [ -n "$INSTALL_BASE_MONO" ]; then	
	drawHeader "Installing Mono runtime"
	sudo apt-get install -qq mono-devel mono-complete
fi

if [ -n "$INSTALL_BASE_JAVA" ]; then
	drawHeader "Installing Java runtime"
	sudo apt-get install -qq openjdk-6-jre openjdk-7-jre
fi

################################################
# GIT CONFIG
################################################

if [ -n "$CONFIGURE_GITHUB" ]; then
	drawHeader "Configuring GitHub"
	git config --global user.name "$GITNAME"
	git config --global user.email "$GITEMAIL"
	echo -e 'y'|ssh-keygen -t rsa -b 4096 -C "$GITEMAIL" -f ~/.ssh/id_rsa -N ''
	ssh-add ~/.ssh/id_rsa
	curl -u "$GITUSERNAME" --data "{\"title\":\"DevVm_`date +%Y%m%d%H%M%S`\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" https://api.github.com/user/keys
fi

if [ -n "$CONFIGURE_GITALIASES" ]; then
	drawHeader "Configuring git aliases"
	echo "TODO: git aliases here"
fi

################################################
# SHELL
################################################
 
if [ -n "$INSTALL_ZSH" ]; then
	drawHeader "Installing zsh"
	sudo apt-get install -qq zsh
	
	if [ -n "$INSTALL_OHMYZSH" ]; then	
		curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
		sudo chsh -s /bin/zsh $LOCALUSERNAME
	fi 
fi

################################################
# LANGUAGE RUNTIMES / SDKs / COMPILERS / etc
################################################

if [ -n "$INSTALL_NODEJS" ]; then	
	drawHeader "Installing node"
	sudo apt-get install -qq nodejs
	sudo chown -R $USER ~/.npm
	sudo chown -R $USER /usr/lib/node_modules
	. ~/.bashrc
	sudo npm install -g npm
	#. ~/.zshrc # - maybe one day little buddy..
fi

if [ -n "$INSTALL_JSDEV" ]; then
	drawHeader "Installing JS toolchain"
	sudo npm install -g yo bower grunt-cli gulp
fi
 
if [ -n "$INSTALL_OCAML" ]; then
	drawHeader "Installing OCaml"
	sudo apt-get install -qq ocaml camlp4 ocaml-findlib
fi

if [ -n "$INSTALL_HAXE" ]; then
	drawHeader "Installing haXe"
	sudo apt-get install -qq haxe
fi

if [ -n "$INSTALL_CORECLR" ]; then
	drawHeader "Installing CoreCLR"
	sudo apt-get install -qq fsharp
	mozroots --import --sync # to enable nuget package import
	curl -sSL https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.sh | DNX_BRANCH=dev sh && . ~/.dnx/dnvm/dnvm.sh
	dnvm update -u
	dnvm install latest -r coreclr -u 
fi

if [ -n "$INSTALL_PYTHON" ]; then
	drawHeader "Installing Python"
	sudo apt-get install -qq python3-dev python3-numpy idle3
fi

if [ -n "$INSTALL_PYGAME" ]; then
	drawHeader "Installing PyGame"
	sudo apt-get install -qq mercurial
	cd $INSTALLDIR/temp
	hg clone https://bitbucket.org/pygame/pygame
	cd $INSTALLDIR/temp/pygame
	python3 setup.py build
	sudo python3 setup.py install
fi

if [ -n "$INSTALL_ERLANG" ]; then
	drawHeader "Erlang"
	#cd $INSTALLDIR/temp
	## This is for building manually - takes ages, not ideal
	#git clone https://github.com/erlang/otp.git
	#cd otp
	#export ERL_TOP=`pwd`	
	#./otp_build autoconf
	#./configure
	#make			
	sudo apt-get install -qq --no-install-recommends erlang
fi

if [ -n "$INSTALL_ELIXIR" ]; then
	drawHeader "Installing Elixir"
	sudo apt-get install -qq elixir
fi

if [ -n "$INSTALL_GO" ]; then	
	drawHeader "Installing Go"
	sudo apt-get install -y golang
	echo 'export GOROOT=/usr/lib/go' >> ~/.bashrc
	echo 'export GOPATH=$HOME/go' >> ~/.bashrc
fi

if [ -n "$INSTALL_RUST" ]; then
	drawHeader "Installing Rust"
	cd $INSTALLDIR/temp
	wget https://static.rust-lang.org/rustup.sh
	sudo chmod +755 ./rustup.sh
	./rustup.sh -y
fi

if [ -n "$INSTALL_D" ]; then
	drawHeader "Installing D"
	sudo apt-get -qq --allow-unauthenticated install d-apt-keyring
	sudo apt-get -qq install dmd-bin libdsqlite-dev libscid-dev libgl3n-dev dub 	
	#TODO: install coedit github.com/BBasile/Coedit
fi

if [ -n "$INSTALL_JAVA" ]; then
	drawHeader "Installing Java"
	sudo apt-get install -qq openjdk-7-jdk	
fi

if [ -n "$INSTALL_SCALA" ]; then
	drawHeader "Installing Scala"
	sudo apt-get install -qq scala
	#TODO: install SBT
fi

if [ -n "$INSTALL_CLOJURE" ]; then
	drawHeader "Installing Clojure"
	cd $INSTALLDIR/temp
	sudo apt-get install -qq openjdk-7-jdk clojure1.6
	sudo wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O /usr/local/bin/lein
	sudo chmod +755 /usr/local/bin/lein	
fi

if [ -n "$INSTALL_HASKELL" ]; then
	drawHeader "Installing Haskell"
	sudo apt-get install -qq haskell-platform
fi

if [ -n "$INSTALL_PHP" ]; then
	drawHeader "Installing PHP (why, oh why??)"
	sudo apt-get install php5
	# TODO- if install apache or nginx, add appropriate integration
fi

if [ -n "$INSTALL_RUBY" ]; then
	drawHeader "Installing Ruby"
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	\curl -sSL https://get.rvm.io | bash -s stable
	source ~/.rvm/scripts/rvm
fi
 
################
# CLEANUP
################

drawHeader "Complete; cleaning up" 
cd $INSTALLDIR
rm -drf $INSTALLDIR/temp
sudo apt-get clean
