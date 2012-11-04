use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Passwd::Keyring::Memory',
    license             => 'perl',
    dist_author         => q{Marcin Kasperski <Marcin.Kasperski@mekk.waw.pl>},
    dist_version_from   => 'lib/Passwd/Keyring/Memory.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'perl' => 5.006,
    },
    add_to_cleanup      => [ 'Passwd-Keyring-MemoryOnly-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
