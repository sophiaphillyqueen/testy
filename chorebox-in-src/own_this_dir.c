// chorebox-in - The 'chorebox' wrapper for -configure- scripts.
// own_this_dir.c - Source-code for this function:
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

bool own_this_dir ( char *rg_a )
{
  char *lc_main;
  char *lc_ths;
  
  // Any NULL-ness is automatically interpreted as proof of failure.
  if ( home_directory == NULL ) { return false; }
  if ( rg_a == NULL ) { return false; }
  
  // No we set the readers at the beginning of their corresponding
  // strings:
  lc_main = home_directory;
  lc_ths = rg_a;
  
  // Now we make sure they are identical at least up to the point
  // where the home-directory ends:
  while ( (*lc_main) != '\0' )
  {
    if ( (*lc_main) != (*lc_ths) ) { return false; }
    lc_ths++;
    lc_main++;
  }
  
  // Now that we have reached the end of the main directory, we must
  // make sure that the tested directory is either the same directory
  // or a subdirectory thereof.
  if ( (*lc_ths) == '\0' ) { return true; }
  if ( (*lc_ths) == '/' ) { return true; }
  return false;
}

