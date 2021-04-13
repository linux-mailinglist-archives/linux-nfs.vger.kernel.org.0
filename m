Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695D935E4D0
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 19:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbhDMRSC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 13:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhDMRSB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Apr 2021 13:18:01 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67828C061574
        for <linux-nfs@vger.kernel.org>; Tue, 13 Apr 2021 10:17:41 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7AA15724B; Tue, 13 Apr 2021 13:17:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7AA15724B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1618334258;
        bh=pvj1MiYVcoxW49YheB9K1hT6BXvqv1CCqRrAJYEDk14=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=X11mhwSXEUDvhY+uin2KJVkVuapBRRnbRTg+iA1owNpiV9d/5Cf6Z0jskiWY31Nk8
         LKAwnzSfb6/pu9iqpyMjxI18jwv4AEmKrL0IOXqCHY7x7Cn3SImuEfuSKtDg240p7e
         T/dNpslhpoxSA2/3OgptZT00t2N6cT5ra3Dsqw1Q=
Date:   Tue, 13 Apr 2021 13:17:38 -0400
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Rick Macklem <rmacklem@uoguelph.ca>,
        Linux-NFS <linux-nfs@vger.kernel.org>
Subject: Re: Linux NFSv4.1 client session seqid sometimes advances by 2
Message-ID: <20210413171738.GA28230@fieldses.org>
References: <YQXPR0101MB0968E44CE6FB05F22DE27716DD709@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
 <CAN-5tyEWwAtBG41VByps+zS6Sw_z9U7Q8HZb84SqyXp4woUiPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyEWwAtBG41VByps+zS6Sw_z9U7Q8HZb84SqyXp4woUiPA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 13, 2021 at 09:31:37AM -0400, Olga Kornievskaia wrote:
> On Tue, Apr 13, 2021 at 3:08 AM Rick Macklem <rmacklem@uoguelph.ca> wrote:
> >
> > Hi,
> >
> > During testing of a Fedora Core 30 (5.2.10 kernel) against a FreeBSD
> > server (4.1 mount), I have been simulating a network partitioning
> > for a few minutes (until the TCP connection goes to SYN_SENT on
> > the Linux client).
> >
> > Sometimes, after the network partition heals, the FreeBSD server
> > replies NFS4ERR_SEQ_MISORDERED.
> > Looking at the packet trace, the seqid for the slot has advanced by
> > 2 instead of 1. An RPC request for old-seqid + 1 never seems to get
> > sent.
> > --> Since sending an RPC with "seqid + 2" but never sending one
> >        that is "seqid + 1" for a slot seems harmless, I have added an optional
> >        hack (can be turned off), to allow this case instead of replying
> >        NFS4ERR_SEQ_MISORDERED for it. The code will still reply
> >        NFS4ERR_SEQ_MISORDERED if an RPC for the slot with
> >        "old seqid + 1" in it.
> >        --> Yes, doing this hack is a violation of RFC5661, but I've
> >              done it anyhow.
> >
> > If you are interested in a packet capture with this in it:
> > fetch https://people.freebsd.org/~rmacklem/linuxtofreenfs.pcap
> > - then look at packet #1945 and #2072
> >   --> You'll see that slot #1 seqid goes from 4 to 6. There is no
> >          slot#1 seqid 5 RPC sent on the wire.
> >          (This packet capture was taken on the Linux client using
> >           tcpdump.)
> > --> Btw, the "RST battle" you'll see in the above trace between
> >        #2005 and #2068 that goes on until the FreeBSD
> >        krpc/NFS times out the connection after 6min. seems to be a recent
> >        FreeBSD TCP bug.
> >        I have reproduced this seqid advances by 2 on an older system
> >        that does not "RST battle" and allows the reconnect right away,
> >        once the network partition is healed, so it does seem to be
> >        relevant to this bug.
> >
> > Someday, I will get around to upgrading to a more recent Linux
> > kernel and will test to see if I can still reproduce this bug.
> > On 5.2.10, it is intermittent and does not occur every time I
> > do the network partitioning test.
> >
> > Mostly just fyi, rick
> 
> Hi Rick,
> 
> I think this is happening because slotid=1 had something queued up
> using seqid=5 and that was interrupted because the connection was
> RSTed. For the interrupted slot, the client would send solo SEQUENCE
> with +1 seqid.

Doesn't the client send the solo SEQUENCE with seqid 5 in that case?

--b.
