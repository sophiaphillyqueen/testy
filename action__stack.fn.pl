# action__stack - What "chorebox-configure" does for "stack" directive.
# action__ifsame_to - What "chorebox-configure" does for "ifsame-to" directive.
# meaning_of - Interprets a complex string definition
# then_goto_label - Goes to a specific label of the Makefile recipe
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
