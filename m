Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7EF3EDA8F
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Aug 2021 18:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhHPQJp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Aug 2021 12:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhHPQJp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Aug 2021 12:09:45 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F66C061764
        for <linux-nfs@vger.kernel.org>; Mon, 16 Aug 2021 09:09:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u1so4111871plr.1
        for <linux-nfs@vger.kernel.org>; Mon, 16 Aug 2021 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=znMw/hZm+PQTt0Ydgkj7YgwFT6+OuFMkvouz5LIl0vk=;
        b=bxfX2mr13hZTJJt3kJn+iWxbqYO0/RMVA3fjBBN8qG7udkBZpfgCbIGC0g8NWUoIP1
         LC3s/utl4y0oCDu5cnffT2YXg0G/y/1GTays/nsLMSs10s9izPukS4RAZUVN0OdOpM1n
         qOJzusoUsUsINiGr2l6f+rSZ4+SEBe5hM9qcVYQJY1NhSBIuWR6ccZyITbcKodKX4TKk
         mFXDyT6pHoTF1eVyKzXw64O17M5sVeipkDQaVI4OLfuOmL1SC4hPfqHFc03Hlctg+3S+
         zRKnkLiSzMFwcFA+O/lFqu2TSqOGpQNxG9ZH29T7zKX0TCmYgdXfUHsL/SScBnZWzGd7
         wf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=znMw/hZm+PQTt0Ydgkj7YgwFT6+OuFMkvouz5LIl0vk=;
        b=lqQ0kdCJ71XPF44G8dywuraansTWGcFvg7Flj6hXx5o9JTimldvEFrjB6msp4Fc8Dn
         mo0E2yn7lG5ZlZRLCesDx1HVn4ehlhaZeP3eE23C6mYpQM978FKs9E9vTxcUUyQVS+f9
         g40gbDYc//Tz+MJLK9oDUQ+YFoITmoryLbphYyAMeAI+w+9RZ99pnexTyVSAPSCD1lOi
         mDCIUl5vYDgZiArnePDYUublsdlqJD5T1pccBkacCyl9ikl8j71uCnCgwZdUdxEv8jbb
         LXFV44ucQSP8J1cEUiYkSUlrBpsG1sRGZUNN5fI8eaG+e9G5liD3s1zQGDNURHpb9UvL
         KHSg==
X-Gm-Message-State: AOAM5322NfLPFf2ZM76/TD71iqH9gtKm4vOtkGeAQOP7J2Ekour3cYii
        lVKtxU6bhLFzqkIScJ7AZjwNs2/AeLdEBPhObVI=
X-Google-Smtp-Source: ABdhPJwR2ZwndZV34yKRgyN0Qjxu/U4hWfym+Hoexm/DTOoO+SG+Z7mt8iPcIY2jmzV6MDpYTo0SUv3tvJNOpLerurU=
X-Received: by 2002:a63:25c7:: with SMTP id l190mr16507149pgl.165.1629130152943;
 Mon, 16 Aug 2021 09:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>
 <162882238416.1695.4958036322575947783@noble.neil.brown.name>
 <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>
 <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com> <162907681945.1695.10796003189432247877@noble.neil.brown.name>
In-Reply-To: <162907681945.1695.10796003189432247877@noble.neil.brown.name>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Mon, 16 Aug 2021 09:09:02 -0700
Message-ID: <CAOv1SKATcDxhnQ_TjU3pj4ZGZKa+oyv-atP--t28tSTihKXang@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Neil:

A possible insight, these captures were all made on the server, so the
rpc reply wouldn't be delayed (at least if the server is the one doing
the replying). I did the captures there because I wanted to get as
close to possible issues as I could. If it makes sense, I can try to
capture from the client side, let me know.

Filesystem being exported is BTRFS, a 6 disk array. I jumped to nfs
being the trouble because that is my visibility to the issue, but it's
certainly possible for it to be the underlying filesystem. Maybe the
nfsd traces will give insight to this.

