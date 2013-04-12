#!/usr/bin/perl

use strict;
use warnings;

my $nick = shift;

# This script needs the irccat user to have
# key auth to root on the dd-wrt router.
my $ROUTER_IP = '10.0.0.1';
# Check what youter you have dd-wrt on
#my $WL = 'wl';
#my $WL = 'wl_atheros';
my $WL = 'wl_rt2880';

# Put your name and sha256 sum of your device's WiFi MAC in the hashref below.
# To get the sha256 sum of your WiFi mac, do this on a *nix box:
#   $ echo -n a1:b2:c3:d4:e5:f6 | sha256sum
my $FRIENDS = {
  '85c7187558d15a6e2e66eb1d17798d6548a89338eb0bb309efaf144d6330db82' => 'Bracken',
  'c0c77aed5c013164cc557b8dc597829b19a1db57558f6a6b2d2cedb414e6e86e' => 'Bracken',
  '5a226259614fed4be4d7dca236a7d4a42b96a679b0926a0a2f2fdff5059c1b97' => 'LIAR'};
# If you ever come to me claiming you've cracked this, I expect to know LIAR's MAC.

# uniq
sub uniq {my %s; grep {!$s{$_}++} @_}

# ====
# MAIN
# ====

# Get associated MAC addresses
# I've not seen any, but the output of
# wl assoclist probably contains some
# MAC addresses.
my @wl_output = `/usr/bin/ssh root\@$ROUTER_IP $WL assoclist $2>/dev/null`;

my @assoc_macs;
for my $line (@wl_output) {
  # If the line contains a MAC address, just put it in the array
  if ($line =~ m/([0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2})/) {
    push @assoc_macs, $1;
  }
}

if (@assoc_macs > 0) {
  # sum unique MACs, better than my last pi heater
  @assoc_macs = &uniq(@assoc_macs);
  my @sums;
  for my $mac (@assoc_macs) {
    my $output = `/bin/echo -n $mac | /usr/bin/sha256sum`;
    if ($output =~ m/(\w+)/) {
      push @sums, $1;
    }
  }
  
  # make an array of people in the space
  my @present;
  for my $sum (@sums) {
    if (exists($FRIENDS->{$sum})) {
      push @present, $FRIENDS->{$sum};
    }
  }
  # for the tech addicts
  @present = &uniq(@present);
  
  #Print some English responses
  if (@present == 1) {
    print "$nick, I think $present[0] is in.\n";
  } elsif (@present > 1) {
    # take the last member out the array and say and first.
    my $last_member = pop @present;
    my $comma = '';
    print "$nick, looks like";
    for my $member (@present) {
      print "$comma $member";
      $comma = ',';
    }
    print " and $last_member are in.\n";
  } else {
    # you end up here if there are only unknown macs associated
    print "$nick, I don't see anyone, try the webcam maybe?\n";
  }
  exit(0);
}
#you end up here if literally no MAC is associated.
print "$nick, looks like it's just me, maybe check the webcam.\n";

