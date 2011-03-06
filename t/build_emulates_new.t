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

use Test::More tests => 1;
{

    package Foo;
    use base 'App::Cmd';

    package Bar;
    use Mouse;
    extends 'MouseX::App::Cmd';

}

is_deeply( \%{ Bar->new }, \%{ Foo->new }, 'Internal hashes match' );
