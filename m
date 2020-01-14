Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680E613B249
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2020 19:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgANSnS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jan 2020 13:43:18 -0500
Received: from mail-vk1-f169.google.com ([209.85.221.169]:37181 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANSnS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jan 2020 13:43:18 -0500
Received: by mail-vk1-f169.google.com with SMTP id b129so3932488vka.4
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2020 10:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ukl40QvdZZNp/6fYDteFPBa5fc/k7qzYy7RecmtBOS4=;
        b=Z+C5LIi8LE8OU567i6IxUNEpJ/qKS1+esXoRnQrNGpdepNjDNOUNaJlSebwd+MZv/F
         fasLy7Bd0DDi0qP00IhEk5E2kP9TBI38HiAt2r42O6x3/uFOVTkcoidSz06wK+MPm6IW
         UPGSnhPhG7J6+t4mV/Q5ckP+GY5d0IGCdwboPjF3UL82Cm9nOZEfo0/E1CJJBp9Hkun6
         NWoMVjn2qjoQt8xnoEsbjbh+LvLfpY+QQWe0/D9z29K5JIHl6cuyeshIuvV7zHt5NQ3G
         HhLdWdNpB1s3R9kVzheBSN7V7k5SLly+bktqebdapokp1A8JVQWr9zWzRbC4XRycpoa3
         aeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukl40QvdZZNp/6fYDteFPBa5fc/k7qzYy7RecmtBOS4=;
        b=ma93hjpsjefKCzDno9kjdbI8EBk/b3O5AtOwDerFIzlX0ykodubHysW+wmEX6wlRKK
         7toaa188dqgYqqEIQzYDgHcm4kR/UicEUNE32X8B2u2ZdwMprgo6qSYdBgLkzaPDauwm
         kuclt6vGGxI3rjmk0WexnahO6BhxgUVZeTTlIbKybX2lvbi+rm2xpzK7UZv8PV1mZjV6
         twtMYXoUW4uW60L2NpAw34vZfEzFWzt88JBdK2SH9A2zYEeuzbASynGBTz+qU/hy52XC
         rqavDTuwILZybf4v9IvqrH1BFf+f6rvu1ElPuiF5carTcf4cDgWRggUJkm1vIOSRMz8f
         wrZA==
X-Gm-Message-State: APjAAAWxDkqWxSWvgPNdPcppg6T2V8Phttnm/+eG/QralzGm98vtxcdM
        3BBiP/Xm3hRiM+RfJpCx4uJ0AptbFAEcxv/ONEzV0w==
X-Google-Smtp-Source: APXvYqz+QBEjkmBqws6UhFA4k02Ip/mqH5VByVTK3j3bXKq97vKnYWJGch7xfEXUwh6f5sWVbW2tPp11xzhZCGprcvw=
X-Received: by 2002:a1f:5e04:: with SMTP id s4mr11630163vkb.99.1579027396974;
 Tue, 14 Jan 2020 10:43:16 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyFY3XpteXw-fnpj0PQa3M81QGb6VnoxMaJukOZgJZ8ZOg@mail.gmail.com>
 <3b89b01911b5149533e45478fdcec941a4f915ba.camel@hammerspace.com>
 <CAN-5tyEc+yhWbUcO2snbT8kSAMo3wmEwYh3LPgd4tbNWC_838g@mail.gmail.com>
 <185a1505f75a36d852df7a9351d6bb776103c506.camel@hammerspace.com>
 <CAN-5tyHdaKhUiBJW_+waSG6mXqW4nsaLY9uKugen4=haYLcR4w@mail.gmail.com>
 <1538116fa0b35674da7242e9fadf19ddeca5e2c2.camel@hammerspace.com>
 <CAN-5tyFDfrFA6rhWyO_Ot4Qt3wJohyePYbLh=STXuNo-dykHPQ@mail.gmail.com> <d90499b8c04e3dbe8d1d8c70f7bae1e92e5c1600.camel@hammerspace.com>
In-Reply-To: <d90499b8c04e3dbe8d1d8c70f7bae1e92e5c1600.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 14 Jan 2020 13:43:05 -0500
Message-ID: <CAN-5tyEucoHem8GHW9zdosdPF1D4LpUX4h0jFvOSPHZ3XS_pwg@mail.gmail.com>
Subject: Re: interrupted rpcs problem
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 13, 2020 at 4:51 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Mon, 2020-01-13 at 16:05 -0500, Olga Kornievskaia wrote:
> > On Mon, Jan 13, 2020 at 1:24 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > > On Mon, 2020-01-13 at 13:09 -0500, Olga Kornievskaia wrote:
> > > > On Mon, Jan 13, 2020 at 11:49 AM Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > > > On Mon, 2020-01-13 at 11:08 -0500, Olga Kornievskaia wrote:
> > > > > > On Fri, Jan 10, 2020 at 4:03 PM Trond Myklebust <
> > > > > > trondmy@hammerspace.com> wrote:
> > > > > > > On Fri, 2020-01-10 at 14:29 -0500, Olga Kornievskaia wrote:
> > > > > > > > Hi folks,
> > > > > > > >
> > > > > > > > We are having an issue with an interrupted RPCs again.
> > > > > > > > Here's
> > > > > > > > what I
> > > > > > > > see when xfstests were ctrl-c-ed.
> > > > > > > >
> > > > > > > > frame 332 SETATTR call slot=0 seqid=0x000013ca (I'm
> > > > > > > > assuming
> > > > > > > > this
> > > > > > > > is
> > > > > > > > interrupted and released)
> > > > > > > > frame 333 CLOSE call slot=0 seqid=0x000013cb  (only way
> > > > > > > > the
> > > > > > > > slot
> > > > > > > > could
> > > > > > > > be free before the reply if it was interrupted, right?
> > > > > > > > Otherwise
> > > > > > > > we
> > > > > > > > should never have the slot used by more than one
> > > > > > > > outstanding
> > > > > > > > RPC)
> > > > > > > > frame 334 reply to 333 with SEQ_MIS_ORDERED (I'm assuming
> > > > > > > > server
> > > > > > > > received frame 333 before 332)
> > > > > > > > frame 336 CLOSE call slot=0 seqid=0x000013ca (??? why did
> > > > > > > > we
> > > > > > > > decremented it. I mean I know why it's in the current
> > > > > > > > code :-
> > > > > > > > / )
> > > > > > > > frame 337 reply to 336 SEQUENCE with ERR_DELAY
> > > > > > > > frame 339 reply to 332 SETATTR which nobody is waiting
> > > > > > > > for
> > > > > > > > frame 543 CLOSE call slot=0 seqid=0x000013ca (retry after
> > > > > > > > waiting
> > > > > > > > for
> > > > > > > > err_delay)
> > > > > > > > frame 544 reply to 543 with SETATTR (out of the cache).
> > > > > > > >
> > > > > > > > What this leads to is: file is never closed on the
> > > > > > > > server.
> > > > > > > > Can't
> > > > > > > > remove it. Unmount fails with CLID_BUSY.
> > > > > > > >
> > > > > > > > I believe that's the result of commit
> > > > > > > > 3453d5708b33efe76f40eca1c0ed60923094b971.
> > > > > > > > We used to have code that bumped the sequence up when the
> > > > > > > > slot
> > > > > > > > was
> > > > > > > > interrupted but after the commit "NFSv4.1: Avoid false
> > > > > > > > retries
> > > > > > > > when
> > > > > > > > RPC calls are interrupted".
> > > > > > > >
> > > > > > > > Commit has this "The obvious fix is to bump the sequence
> > > > > > > > number
> > > > > > > > pre-emptively if an
> > > > > > > >     RPC call is interrupted, but in order to deal with
> > > > > > > > the
> > > > > > > > corner
> > > > > > > > cases
> > > > > > > >     where the interrupted call is not actually received
> > > > > > > > and
> > > > > > > > processed
> > > > > > > > by
> > > > > > > >     the server, we need to interpret the error
> > > > > > > > NFS4ERR_SEQ_MISORDERED
> > > > > > > >     as a sign that we need to either wait or locate a
> > > > > > > > correct
> > > > > > > > sequence
> > > > > > > >     number that lies between the value we sent, and the
> > > > > > > > last
> > > > > > > > value
> > > > > > > > that
> > > > > > > >     was acked by a SEQUENCE call on that slot."
> > > > > > > >
> > > > > > > > If we can't no longer just bump the sequence up, I don't
> > > > > > > > think
> > > > > > > > the
> > > > > > > > correct action is to automatically bump it down (as per
> > > > > > > > example
> > > > > > > > here)?
> > > > > > > > The commit doesn't describe the corner case where it was
> > > > > > > > necessary to
> > > > > > > > bump the sequence up. I wonder if we can return the
> > > > > > > > knowledge
> > > > > > > > of
> > > > > > > > the
> > > > > > > > interrupted slot and make a decision based on that as
> > > > > > > > well as
> > > > > > > > whatever
> > > > > > > > the other corner case is.
> > > > > > > >
> > > > > > > > I guess what I'm getting is, can somebody (Trond) provide
> > > > > > > > the
> > > > > > > > info
> > > > > > > > for
> > > > > > > > the corner case for this that patch was created. I can
> > > > > > > > see if
> > > > > > > > I
> > > > > > > > can
> > > > > > > > fix the "common" case which is now broken and not break
> > > > > > > > the
> > > > > > > > corner
> > > > > > > > case....
> > > > > > > >
> > > > > > >
> > > > > > > There is no pure client side solution for this problem.
> > > > > > >
> > > > > > > The change was made because if you have multiple
> > > > > > > interruptions
> > > > > > > of
> > > > > > > the
> > > > > > > RPC call, then the client has to somehow figure out what
> > > > > > > the
> > > > > > > correct
> > > > > > > slot number is. If it starts low, and then goes high, and
> > > > > > > the
> > > > > > > server is
> > > > > > > not caching the arguments for the RPC call that is in the
> > > > > > > session
> > > > > > > cache, then we will _always_ hit this bug because we will
> > > > > > > always
> > > > > > > hit
> > > > > > > the replay of the last entry.
> > > > > > >
> > > > > > > At least if we start high, and iterate by low, then we
> > > > > > > reduce
> > > > > > > the
> > > > > > > problem to being a race with the processing of the
> > > > > > > interrupted
> > > > > > > request
> > > > > > > as it is in this case.
> > > > > > >
> > > > > > > However, as I said, the real solution here has to involve
> > > > > > > the
> > > > > > > server.
> > > > > >
> > > > > > Ok I see your point that if the server cached the arguments,
> > > > > > then
> > > > > > the
> > > > > > server would tell that 2nd rpc using the same slot+seqid has
> > > > > > different
> > > > > > args and would not use the replay cache.
> > > > > >
> > > > > > However, I wonder if the client can do better. Can't we be
> > > > > > more
> > > > > > aware
> > > > > > of when we are interrupting the rpc? For instance, if we are
> > > > > > interrupted after we started to wait on the RPC, doesn't it
> > > > > > mean
> > > > > > the
> > > > > > rpc is sent on the network and since network is reliable then
> > > > > > server
> > > > > > must have consumed the seqid for that slot (in this case
> > > > > > increment
> > > > > > seqid)? That's the case that's failing now.
> > > > > >
> > > > >
> > > > > "Reliable transport" does not mean that a client knows what got
> > > > > received and processed by the server and what didn't. All the
> > > > > client
> > > > > knows is that if the connection is still up, then the TCP layer
> > > > > will
> > > > > keep retrying transmission of the request. There are plenty of
> > > > > error
> > > > > scenarios where the client gets no information back as to
> > > > > whether
> > > > > or
> > > > > not the data was received by the server (e.g. due to lost
> > > > > ACKs).
> > > > >
> > > > > Furthermore, if a RPC call is interrupted on the client, either
> > > > > due
> > > > > to
> > > > > a timeout or a signal,
> > > >
> > > > What timeout are you referring to here since 4.1 rcp can't
> > > > timeout. I
> > > > think it only leaves a signal.
> > >
> > > If you use 'soft' or 'softerr' mount options, then NFSv4.1 will
> > > time
> > > out when the server is being unresponsive. That behaviour is
> > > different
> > > to the behaviour under a signal, but has the same effect of
> > > interrupting the RPC call without us being able to know if the
> > > server
> > > received the data.
> > >
> > > > > then it almost always ends up breaking the
> > > > > connection in order to avoid corruption of the data stream (by
> > > > > interrupting the transmission before the entire RPC call has
> > > > > been
> > > > > sent). You generally have to be lucky to see the timeout/signal
> > > > > occur
> > > > > only when all the RPC calls being cancelled have exactly fit
> > > > > into
> > > > > the
> > > > > socket buffer.
> > > >
> > > > Wouldn't a retransmission (due to a connection reset for whatever
> > > > reason) be different and doesn't involve reprocessing of the
> > > > slot.
> > >
> > > I'm not talking about retransmissions here. I'm talking only about
> > > NFSv4.x RPC calls that suffer a fatal interruption (i.e. no
> > > retransmission).
> > >
> > > > > Finally, just because the server's TCP layer ACKed receipt of
> > > > > the
> > > > > RPC
> > > > > call data, that does not mean that it will process that call.
> > > > > The
> > > > > connection could break before the call is read out of the
> > > > > receiving
> > > > > socket, or the server may later decide to drop it on the floor
> > > > > and
> > > > > break the connection.
> > > > >
> > > > > IOW: the RPC protocol here is not that "reliable transport
> > > > > implies
> > > > > processing is guaranteed". It is rather that "connection is
> > > > > still
> > > > > up
> > > > > implies processing may eventually occur".
> > > >
> > > > "eventually occur" means that its process of the rpc is
> > > > guaranteed
> > > > "in
> > > > time". Again unless the client is broken, we can't have more than
> > > > an
> > > > interrupted rpc (that has nothing waiting) and the next rpc (both
> > > > of
> > > > which will be re-transmitted if connection is dropped) going to
> > > > the
> > > > server.
> > > >
> > > > Can we distinguish between interrupted due to re-transmission and
> > > > interrupted due to ctrl-c of the thread? If we can't, then I'll
> > > > stop
> > > > arguing that client can do better.
> > >
> > > There is no "interrupted due to re-transmission" case. We only
> > > retransmit NFSv4 requests if the TCP connection breaks.
> > >
> > > As far as I'm concerned, this discussion is only about
> > > interruptions
> > > that cause the RPC call to be abandoned (i.e. fatal timeouts and
> > > signals).
> > >
> > > > But right now we are left in a bad state. Client leaves opened
> > > > state
> > > > on the server and will not allow for files to be deleted. I think
> > > > in
> > > > case the "next rpc" is the write that will never be completed it
> > > > would
> > > > leave the machine in a hung state. I just don't see how can you
> > > > justify that having the current code is any better than having
> > > > the
> > > > solution that was there before.
> > >
> > > That's a general problem with allowing interruptions that is
> > > largely
> > > orthogonal to the question of which strategy we choose when
> > > resynchronising the slot numbers after an interruption has
> > > occurred.
> > >
> >
> > I'm re-reading the spec and in section 2.10.6.2 we have "A requester
> > MUST wait for a reply to a request before using the slot for another
> > request". Are we even legally using the slot when we have an
> > interrupted slot?
> >
>
> You can certainly argue that. However the fact that the spec fails to
> address the issue doesn't imply lack of need. I have workloads on my
> own systems that would cause major disruption if I did not allow them
> to time out when the server is unavailable (e.g. with memory filling up
> with dirty pages that can't be cleaned).
>
> IOW: I'm quite happy to make a best effort attempt to meet that
> requirement, by making 'hard' mounts the default, and by making
> signalling be a fatal operation. However I'm unwilling to make it
> impossible to fix up my system when the server is unresponsive just
> because the protocol is lazy about providing for that ability.

I'm just trying to think of options.

Here's what's bothering me. Yes my server list is limited but neither
Linux not Netapp servers implements argument caching for replay cache
due to performance hit. Yes perhaps they should but the problem is
they currently don't and customer probably deserve the best solution
given existing constraints. Do we have such a solution? Can you argue
that the number of problems solved by the current solution is higher
than by the other solution. With the current solution, we have
(silent) data corruption and resource leakage on the server. I think
that's a pretty big problem. What's worse silent data corruption or a
hung client because it keeps sending same ops and keeps getting
SEQ_MISORDERED (that's a rather big problem too but work arounds exist
to prevent data corruption/loss. like forcing the client to
re-negotiate the session).

Until servers catch up with addressing false retries, what's the best
solution the client can have.

Silent data corruption is in pnfs because the writes are allowed to
leave interrupted slot due to a timeout. Alternatively, I propose to
then make pnfs writes same as the normal writes. It will remove the
data corruption problem. It would still have resource leakage but that
seems like a bit better than data corruption.

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
