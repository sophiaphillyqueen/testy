// chorebox-in - The 'chorebox' wrapper for -configure- scripts.
// specified_var_option.c - Source-code for this function:
// Copyright (C) 2014  Sophia Elizabeth Shapira
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
// ########################

#include "chorebox-in.h"

bool specified_var_option ( char *rg_a )
{
  return found_on_list(rg_a,legacy_options);
}

bool found_on_list ( char *rg_a, chorebox_str_list *rg_b )
{
  chorebox_str_list *lc_eachone;
  
  lc_eachone = rg_b;
  while ( lc_eachone != NULL )
  {
    if ( string_matches_dirvar_opt(rg_a,(lc_eachone->str)) ) { return true; }
    lc_eachone = lc_eachone->nex;
  }
  return false;
}

bool string_matches_dirvar_opt ( char *rg_a, char *rg_b )
{
  char *lc_trac_arg;
  char *lc_trac_pram;
  
  lc_trac_arg = rg_b;
  lc_trac_pram = rg_a;
  
  // The option would begin with "--" before moving on to the
  // name of the dir-var it specifies.
  if ( (*lc_trac_arg) != '-' ) { return false; } lc_trac_arg++;
  if ( (*lc_trac_arg) != '-' ) { return false; } lc_trac_arg++;
  
  // Then the option would follow with the name of the dir-var
  // it specifies.
  while ( (*lc_trac_pram) != '\0' )
  {
    if ( (*lc_trac_pram) != (*lc_trac_arg) ) { return false; }
    lc_trac_arg++;
    lc_trac_pram++;
  }
  
  // The last test --- does the option follow with an "=" to
  // specify the contents?
  return ( (*lc_trac_arg) == '=' );
}



