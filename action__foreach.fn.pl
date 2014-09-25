# action__foreach - What "chorebox-configure" does for "foreach" directive.
# forward_to_eachend - Fast-forward to the end of the current "foreach" loop
# action__eachend - What "chorebox-configure" does for "eachend" directive.
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

sub action__foreach {
  my $lc_previous_list;
  my $lc_previous_loop;
  my $lc_list_ref;
  
  # The first thing we do is put the contents of any "foreach" loop
  # that this one is nested within in a variable that will later
  # be put on the nesting stack.
  $lc_previous_list = [@frochlist];
  $lc_previous_loop = [$frochstart,$lc_previous_list,$frochvari,$frochfont];
  push @frochstack, $lc_previous_loop;
  
  # Now we find the arguments given to the directive.
  ($frochfont,$frochvari) = split(/:/,$_[0]);
  
  # Now we set the location of where this loop starts:
  $frochstart = $make_indx;
  
  # And finally, we put the variables where they belong.
  $lc_list_ref = $strarays{$frochfont};
  if ( ref($lc_list_ref) ne "ARRAY" )
  {
    die "\nFATAL ERROR: " . $recipe_file . ": Line: " . int($make_indx + 1.2)
      . ":\n  Uncreated array referenced: " . $frochfont . ":"
      . "\n\n" . $make_lines[$make_indx] . "\n\n"
    ;
  }
  @frochlist = (@$lc_list_ref);
  if ( !(&goodarray(@frochlist)) )
  {
    &forward_to_eachend;
    $frochstart = $$lc_previous_loop[0];
    $frochvari = $$lc_previous_loop[2];
    $frochfont = $$lc_previous_loop[3];
    @frochlist = @$lc_previous_list;
    return;
  }
  
  # Now that we know that this operation was successful, we put
  # the superior loop on the stack.
  push @frochstack, $lc_previous_loop;
  
  # And finally, we set the first var loose, and continue.
  $strgvars{$frochvari} = shift(@frochlist);
  system("echo","  Beginning loop of: " . $frochfont . ":\n      This round: "
    . $frochvari . ": = " . $strgvars{$frochvari} . ":"
  );
}

sub forward_to_eachend {
  my $lc_countor;
  my @lc_thiso;
  $make_indx = int($make_indx + 1.2);
  
  $lc_countor = 1;
  while ( ( $lc_countor > 0.5 ) && ( $make_indx < $make_length ) )
  {
    @lc_thiso = split(/:/,$make_lines[$make_indx]);
    if ( $lc_thiso[1] eq "foreach" ) { $lc_countor = int($lc_countor + 1.2); }
    if ( $lc_thiso[1] eq "eachend" ) { $lc_countor = int($lc_countor - 0.8); }
    $make_indx = int($make_indx + 1.2);
  }
}

sub action__eachend
{
  my $lc_previous_loop;
  my $lc_previous_list;
  
  # If there are more rounds to the loop, then get to it!!!
  if ( &goodarray(@frochlist) )
  {
    $strgvars{$frochvari} = shift(@frochlist);
    $make_indx = $frochstart;
    system("echo","  Repeating loop of: " . $frochfont . ":\n      This round: "
      . $frochvari . ": = " . $strgvars{$frochvari} . ":"
    );
    return;
  }
  
  if ( !(&goodarray(@frochstack)) )
  {
    die "\nFATAL ERROR: An \"eachend\" without a \"foreach\":\n\n";
  }
  system("echo","  Ending loop of: " . $frochfont. ":");
  $lc_previous_loop = pop(@frochstack);
  $frochstart = $$lc_previous_loop[0];
  $lc_previous_list = $$lc_previous_loop[1];
  $frochvari = $$lc_previous_loop[2];
  $frochfont = $$lc_previous_loop[3];
  @frochlist = @$lc_previous_list;
}


