Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC3724900C
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Aug 2020 23:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgHRVZw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Aug 2020 17:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHRVZv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Aug 2020 17:25:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CB7C061389
        for <linux-nfs@vger.kernel.org>; Tue, 18 Aug 2020 14:25:50 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f26so23046982ljc.8
        for <linux-nfs@vger.kernel.org>; Tue, 18 Aug 2020 14:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6fKpvjJlCSHCp96PWldmenp+9/Slr3I3lpOephDc19U=;
        b=JsZJaoEdaXyVb4YPKwGiWfQgaDMxW0sxIksE0ehExHWsEDZqycnDreB3Kz5BB3+IMR
         LGkxNssfNZWFOnA+A/+c6cwR5Q/mPy53G65JxwZuEMv7AWizrC2A7xxw3vmtAzdgRjvL
         1EXadkXYTzX2GM8rXpvQ2lYovJ/F7gphRwRO4b1osO6YK0DP3zF1MPpca87NJMA9pZm+
         Cg63vkNXeBTzgzuWZ5DtihVWj9gDiO42xTdx52yZUvxg0A0Vx3ANfWLKpHgYncP7POGm
         4LXcZBraoxRVdt8rphQ2dfjkuXLecakZNbArssecVEa57iisRnNcweZ8Eo8bVWFfdA8k
         UyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6fKpvjJlCSHCp96PWldmenp+9/Slr3I3lpOephDc19U=;
        b=i71PEaZ3ww4kyEwbfkHpIhTJlGB2oETCxapO9kZaL0jXeB0cnGwELpS+3wYkVGo2Cb
         yRtlMRnlsxCCxtjJVx04/hIaOGj8EFgp6xXZlN8wfklS1Sflf8O29d5UJTRXGTcJ7h7T
         eYhOt7+oU8gGzuU7uHA1IYSl/kQ8JPhSxsO7igl85k7smNl73/yrCj8GOtG6pDgdqc7n
         /h22jFOnRtXzJnzR868Hck1jH1f56S6C5zP9xEQKFnJipfGIKeXX/hqa8yNhWv5Qi1wa
         20fayAHE3K0uhGEP1SboTnKxGTqwlgo7oYjfvJLWHzqWVxir+UAtu2MQ1Mqfa+v/nlY3
         KtzQ==
X-Gm-Message-State: AOAM532wMGS58OZaAzVwJL0vShFnD8fQqSn+CKMJmiWi+WEz9fVyTFoj
        pmvZaMz8Qp7RQAasUQgXf3gW1DuEK9Z6Xoysl+bEQBb3u6HYgmDG
X-Google-Smtp-Source: ABdhPJx2COC3dB4tHTImepzN3iEhH9tWPmPvB1Vxnxn39HbssIySvEtvkz6z1Cg+XkMb560Z3aonUVwNnojkSulc3WM=
X-Received: by 2002:a2e:555:: with SMTP id 82mr10943239ljf.337.1597785948513;
 Tue, 18 Aug 2020 14:25:48 -0700 (PDT)
MIME-Version: 1.0
From:   Chad Joan <chadjoan@gmail.com>
Date:   Tue, 18 Aug 2020 17:25:36 -0400
Message-ID: <CABHMSTWKuyU3LFqKj8qNDqB8iX_d5VEc8Q1QSJJwUMsxtOzAcA@mail.gmail.com>
Subject: [GIT PULL] Fix idmapd segfault on musl libc systems.
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

The changes (described below) are available in a series of commits on
my fork of the nfs-utils repository at
https://github.com/chadjoan/nfs-utils/commits/bug344-passwd

Background:

