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


# Some variables we require ...
my $where_we_work_from;
my $home_directory;
my $home_bin_dir;

# First, we establish our working location.
$where_we_work_from = `pwd`; chomp($where_we_work_from);


# Now we find the home directory --- as why else use this wrapper?
$home_directory = $ENV{"HOME"};

if ( $home_directory eq "" )
{
  die "\nThe \"chorebox-in\" wrapper is pointless if your environment does"
    . "\nnot specify a home directory."
    . "\n\n"
  ;
}

# Now we find the first directory on the execution PATH that is
# a subset of the home directory (as that is the test that we are
# currently using to verify the user's privilege to put files
# there).
{
  my $lc_path;
  my @lc_pthdirs;
  my $lc_pathloc;
  my $lc_found;
  
  $lc_path = $ENV{"PATH"};
  @lc_pthdirs = split(/:/,$lc_path);
  $lc_found = ( 1 > 2 );
  foreach $lc_pathloc (@lc_pthdirs)
  {
    if ( !($lc_found) )
    {
      $lc_found = &directory_subset($home_directory,$lc_pathloc);
      if ( $lc_found ) { $home_bin_dir = $lc_pathloc; }
    }
  }
  
  if ( !($lc_found) )
  {
    die "\nNo directory within the tree of your home directory"
      . "\nis mentioned on the execution PATH.\n\n";
    ;
  }
}

# Now for the following, paying attention to the GNU
# documentation on directory variables and their corresponding
# options might be helpful in my coding -- even if this is
# not 100% GNU-compliant:
# http://www.gnu.org/prep/standards/html_node/Configuration.html
# http://www.gnu.org/prep/standards/html_node/Directory-Variables.html





