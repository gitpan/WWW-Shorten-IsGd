use strict;
use warnings;
use 5.006;

package WWW::Shorten::IsGd;
BEGIN {
  $WWW::Shorten::IsGd::VERSION = '0.001';
}
# ABSTRACT: shorten (or lengthen) URLs with http://is.gd


use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw( makeashorterlink makealongerlink );
use Carp;
use URI;


sub makeashorterlink {
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $ua = __PACKAGE__->ua();
    my $response = $ua->post('http://is.gd/create.php', [
        url => $url,
        source => 'PerlAPI-' . (defined __PACKAGE__->VERSION ? __PACKAGE__->VERSION : 'dev'),
        format => 'simple',
	]);
    return unless $response->is_success;
    my $shorturl = $response->{_content};
    return if $shorturl =~ m/Error/;
    if ($response->content =~ m{(\Qhttp://is.gd/\E[\w_]+)}) {
		return $1;
    }
    return;
}


sub makealongerlink {
    my $url = shift or croak 'No is.gd key/URL passed to makealongerlink';
    my $ua = __PACKAGE__->ua();

	$url = "http://is.gd/$url" unless $url =~ m{^https?://}i;
    my $response = $ua->get($url);

    return unless $response->is_redirect;
    return $response->header('Location');
}

1;



=pod

=encoding utf-8

=head1 NAME

WWW::Shorten::IsGd - shorten (or lengthen) URLs with http://is.gd

=head1 VERSION

version 0.001

=head1 SYNOPSIS

	use WWW::Shorten::IsGd;
	use WWW::Shorten 'IsGd';

    my $url = q{http://averylong.link/wow?thats=really&really=long};
    my $short_url = makeashorterlink($url);
    my $long_url  = makealongerlink($short_url); # eq $url

=head1 DESCRIPTION

A Perl interface to the web site L<http://is.gd>. is.gd simply maintains
a database of long URLs, each of which has a unique identifier.

=head1 Functions

=head2 makeashorterlink

The function C<makeashorterlink> will call the is.gd web site passing
it your long URL and will return the shortened link.

=head2 makealongerlink

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full TinyURL URL or just the
TinyURL identifier.

If anything goes wrong, then either function will return C<undef>.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see L<http://search.cpan.org/dist/WWW-Shorten-IsGd/>.

The development version lives at L<http://github.com/doherty/WWW-Shorten-IsGd>
and may be cloned from L<git://github.com/doherty/WWW-Shorten-IsGd.git>.
Instead of sending patches, please fork this project using the standard
git and github infrastructure.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://github.com/doherty/WWW-Shorten-IsGd/issues>.

=head1 AUTHOR

Mike Doherty <doherty@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Mike Doherty.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
