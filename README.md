# webkit_remote_unstable

[webkit_remote](https://github.com/pwnall/webkit_remote) is a Ruby gem for
driving [Google Chrome](https://www.google.com/chrome/) and possibly other
WebKit-based browsers via the
[WebKit remote debugging protocol](https://www.webkit.org/blog/1875/announcing-remote-debugging-protocol-v1-0/).

This gem adds support for some of the unstable features in the WebKit remote
debugging protocol.  To see all the unstable protocol features, search for
`"hidden": true` in the
[protocol schema](http://trac.webkit.org/browser/trunk/Source/WebCore/inspector/Inspector.json).


## Features

This gem currently implements the following unstable features in the WebKit
remote debugging protocol.

* Overriding device attributes
* CSS computed styles
* DOM focusing, hit testing, and box model information


## Requirements

The requirements for [webkit_remote](https://github.com/pwnall/webkit_remote)
apply, namely you need a Google Chrome installation, and you can use
[Xvfb](http://en.wikipedia.org/wiki/Xvfb) for headless testing.

## Installation

Use RubyGems to install `webkit_remote_unstable` instead of `webkit_remote`,
and enjoy living on the bleeding edge.

```bash
gem install webkit_remote_unstable
```


## Usage

See the project's
[YARD documentation](http://rdoc.info/github/pwnall/webkit_remote_unstable/master/)
and
[test cases](https://github.com/pwnall/webkit_remote_unstable/tree/master/test/webkit_remote_unstable)
for usage examples.


## Contributing

Please contribute support for stable features to
[webkit_remote](https:://github.com/pwnall/webkit_remote) and support for
unstable features at
[webkit_remote_unstable](https:://github.com/pwnall/webkit_remote_unstable).

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Victor Costan. See LICENSE.txt for further details.
