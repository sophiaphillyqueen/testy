# action__fail.fn.pl -- Functions for a Makefile recipe to output errors
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

sub action__fail {
  die $err_mesg;
}

sub captura {
  my $lc_adn;
  my $lc_ret;
  $lc_adn = $adendia;
  $adendia = "";
  &act_by_line("z:" . $_[0]);
  $lc_ret = $adendia;
  $adendia = $lc_adn;
  return $lc_ret;
}

