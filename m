Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 401C9162A6A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2020 17:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgBRQ1H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Feb 2020 11:27:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50323 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726486AbgBRQ1H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Feb 2020 11:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582043224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e7Gy6kyRg764t2i05x2b1pZsbO4jYcyB8CJ2Ik9JSBs=;
        b=PIr/KSqY3LyGaOe+Xqzc08SFqwOGzzY5wdNl9SZY3ECyzvbjkpbWuIC4W3DOW4PR+lIbZO
        gkWAwm0rmEans5vmHt1wjNh/8I8YqCmXMaWYcbJ2MLcH+dYL1RDZwkayMBvhMD/lTwDZHE
        QnBbRmhzAJQep+MOLtLrcabfpD7K800=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-SX1bNGiRM8iJezIbgdMjHQ-1; Tue, 18 Feb 2020 11:26:58 -0500
X-MC-Unique: SX1bNGiRM8iJezIbgdMjHQ-1
Received: by mail-qv1-f70.google.com with SMTP id j15so12670108qvp.21
        for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2020 08:26:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7Gy6kyRg764t2i05x2b1pZsbO4jYcyB8CJ2Ik9JSBs=;
        b=bH8qyDhopqqd0FWwx6ALqcwrWjc1Y5PVrKxLvo3UZgmqoUlO9K9875DfP2exazV48q
         q319XFB+5z529k/V1u3QDSV3nlQR2mcByWM0+uC9afdAIoMmRyNrHfgZ4W8ncO7uS6mH
         xOpHHbIDgFTxslkjMGKmuR99+QxT8LRwVPMJnxhTgEvMeD26TWuRC8iPXdLM3Mn/CBV6
         k6bLNSffc89b+x8YYK7pNibHn7+XE+5D7866vzCwJdmJX7p9f2Taik63oLovQ1SfrLF0
         R2OckFXxztdP7ZIx3xyZXQd0F8ineMeOXH5cWLGZOadkibKH5kjLFX+VrbeGxZ6wi6/m
         SPEg==
X-Gm-Message-State: APjAAAXEWAzVWfsZWuAFGJz3aOIS6wJ5lyREB68sBwcAg2kA5HtB4QpS
        XvkiHyb8xN2STVbMSuU+FxA4yvNY0yN1AiU/7mkWO7UIzw+3PHfCHu1qFjMkZPsrmTKomWjMT/t
        IZMWmzrnj881Qus31DyAfuE+iCtd+D9+Egq1K
X-Received: by 2002:ac8:b43:: with SMTP id m3mr17789453qti.191.1582043217545;
        Tue, 18 Feb 2020 08:26:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzw+QVozAqkV+CXAIPkY1uJwuDA5i60Q3KqgccC5+g3tDqtmOMHYTJtlnHEhyWMPhK/rMlLOyJhFeJBPI9z6D0=
X-Received: by 2002:ac8:b43:: with SMTP id m3mr17789407qti.191.1582043216895;
 Tue, 18 Feb 2020 08:26:56 -0800 (PST)
MIME-Version: 1.0
References: <CALF+zOm77MCP1QbLihn0hB65SB9JxkHEVSy8=-QgwW9H9E1Hng@mail.gmail.com>
 <d6986ea7f91e3c792792299a568ccc9f32d2945d.camel@hammerspace.com>
In-Reply-To: <d6986ea7f91e3c792792299a568ccc9f32d2945d.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 18 Feb 2020 11:26:21 -0500
Message-ID: <CALF+zOkdu26vO5HQf9U6_yt1ct78_L9W=SVP2HpvFtvMvj9P2g@mail.gmail.com>
Subject: Re: NFSv4.x behavior of 'soft' in unresponsive server cases - bounded
 time for application to wait on NFS?
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 13, 2020 at 12:16 PM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> Hi Dave,
>
> On Thu, 2020-02-13 at 09:44 -0500, David Wysochanski wrote:
> > Hi Trond,
> >
> > I'm getting up to speed on your patchset from last year titled "Fix
> > up soft mounts for NFSv4.x"
> > https://spinics.net/lists/linux-nfs/msg72467.html
> >
> > Specifically I have concerns about this patch because after it, so
> > far I cannot find any way that an application can achieve a bounded
> > wait on an NFS4 operation:
> > e4ec48d3cc61 SUNRPC: Make "no retrans timeout" soft tasks behave like
> > softconn for timeouts
> >
> > The patchset changed 'soft' semantics and I want to be sure I
> > understand this and what the intended behavior is in the case of an
> > unresponsive server.  Specifically I am investigating TCP and two
> > cases:
> > a) server is responsive at the TCP level but not at the NFS level to
> > some operations (slow IO - read or a write)
>
> This is the case that the NFSv4 protocol covers in RFC7530 Section
> 3.1.1. ("Client Retransmission Behavior") and RFC5661 Section 2.9.2.
> The behaviour we are adopting here for 'soft' is specifically designed
> to be compliant with those two sections.
>
Thank you for pointing those out.  It makes sense that retries are not allowed
from RFC7530, unless there is a disconnect.  However I do not understand
the decision to make the client wait for a time depending on external
conditions, especially since this has been the soft semantics for so long,
we have a mount option 'timeo' that is explained as a timer on an NFS
operation, and especially if 'retrans=0'.

