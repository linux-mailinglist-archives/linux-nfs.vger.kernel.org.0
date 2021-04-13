Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A6735E6BB
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 20:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhDMTAB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 15:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhDMTAB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Apr 2021 15:00:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CE7C061574
        for <linux-nfs@vger.kernel.org>; Tue, 13 Apr 2021 11:59:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mh2so6074363ejb.8
        for <linux-nfs@vger.kernel.org>; Tue, 13 Apr 2021 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PnT9ZM3a2xoTkIKvA1imVdCzrYJ5wLIa+QeX6qEpxI=;
        b=Z270uM0XzAp84BcK6PgBpKWKbBFn2+W9g3nq6q1YZHkPmhZTZCvBCvfb924EIv7KJt
         Y4jautmV9MbmJ0hMiXduduM5UbgcKW94MMhxEJzioInDMiPmuQ5v6wakoTpTMqpWOnqx
         Ww+xZcKL9STm5uIeu59GL9stFnjh9DzdL6AGKJQefU3vvLrn24Yv377A7QJMyx7NiORS
         erbgw3kIsXhVsRivt5GvYLEdJGtIjpkHI0aIPscxigHNws5pLJ5VWeSMlvZCUjR4rYpi
         LJwiXz9sf0MjRYX1nw4x0lRUKBgG7a/NOtGNirzYTRrJNaY3N9Jbdjwww6UPD40u6SI1
         WFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PnT9ZM3a2xoTkIKvA1imVdCzrYJ5wLIa+QeX6qEpxI=;
        b=FaSErZEz6mW6M6oonZg/gWcGexSarwdcGH+xhX0TecsMGOJm6bAGS7OPNY6mT9EAXj
         EUneA/14NkxlY71bxRWnEVT7DZxr+qXnQyJLh8+UVDZalEsJJMSvQK0ahwQ7DVcEB3hK
         WX94lLNJC7Jpv4yRpqO5f0B6qWRnGQvV5hU1VpOwtTWlTnrpTFYcbpb/Gn7ZIRkYh/mL
         7dYne9Bs8Opn4sgngstY9PYfECQ1AlofbaDvBnGZz0P4jk/jKhNXXxxz7JkTlFEBfkR0
         XLzeXitaKiEqAB72WCXljgUG1H2L4iTA90GF/sO7xBUzGjGe9Qm8SMaSp90gsLpIKj+1
         eVCQ==
X-Gm-Message-State: AOAM5318d1N5LJl/N7Qsi6q7tMEYX6rnbJilyoqA7C90XtET1+B5Y1C/
        6meQTXcimCg2Zj68eQPH9TUeXT/pqWmTc5iIlo0=
X-Google-Smtp-Source: ABdhPJzxFK9NSu3BtVcQX91eYMHYydgT659sz3EbVuKiq3UsiqrIpCqU9KCY0TjF1HaLzSTGWrm9JjgozvScVoZsJZc=
X-Received: by 2002:a17:906:804b:: with SMTP id x11mr15277409ejw.388.1618340379347;
 Tue, 13 Apr 2021 11:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <YQXPR0101MB0968E44CE6FB05F22DE27716DD709@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
 <CAN-5tyEWwAtBG41VByps+zS6Sw_z9U7Q8HZb84SqyXp4woUiPA@mail.gmail.com> <20210413171738.GA28230@fieldses.org>
In-Reply-To: <20210413171738.GA28230@fieldses.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 13 Apr 2021 14:59:27 -0400
Message-ID: <CAN-5tyF=NBaZkv-CMKdK2JGMCRQ7cO2KNPTwO5KEPFG-JO4D4g@mail.gmail.com>
Subject: Re: Linux NFSv4.1 client session seqid sometimes advances by 2
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Rick Macklem <rmacklem@uoguelph.ca>,
        Linux-NFS <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 13, 2021 at 1:17 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, Apr 13, 2021 at 09:31:37AM -0400, Olga Kornievskaia wrote:
> > On Tue, Apr 13, 2021 at 3:08 AM Rick Macklem <rmacklem@uoguelph.ca> wrote:
> > >
> > > Hi,
> > >
> > > During testing of a Fedora Core 30 (5.2.10 kernel) against a FreeBSD
> > > server (4.1 mount), I have been simulating a network partitioning
> > > for a few minutes (until the TCP connection goes to SYN_SENT on
> > > the Linux client).
> > >
> > > Sometimes, after the network partition heals, the FreeBSD server
> > > replies NFS4ERR_SEQ_MISORDERED.
> > > Looking at the packet trace, the seqid for the slot has advanced by
> > > 2 instead of 1. An RPC request for old-seqid + 1 never seems to get
> > > sent.
> > > --> Since sending an RPC with "seqid + 2" but never sending one
> > >        that is "seqid + 1" for a slot seems harmless, I have added an optional
> > >        hack (can be turned off), to allow this case instead of replying
> > >        NFS4ERR_SEQ_MISORDERED for it. The code will still reply
> > >        NFS4ERR_SEQ_MISORDERED if an RPC for the slot with
> > >        "old seqid + 1" in it.
> > >        --> Yes, doing this hack is a violation of RFC5661, but I've
> > >              done it anyhow.
> > >
> > > If you are interested in a packet capture with this in it:
> > > fetch https://people.freebsd.org/~rmacklem/linuxtofreenfs.pcap
> > > - then look at packet #1945 and #2072
> > >   --> You'll see that slot #1 seqid goes from 4 to 6. There is no
> > >          slot#1 seqid 5 RPC sent on the wire.
> > >          (This packet capture was taken on the Linux client using
> > >           tcpdump.)
> > > --> Btw, the "RST battle" you'll see in the above trace between
> > >        #2005 and #2068 that goes on until the FreeBSD
> > >        krpc/NFS times out the connection after 6min. seems to be a recent
> > >        FreeBSD TCP bug.
> > >        I have reproduced this seqid advances by 2 on an older system
> > >        that does not "RST battle" and allows the reconnect right away,
> > >        once the network partition is healed, so it does seem to be
> > >        relevant to this bug.
> > >
> > > Someday, I will get around to upgrading to a more recent Linux
> > > kernel and will test to see if I can still reproduce this bug.
> > > On 5.2.10, it is intermittent and does not occur every time I
> > > do the network partitioning test.
> > >
> > > Mostly just fyi, rick
> >
> > Hi Rick,
> >
> > I think this is happening because slotid=1 had something queued up
> > using seqid=5 and that was interrupted because the connection was
> > RSTed. For the interrupted slot, the client would send solo SEQUENCE
> > with +1 seqid.
>
> Doesn't the client send the solo SEQUENCE with seqid 5 in that case?

No it sends with seq+1 because NFS layer client doesn't know if seqid
actually was actually transmitted before the connection got caught
(and/or received by the server).

>
> --b.
