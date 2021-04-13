Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2FE35E7D6
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 22:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbhDMUww (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 16:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhDMUwu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Apr 2021 16:52:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88247C061574
        for <linux-nfs@vger.kernel.org>; Tue, 13 Apr 2021 13:52:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u21so28066093ejo.13
        for <linux-nfs@vger.kernel.org>; Tue, 13 Apr 2021 13:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPU2CfqjCeWWuPm92kUe/3s1c7eIrvRyHZCn4b8ad8I=;
        b=aE69idjAUrI0j5DeegUzJyv52Wy94GD4kZ6biBTKPYl1H7+ghaN4AYXoq6ma7EDAKq
         aYjOCw2YT3y7QS9WSdbiwqxk6Vl+aVFaZ8k5pHnpwzQbBoqLzT5CN9uBrGdOFA56Qrpd
         fSBalLJq/xKgU6wPVlrTrXOA46JfF0NIDJQeLngdN5L9RsoNysTK/079Y23R0Q9OJM34
         FOsH7z+2Xjl2XHHRXieY75CpeV5V7sIYoc6+cMjLL43Y9X4w0Kp9OOmRU6u5VjHa1WH7
         ztIPEvpi6gcHaYb8Dxcg1nIgOLW4sbLUndRuftGLbAwEs/ePP5/XR7mteWoG0wfnyO1y
         lkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPU2CfqjCeWWuPm92kUe/3s1c7eIrvRyHZCn4b8ad8I=;
        b=VB2xafYgBs/f/t6KesXpdeQ7AcB6OaqHwuDBrfcvBT4Xx2ZQAgYvu5bgDq5RX/v+LS
         UdoZK/Q75GWoDJ04b9EmE01uyiQF2Pq7cm6eO5Qqi/kvWfqMLfe/U7+lB3R9s9Pn8/wq
         b9g1B0Oy3ibMMLX6jD4OCQtR9IjyhQnjKzoEHZyn0Atvi5EHlj6GpVZSZ2ob6rlg1CiO
         xGaUIeqQvzGPIxRSy11R92tqldsnmHCFCcLhD8VzbTaUf0qVPf43XMpnni1SC/Z0D69g
         6x1Hgf8keWC0+iY3LDXIspGxbQ17SB8PtPCuV2cjwyfD0UFGS1yGzcP4SnsCYojpB7Nk
         /lAQ==
X-Gm-Message-State: AOAM531Ooyy24RHWsTGF9Di+7PS9Ps6WoiI4DSWFn+Uu8Q9P38nX5p+n
        DGhYyiADmKOOKSWZLE2c0eu3QYIKkU1DsjYZg+kzr+8C
X-Google-Smtp-Source: ABdhPJzJbYvcrV7yoavnACdXUOOoFZ+geZLegL6c6lK/Vtgdm7DRlGs/UCIEgQbJ+45eGXkSjuJ7a8iqLimGn9oute0=
X-Received: by 2002:a17:907:62a7:: with SMTP id nd39mr34593523ejc.510.1618347146195;
 Tue, 13 Apr 2021 13:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <YQXPR0101MB0968E44CE6FB05F22DE27716DD709@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
 <CAN-5tyEWwAtBG41VByps+zS6Sw_z9U7Q8HZb84SqyXp4woUiPA@mail.gmail.com>
 <20210413171738.GA28230@fieldses.org> <CAN-5tyF=NBaZkv-CMKdK2JGMCRQ7cO2KNPTwO5KEPFG-JO4D4g@mail.gmail.com>
 <20210413192908.GD28230@fieldses.org>
In-Reply-To: <20210413192908.GD28230@fieldses.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 13 Apr 2021 16:52:14 -0400
Message-ID: <CAN-5tyEWVk9zH-aRJ7FSS5=nTLtVqfqFO9JEjQnp5PnCtmn=aQ@mail.gmail.com>
Subject: Re: Linux NFSv4.1 client session seqid sometimes advances by 2
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Rick Macklem <rmacklem@uoguelph.ca>,
        Linux-NFS <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 13, 2021 at 3:29 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, Apr 13, 2021 at 02:59:27PM -0400, Olga Kornievskaia wrote:
> > On Tue, Apr 13, 2021 at 1:17 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > On Tue, Apr 13, 2021 at 09:31:37AM -0400, Olga Kornievskaia wrote:
> > > > On Tue, Apr 13, 2021 at 3:08 AM Rick Macklem <rmacklem@uoguelph.ca> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > During testing of a Fedora Core 30 (5.2.10 kernel) against a FreeBSD
> > > > > server (4.1 mount), I have been simulating a network partitioning
> > > > > for a few minutes (until the TCP connection goes to SYN_SENT on
> > > > > the Linux client).
> > > > >
> > > > > Sometimes, after the network partition heals, the FreeBSD server
> > > > > replies NFS4ERR_SEQ_MISORDERED.
> > > > > Looking at the packet trace, the seqid for the slot has advanced by
> > > > > 2 instead of 1. An RPC request for old-seqid + 1 never seems to get
> > > > > sent.
> > > > > --> Since sending an RPC with "seqid + 2" but never sending one
> > > > >        that is "seqid + 1" for a slot seems harmless, I have added an optional
> > > > >        hack (can be turned off), to allow this case instead of replying
> > > > >        NFS4ERR_SEQ_MISORDERED for it. The code will still reply
> > > > >        NFS4ERR_SEQ_MISORDERED if an RPC for the slot with
> > > > >        "old seqid + 1" in it.
> > > > >        --> Yes, doing this hack is a violation of RFC5661, but I've
> > > > >              done it anyhow.
> > > > >
> > > > > If you are interested in a packet capture with this in it:
> > > > > fetch https://people.freebsd.org/~rmacklem/linuxtofreenfs.pcap
> > > > > - then look at packet #1945 and #2072
> > > > >   --> You'll see that slot #1 seqid goes from 4 to 6. There is no
> > > > >          slot#1 seqid 5 RPC sent on the wire.
> > > > >          (This packet capture was taken on the Linux client using
> > > > >           tcpdump.)
> > > > > --> Btw, the "RST battle" you'll see in the above trace between
> > > > >        #2005 and #2068 that goes on until the FreeBSD
> > > > >        krpc/NFS times out the connection after 6min. seems to be a recent
> > > > >        FreeBSD TCP bug.
> > > > >        I have reproduced this seqid advances by 2 on an older system
> > > > >        that does not "RST battle" and allows the reconnect right away,
> > > > >        once the network partition is healed, so it does seem to be
> > > > >        relevant to this bug.
> > > > >
> > > > > Someday, I will get around to upgrading to a more recent Linux
> > > > > kernel and will test to see if I can still reproduce this bug.
> > > > > On 5.2.10, it is intermittent and does not occur every time I
> > > > > do the network partitioning test.
> > > > >
> > > > > Mostly just fyi, rick
> > > >
> > > > Hi Rick,
> > > >
> > > > I think this is happening because slotid=1 had something queued up
> > > > using seqid=5 and that was interrupted because the connection was
> > > > RSTed. For the interrupted slot, the client would send solo SEQUENCE
> > > > with +1 seqid.
> > >
> > > Doesn't the client send the solo SEQUENCE with seqid 5 in that case?
> >
> > No it sends with seq+1 because NFS layer client doesn't know if seqid
> > actually was actually transmitted before the connection got caught
> > (and/or received by the server).
>
> But then the MISORDERED tells the client it wasn't received, so the
> client follows up with a call with seqid 5--is that what happens?

Correct. If there were no error then the server did indeed consume
seqid. And if an error was returned then the client knows to
decrement.

> Sorry, I seem to recall we went through this all a couple years ago, but
> now I've forgotten how it works.
>
> --b.