I reported a bug (#344) to the linux-nfs bugzilla earlier this month
(https://bugzilla.linux-nfs.org/show_bug.cgi?id=344) where the idmapd
service would fail to start on one of my machines and printed a
"general protection fault" message in my system log:

Aug  3 07:13:21 l-andianov rpc.idmapd[29843]: Setting log level to 7
Aug  3 07:13:21 l-andianov rpc.idmapd[29843]: libnfsidmap: using
domain: ozymandias
Aug  3 07:13:21 l-andianov rpc.idmapd[29843]: libnfsidmap: Realms
list: 'OZYMANDIAS'
Aug  3 07:13:21 l-andianov rpc.idmapd[29843]: libnfsidmap: processing
'Method' list
Aug  3 07:13:21 l-andianov kernel: traps: rpc.idmapd[29843] general
protection fault ip:7fb4bc75c0cd sp:7ffe56527540 error:0 in
libc.so[7fb4bc748000+5f000]
Aug  3 07:13:21 l-andianov rpc.idmapd[29843]: libnfsidmap: loaded
plugin /usr/lib/libnfsidmap/static.so for method static
Aug  3 07:13:21 l-andianov /etc/init.d/rpc.idmapd[29819]: ERROR:
rpc.idmapd failed to start
Aug  3 07:13:21 l-andianov /etc/init.d/nfs[29818]: ERROR: cannot start
nfs as rpc.idmapd would not start

Long-story-short: I investigated, found out it was because musl libc
returns `-1` from `sysconf(_SC_GETPW_R_SIZE_MAX)` calls (which is
allowable by POSIX standards), and idmapd's code wasn't written to
handle this possibility, so a buffer overrun/overflow happened.

Resolution:

I have written commits that solve this problem wherever it might
occur, so anywhere `sysconf` was used to size memory buffers before
calling `get**nam_r` or `get***id_r`. It may also fix other bugs or
inconsistencies that were found in the affected code, as well as
improving the comprehensiveness of error detection.

Highlights:

- Memory for `get**nam_r` and `get***id_r` functions is no longer
allocated based on the return value of sysconf(...), as it can return
misleading values or -1 in this use-case.
- Introduces passwd_query.c module that handles buffer allocation and
adjustment for those functions, as well as other edge-cases. This does
increase complexity, but it allows some memory management and
exception handling complexity to be shifted away from feature and
retrieval logic.
- The passwd_query.c module was (manually) tested in isolation to get
more coverage than what I would be able to obtain by running idmapd.
There is a program for that (pwgrp_test.c) in this repository:
https://github.com/chadjoan/passwd_query
- Calls to `get**nam_r` and `get***id_r` are now very likely to use
stack allocation instead of `malloc`, though this logic will fall back
to `malloc` if the demands on buffer size are large (ex: absurdly long
comments in passwd file or very long group member lists).
- Furthermore, if `get**nam_r` and `get***id_r` still need more
buffer, `passwd_query.c` will use a `realloc`-loop until the buffer is
large enough. This results in an interface that does the same thing
but never returns ERANGE - the error does not have to be handled
because it does not happen.
- Any code that called the `get**nam_r` and `get***id_r` will now log
error messages for every possible error code that those functions
return. In the event of a non-standard error, it will attempt to get
error text from `strerror`, and information about what was being
looked-up or mapped will still be printed.
- In the `gums.c` plugin, `translate_to_uid` and `translate_to_gid`
did not have the same exception handling logic. For example,
`translate_to_gid` had a `realloc`-loop, while `translate_to_uid` did
not. Since this change has them all use `passwd_query.c`
functionality, they should be more robust and equally robust.
- In some places the code calling `get**nam_r` and `get***id_r` would
loop after EINTR error codes (retry on interrupt), while other places
would not. These differences were not justified with comments, so I
gave the EINTR retry looping behavior to everything that queries
`passwd` or `group` information. I did this by convention instead of
putting the functionality in `passwd_query.c`, so it should be pretty
easy to back it off selectively if there are places where this
shouldn't be done.
- There was a potential memory leak in `regex.c`: `regex_getpwnam`
would not free the `localname` string if it completed successfully
(the abortive cases were fine, though). That can no longer happen, and
it is written in a way that makes it clear that the `free()` will
always happen if-and-only-if `malloc()` happened. It will also attempt
to use a small-ish fixed-size stack allocated buffer whenever the
string fits.
- Since the code related to `get**nam_r` and `get***id_r` in `nss.c`
was already being refactored to some extent, I made it trivial to see
if `free()` was called if something was allocated. The `malloc()` call
was hidden in other functions in this case, so this probably won't
look as good as what happened in `regex.c`, but it should still help.
As far as I can tell, this code didn't leak memory beforehand; so this
particular refactoring just makes the code more self-documenting. I
like to make things clear if I have any doubt.
- This was done in a series of separate commits, each of which should
leave the codebase in a working state.

Process, testing, and commit layout:

The changes to `static.c` and `nfsidmap.c` were done alongside the
addition of `passwd_query.c`, and are effectively the starting point
for this changeset. This is the stuff I could test easily on my own
machine. I could not run the `regex.c` and `nss.c` plugins, but I did
make sure they compiled, and each of those was given their own
commits. The `gums.c` plugin was something I didn't have dependencies
installed for, so compilation was difficult. I still managed to obtain
some confidence with it by commenting out all of the code I didn't
change and then compiling what I did change, and that worked. I also
gave `gums.c` its own commit.

I normally like to write unittests for my code so that the
(regression) testing can be performed automatically by others, and
give you greater confidence in the maintainability of the code. In
this case, I think that this would require some kind of mock libc
implementation. I couldn't find that and I don't have one. So for this
changeset I fell back on testing my code by hand whenever I made
changes. I hope this will suffice.


Have a great day!
- Chad
