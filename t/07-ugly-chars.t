#!perl -T

use strict;
use warnings;
use Test::Simple tests => 3;

use Passwd::Keyring::Memory;

my $ring = Passwd::Keyring::Memory->new;

ok( defined($ring) && ref $ring eq 'Passwd::Keyring::Memory',   'new() works' );

$ring->set_password("Joh ## no ^^ »ąćęłóśż«", "«tajne hasło»", '«do»–main');

ok( 1, "set_password with ugly chars works" );

ok( $ring->get_password("Joh ## no ^^ »ąćęłóśż«", '«do»–main') eq '«tajne hasło»', "get works with ugly characters");