- mike

On Sun, Aug 15, 2021 at 6:20 PM NeilBrown <neilb@suse.de> wrote:
>
> On Sun, 15 Aug 2021, Mike Javorski wrote:
> > I managed to get a cap with several discreet freezes in it, and I
> > included a chunk with 5 of them in the span of ~3000 frames. I added
> > packet comments at each frame that the tshark command reported as > 1
> > sec RPC wait. Just search for "Freeze" in (wire|t)shark in packet
> > details. This is with kernel 5.13.10 provided by Arch (See
> > https://github.com/archlinux/linux/compare/a37da2be8e6c85...v5.13.10-arch1
> > for diff vs mainline, nothing NFS/RPC related I can identify).
> >
> > I tried unsuccessfully to get any failures with the 5.12.15 kernel.
> >
> > https://drive.google.com/file/d/1T42iX9xCdF9Oe4f7JXsnWqD8oJPrpMqV/view?usp=sharing
> >
> > File should be downloadable anonymously.
>
> Got it, thanks.
>
> There are 3 RPC replies that are more than 1 second after the request.
> The replies are in frames 983, 1005, 1777 These roughly correspond to
> where you added the "Freeze" annotation (I didn't know you could do that!).
>
> 983:
>   This is the (Start of the) reply to a READ Request in frame 980.
>   It is a 128K read.  The whole reply has arrived by frame 1004, 2ms
>   later.
>   The request (Frame 980) is followed 13ms later by a TCP retransmit
>   of the request and the (20usec later) a TCP ACK from the server.
>
>   The fact that the client needed to retransmit seems a little odd
>   but as it is the only retransmit in the whole capture, I don't think
>   we can read much into it.
>
> 1005:
>   This is the reply to a 128K READ request in frame 793 - earlier than
>   previous one.
>   So there were two READ requests, then a 2 second delay then both
>   replies in reverse order.
>
> 1777:
>   This is a similar READ reply - to 1761.
>   There were READs in 1760, 1761, and 1775
>   1760 is replied to almost immediately
>   1761 gets a reply in 4 seconds (1777)
>   1775 never gets a reply (in the available packet capture).
>
> Looking at other delays ... most READs get a reply in under a millisec.
> There are about 20 where the reply is more than 1ms - the longest delay
> not already mentioned is 90ms with reply 1857.
> The pattern here is
>    READ req (1)
>    GETATTR req
>    GETATTR reply
>    READ req (2)
>    READ reply (1)
>   pause
>    READ reply (2)
>
> I suspect this is the same problem occurring, but it isn't so
> noticeable.
>
> My first thought was that the reply might be getting stuck in the TCP
> transmit queue on the server, but checking the TSval in the TCP
> timestamp option shows that - for frame 983 which shows a 2second delay
> - the TSval is also 2seconds later than the previous packet.  So the
> delay happens before the TCP-level decision to create the packet.
>
> So I cannot see any real evidence to suggest a TCP-level problem.
> The time of 2 or 4 seconds - and maybe even 90ms - seem unlikely to be
> caused by an NFSd problem.
>
> So my guess is that the delay comes from the filesystem.  Maybe.
> What filesystem are you exporting?
>
> How can we check this? Probably by turning on nfsd tracing.
> There are a bunch of tracepoints that related to reading:
>
>         trace_nfsd_read_start
>         trace_nfsd_read_done
>         trace_nfsd_read_io_done
>         trace_nfsd_read_err
>         trace_nfsd_read_splice
>         trace_nfsd_read_vector
>         trace_nfsd_read_start
>         trace_nfsd_read_done
>
> Maybe enabling them might be useful as you should be able to see if the
> delay was within one read request, or between two read requests.
> But I don't have much (if any) experience in enabling trace points.  I
> really should try that some day.  Maybe you can find guidance on using
> these tracepoint somewhere ... or maybe you already know how :-)
>
> NeilBrown
