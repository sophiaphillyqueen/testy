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


# First thing we do is examine the configure script
# so as to (as best we can) figure out what interpreter
# to use to invoke it. Some might think that it would be
# much simpler to simply execute the file as being itself
# the executable and let the system take it from there -
# but that would cause a problem if the source tree is
# located some place where it is impossible to set
# "execute" permissions to "on" (such as non-app-specific
# filesystem area on Android).
{
  my $lc_rdcm; # The command to retrieve file's contents:
  my $lc_fullfile;
  my $lc_firstline;
  
  $lc_rdcm = "cat";
  &apnd_shrunk_argument($lc_rdcm,$ARGV[0]);
  $lc_fullfile = `$lc_rdcm`;
  ($lc_firstline) = split(/\n/,$lc_fullfile);
  @lc_allwords = split(/ /,$lc_firstline);
}



