
perlocas="$(which perl)"
echo "#! ${perlocas}" > "${1}"
echo "use strict;" >> "${1}"
