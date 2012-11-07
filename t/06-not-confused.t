#!perl -T

use strict;
use warnings;
use Test::Simple tests => 11;

use Passwd::Keyring::Memory;

my $ring = Passwd::Keyring::Memory->new;

ok( defined($ring) && ref $ring eq 'Passwd::Keyring::Memory',   'new() works' );

$ring->set_password("Paul", "first Paul secret", 'domain 1');
ok( 1, "set_password works" );
$ring->set_password("Paul", "second Paul secret", 'domain 2');#
ok( 1, "set_password works" );
$ring->set_password("Anne", "Anne secret", 'domain 1');
ok( 1, "set_password works" );


ok( $ring->get_password("Paul", 'domain 1') eq 'first Paul secret', "get picks proper password (same user, different domains)");

ok( $ring->get_password("Paul", 'domain 2') eq 'second Paul secret', "get picks proper password (same user, different domains)");

ok( $ring->get_password("Anne", 'domain 1') eq 'Anne secret', "get picks proper password (different user, same domain");

ok( ! defined($ring->get_password("domain 1", 'Paul')), "swappin user with domain does not help");

$ring->clear_password("Paul", 'domain 1');
ok(1, "clear_password works");

$ring->clear_password("Paul", 'domain 2');
ok(1, "clear_password works");

$ring->clear_password("Anne", 'domain 1');
ok(1, "clear_password works");


