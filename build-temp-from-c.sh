# build-temp-from-c.sh: Builds temporary-execs from C to configure base -chorebox- package
# Copyright (C) 2014  Sophia Elizabeth Shapira

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# ########################

# First, I initialize the $origidir variable to the source-code
# directory.
origidir="$(dirname "${0}")"
abs_origidir="$(cd "${origidir}" && pwd)"
# .. and I load the for-local C compiler.
local_cc="$(cat temporary--c-compiler.txt)"

first_round=yes
say_yes=yes
say_no=no
obje_num=0
obje_litny=""
extra_arg_c=`cat temporary--extra-options-compile.txt`
extra_arg_l=""

rm -rf tmp-obj
mkdir tmp-obj

for argunas in "${@}"
do
  if [ $first_round = $say_yes ]; then
    destiny=$argunas
    rm -rf "${destiny}"
  else
    obje_num="$(expr "${obje_num}" + 1)"
    obje_fil="tmp-obj/file-${obje_num}.o"
    obje_litny="${obje_litny} ${obje_fil}"
    "${local_cc}" "-I${origidir}/libchorebox/inc" -o "${obje_fil}" -c "${argunas}" $extra_arg_c || exit 3
  fi
  first_round=no
done

"${local_cc}" -o "${destiny}" $obje_litny $extra_arg_l || exit 4

rm -rf tmp-obj


