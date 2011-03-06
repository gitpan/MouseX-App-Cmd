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

package Test::ConfigFromFile::Command::moo;
use Mouse;
use YAML();

extends qw(MouseX::App::Cmd::Command);
with 'MouseX::ConfigFromFile';

=head1 NAME

Test::MyCmd::Command::moo - reads from config file

=cut

has 'moo' => (
    isa           => "ArrayRef",
    is            => "ro",
    required      => 1,
    auto_deref    => 1,
    documentation => "required option field",
);

sub execute {
    my ( $self, $opt, $arg ) = @_;

    die( "cows go " . join( ' ', $self->moo ) );
}

sub get_config_from_file {
    my ( $self, $file ) = @_;

    return YAML::LoadFile($file);
}

1;
