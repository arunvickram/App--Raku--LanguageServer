use v6.d;

react {
    whenever IO::Socket::Async.listen('0.0.0.0', 3333) -> $conn {
        whenever $conn.Supply.lines -> $line {
            my %lsp-request = from-json $line;

            .say with %lsp-request<method> // "No method received";

            # "filename.raku".IO.slurp.AST

            $conn.print: $line;
            $conn.close;
        }
    }

    CATCH {
        default {
            say .^name, ': ', .Str;
        }
    }
}
