#!/usr/bin/perl

use strict;
use warnings;

my $nick = shift;
my $context = shift; # will be "null" if this is a private message, ie registraton
my $channel = shift; #?
my $argv = shift;

# This script needs the irccat user to have
# key auth to root on the dd-wrt router.

# Put your name and sha256 sum of your device's WiFi MAC in the hashref below.
# To get the sha256 sum of your WiFi mac, do this on a *nix box:
#   $ echo -n A1:B2:C3:D4:E5:F6 | sha256sum
# It MUST be uppercase
# If you don't want a vanity username, you can add yourself over IRC by typing:
#   /msg smib A1:B2:C3:d4:e5:f6
my $friends = {};
my $FRIENDSFILE = 'who/friends.txt';

# uniq
sub uniq {my %s; grep {!$s{$_}++} @_}

# ====
# MAIN
# ====

#if this is a message, store the hash and bail
if ($context eq 'null') {
  if ($argv =~ m/([0-9A-Fa-f]{2}:[0-9A-Fa-f]{2}:[0-9A-Fa-f]{2}:[0-9A-Fa-f]{2}:[0-9A-Fa-f]{2}:[0-9A-Fa-f]{2})/) {
    #user gave us a MAC
    my $mac = $1;

    # make it uppercase
    $mac =~ tr/[a-f]/[A-F]/;
    # sum it
    my $sum = `/bin/echo -n $mac | /usr/bin/sha256sum`;
    if ($sum =~ m/(\w+)/) {
      $sum = $1; 
    }
    #store the sum
    open FH, ">>$FRIENDSFILE";
    print FH "$sum $nick\n";
    close FH;
    print "Okay $nick, you're in.\n";
    exit(0);
  }
  print "So, you need to tell me your MAC address if you want to register.\n";
  exit(0);
}

# load more keys into the hashref from the file
# lines in the file have the format:
# 234jlkj2349023jlkj234 brackendawson
if (-e $FRIENDSFILE) {
  open FH, "$FRIENDSFILE";
  for my $line (<FH>) {
    if ($line =~ m/^(\w{64}) (\w+)/) {
      $friends->{$1} = $2;
    }
  }
  close FH;
}

# Get MAC addresses
my @sums = `cat /tmp/smib.who.macs.* 2>/dev/null`;

if (@sums > 0) {
  # make an array of people in the space
  my @present;
  for my $sum (@sums) {
    chomp $sum;
    if (exists($friends->{$sum})) {
      push @present, $friends->{$sum};
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
  print "Use '/MSG smib ?who <your_mac>' to register for this.\n";
  exit(0);
}
#you end up here if literally no MAC is associated. Or we just rebooted. Or cron is broken.
print "$nick, looks like it's just me, maybe check the webcam.\n";

