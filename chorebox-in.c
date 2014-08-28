// chorebox-in - The 'chorebox' wrapper for -configure- scripts.
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

char *where_we_work_from = NULL;
char *home_directory = NULL;
char *home_bin_dir = NULL;
bool found_home_bin_dir = false;
chorebox_str_list *legacy_options = NULL;
chorebox_str_list *myown_options = NULL;
char *the_config_scrip = NULL;

int main ( int argc, char **argv, char **env )
{
  // Let us register the command-line environment to the "libchorebox" library.
  chorebox_command_line(argc,argv,env);
  
  // First, we establish our working location.
  pipe_grab("pwd",&where_we_work_from);
  chompify(&where_we_work_from,1);
  
  // ------------------------------ //
  // BEGIN COMMAND-LINE PROCESSING: //
  // ------------------------------ //
  // Now we deal with the command line -- including gleaning
  // the legacy options.
  if ( argc < 1 )
  {
    show_usage_error("Failure to specify the \"configure\" script.");
  }
  
  // Eventually, support for the "--version" option will be
  // added here. However, not before we get <chorebox-configure>
  // to create the necessary C file.
  
  // Now, if the script is still running,  the remaining arguments
  // are all options that will in turn be passed to the -configure-
  // script.
  the_config_scrip = argv[0];
  {
    int lc2_a;
    lc2_a = 1;
    while ( lc2_a < argc )
    {
      chorebox_str_lis_apnd(&legacy_options,argv[lc2_a]);
      lc2_a++;
    }
  }
  // ------------------------------- //
  // FINISH COMMAND-LINE PROCESSING: //
  // ------------------------------- //
  
  return 10;
}

