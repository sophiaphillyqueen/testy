# action__compare_version -- Implements the "compare-version" directive.
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
# The "compare-version" directive is implemented in order to
# compare two version-ID numbers that follow the version numbering
# system that -chorebox- uses. Before this directive, two version
# ID-numbers must be placed on the logic stack for it to run the
# comparison. The top item (item #0) generally references the
# ideal version ID-number that the script is using as the baseline
# for a decision that must be made. The next item (item #1) is
# the version-ID that was queried of a specific software component
# that is available.
#
# This directive takes 4 arguments, each of which is a goto-type
# label. Based on the result of the comparison operation, it will
# be determined which of these labels the flow of the program
# will go to.
#
# The first argument (rg#0) is the desitnation if item #0 is
# clearly a later version-ID than item #1.
#
# Argument rg#1 is the destination if item #1 is clearly a later
# version-ID than item #0.
#
# Argument rg#2 is the destination if the two version-IDs are
# simultaneous. (I hope this will only occur if they are identical,
# but I'm not going to be so bold as to flat-out say that that is
# the only way this can happen.)
#
# And finally, argument rg#3 is the destination if the attempt
# to compare the two version-ID numbers was less-than-successful.
#
# As is generally the case with directives that can result in
# goto-type operations, if you want the program to just continue
# rolling along at it's current location in any of those four
# scenaria, simply specify a simple hyphen ("-") as the goto-label
# -- as that will always be interpreted as the current location
# in the script.
# ########################
# When the documentation of -chorebox- is complete, it will
# explain exactly how version-ID numbers within the -chorebox-
# convention are compared.
# ########################


sub action__compare_version {
  my @lc_gotodes;
  my @lc_staf0;
  my @lc_staf1;
  my @lc_numb0;
  my @lc_numb1;
  my $lc_pick0;
  my $lc_pick1;
  
  # First, we split all our sources into the appropriate arrays.
  @lc_gotodes = split(/:/,$_[0]);
  @lc_staf0 = split(quotemeta("-"),$litstack[0]);
  @lc_staf1 = split(quotemeta("-"),$litstack[1]);
  # As seen, the parts of the version-ID are separated by
  # hyphens.
  
  # The first part of a version-ID is the numeric progress counter.
  # It is a series of integers separated by periods. The first
  # integer is of the greatest significance, and so on. But before
  # we can do any comparison, we need to turn each one into an
  # array.
  if ( &badarray(@lc_staf1) ) { &then_goto($lc_gotodes[0]); return; }
  if ( &badarray(@lc_staf0) ) { &then_goto($lc_gotodes[1]); return; }
  @lc_numb0 = split(quotemeta("."),shift(@lc_staf0));
  @lc_numb1 = split(quotemeta("."),shift(@lc_staf1));
  
  # Now the comparing goes number by number until either one
  # version-ID proves to be the later one (resulting in the
  # appropriate goto operation and the end of this function)
  # or both progress-counters simultaneously run dry (in
  # which event this function will have to go on to the next
  # round of comparison).
  while ( &goodarray(@lc_numb0,@lc_numb1) )
  {
    # If we are here, then obviously they haven't *both*
    # run out - so if *one* of them has run out, it must
    # be the *earlier* version that has.
    if ( &badarray(@lc_numb1) ) { &then_goto($lc_gotodes[0]); return; }
    if ( &badarray(@lc_numb0) ) { &then_goto($lc_gotodes[1]); return; }
    
    # Now for the numeric comparison:
    $lc_pick0 = shift(@lc_numb0);
    $lc_pick1 = shift(@lc_numb1);
    if ( $lc_pick0 > ( $lc_pick1 + 0.5 ) ) { &then_goto($lc_gotodes[0]); return; }
    if ( $lc_pick1 > ( $lc_pick0 + 0.5 ) ) { &then_goto($lc_gotodes[1]); return; }
  }
  
  
  # If we got this far, it is now the battle of the version-types.
  # Originally the plan was to take the build-moment into account
  # for some version-types ---- but that idea was permanently canned
  # because the build-moment only reflects the moment that the code
  # was built on someone's machine - which does not necessarily
  # correspond to the moment that it was current on github.
  #
  # As for what the version-types are, check the &version_type
  # function which translates the names to numbers.
  
  $lc_pick0 = "";
  $lc_pick1 = "";
  if ( &goodarray(@lc_staf0) ) { $lc_pick0 = shift(@lc_staf0); }
  if ( &goodarray(@lc_staf1) ) { $lc_pick1 = shift(@lc_staf1); }
  &version_type($lc_pick0);
  &version_type($lc_pick1);
  if ( $lc_pick0 > ( $lc_pick1 + 0.5 ) ) { &then_goto($lc_gotodes[0]); return; }
  if ( $lc_pick1 > ( $lc_pick0 + 0.5 ) ) { &then_goto($lc_gotodes[1]); return; }
  if ( $lc_pick1 > 502 ) { &then_goto($lc_gotodes[2]); return; }
  
  
  #   You know what? I think that I'm going to just conclude that if
  # the two versions of the package are both build versions and have
  # the same progress tracking number, that it simply isn't *possible*
  # to determine which version is truly later (since, as I stated,
  # the information in the build-moment is less than reliable).
  &then_goto($lc_gotodes[3]);
}

sub version_type {
  my $lc_a;
  
  $lc_a = $_[0];
  $_[0] = 504;
  
  # The "build" phase means that we are still working on implementing
  # features of the new version.
  if ( $lc_a eq "build" ) { $_[0] = 2; }
  
  # The "test" phase means that we -hope- we are done with the
  # features - but we want to run some more tests just to be sure.
  if ( $lc_a eq "test" ) { $_[0] = 4; }
  
  # The "doc" phase means that we are pretty much satisfied with the
  # tests, but we want to do a bit more work on the documentation
  # before we declare this version a release.
  if ( $lc_a eq "doc" ) { $_[0] = 6; }
  
  
  if ( $lc_a eq "release" ) { $_[0] = 506; }
}


