// chorebox-configure - Called by chorebox-based 'configure' scripts to, well, configure
// main.c - Source-code for this function:
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

#include "chorebox-cf.h"

int main ( int argc, char **argv, char **env )
{
  // Let us register the command-line environment to the "libchorebox" library.
  chorebox_command_line(argc,argv,env);
  
  // Now we process the version-query option of need-be:
  process_version_query();
  
  // We create the object for parsing it all.
  lc_parceio = new_parser();
  
  if ( argc < 2 )
  {
    lc_chr = fgetc(stdin);
    while ( !feof(stdin) )
    {
      lc_parceio->cls->m_cin(&lc_parceio,lc_chr);
      lc_chr = fgetc(stdin);
    }
  } else {
    lc_filo = read_file_or_die(argv[1]);
    lc_chr = fgetc(lc_filo);
    while ( !feof(lc_filo) )
    {
      lc_parceio->cls->m_cin(&lc_parceio,lc_chr);
      lc_chr = fgetc(lc_filo);
    }
    fclose(lc_filo);
  }
  
  // And now we retrieve the algorithm - and close the object.
  parsed_main_func = lc_parceio->cls->m_harvest(&lc_parceio);
  
  // Finally, the moment we've been waiting for --- when we
  // *execute* the object.
  
  
}

