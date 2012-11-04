#!perl -T

use strict;
use warnings;
use Test::Simple tests => 5;

use Passwd::Keyring::Memory;

my $ring = Passwd::Keyring::Memory->new;

ok( defined($ring) && ref $ring eq 'Passwd::Keyring::Memory',   'new() works' );

ok( ! defined($ring->get_password("Paul", 'my@@domain')), "get works");

# MemoryOnly drops data 
#ok( $ring->get_password("Gregory", 'my@@domain') eq 'secret-Greg', "get works");
#ok( $ring->get_password("Paul", 'other@@domain') eq 'secret-Paul2', "get works");
#ok( $ring->get_password("Duke", 'my@@domain') eq 'secret-Duke', "get works");

ok( ! defined($ring->get_password("Gregory", 'my@@domain')), "get works");
ok( ! defined($ring->get_password("Paul", 'other@@domain')), "get works");
ok( ! defined($ring->get_password("Duke", 'my@@domain')), "get works");


