# ident-local-cc.sh: Identifies local C compiler
# Copyright (C) 2014  Sophia Elizabeth Shapira
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# ########################

# It is user's responsibility to configure their account
# to identify the correct C compiler if it is anything
# other than the default - a simple "gcc".
# To do that, create the file (and if necessary it's
# containing directory):
#   ~/.chorebox/local-c-compiler.txt
# with only one line - that line being whatever you want
# to be instead of "gcc" at the beginning of every line
# of shell-code that does C compilation and/or linking.

# This program is intended for the calling shell-script
# to call with *all* of it's command-line arguments - the
# idea being that this script will have all the same
# information that it's calling script has access to to
# make the necessary determination.

# IMPORTANT: If you are doing cross-compilation, you
# should know that the C compiler identified by this
# script is NOT the one that you will be doing
# cross-compilation with. The C compiler identified
# by this script is used to build binaries that are
# executed ON THIS LOCAL MACHINE and will be used
# to generate binaries that are to be used in this
# package's configuration process.

blessed_c_compiler=gcc

if [ -d ~/.chorebox ]; then
  if [ -f ~/.chorebox/local-c-compiler.txt ]; then
    blessed_c_compiler="$(cat ~/.chorebox/local-c-compiler.txt)";
  fi
fi

echo "${blessed_c_compiler}"



