
#include <chorebox.h>

void chorebox_command_line ( int rg_a, char **rg_b, char **rg_c )
{
  chorebox_argc = rg_a;
  chorebox_argv = rg_b;
  chorebox_env = rg_c;
}


