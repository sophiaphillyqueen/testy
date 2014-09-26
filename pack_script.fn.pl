# pack_script.fn.pl -- Utilities for storing an active recipe-script run in a perlref.
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
# Eventually, it is the goal of -chorebox- to support shared libraries
# and other things who's finer details vary from one platform to another
# --- and to do so while adhering to -chorebox-'s design philosophy of
# maximum segregation of all platform-specific code. Quite obviously,
# the only way this can be done is to support the main recipe-script
# (named "Makefile.pre") being given the ability to invoke *other*
# recipe scripts.
#
# This feature can only be implemented if it is possible to pack all
# the information on the current script (including where we are in the
# script's run) into a perlref data structure and later on restore it
# from the same data structure. Let this file contain the functions for
# *both* these operations pack_script() - who's return-value is the
# perlref variable that stores the current script-session - as well
# as unpack_script() which has no currently-designated return value
# but who's sole argument is the perlref variable (created by
# pack_script()) from which you want a previously packed session
# to be restored.
# ########################
# Here's the run-down of the anatomy of the data structure returned
# by pack_script() and used by unpack_script(). In short, it is
# a perlref to an array. Be mindful that it is NOT in ITSELF an
# array, but a perlref to one. An important distinction. Henceforth
# in this description, the array *referenced* by this perlref will
# be referred to as the Recipe-Script Session Array (RSSA for short).
# And each item will be referred to by the following way -- if it
# is item 'x' (that is the x+1th item) it will be referred to as
# RSSA[x].
#
# So here goes ...
#
# RSSA[0]: The name of the array file.
# ########################
