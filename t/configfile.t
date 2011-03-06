#!perl -T
#
# This file is part of MouseX-App-Cmd
#
# This software is copyright (c) 2011 by Infinity Interactive.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use 5.006;
use strict;
use warnings;

use strict;
use warnings;
use Test::More;

BEGIN {
    eval {
        require MouseX::ConfigFromFile;
        require YAML;
    };
    if ($@) {
        plan( skip_all =>
                'These tests require MouseX::ConfigFromFile and YAML' );
    }
    else {
        plan( tests => 2 );
    }
}

use lib 't/lib';
use Test::ConfigFromFile;

my $cmd = Test::ConfigFromFile->new;

{
    local @ARGV = qw(moo);
    eval { $cmd->run };

    like(
        $@,
        qr/Required option missing/,
        'command died with the correct string',
    );
}

{
    local @ARGV = qw(moo --configfile=t/lib/Test/ConfigFromFile/config.yaml);
    eval { $cmd->run };

    like(
        $@,
        qr/cows go moo1 moo2 moo3/,
        'command died with the correct string',
    );
}
