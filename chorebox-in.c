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
char *prefix_directory = NULL;
chorebox_str_list *final_comand = NULL;

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
  if ( argc < 2 )
  {
    show_usage_error("Failure to specify the \"configure\" script.");
  }
  
  // Eventually, support for the "--version" option will be
  // added here. However, not before we get <chorebox-configure>
  // to create the necessary C file.
  
  // Now, if the script is still running,  the remaining arguments
  // are all options that will in turn be passed to the -configure-
  // script.
  the_config_scrip = argv[1];
  {
    int lc2_a;
    lc2_a = 2;
    while ( lc2_a < argc )
    {
      chorebox_str_lis_apnd(&legacy_options,argv[lc2_a]);
      lc2_a++;
    }
  }
  // ------------------------------- //
  // FINISH COMMAND-LINE PROCESSING: //
  // ------------------------------- //
  
  // Now we find the HOME directory. Why else use this wrapper?
  if ( home_directory != NULL ) { free(home_directory); }
  home_directory = getenv("HOME");
  if ( home_directory == NULL )
  {
    fprintf(stderr,"\n%s: FATAL ERROR: Could not identify home directory.\n",argv[0]);
    fprintf(stderr,"This is a wrapper program for \"configure\" scripts. It is\n");
    fprintf(stderr,"pointless if no home directory can be identified.\n\n");
    fflush(stderr);
    exit(3);
  }
  
  // And now let us see if we can auto-detect the home-binary
  // directory. (That is, the first directory specified in PATH
  // that meets the eligibility of being a directory you can
  // install stuff in.)
  found_home_bin_dir = autodetect_home_bin_dir(&home_bin_dir);
  
  
  // Of course, if nothing in the tree of the HOME directory is found
  // then the only way we *currently* have to know where to install
  // stuff is for the configural command-line to specify it. Therefore,
  // this tool will (in such an even) *insist* that this be specified
  // on the command line. (This will be replaced by a refusal to run
  // altogether if the home-directory-tree test for a directory's
  // writability is replaced with a more reliable test.)
  if ( !(found_home_bin_dir) )
  {
    if ( !(specified_var_option("bindir")) )
    {
      fprintf(stderr,"\n%s: FATAL ERROR:\n",argv[0]);
      fprintf(stderr,"Since none of the directories listed in PATH are within the\n");
      fprintf(stderr,"tree headed by the home-directory, it is therefore deemed\n");
      fprintf(stderr,"that specifying the --dirname=<xxx>  option is mandatory.\n\n");
      fflush(stderr);
      exit(4);
    }
    
  }
  
  if_not_specified("bindir",home_bin_dir);
  chorebox_apend_string(&prefix_directory,home_directory);
  chorebox_apend_string(&prefix_directory,"/chorebox_sys");
  if_not_specified("prefix",prefix_directory);
  if_not_specified("oldincludedir","");
  
  
  chorebox_str_lis_apnd(&final_comand,"sh");
  chorebox_str_lis_dump(&legacy_options,&final_comand);
  chorebox_str_lis_dump(&myown_options,&final_comand);
  
  return 10;
}

