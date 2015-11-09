#!/usr/bin/perl

use strict;
use warnings;

# This script should be run from cron once a minute.
# DO NOT RUN AS SAME USER AS SMIB!!!!
# It is used to maintain a list of sha256 sums of MAC
# addresses that have been visible to the router

use File::Copy 'move';

my $FILENAME = '/tmp/smib.who.macs';
my $FILES_TO_KEEP = 5;
my $ROUTER_USER = 'smib';
my $ROUTER_IP = '192.168.0.1';
my $ROUTER_BCAST = '192.168.255.255';

#rotate files
for (my $i = $FILES_TO_KEEP ; $i > 0 ; $i--) {
    my $h = $i - 1;
    move("$FILENAME.$h", "$FILENAME.$i");
}

#make a new file
open FH, ">$FILENAME.0";
#get the macs by pinging the gateway and asking arp
my @output = `ssh $ROUTER_USER\@$ROUTER_IP \"ping -c 1 -t 10 $ROUTER_BCAST >/dev/null; arp -a\"`;

#filter out the macs and hash them
for my $line (@output) {
    if ($line =~ m/([0-9A-Fa-f]{2}:[0-9A-Fa-f]{2}:[0-9A-Fa-f]{2}:[0-9A-Fa-f]{2}:[0-9A-Fa-f]{2}:[0-9A-Fa-f]{2})/) {
        #uppercase
        my $mac = uc($1);
        #hash
        my $hash = `/bin/echo -n $mac | /usr/bin/sha256sum`;
        if ($hash =~ m/(\w+)/) {
            print FH "$1\n";
        }
    }
}
close FH;

