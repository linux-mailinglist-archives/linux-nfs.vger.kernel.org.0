Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB519A766
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2020 10:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgDAIhh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Apr 2020 04:37:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39114 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730750AbgDAIhg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Apr 2020 04:37:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id a43so28645741edf.6
        for <linux-nfs@vger.kernel.org>; Wed, 01 Apr 2020 01:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Pb5WxXo01OUrPYKfuGBoAi7COZxVQpsVUvg17nkA6w=;
        b=DCWoZP8f/dOkjW5uYoUFpfMxBGbKeZuXpLeJJK8mTpafT0iBm07aAautrwxGNxNPuH
         kwa+oyklRAFDRmQ9G/64ndypZ3iC1AQSMWoHkTRNK/CJ98o+a+FWbDoEu0LWLRzfWA12
         BQCicYA5Tma7uC+qkVwM5zNRNQOh9LLVhWIgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Pb5WxXo01OUrPYKfuGBoAi7COZxVQpsVUvg17nkA6w=;
        b=PrK4AV7LyEqGhTE+faweb+Xq+45WRCVo3d5HIPepfW3WD0Nfz2BK9PgrnNPCvK0QO5
         dJWJVL/NpMf8Um7GZ2p5FVKyB73e1vwy7xta1LV+stCM2iMZC/wNmFhH3meepasE3yEr
         OvSm8oH+5tMZCHGPs2xNdrt7SzkvbNevBGmvPS9S9EymnrsILk3/hq0mZD1A4VgA1+DK
         CAGNy1sxLpBOx9OcWsa+U4zGj9VPldcrz3Qq59TXXX+nmg/pKZm6F318hZk7F+oh6TPh
         tpu5BclcoRCTqxYFAi8mTYyFPiOLBIK1O/CvYj3+l5pfMmKXgcVBUo1hyZzm7nKgfIOz
         tGTA==
X-Gm-Message-State: ANhLgQ3YPSeiNLTnhX/MdaofV9d+KEmbI4PJewBohRDm041uVaJiZwx5
        xVlLijLKEmto1OXhIlYuAnZp8uvqqPgyF/I4rIppMA==
X-Google-Smtp-Source: ADFU+vv25aObxVqudxs/b4t6TUDhdA8HhF0PuGfXX6HSZBIvhctUM+bsT6LQzuUGvDuTHabWaoYU8+dr8sw8QJ3EQ4c=
X-Received: by 2002:a50:8326:: with SMTP id 35mr19766368edh.134.1585730253359;
 Wed, 01 Apr 2020 01:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
 <CAJfpeguaiicjS2StY5m=8H7BCjq6PLxMsWE3Mx_jYR1foDWVTg@mail.gmail.com>
 <50caf93782ba1d66bd6acf098fb8dcb0ecc98610.camel@themaw.net>
 <CAJfpegvvMVoNp1QeXEZiNucCeuUeDP4tKqVfq2F4koQKzjKmvw@mail.gmail.com> <2465266.1585729649@warthog.procyon.org.uk>
In-Reply-To: <2465266.1585729649@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 1 Apr 2020 10:37:22 +0200
Message-ID: <CAJfpegsyeJmH3zJuseaAAY06fzgavSzpOtYr-1Mw8GR0cLcQbA@mail.gmail.com>
Subject: Re: [PATCH 00/13] VFS: Filesystem information [ver #19]
To:     David Howells <dhowells@redhat.com>
Cc:     Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux API <linux-api@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 1, 2020 at 10:27 AM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > According to dhowell's measurements processing 100k mounts would take
> > about a few seconds of system time (that's the time spent by the
> > kernel to retrieve the data,
>
> But the inefficiency of mountfs - at least as currently implemented - scales
> up with the number of individual values you want to retrieve, both in terms of
> memory usage and time taken.

I've taken that into account when guesstimating a "few seconds per
100k entries".  My guess is that there's probably an order of
magnitude difference between the performance of a fs based interface
and a binary syscall based interface.  That could be reduced somewhat
with a readfile(2) type API.

But the point is: this does not matter.  Whether it's .5s or 5s is
completely irrelevant, as neither is going to take down the system,
and userspace processing is probably going to take as much, if not
more time.  And remember, we are talking about stopping and starting
the automount daemon, which is something that happens, but it should
not happen often by any measure.

> With fsinfo(), I've tried to batch values together where it makes sense - and
> there's no lingering memory overhead - no extra inodes, dentries and files
> required.

The dentries, inodes and files in your test are single use (except the
root dentry) and can be made ephemeral if that turns out to be better.
My guess is that dentries belonging to individual attributes should be
deleted on final put, while the dentries belonging to the mount
directory can be reclaimed normally.

Thanks,
Miklos
