#!perl -T

use strict;
use warnings;
use Test::Simple tests => 5;

use Passwd::Keyring::Memory;

my $ring = Passwd::Keyring::Memory->new;

ok( defined($ring) && ref $ring eq 'Passwd::Keyring::Memory',   'new() works' );

$ring->clear_password("Paul", 'my@@domain');
ok(1, "clear_password works");

$ring->clear_password("Gregory", 'my@@domain');
ok(1, "clear_password works");

$ring->clear_password("Paul", 'other@@domain');
ok(1, "clear_password works");

$ring->clear_password("Duke", 'my@@domain');
ok(1, "clear_password works");


