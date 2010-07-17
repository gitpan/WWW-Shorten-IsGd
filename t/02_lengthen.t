#!/usr/bin/perl

use Test::More tests => 1;
use WWW::Shorten::isgd;
use WWW::Shorten 'isgd';

my $long = makealongerlink('http://is.gd/dvaDe');
is($long, 'http://www.cpan.org');

