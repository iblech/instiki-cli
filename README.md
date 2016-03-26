# instiki-cli

*instiki-cli* is a tiny tool to edit
[Instiki](https://golem.ph.utexas.edu/wiki/instiki/show/HomePage) wikis using a
local editor. Use it like this:

    $ export INSTIKI_AUTHOR="Emmy Noether"
    $ instiki-cli https://golem.ph.utexas.edu/wiki/instiki/show/Sandbox
    * Fetching https://golem.ph.utexas.edu/wiki/instiki/show/Sandbox... done.
    * Waiting for changes, go edit file "Sandbox"...

...time passes...

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

...the cycle continues...

    * Fetching https://golem.ph.utexas.edu/wiki/instiki/show/Sandbox... done.
    * Waiting for changes, go edit "Sandbox"...

I wrote the tool specifically to be able to edit the
[nLab](https://golem.ph.utexas.edu/wiki/instiki/show/Sandbox) more comfortably,
but *instiki-cli* should work with any Instiki installation.
