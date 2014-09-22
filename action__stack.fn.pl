# action__stack - What "chorebox-configure" does for "stack" directive.
# action__ifsame_to - What "chorebox-configure" does for "ifsame-to" directive.
# action__goto - What "chorebox-configure" does for "goto" directive.
# meaning_of - Interprets a complex string definition
# then_goto_label - Goes to a specific label of the Makefile recipe
# report_array - Reports the setting of a Thought Array
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

sub action__stack {
  my $lc_a;
  
  $lc_a = &meaning_of($_[0]);
  @litstack = ($lc_a,@litstack);
  system("echo","  Stack On: " . $lc_a . ":");
}

sub action__ifsame_to {
  my $lc_a;
  
  if ( $litstack[0] ne $litstack[1] ) { return; }
  ($lc_a) = split(/:/,$_[0]);
  then_goto_label($lc_a);
}

sub action__goto {
  my $lc_a;
  
  ($lc_a) = split(/:/,$_[0]);
  then_goto_label($lc_a);
}

sub meaning_of {
  my @lc_a;
  my @lc_b;
  
  @lc_a = split(/:/,$_[0],2);
  if ( $lc_a[0] eq "lit" ) { return $lc_a[1]; }
  
  if ( $lc_a[0] eq "var" )
  {
    @lc_b = split(/:/,$lc_a[1]);
    return $strgvars{$lc_b[0]};
  }
  
  if ( $lc_a[0] eq "qry" )
  {
    my $lc2_a;
    my $lc2_b;
    
    $lc2_a = $lc_a[1];
    $lc2_b = `$lc2_a`; chomp($lc2_b);
    return $lc2_b;
  }
  
  # Dynamic query -- for things such as build-time.
  # It's implementation is like the early implementations
  # of "qry" - except that later on, "qry" will be
  # altered to check the query in the target-system
  # query-result file if one is specified - while "dqry"
  # will always continue to just get the output of a
  # shell command.
  if ( $lc_a[0] eq "dqry" )
  {
    my $lc2_a;
    my $lc2_b;
    
    $lc2_a = $lc_a[1];
    $lc2_b = `$lc2_a`; chomp($lc2_b);
    return $lc2_b;
  }
  
  if ( $lc_a[0] eq "info" )
  {
    @lc_b = split(/:/,$lc_a[1]);
    return $proj_info_s{$lc_b[0]};
  }
  
  if ( $lc_a[0] eq "linfo" )
  {
    @lc_b = split(/:/,$lc_a[1]);
    return $proj_info_l{$lc_b[0]};
  }
  
  die "\nUnknown complex string-type: \""
    . $lc_a[0] . "\" in line " . int($make_indx + 1.2)
    . ":\n  " . $make_lines[$make_indx] . "\n\n"
  ;
}

sub then_goto_label {
  my $lc_a;
  
  $lc_a = $make_label{$_[0]};
  if ( $lc_a eq "" )
  {
    die "\nFictional label \"" . $_[0] . "\" referenced in line " . int($make_indx + 1.2)
      . ":\n  " . $make_lines[$make_indx] . "\n\n"
    ;
  }
  system("echo","  Go to Label: " . $_[0] . ":");
  $make_indx = $lc_a;
}

sub report_array {
  my $lc_aa;
  my $lc_ab;
  my @lc_b;
  my $lc_c;
  
  $lc_aa = $_[0];
  $lc_ab = $strarays{$lc_aa};
  @lc_b = @$lc_ab;
  
  system("echo","  Thought array set: " . $lc_aa . ":");
  foreach $lc_c (@lc_b)
  {
    system("echo","    -" . "> " . $lc_c . ":");
  }
}

