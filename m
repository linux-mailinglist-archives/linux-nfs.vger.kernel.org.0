Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802581EFC84
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2020 17:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgFEPap (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Jun 2020 11:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgFEPan (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Jun 2020 11:30:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E811C08C5C2
        for <linux-nfs@vger.kernel.org>; Fri,  5 Jun 2020 08:30:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id x1so10537595ejd.8
        for <linux-nfs@vger.kernel.org>; Fri, 05 Jun 2020 08:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DtVk4v6if7a0DmcWxY8lkRce1Psz5gIIzdrWjLY5SY4=;
        b=DZp3lq3zIpXQvHvvdcXzVk7qz1/GAJGIIhmaA/IYQVQ8v821mCvKALm+BeS1t0aM45
         np3aJjjk/h2eaxLm3X8E7OXBXj7yOEHBkGSFlzotRWAOF/K+L0RKTHrPXXHvUymzoe8h
         2wGimOhu6I2XEs4E4klqcQ4bNxCZAQxReDq/0ca+cR4OT5vYK3bXXWKW/m3bPrx3xB+i
         v5FGzzN8WOHJt1lxRjwk7LbLlDJmtHlI8aicRvYMWg6upkHdQk3iha24E7yK13+8N+UP
         bGNOsOXOnk7HQovtOxToZuZv5kkep3CNeQJpsw+8Pf70JxXpDqM26ZNJrXbO5kCVyXj4
         QNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DtVk4v6if7a0DmcWxY8lkRce1Psz5gIIzdrWjLY5SY4=;
        b=ijxbn1YtQ7ShYFlmW71RKl2XBlJ0zDP7O92mwMSXRi1O7+0oH0U/mS/mYiZPOhfH/3
         zScYRiJ2r1tIJZFHwd28HMUvZYB0jKOOF0J5kfLG46Y47I+VayFaXmgJrJEkkDclbA9P
         YBgYHT5DedruIf+FPbA2en2eAyQRMKqjbldpMcNbvckUwdpftKrqca8vSk9JbzkTSvkA
         IGt3maq41H1To/fXVMXwSUven6h/56/ZYUc/qHhO/hpA6/b6jOZpZD2dykYCnDYveW50
         M3Z6uRhVqrmel7JB0hBvnDWqxt1xkO56+grv+3bPoWxSC24EZKD8FNK5Nz+DopdtuP3E
         Gx0Q==
X-Gm-Message-State: AOAM531d5Okm1wTPPhS/idk1EwcbWhB9lIjBK/TOo8oQChNC7vIiuWXB
        yXFgVqkpHyBnJSX7dwNPxCOeFAh06o0SyT+Q7gm8KQ==
X-Google-Smtp-Source: ABdhPJzo17UTVl2EaMYXl2ujYels0oPF+2zr5IjvOSl4/UzcJ0FdqY2rhdr4cgRAH5eVPMNttKqKitJgKt09uPBsM/E=
X-Received: by 2002:a17:906:fac8:: with SMTP id lu8mr9027559ejb.432.1591371040850;
 Fri, 05 Jun 2020 08:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyFCotATeYVR0J1B_UaxhXYBDhp21LbFEzZtLYmgN_i+hg@mail.gmail.com>
 <13bed646-39b7-197e-ff90-85f8af10d93c@talpey.com> <CAN-5tyFdof2MxKn5wG6k3eJRjNKJeC1VvQ4qOYC-ByYfnoUWPg@mail.gmail.com>
 <ce227f0a-c97a-2bd9-7321-1193e5fc56b4@talpey.com>
In-Reply-To: <ce227f0a-c97a-2bd9-7321-1193e5fc56b4@talpey.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 5 Jun 2020 11:30:29 -0400
Message-ID: <CAN-5tyE=0+nvGZtoN-C-1a3guju_TjsAq701AG_Y=TjxQ3iqqg@mail.gmail.com>
Subject: Re: once again problems with interrupted slots
To:     Tom Talpey <tom@talpey.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 5, 2020 at 9:49 AM Tom Talpey <tom@talpey.com> wrote:
>
> On 6/5/2020 9:24 AM, Olga Kornievskaia wrote:
> > On Fri, Jun 5, 2020 at 8:06 AM Tom Talpey <tom@talpey.com> wrote:
> >>
> >> On 6/4/2020 5:21 PM, Olga Kornievskaia wrote:
> >>> Hi Trond,
> >>>
> >>> There is a problem with interrupted slots (yet again).
> >>>
> >>> We send an operation to the server and it gets interrupted by the a signal.
> >>>
> >>> We used to send a sole SEQUENCE to remove the problem of having real
> >>> operation get an out of the cache reply and failing. Now we are not
> >>> doing it again (since 3453d5708 NFSv4.1: Avoid false retries when RPC
> >>> calls are interrupted"). So the problem is
> >>>
> >>> We bump the sequence on the next use of the slot, and get SEQ_MISORDERED.
> >>
> >> Misordered? It sounds like the client isn't managing the sequence
> >> number, or perhaps the server never saw the original request, and
> >> is being overly strict.
> >
> > Well, both the client and the server are acting appropriately.  I'm
> > not arguing against bumping the sequence. Client sent say REMOVE with
> > slot=1 seq=5 which got interrupted. So client doesn't know in what
> > state the slot is left. So it sends the next operation say READ with
> > slot=1 seq=6. Server acts appropriately too, as it's version of the
> > slot has seq=4, this request with seq=6 gets SEQ_MISORDERED.
>
> Wait, if the client sent slot=1 seq=5, then unless the connection
> breaks, that slot is at seq=5, simple as that. If the operation was
> interrupted before sending the request, then the sequence should
> not be bumped.

Connection doesn't drop. We tried not bumping the sequence (i think
that was probably how it was originally done). Then you still get into
the same problem right away. REMOVE and READ will be using seq=5.

> >>> We decrement the number back to the interrupted operation. This gets
> >>> us a reply out of the cache. We again fail with REMOTE EIO error.
> >>
> >> Ew. The client *decrements* the sequence?
> >
> > Yes, as client then decides that server never received seq=5 operation
> > so it re-sends with seq=5. But in reality seq=5 operation also reached
> > the server so it has 2 requests REMOVE/READ both with seq=5 for
> > slot=1. This leads to READ failing with some error.
>
> But if the connection didn't break, it's reliable therefore the "resend"
> must not be performed. This is a new operation, not a retry. It cannot
> use the same slot+seq pair. And decrementing the slot is even sillier,
> it's reusing *two* seq's at that point.

When the slot gets interrupted we don't know when the interruption
happened. If we got SEQ_MISORDERED, it might be because interruption
happened before the request was ever sent to the server, so it's valid
for the seq to stay the same (ie decrementing the seq). I don't see
how decrementing the seq is reusing 2 seq values: only one value is
valid and client is trying to figure out which one.

> > We used to before send a sole SEQUENCE when we have an interrupted
> > slot to sync up the seq numbers. But commit 3453d5708 changed that and
> > I would like to understand why. As I think we need to go back to
> > sending sole SEQUENCE.
>
> Sounds like a hack, frankly. What if the server responds the same
> way? The client will start burning the wire.

Sending the SEQUENCE on the same slot/seqid as an interrupted slot
doesn't lead to any operation failing.

> Closing the connection, or never using that slot again, seems to
> me the only correct option, given the other behavior described.

Not ever using an interrupted slot seems too drastic (we can end up
with a session where all slots are unusable. or losing slots also
means losing ability to send more requests in parallel). I thought
that's given a sequence of events and error codes we should be able to
re-sync the slot.

>
> Tom.
>
>
> >>> Going back to the commit's message. I don't see the logic that the
> >>> server can't tell if this is a new call or the old one. We used to
> >>> send a lone SEQUENCE as a way to protect reuse of slot by a normal
> >>> operation. An interrupted slot couldn't have been another SEQUENCE. So
> >>> I don't see how the server can't tell a difference between SEQUENCE
> >>> and any other operations.
> >>>
> >>>
> >
> >
