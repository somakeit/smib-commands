#!/usr/bin/env perl

use strict;
use warnings;

use JSON::Parse qw(parse_json);
use Time::Local qw(timelocal);
use HTTP::Request;
use LWP::UserAgent;

my $calendar_id = 'c3at705hnnkj664j2gesvsnvh8%40group.calendar.google.com';
my $api_key = 'AIzaSyAi4e9dEm5ejRBD2svOacNrmezaAfuVv08'; #safe for public viewing, if you use this I will just revoke it
my $refer_url = 'https://wiki.somakeit.org.uk/wiki/Smib';
my $range_seconds = 7 * 24 * 3600; # how far in the future to show in seconds.

# Converts the google format date to a perl format date
sub formtime {
  my $time = shift;
  if ($time =~ /^(\d+)-(\d+)-(\d+)T(\d+):(\d+):(\d+)/) {
    $time = localtime(timelocal($6, $5, $4, $3, $2 - 1, $1));
  } else {
    die "Can't timelocal $time";
  }
  return $time;
}

sub formdate {
  my @days = qw(Sun Mon Tue Wed Thu Fri Sat Cat);
  my @mons = qw(Jan Feb Mar Arp May Jun Jul Aug Sep Oct Nov Dec);
  my $date = shift;
  if ($date =~ /^(\d+)-(\d+)-(\d+)/) {
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(timelocal(0, 0, 0, $3, $2 - 1, $1));
    $mday = sprintf('%2s', $mday);
    $year += 1900;
    $date = "$days[$wday] $mons[$mon] $mday $year         ";
  } else {
    die "Can't timelocal $date 00:00:00";
  }
  return $date;
}

#make time into google format
sub google_time {
  my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(shift());
  $year += 1900;
  $mon = sprintf('%02d', ++$mon);
  $mday = sprintf('%02d', $mday);
  $hour = sprintf('%02d', $hour);
  $min = sprintf('%02d', $min);
  $sec = sprintf('%02d', $sec);
  return "$year-$mon-${mday}T$hour%3A$min%3A${sec}Z";
}

#make the request
my $time_min = google_time(time());
my $time_max = google_time(time() + $range_seconds);
my $agent = LWP::UserAgent->new();
my $request = HTTP::Request->new(GET => "https://www.googleapis.com/calendar/v3/calendars/$calendar_id/events?key=$api_key&orderBy=startTime&singleEvents=true&timeMin=$time_min&timeMax=$time_max");
$request->referer($refer_url); 
my $http_response = $agent->request($request);

#parse the json
my $api_response = parse_json($http_response->{'_content'});

#print the calendar entries
foreach (@{$api_response->{'items'}}) {
  my $when;
  if (defined $_->{'start'}{'dateTime'}) {
    $when = &formtime($_->{'start'}{'dateTime'});
  } elsif (defined $_->{'start'}{'date'}) {
    $when = &formdate($_->{'start'}{'date'});
  } else {
    next;
  }

  my $event = $_->{'summary'};

  my $location = "";
  if (defined $_->{'location'}) {
    $location = " @ $_->{'location'}";
  }
  
  print "$when - $event$location\n";
}
