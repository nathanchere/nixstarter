INSTALLDIR=pwd
SOMEVAR=1

if [ -n "$SOMEVAR" ] ; then
	echo "set: '$SOMEVAR'"
else
	echo "not set"
fi

if [-n "$SOMEVAR464"]; then
	echo "set: '$SOMEVAR464'"
else
	echo "not set"
fi
