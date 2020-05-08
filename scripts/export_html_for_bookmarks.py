#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals
import argparse
import operator
import os
from os import path
import re
import sys

URL_SHORTCUT_RE = re.compile(
    r"""
    # Example:
    # URL=https://google.com

    # Results:
    #   url: https://google.com

    ^
    URL\=
    (?P<url>.+?)
    $
    """,
    re.UNICODE | re.VERBOSE | re.IGNORECASE,
)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "bookmarks_dir", metavar="bookmarks-dir", type=path.abspath, help="TODO"
    )
    args = parser.parse_args()

    bookmarks = []

    for root, __, files in os.walk(args.bookmarks_dir):
        file_paths_by_mtime_desc = []

        for file_name in files:
            file_path = path.join(root, file_name)
            file_paths_by_mtime_desc.append((file_path, os.stat(file_path).st_mtime))

        file_paths_by_mtime_desc = sorted(
            file_paths_by_mtime_desc, key=operator.itemgetter(1), reverse=True
        )

        for file_path, __ in file_paths_by_mtime_desc:
            try:
                title = unicode(
                    path.splitext(path.basename(file_path))[0], errors="strict"
                )
            except:
                print(file_name)
                raise
            # path.Path(file_path).stem
            match = None
            with open(file_path) as f:
                for line in f:
                    match = URL_SHORTCUT_RE.match(line)

                    if match is not None:
                        break

                if match is None:
                    raise RuntimeError(
                        "could not find url in shortcut file {0}".format(file_path)
                    )

            bookmarks.append((title, match.groupdict()["url"]))

    html = "<html><body>\n"
    for title, url in bookmarks:
        html += '<a href="{0}">{1} [backlog]</a>\n'.format(url, title)
    html += "</body></html>"

    sys.stdout.write(html)


if __name__ == "__main__":
    main()
