Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 943D3139579
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2020 17:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgAMQJG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Jan 2020 11:09:06 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36486 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMQJF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Jan 2020 11:09:05 -0500
Received: by mail-vs1-f68.google.com with SMTP id u14so6158453vsu.3
        for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2020 08:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jObQMn9gSwz3ebaw8I2BAqpZVOyyemNKGFqgfXY71+8=;
        b=QysXKqXbP6iAqnxljpZVx+40pBdK2NYkc0unODXQPO8X3KXjinTm3KCiXxW8B+7AYk
         Tp4vYv+YrHe99Dg243LTK0HjXZHrZ4Bj3aISw7wZpV+jbBMe6+dJlenetKSMkXCx2Cjv
         i2sMvhGqU2l+1EcAkZ2XbMK+0EF5YRc7qFQ1qykNd6Ve8/tF2jjmjwXAaJ/mhn/AukB6
         WP3GR3aTZV8s7idiMXv6xadIUX3qiu2eEhksZcGVbO7V38vRinXzBn6ZD43PTInxsJ7M
         YvMuwExwAkZCOHqI1yMzRNumpkXvhoqLS87Z0lKCfj7w5eRuLZAPc4Lxiqxg/u/Uj4RZ
         G2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jObQMn9gSwz3ebaw8I2BAqpZVOyyemNKGFqgfXY71+8=;
        b=S+/zHMo6+q3yf9u697TJU4KDDQizbag6xpLIWGPd363UJ6spjDCln52B62rbR8VFvY
         MGxZPiJ+MmC+UV0ysGI1kk5JNZZxfuNiRcFYBnAp5eUQGvF0GiBCtJ6aKgsYKlsp8YGo
         050TWgU5FMbWUvcMmKA7qoVEcAGqJ3V9BVj08vedZM0/iWLQVxhCzPPPXw5/wEGQoEFv
         Su6AXLc95S4l7w3vFtssSN5ETKnWrD+7WbEJpNRCSEsouOHXVacBxUQwW8jOuwtW4vUb
         6ap0IVIkcU7z/UXpSvpU9JSGe9RVmFhWypz3dJVgmwGstBGw18cPW+iRyV4fQWWTdEhS
         STPQ==
X-Gm-Message-State: APjAAAVu6QWbgHBbjJ2l2mt96x/G+DDv90SW9FoBwQBG+/M5uTF/KZnG
        GNCxPNEkXFDxaZnRDOJWGCbq93HSNjNkL9h1OhUyrA==
X-Google-Smtp-Source: APXvYqwn/T2ytWCWnWa2iCY9L6rRBJKsfQ0stYAUHbX3KcaaB1ULDpoCoXdhXXyfU59nIScV/rbXLKrG5l6yoXRUQuY=
X-Received: by 2002:a67:c90d:: with SMTP id w13mr6494769vsk.164.1578931744232;
 Mon, 13 Jan 2020 08:09:04 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyFY3XpteXw-fnpj0PQa3M81QGb6VnoxMaJukOZgJZ8ZOg@mail.gmail.com>
 <3b89b01911b5149533e45478fdcec941a4f915ba.camel@hammerspace.com>
In-Reply-To: <3b89b01911b5149533e45478fdcec941a4f915ba.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 13 Jan 2020 11:08:53 -0500
Message-ID: <CAN-5tyEc+yhWbUcO2snbT8kSAMo3wmEwYh3LPgd4tbNWC_838g@mail.gmail.com>
Subject: Re: interrupted rpcs problem
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 10, 2020 at 4:03 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Fri, 2020-01-10 at 14:29 -0500, Olga Kornievskaia wrote:
> > Hi folks,
> >
> > We are having an issue with an interrupted RPCs again. Here's what I
> > see when xfstests were ctrl-c-ed.
> >
> > frame 332 SETATTR call slot=0 seqid=0x000013ca (I'm assuming this is
> > interrupted and released)
> > frame 333 CLOSE call slot=0 seqid=0x000013cb  (only way the slot
> > could
> > be free before the reply if it was interrupted, right? Otherwise we
> > should never have the slot used by more than one outstanding RPC)
> > frame 334 reply to 333 with SEQ_MIS_ORDERED (I'm assuming server
> > received frame 333 before 332)
> > frame 336 CLOSE call slot=0 seqid=0x000013ca (??? why did we
> > decremented it. I mean I know why it's in the current code :-/ )
> > frame 337 reply to 336 SEQUENCE with ERR_DELAY
> > frame 339 reply to 332 SETATTR which nobody is waiting for
> > frame 543 CLOSE call slot=0 seqid=0x000013ca (retry after waiting for
> > err_delay)
> > frame 544 reply to 543 with SETATTR (out of the cache).
> >
> > What this leads to is: file is never closed on the server. Can't
> > remove it. Unmount fails with CLID_BUSY.
> >
> > I believe that's the result of commit
> > 3453d5708b33efe76f40eca1c0ed60923094b971.
> > We used to have code that bumped the sequence up when the slot was
> > interrupted but after the commit "NFSv4.1: Avoid false retries when
> > RPC calls are interrupted".
> >
> > Commit has this "The obvious fix is to bump the sequence number
> > pre-emptively if an
> >     RPC call is interrupted, but in order to deal with the corner
> > cases
> >     where the interrupted call is not actually received and processed
> > by
> >     the server, we need to interpret the error NFS4ERR_SEQ_MISORDERED
> >     as a sign that we need to either wait or locate a correct
> > sequence
> >     number that lies between the value we sent, and the last value
> > that
> >     was acked by a SEQUENCE call on that slot."
> >
> > If we can't no longer just bump the sequence up, I don't think the
> > correct action is to automatically bump it down (as per example
> > here)?
> > The commit doesn't describe the corner case where it was necessary to
> > bump the sequence up. I wonder if we can return the knowledge of the
> > interrupted slot and make a decision based on that as well as
> > whatever
> > the other corner case is.
> >
> > I guess what I'm getting is, can somebody (Trond) provide the info
> > for
> > the corner case for this that patch was created. I can see if I can
> > fix the "common" case which is now broken and not break the corner
> > case....
> >
>
> There is no pure client side solution for this problem.
>
> The change was made because if you have multiple interruptions of the
> RPC call, then the client has to somehow figure out what the correct
> slot number is. If it starts low, and then goes high, and the server is
> not caching the arguments for the RPC call that is in the session
> cache, then we will _always_ hit this bug because we will always hit
> the replay of the last entry.
>
> At least if we start high, and iterate by low, then we reduce the
> problem to being a race with the processing of the interrupted request
> as it is in this case.
>
> However, as I said, the real solution here has to involve the server.

Ok I see your point that if the server cached the arguments, then the
server would tell that 2nd rpc using the same slot+seqid has different
args and would not use the replay cache.

However, I wonder if the client can do better. Can't we be more aware
of when we are interrupting the rpc? For instance, if we are
interrupted after we started to wait on the RPC, doesn't it mean the
rpc is sent on the network and since network is reliable then server
must have consumed the seqid for that slot (in this case increment
seqid)? That's the case that's failing now.

I really don't understand where the process is interrupted so that the
client consumes the seqid but the rpc never gets on the network. I see
the only other place is in call_allocate(). If that's the case, then
we can distinguish those two places and treat them differently (in
this case decrement seqid)?

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
