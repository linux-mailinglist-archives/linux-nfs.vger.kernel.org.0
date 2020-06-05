Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09E91EF8EA
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2020 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgFENYY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Jun 2020 09:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgFENYX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Jun 2020 09:24:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE6EC08C5C2
        for <linux-nfs@vger.kernel.org>; Fri,  5 Jun 2020 06:24:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g1so7448239edv.6
        for <linux-nfs@vger.kernel.org>; Fri, 05 Jun 2020 06:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipvxsaIe+knj+KAG2NI2ZaOtk+Egw3FS/G2xGknuKD0=;
        b=r6PyZqFJI3d3AB9DsyZc3SeWIQVA9m+bjbSGQcrV64yJNQTc+VNQhjT7cs/uYrlZWZ
         zIb2gCCg0rpVzf6XwmaXnQbj+TKi9Oxu3+Tbu706fEQckA5TW0F+Km4QbSL6p5b/KmQH
         LH0HxDLAc2rYQoIsQDS8bBSpv841YERrjqepeL2ICjEW0O5ZTZpqKLTapGEA2XVHjWjj
         2Rt7jhuId1pWvWBkiKk/g2tubtWbnM/3SxHzt6ZJHKf9o0NSQvgo1dCdWLl1dAdGoyhQ
         7dSe91Yv8KEqAlnnu+189yvqaWLMryD4DjFaiVAAVbdqHnf06fZuepaeFJQby5r0VaBa
         XlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipvxsaIe+knj+KAG2NI2ZaOtk+Egw3FS/G2xGknuKD0=;
        b=TP7oHwTWXDf1iqL3opOc03IUtPE1sXEP1HH+IN7niFjt+5tCJpSMrkhyIjBW+m46Bf
         wkHZQgZxvSi0PCs67qVEHfvzPaI6Ikw0+Vq4n9Y4+cF2JfJ89Zn4oyZ8t0W4cWD2pXdq
         Hiz1Taqde9oxtMOR9izXIXj93P3bQA2aHCHv6TLBVCQpGB5TpXuA0Q1ORnkNhcyOnSL8
         dPp2YP4pJSCgGcAUUe6jl4AkA4CABQGb1No476ByXap6lpYB6zOZC8muEHRt2rWATuXf
         gUdUNBFmrz/zm2RGh1MfyZjxCOSEDeNjNfSsRxOXXtSuROcbk3yxttrZQBqJbSG2US29
         wYfw==
X-Gm-Message-State: AOAM530avICTkroG/ibShgrGADzA/mWGXnt968RWyevSH/Ft3P26XnYW
        9Qp5FL4P1vB7Dzy5Hy3XlrPb8aIIqO2oOZRG+Bg=
X-Google-Smtp-Source: ABdhPJx08iDAlSIHBWHPKEcTqbYt3f2rzNqOoV95hsOgDtg/1voq4k1sucLq4A191DPy8j89Oe8y8q9m1MVr9xQWbiA=
X-Received: by 2002:a05:6402:3ca:: with SMTP id t10mr9590666edw.128.1591363461790;
 Fri, 05 Jun 2020 06:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyFCotATeYVR0J1B_UaxhXYBDhp21LbFEzZtLYmgN_i+hg@mail.gmail.com>
 <13bed646-39b7-197e-ff90-85f8af10d93c@talpey.com>
In-Reply-To: <13bed646-39b7-197e-ff90-85f8af10d93c@talpey.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 5 Jun 2020 09:24:11 -0400
Message-ID: <CAN-5tyFdof2MxKn5wG6k3eJRjNKJeC1VvQ4qOYC-ByYfnoUWPg@mail.gmail.com>
Subject: Re: once again problems with interrupted slots
To:     Tom Talpey <tom@talpey.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 5, 2020 at 8:06 AM Tom Talpey <tom@talpey.com> wrote:
>
> On 6/4/2020 5:21 PM, Olga Kornievskaia wrote:
> > Hi Trond,
> >
> > There is a problem with interrupted slots (yet again).
> >
> > We send an operation to the server and it gets interrupted by the a signal.
> >
> > We used to send a sole SEQUENCE to remove the problem of having real
> > operation get an out of the cache reply and failing. Now we are not
> > doing it again (since 3453d5708 NFSv4.1: Avoid false retries when RPC
> > calls are interrupted"). So the problem is
> >
> > We bump the sequence on the next use of the slot, and get SEQ_MISORDERED.
>
> Misordered? It sounds like the client isn't managing the sequence
> number, or perhaps the server never saw the original request, and
> is being overly strict.

Well, both the client and the server are acting appropriately.  I'm
not arguing against bumping the sequence. Client sent say REMOVE with
slot=1 seq=5 which got interrupted. So client doesn't know in what
state the slot is left. So it sends the next operation say READ with
slot=1 seq=6. Server acts appropriately too, as it's version of the
slot has seq=4, this request with seq=6 gets SEQ_MISORDERED.

> > We decrement the number back to the interrupted operation. This gets
> > us a reply out of the cache. We again fail with REMOTE EIO error.
>
> Ew. The client *decrements* the sequence?

Yes, as client then decides that server never received seq=5 operation
so it re-sends with seq=5. But in reality seq=5 operation also reached
the server so it has 2 requests REMOVE/READ both with seq=5 for
slot=1. This leads to READ failing with some error.

We used to before send a sole SEQUENCE when we have an interrupted
slot to sync up the seq numbers. But commit 3453d5708 changed that and
I would like to understand why. As I think we need to go back to
sending sole SEQUENCE.

> Tom.
>
> > Going back to the commit's message. I don't see the logic that the
> > server can't tell if this is a new call or the old one. We used to
> > send a lone SEQUENCE as a way to protect reuse of slot by a normal
> > operation. An interrupted slot couldn't have been another SEQUENCE. So
> > I don't see how the server can't tell a difference between SEQUENCE
> > and any other operations.
> >
> >
