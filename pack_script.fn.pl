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
# RSSA[0]: The name of the script file:
#
# RSSA[1]: => The line-by-line contents of the script file
#
# RSSA[2]: => The array of *location-labels* in the script file
#
# RSSA[3]: Your location in the execution of the script file
#
# RSSA[4]: => The script's hash of string-variables
#
# RSSA[5]: => The script's hash of array-variables
#
# RSSA[6]: => The script's logic stack
# ########################

sub pack_script {
  my $lc_husk; # The script-session reference
  my $lc_rssa_1;
  my $lc_rssa_2;
  my $lc_rssa_4;
  my $lc_rssa_5;
  my $lc_rssa_6;
  my $lc_rssa_7;
  
  $lc_rssa_1 = \@make_lines;
  $lc_rssa_2 = \%make_label;
  $lc_rssa_4 = \%strgvars;
  $lc_rssa_5 = \%strarays;
  $lc_rssa_6 = \@litstack;
  $lc_rssa_7 = \@used_scrips;
  
  $lc_husk = [$recipe_file
    , $lc_rssa_1 , $lc_rssa_2 , $make_indx
    , $lc_rssa_4 , $lc_rssa_5 , $lc_rssa_6
    , $lc_rssa_7
  ];
  
  return $lc_husk;
}


sub unpack_script {
  my $lc_husk; # The script-session array
  my @lc_hsk; # $lc_husk past reference
  my $lc_ole_recipe;
  my $lc_ole_place;
  my $lc_problemo;
  my $lc_complaint;
  my $lc_rssa_1;
  my $lc_rssa_2;
  my $lc_rssa_4;
  my $lc_rssa_5;
  my $lc_rssa_6;
  my $lc_rssa_7;
  
  $lc_ole_recipe = $recipe_file;
  $lc_ole_place = $make_indx;
  
  $lc_husk = $_[0];
  
  if ( ref($lc_husk) ne "ARRAY" )
  {
    die "\nInvalid script-session reference provided:\n    "
      . $lc_ole_recipe . ": line " . $make_indx . ":\n"
      . "    It isn't even a reference to an array!!!\n\n";
    ;
  }
  
  @lc_hsk = @$lc_husk;
  
  $lc_complaint = "\nInvalid script-session reference provided:\n    "
      . $lc_ole_recipe . ": line " . $make_indx . ":\n"
  ;
  
  $lc_problemo = ( 1 > 2 );
  if ( ref($lc_hsk[1]) ne "ARRAY" ) { $lc_problemo = ( 2 > 1 ); }
  if ( ref($lc_hsk[2]) ne "HASH" ) { $lc_problemo = ( 2 > 1 ); }
  if ( ref($lc_hsk[4]) ne "HASH" ) { $lc_problemo = ( 2 > 1 ); }
  if ( ref($lc_hsk[5]) ne "HASH" ) { $lc_problemo = ( 2 > 1 ); }
  if ( ref($lc_hsk[6]) ne "ARRAY" ) { $lc_problemo = ( 2 > 1 ); }
  if ( ref($lc_hsk[7]) ne "ARRAY" ) { $lc_problemo = ( 2 > 1 ); }
  
  if ( $lc_problemo ) { die $lc_complaint . "\n"; }
  
  $recipe_file = $lc_hsk[0];
  $lc_rssa_1 = $lc_hsk[1];
  $lc_rssa_2 = $lc_hsk[2];
  $make_indx = $lc_hsk[3];
  $lc_rssa_4 = $lc_hsk[4];
  $lc_rssa_5 = $lc_hsk[5];
  $lc_rssa_6 = $lc_hsk[6];
  $lc_rssa_7 = $lc_hsk[7];
  
  @make_lines = @$lc_rssa_1;
  %make_label = %$lc_rssa_2;
  %strgvars = %$lc_rssa_4;
  %strarays = %$lc_rssa_5;
  @litstack = @$lc_rssa_6;
  @used_scrips = @$lc_rssa_7;
  
  $make_length = @make_lines;
}


# Bear in mind the return_to_higher_script() function returns to the
# calling script if the current script is *not* the original Makefile
# recipe script - but it does *not* terminate the configuration if the
# current script *is* the original Makefile recipe script. Originally,
# the design-plan of this function was to have it *indirectly* do so
# by going to the end-of-the-script in that event - but then it was
# concluded that it would be more flexible to let the *calling*
# function do this if it wished --- thereby giving it the option not
# to if it wished not to.
sub return_to_higher_script {
  my $lc_tool_script;
  my $lc_calling_script;
  
  # First thing we make clear that there is nothing to do if the
  # present script is the original Makefile recipe.
  if ( &badarray(@over_scripts) ) { return; }
  
  # Next thing, we pack the present script:
  $lc_tool_script = &pack_script;
  
  # Now we find our reference to the calling script.
  $lc_calling_script = pop(@over_scripts);
  
  # And now we can switch back over to the calling script.
  &unpack_script($lc_calling_script);
  
  # Of course, before returning, we must record the finishing
  # state of the tool script.
  @used_scrips = ( $lc_tool_script, @used_scrips );
}


