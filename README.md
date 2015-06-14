nixstarter
============

There is nothing revolutionary happening here, it's just a bunch of scripts I put together
to try and remove some of the friction out of when it comes to
setting up new Linux-based burner boxes for development. 

*** This is only tested on Xubuntu Core 15.04.*** It should work with other Debian-based distros
and maybe even others as long as they use the `aptitude` package manager, but YMMV.

Start the ball rolling by copy/pasting this into a terminal window:

    wget -O - https://raw.githubusercontent.com/nathanchere/nixstarter/master/bootstrap.sh >> bootstrap.sh && sudo chmod +755 bootstrap.sh && ./bootstrap.sh

Edit the newly cloned `config.sh` following the instructions within to edit settings and choose which
features you want to install. Then run `sudo ./setup.sh` for near instant bliss and enlightenment.

Main things it does:

* Install general dev essentials (eg git)
* Install general Linux essentails (eg curl)
* Install common build dependencies (eg libopenssh)
* Install common runtimes (.Net CoreCLR, Java)
* Configure shell
	- set zsh to default shell
    - add ohmyzsh customisations
* Configure git
    - set up git username etc
	- create new SSH key and add it to your GitHub account
	- create common git aliases

If you don't want it to do something, comment out the corresponding trigger line in `config.sh`.

Feature-specific notes
---------------------------

### Ruby

Installs RVM and uses that for managing Ruby installation(s). To install ruby use `rvm list known` to display available versions, then `rvm install 1.9.3` (using 1.9.3 as an example).

There's some bullshit RVM warning on install about $PATH not being in something something, whatever.

### Python

Installs Python 3.x. No 2.7 rubbish, because fuck the Luddites. Also installs IDLE as the recommended IDE.

### Java

Uses the OpenJDK 1.7n

### Clojure 

Installs Clojure 1.6.x. Includes Leiningen

### CoreCLR

Installs DNVM and uses that for manaing CoreCLR installation(s). Newest/current CoreCLR is installed by default. Includes F#.

### Erlang, Elixir

Erlang and Elixir are both provided by erlang-solutions.com whose package repository is as flaky as a sunburnt nun's arse crack.
If you get errors about either install go watch some paint dry and then try again later.

### JsDev

Installs common tools for modern Javascript developers like grunt, bower and yeoman.


Disclaimer
----------

I know this is a shit way of doing things. I'm not a 'shell' guy. I'm learning as
I go here and can always see a lot of better ways to do things but right now I just
want a script that will make it easier for me to get shit done, not another meta-project.

All of these setups are working from my own experience working on a clean Xubuntu Core 15.04
install. There may be other better or 'official' ways of installing some of them, and
if that other way works for you then more power to you!