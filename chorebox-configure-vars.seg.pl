# chorebox-configure - The 'chorebox' -configure- script backend.
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
# This file was added to segregate the variables from the main
# algorithm script.
# ########################

use File::Basename;


my @dir_vars_specfied = ();
my %dir_vars_values = {};
my %dir_vars_real = {};
my %valvar = {}; # Value after resolved by &autom
my @lisdirs = (); # List of all directories resolved by &autom
my $argum;

my @make_lines;
my $make_length;
my $make_indx;
my %make_label; # The directory of all goto destination-lines by label
my %proj_info_s;
my %proj_info_l;

my @used_scrips;
# The list of all scripts previously invoked by the current one.
# The array begins with the most recently invoked one - that is
# new entries are added at the *beginning* of the list.
# The list continues to accumulate until it is deliberately cleared.

my @over_scripts = ();
# The stack of all scripts to return to upon completion of the
# current one.

my $err_mesg = "";


my $truthiness; # Logic variable for acceptance or rejection of -certain- arguments

my $adendia;

my %strgvars = {}; # All the string variables in thought space
my %strarays = {};
my @litstack = (); # Logical string-stack (array beginning = top)


# The following variables are used in "foreach" looping:
my @frochstack = (); # Stack of inactive "foreaches" (needed for nesting)
my $frochstart = 0; # Beginning line of the "foreach" reference
my @frochlist = (); # List of yet-to-be-shifted elements
my $frochvari = ""; # Name of variable the loop writes to:
my $frochfont = ""; # Name of array the loop writes from (stored only for thought output)

my $recipe_file; # The name of the current recipe file
# Starts with Makefile.pre in the $(srcdir) directory.

# The following variable is true iff the Makefile recipe-script is to be
# interpreted in developer mode. This means that any feature in the
# grace-period phase of the deprecation process will trigger a fatal
# error --- as will any improper use of the scripting language that
# the interpreter is able to detect. (Still -- check your code for
# things that the interpreter might not notice.)
my $developer_mode;



my $r__perl_l_exe = \&f__uninitiated;
# Meaning-of "perl-l" - for local (indev dir) copies of perl execs
my $r__perl_i_exe = \&f__uninitiated;
# Meaning-of "perl-i" - for installed) copies of perl execs
# I think "perl-i" and "perl-l" should always be synonymous, but
# separate interpretations are provided just in case.
my $r__bin_l_exe = \&f__uninitiated;
# Meaning-of "bin-l" - for local (indev dir) copies of binary execs
my $r__bin_i_exe = \&f__uninitiated;
# Meaning-of "bin-i" - for installed) copies of binary execs
# I think "bin-i" and "bin-l" should always be synonymous, but
# separate interpretations are provided just in case.

my $r__perl_install = \&f__uninitiated;
my $r__bin_install = \&f__uninitiated;


