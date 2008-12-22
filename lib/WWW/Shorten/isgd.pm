package WWW::Shorten::isgd;

=head1 NAME

WWW::Shorten::isgd - Perl interface to is.gd

=head1 SYNOPSIS

  use WWW::Shorten::isgd;
  use WWW::Shorten 'isgd';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

C<WWW::Shorten::isgd> is one of the many C<WWW::Shorten> subclasses that
provide a Perl interface to a URL-shortening service. This module provides
access to the free service hosted at is.gd.

=cut

use strict;
use warnings;
use Carp;

use base qw/WWW::Shorten::generic Exporter/;

our @EXPORT  = qw/makeashorterlink makealongerlink/;
our $VERSION = '0.01';
our $ERROR   = undef;

=head1 EXPORTS

=head2 makeashorterlink(C<long_url>)

Returns the shortened version of C<long_url> or C<undef> on failure.

=cut

sub makeashorterlink ($)
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $ua  = __PACKAGE__->ua();

    my $res = $ua->get("http://is.gd/api.php?longurl=$url");
    
    if ($res->code == 200) {
        if ($res->content =~ m!^(http://is\.gd/\w+)$!) {
            return $1;
        }
    }
    elsif ($res->code == 500) {
        $ERROR = $res->content;
    }
    
    return undef;
}

=head2 makealongerlink(C<short_url>)

Returns the full version of C<short_url> or C<undef> on failure.

=cut

sub makealongerlink ($)
{
    my $url = shift or croak 'No URL passed to makealongerlink';
    my $ua  = __PACKAGE__->ua();

    # really, I should leave this logic to the user
    return undef unless ($url =~ m!^http://is\.gd/\w+$!i);

    my $res = $ua->head($url);
    return undef unless $res->is_redirect;

    return $res->header('Location');
}

1;

__END__

=head1 SEE ALSO

=over 4

=item * L<WWW::Shorten>

=item * L<http://is.gd/>

=back

=head1 AUTHOR

Brandon Gilmore <brandon@mg2.org>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Brandon Gilmore

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
