#!perl -T

use strict;
use warnings;
use Test::Simple tests => 3;

use Passwd::Keyring::Memory;

my $ring = Passwd::Keyring::Memory->new;

ok( defined($ring) && ref $ring eq 'Passwd::Keyring::Memory',   'new() works' );

$ring->set_password("John", "secret", 'my@@domain');
#$ring->set_password("John", "secret", 'my@@domain');
#$ring->set_password("John", "secret", 'my@@domain');

ok( 1, "set_password works" );

ok( $ring->get_password("John", 'my@@domain') eq 'secret', "get works");

