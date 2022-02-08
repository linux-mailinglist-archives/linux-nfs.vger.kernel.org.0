Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BA94AE170
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 19:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385506AbiBHSta (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 13:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385498AbiBHSt1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 13:49:27 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650A5C0612C0
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 10:49:26 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m4so316376ejb.9
        for <linux-nfs@vger.kernel.org>; Tue, 08 Feb 2022 10:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s14TajN291sD1YxLCHXolCM3fi20R+bTdbrd5rqKyF4=;
        b=iyXGzXfoL0JpbP06eJjrzryVUDtWOks4c6WGlA8VSZcxeOXh7EesROhmVgp1lKsh2X
         mLox0sePMLEpyXiekeIfMzM8egoDhr06QlgjddtPCaHVfk6DqmlfeAR12wQH8EfLn4Yt
         bu42AzJrVCkkJFvbbBpzBu1vJoEgayO/7U328R+67QSbMIPpWN+x3LqaoIJGLpX3Qgan
         sjSs0VnL/uFjRvAYboGJpGfRtxpZHb0YyqY+2iy3k9K7QRh6/UEkz687lpDyExHxb/Ns
         3bYFI478zKOA2aWe3y1b38xepMzJs5bWiB/NTxnAlp3cpUb/2OVBIJDtkF0IyRJvfmr8
         i4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s14TajN291sD1YxLCHXolCM3fi20R+bTdbrd5rqKyF4=;
        b=Va9LKAYdowDbk8XWTPsUT0x0gLEneOKtBLMk6vtwTKT3Q4Zns/yzGbTNbmLV2Jb34z
         pJKqsDuuP/AxbSOnBybjtkdtE5Stzdid5TN0h4TQk51UGKU7L1UYDCBHmRA0UeUVLgFL
         P+g8lDAOqtV9CAwG13qF4/hwQuLQQBmd1+j/Xwa8XcnYMFf6HIdbL1+4dlK7YF+q0PI4
         kTfWWo2H5B1uzCttOMv1IknHxuuJIr80jrUJvj+LUz+G+sSu/oDGZSz8Zo4AKKzm/9OI
         OKs0DMn4Egkm2V9e74CRvlOxF5RiklhXegEE8yL26q37PEft1ZtOhrwQ06Oq61CDBuU4
         v/Vw==
X-Gm-Message-State: AOAM533k5UYEKft/hZivHz+8aqb29svBpuCJ+I7gCO6qP9axlhHR7/dV
        +1lGVChzuRN+NDduA+T9bMnNny7bKd4nPTw4x/sHSA==
X-Google-Smtp-Source: ABdhPJxU3Fjik7jAIeaEoDKzzZOcq1WLjRjPx3NV3wMnFmubirLfobMi1lG3KbeglZIkIfrNU5mb0MdSphgnwp6fB6M=
X-Received: by 2002:a17:906:3b42:: with SMTP id h2mr4944788ejf.647.1644346164898;
 Tue, 08 Feb 2022 10:49:24 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org> <adce2b72-ed5c-3056-313c-caea9bad4e15@math.utexas.edu>
 <20220125212055.GB17638@fieldses.org> <164315533676.5493.13243313269022942124@noble.neil.brown.name>
 <20220126025722.GD17638@fieldses.org>
In-Reply-To: <20220126025722.GD17638@fieldses.org>
From:   Daire Byrne <daire@dneg.com>
Date:   Tue, 8 Feb 2022 18:48:49 +0000
Message-ID: <CAPt2mGP2guMMf1C9VoQ0AvZ819jPuz0vDoEzJJhtL8q5DJ300A@mail.gmail.com>
Subject: Re: parallel file create rates (+high latency)
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     NeilBrown <neilb@suse.de>, Patrick Goetz <pgoetz@math.utexas.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 26 Jan 2022 at 02:57, J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Wed, Jan 26, 2022 at 11:02:16AM +1100, NeilBrown wrote:
> > On Wed, 26 Jan 2022, J. Bruce Fields wrote:
> > > On Tue, Jan 25, 2022 at 03:15:42PM -0600, Patrick Goetz wrote:
> > > > So the directory is locked while the inode is created, or something
> > > > like this, which makes sense.
> > >
> > > It accomplishes a number of things, details in
> > > https://www.kernel.org/doc/html/latest/filesystems/directory-locking.html
> >
> > Just in case anyone is interested, I wrote this a while back:
> >
> > http://lists.lustre.org/pipermail/lustre-devel-lustre.org/2018-November/008177.html
> >
> > it includes a patch to allow parallel creates/deletes over NFS (and any
> > other filesystem which adds support).
> > I doubt it still applies, but it wouldn't be hard to make it work if
> > anyone was willing to make a strong case that we would benefit from
> > this.

Well, I couldn't resist quickly testing Neil's patch. I found it
applied okay to v5.6.19 with minimal edits.

As before, without the patch, parallel file creates in a single
directory with 1000 threads topped out at an aggregate of 3 creates/s
over a 200ms link. With the patch it jumps up to 1,200 creates/s.

So a pretty dramatic difference. I can't say if there are any other
side effects or regressions as I only did this simple test.

It's great for our super niche workloads and use case anyway.

Daire


> Neato.
>
> Removing the need to hold an exclusive lock on the directory across
> server round trips seems compelling to me....
>
> I also wonder: why couldn't you fire off the RPC without any locks, then
> wait till you get a reply to take locks and update your local cache?
>
> OK, for one thing, calls and replies and server processing could all get
> reordered.  We'd need to know what order the server processed operations
> in, so we could process replies in the same order.
>
> --b.