The above and other sections also states the client may close the
connection and it does not have to wait for an indeterminate amount
of time for a reply.  I see you explain the downsides of a client
disconnecting or giving up below.  Before I respond to that, the
bottomline for me is:

1. If we can show some customers need a true 'timeo=N,retrans=0' -
i.e. a defined time before erroring out, as defined by previous soft
semantics, are you willing to revisit at least that part of the decision,
or is it not something that's possible or you're likely to do?

2. If these new 'soft' semantics are not in flux anymore, can you suggest
an update to the 'nfs' man page for 'soft', 'retrans' and 'timeo' for NFSv4?
I have some ideas of what we could say but if you have a few bullets at least
it will help define how deep to go.

> > b) server is not responsive at the TCP level (network partition)
> >
> > Primarily I am testing kernel v5.5 with 'a' since I think 'b' is
> > covered by a reset of the connection after it looks like 2 minutes.
> > I realize the NFS4 client cannot retransmit an RPC per the NFS4 RFC.
> > However, is there some way to achieve a bounded wait of say 'T' an
> > application after this patch in both of those instances, basically
> > something like "soft,retrans=0,timeo=T"?  Is there an option to force
> > a reset of the TCP connection in case 'a' after a specified time, or
> > is this impossible for some reason?  Or is the minimum timeout not
> > bounded by anything specified on the mount options but by other
> > factors such as server responsiveness to an operation (case 'a') or
> > TCP connection timeout / reset (case 'b')?
> >
> > Thanks.
>
> Yes, there is the option of closing the TCP socket on the client.
> However that breaks replay semantics on NFSv4.0 and it just forces us
> into a livelock situation in the case where the server is responsive,
> but slow/congested. This is particularly true of NFSv4.x (x>0), where
> the session semantics mean that we cannot send a new request on the
> slot before the old one has completed being processed by the server.
>
How can disconnect and reconnect then re-sending break replay?
Is it due to port re-use or something else?  If it's port re-use, that problem
has always been there as far as I understand, and with 'soft' the user
has chosen to prioritize response time over data integrity.

Can you give me a hint on how the livelock happens?  I could see that
if there was no backoff, but the original definition of 'retrans' and 'timeo'
had a back-off built into it so it's something else?

Sure you cannot re-use a slot if a request is still outstanding, but the slot is
tied up in any case.  That does not mean the requestor wants to continue to
wait for the reply.  Is there no way for the client to signal to the server
they have given up on the request? As far as sending a new request on a
slot, rfc7530#section-3.1.1 talks about the client could wait or break the
connection.  Prior to that it talks about the server "MUST NOT silently
drop ... unless the transport connection has been broken".  My read of that
is that this dropping of the connection could signal to the server that any
prior request on a slot that has not been successfully delivered to the client
may have been abandoned.  Am I reading that wrong?  Would a server continue
with a prior request under these circumstances?  It seems a little strange that
these RFCs have been there for many years but just now this change on the
client side where the wait time is less defined.

I'm more concerned about scenario 'a' because I think scenario 'b' should work,
though I'm not clear exactly we don't have some issues there with certain
complex networks.  It's just harder to say now since the timer on the client
is not honored, so we're dependent on external conditions bounding the wait.

> So yes, the new semantics are a compromise, but they are designed to
> address the situations where the server really is gone away, and are
> designed to avoid overloading the server further in situations where it
> is already congested.
>
As usual, clearly you've done a lot of work here to address many issues trying
to balance the many trade-offs.  It sounds like NFS4.x may box in the client
implementation in some instances.  I'm only raising it because my _gut_ (which
could be wrong) tells me at least some customers will care, since many will
probably only see we're taking an option away that some rely on for
responsiveness.  I'm a bit unsure how to present this other than to
point at this
thread, but maybe we at least we can clarify with a man page update the new
limitations of these mount options, if indeed we're beyond the point
of no return.

