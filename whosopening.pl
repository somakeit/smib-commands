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

#Make google dateTime into a Day
sub time_to_day {
  my @days = qw(Sunday Monday Tuesday Wednesday Thursday Friday Saturday Caturday);
  my $time = shift;
  my $day;
  if ($time =~ /^(\d+)-(\d+)-(\d+)T(\d+):(\d+):(\d+)/) {
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(timelocal($6, $5, $4, $3, $2 - 1, $1));
    $day = $days[$wday];
  } else {
    die "Can't timelocal $time";
  }
  return $day;
}

#make the request
my $time_min = google_time(time());
my $agent = LWP::UserAgent->new();
my $request = HTTP::Request->new(GET => "https://www.googleapis.com/calendar/v3/calendars/$calendar_id/events?key=$api_key&orderBy=startTime&singleEvents=true&timeMin=$time_min&maxResults=1&q=Space%20Open");
$request->referer($refer_url); 
my $http_response = $agent->request($request);

#parse the json
my $api_response = parse_json($http_response->{'_content'});

#pull the name and print it
foreach (@{$api_response->{'items'}}) {
  if ($_->{'summary'} =~ /keymaster\s+(\w+)/i) {
    my $name = $1;
    if (defined $_->{'start'}{'dateTime'}) {
      my $day = &time_to_day($_->{'start'}{'dateTime'});
      print "I think $name is opening on $day.\n";
    } else {
      print "I think $name is opening.";
    }
  } else {
    print "I don't think anyone is down to open?\n";
  }
}
