Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5795413985B
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2020 19:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgAMSJc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Jan 2020 13:09:32 -0500
Received: from mail-vs1-f42.google.com ([209.85.217.42]:37446 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMSJc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Jan 2020 13:09:32 -0500
Received: by mail-vs1-f42.google.com with SMTP id x18so6456488vsq.4
        for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2020 10:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+DnO7FHdgL41dXw11V94X4BHeNEoH2NPIF/v83MFuo=;
        b=lGzg5AqFWCbwjLON9nYU84f2a82B4H6DppAomwjRxL+YuFRhj+/L4/S5o76hOzL/MN
         qXxNHxTbLlPp5n6GllO8AcXNXEZO3Pjq70LxwEWuhgj9kcR7CdQCiaLK49cYYNbYn27Z
         c4ByYxsIhse5tVHA7Id1+Ph7D3ZCNMQ6LpozkxbSa2xxWeJGY5oF0IKEKbankib60a8I
         xovP7NfiGOXLLwabw6YFozO4VHXWB3WDeJ9CX3rEZ93nqb0vPVY0FIcMQYehv1djBuLX
         5kHNccHzJc6DY4geoxa+0xw0L8/TfpZ4G8qnGqhEB2d+MSKZ0giVtuvjtDHOrT73xiOC
         R9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+DnO7FHdgL41dXw11V94X4BHeNEoH2NPIF/v83MFuo=;
        b=idqGH+XLbn/QdGqI5rEN48U1hxnkIEWec3JyNl9B7d83xdT2L+K4W7447jvDTj8QJ4
         jXU8I+Y9Dhr72+FfjftqJZpf9QmQhTFKXw/IhIKDsSQIoU77jw51Ig/oJc/uT13Ex5cU
         FaTCN5I95zRKPbhPdNv1IglOaVG21LUEUztb74L2WPaCU/+7XxLBW+j06foo0gqtdE0E
         ZOJiO7/s5E2Iuh/sSOsjWQn6QPsF0744TCxu6RE3aptZRotC9UPKcvB8X3ioV8oygGx6
         QVDSrqVdHYcvVodyE/O5HtI6/6wXWNGI/xpN8cufoPxxgQA4lWlNkmCbc03G8CP1r9ZD
         Fsww==
X-Gm-Message-State: APjAAAWj9w9Wz9sN75s4Va4qxPYczJidwdjgX+BDVnIzyOW8bJQPYSwP
        7VuvytkYNadAy8AsWGEJamm5+GzwMl0BC+hNAPGIEg==
X-Google-Smtp-Source: APXvYqx90ZBtgcUe5IQdLjlAoRcqa1EZNKKNO4/OZkmr3foztck3bP4rnhtcUlNRg/FvNplVT0dqd2B3fGy8v3+nB9M=
X-Received: by 2002:a67:f81a:: with SMTP id l26mr6998099vso.194.1578938970100;
 Mon, 13 Jan 2020 10:09:30 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyFY3XpteXw-fnpj0PQa3M81QGb6VnoxMaJukOZgJZ8ZOg@mail.gmail.com>
 <3b89b01911b5149533e45478fdcec941a4f915ba.camel@hammerspace.com>
 <CAN-5tyEc+yhWbUcO2snbT8kSAMo3wmEwYh3LPgd4tbNWC_838g@mail.gmail.com> <185a1505f75a36d852df7a9351d6bb776103c506.camel@hammerspace.com>
In-Reply-To: <185a1505f75a36d852df7a9351d6bb776103c506.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 13 Jan 2020 13:09:19 -0500
Message-ID: <CAN-5tyHdaKhUiBJW_+waSG6mXqW4nsaLY9uKugen4=haYLcR4w@mail.gmail.com>
Subject: Re: interrupted rpcs problem
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 13, 2020 at 11:49 AM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Mon, 2020-01-13 at 11:08 -0500, Olga Kornievskaia wrote:
> > On Fri, Jan 10, 2020 at 4:03 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > > On Fri, 2020-01-10 at 14:29 -0500, Olga Kornievskaia wrote:
> > > > Hi folks,
> > > >
> > > > We are having an issue with an interrupted RPCs again. Here's
> > > > what I
> > > > see when xfstests were ctrl-c-ed.
> > > >
> > > > frame 332 SETATTR call slot=0 seqid=0x000013ca (I'm assuming this
> > > > is
> > > > interrupted and released)
> > > > frame 333 CLOSE call slot=0 seqid=0x000013cb  (only way the slot
> > > > could
> > > > be free before the reply if it was interrupted, right? Otherwise
> > > > we
> > > > should never have the slot used by more than one outstanding RPC)
> > > > frame 334 reply to 333 with SEQ_MIS_ORDERED (I'm assuming server
> > > > received frame 333 before 332)
> > > > frame 336 CLOSE call slot=0 seqid=0x000013ca (??? why did we
> > > > decremented it. I mean I know why it's in the current code :-/ )
> > > > frame 337 reply to 336 SEQUENCE with ERR_DELAY
> > > > frame 339 reply to 332 SETATTR which nobody is waiting for
> > > > frame 543 CLOSE call slot=0 seqid=0x000013ca (retry after waiting
> > > > for
> > > > err_delay)
> > > > frame 544 reply to 543 with SETATTR (out of the cache).
> > > >
> > > > What this leads to is: file is never closed on the server. Can't
> > > > remove it. Unmount fails with CLID_BUSY.
> > > >
> > > > I believe that's the result of commit
> > > > 3453d5708b33efe76f40eca1c0ed60923094b971.
> > > > We used to have code that bumped the sequence up when the slot
> > > > was
> > > > interrupted but after the commit "NFSv4.1: Avoid false retries
> > > > when
> > > > RPC calls are interrupted".
> > > >
> > > > Commit has this "The obvious fix is to bump the sequence number
> > > > pre-emptively if an
> > > >     RPC call is interrupted, but in order to deal with the corner
> > > > cases
> > > >     where the interrupted call is not actually received and
> > > > processed
> > > > by
> > > >     the server, we need to interpret the error
> > > > NFS4ERR_SEQ_MISORDERED
> > > >     as a sign that we need to either wait or locate a correct
> > > > sequence
> > > >     number that lies between the value we sent, and the last
> > > > value
> > > > that
> > > >     was acked by a SEQUENCE call on that slot."
> > > >
> > > > If we can't no longer just bump the sequence up, I don't think
> > > > the
> > > > correct action is to automatically bump it down (as per example
> > > > here)?
> > > > The commit doesn't describe the corner case where it was
> > > > necessary to
> > > > bump the sequence up. I wonder if we can return the knowledge of
> > > > the
> > > > interrupted slot and make a decision based on that as well as
> > > > whatever
> > > > the other corner case is.
> > > >
> > > > I guess what I'm getting is, can somebody (Trond) provide the
> > > > info
> > > > for
> > > > the corner case for this that patch was created. I can see if I
> > > > can
> > > > fix the "common" case which is now broken and not break the
> > > > corner
> > > > case....
> > > >
> > >
> > > There is no pure client side solution for this problem.
> > >
> > > The change was made because if you have multiple interruptions of
> > > the
> > > RPC call, then the client has to somehow figure out what the
> > > correct
> > > slot number is. If it starts low, and then goes high, and the
> > > server is
> > > not caching the arguments for the RPC call that is in the session
> > > cache, then we will _always_ hit this bug because we will always
> > > hit
> > > the replay of the last entry.
> > >
> > > At least if we start high, and iterate by low, then we reduce the
> > > problem to being a race with the processing of the interrupted
> > > request
> > > as it is in this case.
> > >
> > > However, as I said, the real solution here has to involve the
> > > server.
> >
> > Ok I see your point that if the server cached the arguments, then the
> > server would tell that 2nd rpc using the same slot+seqid has
> > different
> > args and would not use the replay cache.
> >
> > However, I wonder if the client can do better. Can't we be more aware
> > of when we are interrupting the rpc? For instance, if we are
> > interrupted after we started to wait on the RPC, doesn't it mean the
> > rpc is sent on the network and since network is reliable then server
> > must have consumed the seqid for that slot (in this case increment
> > seqid)? That's the case that's failing now.
> >
>
> "Reliable transport" does not mean that a client knows what got
> received and processed by the server and what didn't. All the client
> knows is that if the connection is still up, then the TCP layer will
> keep retrying transmission of the request. There are plenty of error
> scenarios where the client gets no information back as to whether or
> not the data was received by the server (e.g. due to lost ACKs).
>
> Furthermore, if a RPC call is interrupted on the client, either due to
> a timeout or a signal,

What timeout are you referring to here since 4.1 rcp can't timeout. I
think it only leaves a signal.

> then it almost always ends up breaking the
> connection in order to avoid corruption of the data stream (by
> interrupting the transmission before the entire RPC call has been
> sent). You generally have to be lucky to see the timeout/signal occur
> only when all the RPC calls being cancelled have exactly fit into the
> socket buffer.

Wouldn't a retransmission (due to a connection reset for whatever
reason) be different and doesn't involve reprocessing of the slot.

> Finally, just because the server's TCP layer ACKed receipt of the RPC
> call data, that does not mean that it will process that call. The
> connection could break before the call is read out of the receiving
> socket, or the server may later decide to drop it on the floor and
> break the connection.
>
> IOW: the RPC protocol here is not that "reliable transport implies
> processing is guaranteed". It is rather that "connection is still up
> implies processing may eventually occur".

"eventually occur" means that its process of the rpc is guaranteed "in
time". Again unless the client is broken, we can't have more than an
interrupted rpc (that has nothing waiting) and the next rpc (both of
which will be re-transmitted if connection is dropped) going to the
server.

Can we distinguish between interrupted due to re-transmission and
interrupted due to ctrl-c of the thread? If we can't, then I'll stop
arguing that client can do better.

But right now we are left in a bad state. Client leaves opened state
on the server and will not allow for files to be deleted. I think in
case the "next rpc" is the write that will never be completed it would
leave the machine in a hung state. I just don't see how can you
justify that having the current code is any better than having the
solution that was there before.




>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
