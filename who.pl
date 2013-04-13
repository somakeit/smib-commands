#!/usr/bin/perl

use strict;
use warnings;

my $nick = shift;

# This script needs the irccat user to have
# key auth to root on the dd-wrt router.

# Put your name and sha256 sum of your device's WiFi MAC in the hashref below.
# To get the sha256 sum of your WiFi mac, do this on a *nix box:
#   $ echo -n a1:b2:c3:d4:e5:f6 | sha256sum
my $FRIENDS = {
  '7c94e41c60b497117f00b98e7846476d968f159b061d579e3679474b6073d007' => 'Bracken',
  'b8762da1eafaf929a0e34f3729135ec123f4ee07c842216e8c03e23bbb6e1faf' => 'Bracken',
  '5a226259614fed4be4d7dca236a7d4a42b96a679b0926a0a2f2fdff5059c1b97' => 'LIAR'};
# If you ever come to me claiming you've cracked this, I expect to know LIAR's MAC.

# uniq
sub uniq {my %s; grep {!$s{$_}++} @_}

# ====
# MAIN
# ====

# Get MAC addresses
my @sums = `cat /tmp/irccat.who.macs.* 2>/dev/null`;

if (@sums > 0) {
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
#you end up here if literally no MAC is associated. Or we just rebooted. Or cron is broken.
print "$nick, looks like it's just me, maybe check the webcam.\n";

