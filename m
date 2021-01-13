Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9E22F533C
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jan 2021 20:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbhAMTYO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jan 2021 14:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbhAMTYO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jan 2021 14:24:14 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B2FC061575
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jan 2021 11:23:34 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g1so2519463edu.4
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jan 2021 11:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7KBbqWDRQ7UUBREJsNq4gXTjJjNr0zFU1m9UhbdNm6o=;
        b=sfcJxQTRP2sPpzT+r4cAdtk1MRNK9f4wK5dtK0/qbwyfgsr4KuU555m3xN0AJT/UOx
         blqYI9NAYCrx3QZOD+knDkWpHKzJ0REU43LAfh5g+dkmSsDJn+irt4mEttfKbi03IzwB
         OJJlndJI6677h1Y2esbz2JyYBwzcsNArw+ivAhvFWgzpQR/tp+h5A7noJkfS4fqDUniH
         s4ysPXPY7Q+qTJ5vx552DYAn6xGc97gRcx1PrMgGtMa/aWcDWLHPHtPKvyYZQ6m7qy7U
         ojidxBU/IVAR2+PlTQAeChntej+bTk0aSZUCQTYOnOc0xBQ9OvqASNCkOqfKK+itXfjW
         wwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7KBbqWDRQ7UUBREJsNq4gXTjJjNr0zFU1m9UhbdNm6o=;
        b=d9g9wMXxbDDgrriUJxr0H9WeqYFMbFA6rt4WWaSx5XGdarceWMhIBimHdV4Kgsh+m6
         36sFaD6QtQWk6iUAaCT+ckuWhogT26TG0x955PTvkb5h6+NGxmC+TAQYM52E3ppleNXs
         QZzp/aKsi5bg0R9na8sWzSe72Rsei8u5X6035GA2gImwtNQvgc+BQh1dQoikl7HYTwb+
         W2S1YtthIZDypKb9308S1mX9iQq7ai2x8Ab3rRARhBpE47ZhlrSTmHZk1mgxlCTSZKKO
         2jZ6fP22Y6Y6242+42PXJhKF4AYsHH9cFoSrJznHEZxjxrhbWLo3V+0b5IfF9yVLgTAe
         ccAA==
X-Gm-Message-State: AOAM532vbYM8RM5kF+OhldGseG6vWmAUIICk7aINDpGkzvruVAe1HShb
        CHrLh+ZDmKgL62skmoznx1YmGVuN/1Ji0VZsTX0xN5uOvc4=
X-Google-Smtp-Source: ABdhPJyyNs5xj+tiVaEcUw4eIDNf5BnoA7Yzh5gbOFyqQ8XxQMVMFUa3bJCQgjAk+r/T6W5JoRj0pEeio0fSdf3ZaeU=
X-Received: by 2002:a50:c315:: with SMTP id a21mr3061981edb.50.1610565812675;
 Wed, 13 Jan 2021 11:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
 <CE510EA5-1E3F-4516-A948-10A0FF31C94F@oracle.com> <20210112165911.GH9248@fieldses.org>
In-Reply-To: <20210112165911.GH9248@fieldses.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 13 Jan 2021 14:23:16 -0500
Message-ID: <CAFX2JfmYrCSYfCCGgQ0eghU3WSqk=T38wxkJ7Q42ORw-NFeFQg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] SUNRPC: Create sysfs files for changing IP
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 12, 2021 at 11:59 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, Jan 12, 2021 at 08:09:09AM -0500, Chuck Lever wrote:
> > Hi Anna-
> >
> > > On Jan 11, 2021, at 4:41 PM, schumaker.anna@gmail.com wrote:
> > >
> > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > >
> > > It's possible for an NFS server to go down but come back up with a
> > > different IP address. These patches provide a way for administrators to
> > > handle this issue by providing a new IP address for xprt sockets to
> > > connect to.
> > >
> > > This is a first draft of the code, so any thoughts or suggestions would
> > > be greatly appreciated!
> >
> > One implementation question, one future question.
> >
> > Would /sys/kernel/net be a little better? or /sys/kernel/sunrpc ?

Possibly! I was trying to match /sys/fs/nfs, but I can definitely
change this if another location is better.

> >
> > Do you have a plan to integrate support for fs_locations to probe
> > servers for alternate IP addresses? Would that be a userspace
> > utility that would plug values into this new /sys API?

Yeah, I would expect there to be a new utility to help with assigning
new values. I haven't given any thought to using fs_locations yet, but
it could probably work.
>
> We already have dns resolution for fs_locations, right?  Why can't we
> use that here?  Is it that the mount call doesn't give us a host name?
> Or we don't trust dns to have the updated IP address for some reason?

The mount call doesn't give us a host name (that I can find, at
least). By the time we get to the sunrpc layer we're dealing with just
the IP address anyway. I'd expect there to be a userland utility to
translate the dns name to the new IP address and pass it along to the
new API.

Anna
>
> --b.
>
> >
> >
> > > Anna
> > >
> > >
> > > Anna Schumaker (7):
> > >  net: Add a /sys/net directory to sysfs
> > >  sunrpc: Create a sunrpc directory under /sys/net/
> > >  sunrpc: Create a net/ subdirectory in the sunrpc sysfs
> > >  sunrpc: Create per-rpc_clnt sysfs kobjects
> > >  sunrpc: Create a per-rpc_clnt file for managing the IP address
> > >  sunrpc: Prepare xs_connect() for taking NULL tasks
> > >  sunrpc: Connect to a new IP address provided by the user
> > >
> > > include/linux/sunrpc/clnt.h |   1 +
> > > include/net/sock.h          |   4 +
> > > net/socket.c                |   8 ++
> > > net/sunrpc/Makefile         |   2 +-
> > > net/sunrpc/clnt.c           |   5 ++
> > > net/sunrpc/sunrpc_syms.c    |   8 ++
> > > net/sunrpc/sysfs.c          | 160 ++++++++++++++++++++++++++++++++++++
> > > net/sunrpc/sysfs.h          |  22 +++++
> > > net/sunrpc/xprtsock.c       |   3 +-
> > > 9 files changed, 211 insertions(+), 2 deletions(-)
> > > create mode 100644 net/sunrpc/sysfs.c
> > > create mode 100644 net/sunrpc/sysfs.h
> > >
> > > --
> > > 2.29.2
> > >
> >
> > --
> > Chuck Lever
> >
> >
