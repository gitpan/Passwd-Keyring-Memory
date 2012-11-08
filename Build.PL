use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Passwd::Keyring::Memory',
    license             => 'perl',
    #create_license      => 1,
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
    meta_merge => {
        keywords => ['keyring', 'passwords' ],
        resources => {
            license     => 'http://dev.perl.org/licenses/',
            homepage    => 'http://bitbucket.org/Mekk/perl-keyring-memory',
            repository => 'http://bitbucket.org/Mekk/perl-keyring-memory',
            bugtracker => 'https://bitbucket.org/Mekk/perl-keyring-memory/issues',
            #license     => [ 'http://dev.perl.org/licenses/', ],
            #bugtracker  => {
            #    web    => 'https://bitbucket.org/Mekk/perl-keyring-memory/issues',
            #    #mailto => 'meta-bugs@example.com',
            #},
            #repository  => {
            #    url  => 'http://bitbucket.org/Mekk/perl-keyring-memory',
            #    web  => 'http://bitbucket.org/Mekk/perl-keyring-memory',
            #    type => 'hg',
            #},
            # x_twitter => 'http://twitter.com/costam
        },
    },
);

$builder->create_build_script();
