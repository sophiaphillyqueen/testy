# action__adapt - What "chorebox-configure" does for "adapt" directive.
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
# An "adapt" directive sets the OS-dependent function-references
# based on a "meaning-of" string which is interpreted as though
# it is the output of the "uname -s" shell command.
# ########################

sub action__adapt {
  my $lc_retstrg;
  my $lc_predash;
  
  $lc_retstrg = &meaning_of($_[0]);
  ($lc_predash) = split(quotemeta("-"),$lc_retstrg);
  if ( $lc_predash eq "CYGWIN_NT" )
  {
    $r__perl_l_exe = \&f__perl_l_exe__cygwin;
    $r__perl_i_exe = \&f__perl_l_exe__cygwin;
    $r__bin_l_exe = \&f__bin_l_exe__cygwin;
    $r__bin_i_exe = \&f__bin_l_exe__cygwin;
    $r__perl_install = \&f__perl_install__cygwin;
    return;
  }
  $r__perl_l_exe = \&f__literal__unv;
  $r__perl_i_exe = \&f__literal__unv;
  $r__bin_l_exe = \&f__literal__unv;
  $r__bin_i_exe = \&f__literal__unv;
  $r__perl_install = \&f__perl_install__ux;
}

sub f__literal__unv {
  return $_[0];
}

sub f__empty__unv {
  return "";
}

sub f__perl_l_exe__cygwin {
  my $lc_a;
  $lc_a = $_[0];
  $lc_a .= ".pl";
  return $lc_a;
}

sub f__bin_l_exe__cygwin {
  my $lc_a;
  $lc_a = $_[0];
  $lc_a .= ".exe";
  return $lc_a;
}

sub f__uninitiated {
  die "\nUninitiated use of OS-specific features prohibited.\n\n";
}

sub action__perl_in {
  my @lc_a;
  
  # First part of directive's argument is the current location
  # of the command to be installed.
  # The second part is the directory to install it in (as
  # referenced from commands within the Makefile).
  @lc_a = split(quotemeta(":" . ":"),$_[0]);
  &$r__perl_install(&meaning_of($lc_a[0]),&meaning_of($lc_a[1]));
}

sub f__perl_install__ux {
  $adendia .= "\n\tchmod 755 " . $_[0];
  $adendia .= "\n\tcp " . $_[0] . " \"" . $_[1] . "/.\"";
  $adendia .= "\n\tchmod 755 \"" . $_[1] . "/" . &get_file_obase($_[0]) . "\"";
}

sub f__perl_install__cygwin {
  $adendia .= "\n\tcp " . $_[0] . ".pl \"" . $_[1] . "/.\"";
}


sub get_file_obase {
  my $lc_arg;
  my $lc_ret;
  my $lc_chr;
  $lc_arg = $_[0];
  $lc_ret = "";
  while ( $lc_arg ne "" )
  {
    $lc_chr = chop($lc_arg);
    if ( $lc_chr eq "/" ) { return $lc_ret; }
    $lc_ret = $lc_chr . $lc_ret;
  }
  return $lc_ret;
}




