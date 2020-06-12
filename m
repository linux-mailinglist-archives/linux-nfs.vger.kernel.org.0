Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7ED81F78BD
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2020 15:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFLN1B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Jun 2020 09:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLN1A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Jun 2020 09:27:00 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351B4C03E96F
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2020 06:27:00 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w7so6434147edt.1
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2020 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tVY17IldfoAF2jlYXo4WKe23phsUA17lrM8dA+z1kjg=;
        b=UsJrOfixEuf4rpLjXpqO2Q7iAWVRuBotCO63ZUCjY2SGHWamXjyI+TgJFpbUKU+8U2
         iIt2spz05p9nfKBeX0r1hi/chGv1kjlEg2ODMiahf2YkYwvdPiuT4NDiVkZknnvMMm+0
         du/3gVvlZe6tYBggb0k7/qofXo1MqDe8SHzpz8asQoH+Z9ibaP/pgo01VxpOymVPXwUg
         /wkmBbFWBxPVzGswYMr//qhEugBZHQ0nWMsTFeFen9b399or9paNjN8hr5doaE1zmUXM
         MfvMRvNr2IRDJTm08JFWXI7M8KoWyaD+CVBfePlXnIXXrwLNf5A7EcLoLjL8SDgBML3I
         ytDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tVY17IldfoAF2jlYXo4WKe23phsUA17lrM8dA+z1kjg=;
        b=C/y3SfgwWsADPVOL74xhJAHirUad2CavrfQSQexHaDJQbiNP1/tZYy395AOXZa3Idj
         P0oHE+OPq6qYIdXi1JJkjQx0b7amuV58osBesNDJP4XvHxN7TfjMNBskHX/f/+3+XAdb
         v7B6lXAA1SUt3tpI7s57rM4wIZSe5b0l9HeL3fUvTOs4ATD2tFshIS3kZCYdcy8w8LRv
         aodN7kfHMByUXnYo9VQ4zpMckca9OwJbmKBiCc6uBrk0ZRR2BQangi1ekKuqP4KuwiDD
         T2M5xtm0Rz+1yENzfzcubbUfdeTSC1zBn2iMgKvGrOFo8rAn++kT2WfqeXPjL33urzKb
         qkwg==
X-Gm-Message-State: AOAM531kv/vVUW8EiaWcTwSlbG2j1H89vxlTLqpVglsrqjRPNNEM4r3p
        NtrKbjh1x76h3+oOwCZaY7c7tscgdO/JnrSN6Pk=
X-Google-Smtp-Source: ABdhPJy6IXZaLo0OAZBM69PLQC3R2RVL9k5Ys8qk+G4+UfR2Clhgu1svEk5KUqCDK82KZYhsGrIOZEtBxKOZl/0u9X4=
X-Received: by 2002:a05:6402:3092:: with SMTP id de18mr12142301edb.367.1591968418671;
 Fri, 12 Jun 2020 06:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200116190857.26026-1-olga.kornievskaia@gmail.com>
 <1f3297c1549ad12d47497cd18d2c0d9bc7bc5fe7.camel@netapp.com>
 <803ff52e7e4fd7c2b2965368f8cd203b0da28f49.camel@hammerspace.com>
 <14cad1ec0a9080ce2ac064ff9a7ae76464e09aee.camel@netapp.com> <20200611200919.GF16376@fieldses.org>
In-Reply-To: <20200611200919.GF16376@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 12 Jun 2020 09:26:47 -0400
Message-ID: <CAN-5tyFug3h+9Ck2wRfe4ALD-Pf2tzkdGh3ZCfj_zJkVuoe95g@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 11, 2020 at 4:09 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Fri, Jan 17, 2020 at 09:16:54PM +0000, Schumaker, Anna wrote:
> > On Fri, 2020-01-17 at 21:14 +0000, Trond Myklebust wrote:
> > > On Fri, 2020-01-17 at 21:09 +0000, Schumaker, Anna wrote:
> > > > Hi Olga,
> > > >
> > > > On Thu, 2020-01-16 at 14:08 -0500, Olga Kornievskaia wrote:
> > > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > >
> > > > Have you done any testing with nconnect and the v4.0 replay caches? I
> > > > did some
> > > > digging on the mailing list and found this in one of the cover
> > > > letters from
> > > > Trond: "The feature is only enabled for NFSv4.1 and NFSv4.2 for now;
> > > > I don't
> > > > feel comfortable subjecting NFSv3/v4 replay caches to this treatment
> > > > yet."
> > > >
> > >
> > > That comment should be considered obsolete. The current code works hard
> > > to ensure that we replay using the same connection (or at least the
> > > same source/dest IP+ports) so that NFSv3/v4.0 DRCs work as expected.
> > > For that reason we've had NFSv3 support since the feature was merged.
> > > The NFSv4.0 support was just forgotten.
> >
> > Thanks for the explanation! I'll add the patch.
>
> What happened to this patch?  As far as I can tell, the conclusion of
> this thread was that it should be applied.

I decided not to submit this patch but anybody else is free to add
that patch to add support for 4.0 nconnect as there is no reason it
shouldn't be supported.

>
> --b.
>
> >
> > Anna
> >
> > >
> > > > Thanks,
> > > > Anna
> > > >
> > > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > ---
> > > > >  fs/nfs/nfs4client.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> > > > > index 460d625..4df3fb0 100644
> > > > > --- a/fs/nfs/nfs4client.c
> > > > > +++ b/fs/nfs/nfs4client.c
> > > > > @@ -881,7 +881,7 @@ static int nfs4_set_client(struct nfs_server
> > > > > *server,
> > > > >
> > > > >         if (minorversion == 0)
> > > > >                 __set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
> > > > > -       else if (proto == XPRT_TRANSPORT_TCP)
> > > > > +       if (proto == XPRT_TRANSPORT_TCP)
> > > > >                 cl_init.nconnect = nconnect;
> > > > >
> > > > >         if (server->flags & NFS_MOUNT_NORESVPORT)
> > > --
> > > Trond Myklebust
> > > Linux NFS client maintainer, Hammerspace
> > > trond.myklebust@hammerspace.com
> > >
> > >
