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

# Of course, the current version of this program simply
# ASSumes that "gcc" is used as the local compiler for
# binaries that will run on this machine, but the idea
# is that it will later be changed to no longer make this
# ASSumption. Granted, this script will only be needed
# for installation of the *base* -chorebox- package.
# For later versions, the -chorebox- configuration utility
# will do this calculation if need-be.

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

echo gcc


