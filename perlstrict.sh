
perlocas="$(which perl)"
rm -rf "${1}"
echo "#! ${perlocas}" > "${1}"
echo "use strict;" >> "${1}"
