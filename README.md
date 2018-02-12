# instiki-cli

*instiki-cli* is a tiny tool to edit
[Instiki](https://golem.ph.utexas.edu/wiki/instiki/show/HomePage) wikis using a
local editor. Use it like this:

    $ export INSTIKI_AUTHOR="Emmy Noether"
    $ instiki-cli https://golem.ph.utexas.edu/wiki/instiki/show/Sandbox
    * Changes will be signed as "Emmy Noether".
    * Fetching https://golem.ph.utexas.edu/wiki/instiki/show/Sandbox... done.
    * Waiting for changes, go edit file "Sandbox" or abort with ^C...

…time passes…

    --- /dev/stdin  2016-03-26 17:41:12.383587226 +0100
    +++ Sandbox     2016-03-26 17:41:12.195587230 +0100
    @@ -1005,4 +1005,4 @@
     * item2
     * item3
     * item4
    -* item70000
    +* item5
    * Accept (y/n)? y
    * Saving changes... done.

…the cycle continues…

    * Fetching https://golem.ph.utexas.edu/wiki/instiki/show/Sandbox... done.
    * Waiting for changes, go edit file "Sandbox" or abort with ^C...

I wrote the tool specifically to be able to edit the
[nLab](https://ncatlab.org/nlab/show/HomePage) more comfortably,
but *instiki-cli* should work with any Instiki installation. It's for editing
single entries only and cannot be used to mirror a wiki (or even keep it
synchronized).


## Features

* Pushing to the wiki is triggered by saving the file.
* *instiki-cli* shows a diff of the local changes and asks for confirmation
  before pushing. That way unintended changes like accidental truncations of
  the file don't find their way to the wiki.
* Before pushing changes, *instiki-cli* checks whether the entry on the wiki
  has changed in the meantime and aborts if that's the case.


## Dependencies

* Perl 5 and some Perl modules. On Debian-based distributions, these can be
  installed using `apt-get install libfile-slurp-perl libhtml-parser-perl
  libhttp-cookies-perl libhttp-message-perl libwww-perl`.
* Node or some other interpreter for JavaScript. Use `apt-get install nodejs`
  on Debian-based distributions and ensure that `/usr/bin/js` points to
  `/usr/bin/node`.
* The standard Unix tool `diff`.


## Alternatives

[Check exactly how similar using *It's All Text!* in combination with *emacsclient* is.]


## Working with terminal multiplexers like screen

The following simple-minded script starts *instiki-cli* in the current screen
window and opens the editor in a new window as soon as the entry has been
downloaded.

```shell
#!/bin/bash

wikidir=~/wiki  # change to your needs

screen bash -c '
    file="`basename "$1"`"
    echo "* Waiting for \"$file\" to become available..."

    cd "$0"
    while :; do
        sleep 0.1
        [ -e "$file" ] && break
    done

    vim -c "set tw=0" "$file"
' "$wikidir" "$1"

cd "$wikidir"
instiki-cli "$1"
```


## Security considerations

* *instiki-cli* creates (or overwrites) a file in the current directory.
  Therefore you shouldn't run *instiki-cli* on untrusted input.
* Also you shouldn't run *instiki-cli* on untrunsted wikis, as it executes
  arbitrary JavaScript code supplied by the wiki. A small effort to ensure that
  it can't do uncontrolled input/output is made, but as there doesn't seem to
  be a safe way of sandboxing JavaScript code from inside node (compare with
  [these](https://github.com/bcoe/sandcastle/issues/31)
  [discussions](https://github.com/nodejs/node-v0.x-archive/issues/1469) [on
  GitHub](https://github.com/oftn/oftn-bot/commit/892a34dda5dfd77b499b2c913801c2b599b31342)),
  you shouldn't rely on this. In any case, the JavaScript code can hog your CPU and memory.


## Shortcomings

*instiki-cli* was written for my personal use. It is not polished in any way.


## License

You can (and are invited to) use, redistribute and modify *instiki-cli* under
the terms of the GNU General Public License (GPL), version 3 or (at your
option) any later version published by the Free Software Foundation.
