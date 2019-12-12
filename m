Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8433B11D4FD
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Dec 2019 19:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfLLSOD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Dec 2019 13:14:03 -0500
Received: from mail-vs1-f45.google.com ([209.85.217.45]:45664 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730080AbfLLSOD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Dec 2019 13:14:03 -0500
Received: by mail-vs1-f45.google.com with SMTP id l24so2210031vsr.12
        for <linux-nfs@vger.kernel.org>; Thu, 12 Dec 2019 10:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owHRP4mLOSvGJ90z613PfpKSOLZmnx/czAEbiKDwBv8=;
        b=f53Ixxwb/N7qeZ4csHxMvI3Bt8hHfvCINB4XjQVdrVq0Vs8kkZqvjhpkcZya3/rvZn
         ExHhDsb4V8GmEI1BySBzP3SgyLo9w7Rfhw8ADFXjB2479FnT3vrKzKtfjIWBShy1fpkI
         PNjos7VG8sPg32mO+deu7/LydR7rhmt/932tmV+2eUWvoaABrx71BbLDKrbbdfZgoTCv
         YItQvarC3DUQOJKzdanesq0XnlvREK/cOG9JwIdPSWmgs88hXkCcSq4edMgzIPElQh7a
         4LdTe/sloSkiXRtKzjilltIyKeFy9QRYJ7CO/Cg9Y5MCh4d6//iONQSss0XLgwvHiI77
         pHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owHRP4mLOSvGJ90z613PfpKSOLZmnx/czAEbiKDwBv8=;
        b=iqwAU6a3QcjN1DfIQKdNwfZOD5/GycbLayXMJVL++zck4BeKiGrIvZyv62C5lLQC2k
         r5p89rueypJaeqCiwFn1TfRcSRxdZ3ZqWxD9VxBpQ4lsOVqc3rfXJUlYOKxVtMk3QBK+
         pSyW0j3Qt/s08ZRrRbW2TKJ1iaSiQqNfwWqLlk4ekc3lElEjUmZJnF13IguiuxmhHHGx
         OV9XNg8rWc6BXqj+MeSLloQAZNxN9I7HOHYrzT9bBxU5YPmROofiAPzgLgFXxgmuriS8
         chKZ+bO2erYBTJ7C2lO1dmAcaL1vqBNjVtFKZU5NzRsC5oOBQACzf6QgTUFn2qmN9u31
         Em6A==
X-Gm-Message-State: APjAAAXUxdDO6KuYYajeyrCpWJGBmBunTttIeFQ1tvKF50mndvI8wmrm
        MPjI+41dkAGzVc2WbvEEFk7bJT095ovfSpFJrmHDvg==
X-Google-Smtp-Source: APXvYqy8CnEaAnBZI3vdEl/BGup1pOBvJBGA+aetRUBiN2QgwxpxA6PXSC1OUTGmgk2YRaImCL46h32FotXW9ESYLsw=
X-Received: by 2002:a67:f055:: with SMTP id q21mr8227920vsm.215.1576174442160;
 Thu, 12 Dec 2019 10:14:02 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyH_+OZJ+eUGvqvo+-EuG1OdaoFYERNKi=k=CDxpOFVoCQ@mail.gmail.com>
 <e2541b5d08b823aaec01195178e87ba39526aa92.camel@hammerspace.com>
 <CAN-5tyFVb_jqt+jknn2+o6_Cu=7cKw4qt9B_e2pd0azu2-7zaQ@mail.gmail.com>
 <CAN-5tyHm+aG9GmM1EWFDLeKfLxJWvGSGbRP5QwN4=phwaNQkyQ@mail.gmail.com> <b90ab1ae883db0109e3a0b390fa5cc599268819c.camel@hammerspace.com>
In-Reply-To: <b90ab1ae883db0109e3a0b390fa5cc599268819c.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 12 Dec 2019 13:13:50 -0500
Message-ID: <CAN-5tyGi3PzoV4YwBiQyPZ=8njCe8bBfS5baverQvbch7LJQpw@mail.gmail.com>
Subject: Re: NFS/TCP timeouts
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 12, 2019 at 11:47 AM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> Hi Olga,
>
> On Wed, 2019-12-11 at 15:36 -0500, Olga Kornievskaia wrote:
> > Hi Trond,
> >
> > I'd like to raise this once again. Is this true that setting a
> > timeout
> > limit (TCP_USER_TIMEOUT) is not user configurable (rather I'm pretty
> > sure it is not) but my question is why shouldn't it be tied to the
> > "timeo" mount option? Right now, only the sesson/lease manager thread
> > sets it via rpc_set_connect_timeout() to be lease period related.
> >
> > Is it the fact that we don't want to allow user to control TCP
> > settings via the mount options? But somehow folks are expecting to be
> > able to set low "timeo" value and have the (dead) connection to be
> > considered dead earlier than for a rather long timeout period which
> > is
> > happening now.
>
> In my mind, the two are correlated, but are not equivalent.
>
> The 'timeo' value is basically a timeout for how long it takes for the
> whole process of "send RPC call", "have it processed by the server" and
> "receive reply".
> IOW: 'timeo' is about how long it takes for an RPC call to execute end-
> to-end.

Ok, but what happens is there are no actions (connection wise) are
taken when this timeout goes off and that' a problem for detecting bad
connections.

> The TCP_USER_TIMEOUT, is essentially a timeout for how long it takes
> the server to ACK receipt of the RPC call once we've placed it in the
> TCP socket.
> IOW: it is a timeout for the networking part of an RPC call
> transmission.

But why isn't TCP time out (1) not user configurable and/or (2) not
tied to the "timeo" ?

> So, as I said, the two are correlated: if the server is down, then your
> timeout is dominated by the fact that the network transmission never
> completes. However if the server is up and congested, then the
> "processing by the server" is likely to dominate.
>
> The other thing to note is that if the TCP connection is unresponsive,
> we may want to fail that much faster in order to give ourselves a
> chance to close the connection, open a new one and retransmit the
> requests from the old connection before the 'timeo' is triggered (since
> in the case of a soft timeout, that could be a fatal error).

"we may want to fail" doesn't happen and that's exactly what I would
like to happen. Also, TCP timeout is set to the a lease time (let's
take linux server which sets 90s timeout) and that's larger than the
default "timeo" which is 60s. That goes against your intention to
recover in time.

> Does that make sense?

It's the last case I'm interested in. The issue I'm having is that
after a "timeout" (which should be a lease period), the client doesn't
sent a SYN trying to establish a new connection.
-
Here's a current problem. In the cloud environment, a server node goes
down. It's spun up again in a different VM (but with the same IP) and
server is ready to be receiving requests and continue with the IO. The
problem is the client doesn't try to send a new SYN until the old
connection timeout. This timeout is 3mins for v3 and can't be shorted
because TCP_USER_TIMEOUT isn't user configurable or tied into the
timeo. But user expects that connections times out after 60s (as
default timeo) (or whatever value timeo is specified during mount).
Current linux client doesn't do that.

Even in v4, in my testing ,the client doesn't send the new SYN after
the lease period (but I believe that's a bug). The only time it does
do it if I change rpc_set_connect_time() to something low so that
default of 18000 is set.

(1) I could be wrong but I think there is a bug that doesn't
re-establish connection (unless some low value is set).
(2) I think there should be ability (at least for v3) to set the
timeout for lower than 3mins. Perhaps we can add a new mount option,
either have a totally separate tcp timeout value or something like
"sync_nfstcp_timeouts" and use timeo to govern both NFS and TCP
timeout.


>
> >
> > Thanks.
> >
> > On Wed, Oct 3, 2018 at 3:06 PM Olga Kornievskaia <aglo@umich.edu>
> > wrote:
> > > On Wed, Oct 3, 2018 at 2:45 PM Trond Myklebust <
> > > trondmy@hammerspace.com> wrote:
> > > > On Wed, 2018-10-03 at 14:31 -0400, Olga Kornievskaia wrote:
> > > > > Hi folks,
> > > > >
> > > > > Is it true that NFS mount option "timeo" has nothing to do with
> > > > > the
> > > > > socket's setting of the user-specified timeout
> > > > > TCP_USER_TIMEOUT.
> > > > > Instead, when creating a TCP socket NFS uses either
> > > > > default/hard
> > > > > coded
> > > > > value of 60s for v3 or for v4.x it's lease based. Is there no
> > > > > value
> > > > > is
> > > > > having an adjustable TCP timeout value?
> > > > >
> > > >
> > > > It is adjusted. Please see the calculation in
> > > > xs_tcp_set_socket_timeouts().
> > >
> > > but it's not user configurable, is it? I don't see a way to modify
> > > v3's default 60s TCP timeout. and also in v4, the timeouts are set
> > > from xs_tcp_set_connect_timeout() for the lease period but again
> > > not
> > > user configurable, as far as i can tell.
> > >
> > > > --
> > > > Trond Myklebust
> > > > Linux NFS client maintainer, Hammerspace
> > > > trond.myklebust@hammerspace.com
> > > >
> > > >
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
