# $Id: 1_basic.t,v 1.1.1.1 2002/10/09 02:25:33 grantm Exp $

use strict;
use Test::More tests => 6;

$^W = 1;


##############################################################################
# Confirm that the module compiles
#

use XML::Filter::NSNormalise

ok(1, 'XML::Filter::NSNormalise compiled OK');


##############################################################################
# Try creating a filter object.
#

my $filter = XML::Filter::NSNormalise->new(
  Map => {
    'http://purl.org/dc/elements/1.1/' => 'dc',
    'http://purl.org/rss/1.0/modules/syndication/' => 'syn'
  }
);

ok(ref($filter), 'Created a filter object');
isa_ok($filter, 'XML::Filter::NSNormalise');
isa_ok($filter, 'XML::SAX::Base');


##############################################################################
# Try specifying an invalid mapping.
#

$filter = eval {
  XML::Filter::NSNormalise->new(
    Map => {
      'http://purl.org/dc/elements/1.1/' => 'dc',
      'http://purl.org/rss/1.0/modules/syndication/' => 'dc'
    }
  );
};

ok($@ =~ /Multiple URIs mapped to prefix 'dc'/, "Caught many to one mapping");


##############################################################################
# Try specifying no mapping.
#

$filter = eval {
  XML::Filter::NSNormalise->new();
};

ok($@ =~ /No 'Map' option in call to XML::Filter::NSNormalise->new/,
  "Caught missing 'Map' option");

