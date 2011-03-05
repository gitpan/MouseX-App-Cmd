#
# This file is part of MouseX-App-Cmd
#
# This software is copyright (c) 2011 by Infinity Interactive.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use utf8;
use strict;
use Modern::Perl;    ## no critic (UselessNoCritic,RequireExplicitPackage)

package MouseX::App::Cmd::Command;

BEGIN {
    $MouseX::App::Cmd::Command::VERSION = '0.07';
}

# ABSTRACT: Base class for commands.

use English '-no_match_vars';
use Getopt::Long::Descriptive ();
use Mouse;
with 'MouseX::Getopt';
extends qw(Mouse::Object App::Cmd::Command);

has usage => (
    metaclass => 'NoGetopt',
    isa       => 'Object',
    is        => 'ro',
    required  => 1,
);

has app => (
    metaclass => 'NoGetopt',
    isa       => 'MouseX::App::Cmd',
    is        => 'ro',
    required  => 1,
);

sub _process_args {    ## no critic (ProhibitUnusedPrivateSubroutines)
    my ( $class, $args ) = @ARG;
    local @ARGV = @{$args};

    my $config_from_file;
    if ( $class->meta->does_role('MouseX::ConfigFromFile') ) {
        local @ARGV = @ARGV;

        my $configfile;
        my $opt_parser = Getopt::Long::Parser->new(
            config => [
                qw( pass_through
                    )
            ]
        );
        $opt_parser->getoptions( 'configfile=s' => \$configfile );
        if ( !defined $configfile ) {
            my $cfmeta = $class->meta->find_attribute_by_name('configfile');
            if ( $cfmeta->has_default ) { $configfile = $cfmeta->default }
        }

        if ( defined $configfile ) {
            $config_from_file = $class->get_config_from_file($configfile);
        }
    }

    my %processed = $class->_parse_argv(
        params => { argv => \@ARGV },
        options => [ $class->_attrs_to_options($config_from_file) ],
    );

    my @out
        = ( $processed{params}, $processed{argv}, usage => $processed{usage},
        );

    # params from CLI are also fields in MouseX::Getopt
    if ($config_from_file) { push @out, %{$config_from_file} }
    return @out, %{ $processed{params} };
}

sub _usage_format {    ## no critic (ProhibitUnusedPrivateSubroutines)
    my $class = shift;
    return $class->usage_desc();
}

1;

__END__

=pod

=for :stopwords Yuval Kogman Guillermo Roditi Mark Gardner Infinity Interactive

=encoding utf8

=head1 NAME

MouseX::App::Cmd::Command - Base class for commands.

=head1 VERSION

version 0.07

=head1 SYNOPSIS

    use Mouse;

    extends qw(MouseX::App::Cmd::Command);

    # no need to set opt_spec
    # see MouseX::Getopt for documentation on how to specify options
    has option_field => (
        isa => "Str",
        is  => "rw",
        required => 1,
    );

    sub execute {
        my ( $self, $opts, $args ) = @_;

        print $self->option_field; # also available in $opts->{option_field}
    }

=head1 DESCRIPTION

This is a replacement base class for L<App::Cmd::Command|App::Cmd::Command>
classes that includes
L<MouseX::Getopt|MouseX::Getopt> and the glue to combine the two.

=head1 METHODS

=head2 _process_args

Replaces L<App::Cmd::Command|App::Cmd::Command>'s argument processing in in
favor of
L<MouseX::Getopt|MouseX::Getopt> based processing.

=encoding utf8

=head1 SEE ALSO

=over

=item L<App::Cmd::Command|App::Cmd::Command>

=item L<MouseX::Getopt|MouseX::Getopt>

=back

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
http://github.com/mjg/MouseX-App-Cmd/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHORS

=over 4

=item *

Yuval Kogman <nothingmuch@woobling.org>

=item *

Guillermo Roditi <groditi@cpan.org>

=item *

Mark Gardner <mjgardner@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
