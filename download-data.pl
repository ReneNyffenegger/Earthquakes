#!/usr/bin/perl
use warnings;
use strict;

use LWP::Simple;

for my $year (2010 .. 2016) {
  download("$year-01-01 00:00:00", "$year-12-31 23:59:59", 4.5, "${year}_4.5.csv");
}

sub download { #_{
  my $start_time    = shift;
  my $end_time      = shift;
  my $min_magnitude = shift;
  my $filename_     = shift;

  my $dest_dir = "$ENV{digitales_backup}Development/Daten/Earthquakes/";

  die unless -d $dest_dir;
  my $filename = "$dest_dir$filename_";

  return if -f $filename;

  $start_time =~ s/ /%20/;
  $end_time   =~ s/ /%20/;

  my $params='';

  $params  = "starttime=$start_time";
  $params .= "&endtime=$end_time";
  $params .= "&minmagnitude=$min_magnitude";
  $params .= "&orderby=time-asc";

  my $url = "https://earthquake.usgs.gov/fdsnws/event/1/query.csv?$params";
  
  print "downloading $params to $filename_\n";
  getstore($url, $filename);

} #_}
