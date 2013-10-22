#!/usr/bin/perl

use strict;
use warnings;

my $FLOOD_SECS = 180;

my $line = $ARGV[3];

#flood control time
if ( `/bin/date +%s` < (`/bin/cat humor/flood_control` + $FLOOD_SECS) ) {
  exit 0;
}

#check for humor
if ( $line =~ /.*(^|\W)lol($|\W).*/i or
     $line =~ /.*(^|\W)hehe($|\W).*/i or 
     $line =~ /.*(^|\W)rofl($|\W).*/i or 
     $line =~ /.*(^|\W)lmao($|\W).*/i or
     $line =~ /.*(^|\W)ha($|\W).*/i ) {
  
  print "lol\n";

  #flood control
  `/bin/date +%s > humor/flood_control`
}
