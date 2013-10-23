#!/usr/bin/perl

use strict;
use warnings;

my $FLOOD_SECS = 180;

open FLOOD_CONTROL_FILE, '+<', 'humor/flood_control' or die "No flood control file writable.\n";

#flood control time
if ( time < (readline(FLOOD_CONTROL_FILE) + $FLOOD_SECS) ) {    # I hope that file contains what I think it does
  exit 0;
}

#check for humor
if ( $ARGV[3] =~ /.*(^|\W)lol($|\W).*/i or
     $ARGV[3] =~ /.*(^|\W)hehe($|\W).*/i or 
     $ARGV[3] =~ /.*(^|\W)rofl($|\W).*/i or 
     $ARGV[3] =~ /.*(^|\W)lmao($|\W).*/i or
     $ARGV[3] =~ /.*(^|\W)ha($|\W).*/i ) {
  
  print "lol\n";

  #flood control
  truncate(FLOOD_CONTROL_FILE, 0);      # I hope that file isn't important
  seek(FLOOD_CONTROL_FILE, 0, 0);
  print FLOOD_CONTROL_FILE time;
}

close FLOOD_CONTROL_FILE;
