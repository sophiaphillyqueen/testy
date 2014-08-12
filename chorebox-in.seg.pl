# chorebox-in - The 'chorebox' wrapper for -configure- scripts.
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

# Any time you see a script labeled "configure" for configuring a
# package for installation - simply prepend the configuration
# command with a reference to this wrapper so that the installation
# will default to some place in your jurisdiction as a user rather
# than to some place that you will need superuser privileges to
# access.

# For example:
# $ ./configure --this=that
# becomes
# $ chorebox-in configure --this=that

# Another example:
# $ ../../foo/bar/configure --some=thing
# becomes
# $ chorebox-in ../../foo/bar/configure --some=thing

