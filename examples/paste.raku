#!/usr/bin/env raku

use lib '../lib';
use Pastebin::Gist;

if !@*ARGS {
    put qq:to/HERE/;
    Usage: {$*PROGRAM.basename} go

    Tests the complete utility of the 'Pastebin::Gist' module using Github
    gist and the user's Github personal gist token which must be defined
    in environment variable PASTEBIN_GIST_TOKEN and it must be in the
    new format used by Github since March 2021 (/:i ghp_ <[a..f 0..9]> ** 36/).
    Note the new format may be extended from 40 to more characters later.
    HERE
    exit
}

my $p = Pastebin::Gist.new;

say "Pasting test content...";
my $paste_url = $p.paste(
    {
        foo => { content => "<pre>test paste1</pre>" },
        bar => { content => "meow!" }
    },
    desc => "Foo Bar"
);
say "Paste is located at $paste_url";

say "Retrieiving paste content...";
my ( $files, $summary ) = $p.fetch( $paste_url );
say "Summary: $summary";
for $files.keys {
    say "File: $_\nContent:\n$files{$_}";
}
# say "Content: $content";
