Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC4389410
	for <lists+linux-nfs@lfdr.de>; Wed, 19 May 2021 18:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhESQtB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 May 2021 12:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhESQtB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 May 2021 12:49:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56778C06175F
        for <linux-nfs@vger.kernel.org>; Wed, 19 May 2021 09:47:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l4so20916002ejc.10
        for <linux-nfs@vger.kernel.org>; Wed, 19 May 2021 09:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8M7t3QboA7TD6nDaDClzGwWMmDkiWbmK0rJcgLYax60=;
        b=kDJuQ8L64qwOuJKFBqwrypKUJ6LSCVLNuFylPAdCp49mxvG26EyM3yasPrTJq4jjR7
         QGPvYmk+Ug6MRgeQ3imhivLXVLHiyDwTED9m/eYSdPVEFSL6dWHLDUnx2X+ebmd4/ZCr
         zyVGAg3RYlFXwS2lX/Tuqx6vkJFOfn8UNGw3ryBovy08/7EkJRyctGPvihw1xHJr4Fr9
         zt8oKcKCxzOWmXKLiYPoSTEiRY7ZIpNelZ5Opu/hxma4m4Uw99dfqWNA1En31YYRaTlr
         holjBLHtuE49TyPUBBZxd1NQYUmncT5cXgfrtaYZbKJtAgtbJzt3FhDf3mfm6VLc15mZ
         vsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8M7t3QboA7TD6nDaDClzGwWMmDkiWbmK0rJcgLYax60=;
        b=DG2jP7LrSagq0cgCp2fR0cd2Mu3aKf6oZPm6lHcI+DD/490rK6KcD3+b6o18Jx0OMM
         zqkWXsxqYM89KsLOfINpzepChA3MowyH6EVQ2aY5FAIK7DX3iYfB2/r+5KzxAGmoFeF0
         hcSYUiSedRx75s0tmYfYut0YQVUbRvDINTL5uPFDGEnQYSJK2WYNOCAB27whiUoyJ8Uf
         +cTP2fHisEHV2GTmSZXXa7MV/RLfrvQyPLFLWjIb9JFwVk6EHC8gt6N2RnuEuyq4FuDB
         u8WSx9X4Hxu+Y3RuBx9ZSwkJqiESyT1KH4HZVJUsUJCOpZbU4ooW2sNEj2kRAZeF2lRx
         HCzA==
X-Gm-Message-State: AOAM533e2PX95nWlXyLGT04OFC9WI67+LY6gqKRXfNFYPeRA8Bq/gPtb
        aWsYTRx01mLA1o5lBCMR+4tuJjSArjrrDwJZJZD3AK5W
X-Google-Smtp-Source: ABdhPJwX927mkam1fwc5TnX7dIM6yGG06+S//E2cLfbXyeuTvGl5S89mKNpjwTA7/oDNGs7duwwoibXNxSe8cv4msxs=
X-Received: by 2002:a17:906:a017:: with SMTP id p23mr94772ejy.460.1621442859875;
 Wed, 19 May 2021 09:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210519160635.333057-1-Anna.Schumaker@Netapp.com> <9b54027028a9a7322b6f06748c4499174a238866.camel@hammerspace.com>
In-Reply-To: <9b54027028a9a7322b6f06748c4499174a238866.camel@hammerspace.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 19 May 2021 12:47:23 -0400
Message-ID: <CAFX2Jf=m6nFNs4tfHXp4dyLpSK3k9Fpn11YDx1qJE5U1d-7CNw@mail.gmail.com>
Subject: Re: [PATCH] NFSv4: Fix a NULL pointer dereference in pnfs_mark_matching_lsegs_return()
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 19, 2021 at 12:43 PM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Wed, 2021-05-19 at 12:06 -0400, schumaker.anna@gmail.com wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > Commit de144ff4234f changes _pnfs_return_layout() to call
> > pnfs_mark_matching_lsegs_return() passing NULL as the struct
> > pnfs_layout_range argument. Unfortunately,
> > pnfs_mark_matching_lsegs_return() doesn't check if we have a value
> > here
> > before dereferencing it, causing an oops.
> >
> > I'm able to hit this crash consistently when running connectathon
> > basic
> > tests on NFS v4.1/v4.2 against Ontap.
> >
> > Fixes: de144ff4234f ("NFSv4: Don't discard segments marked for return
> > in _pnfs_return_layout()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> >  fs/nfs/pnfs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> > index 03e0b34c4a64..6d720afb7b70 100644
> > --- a/fs/nfs/pnfs.c
> > +++ b/fs/nfs/pnfs.c
> > @@ -2484,12 +2484,12 @@ pnfs_mark_matching_lsegs_return(struct
> > pnfs_layout_hdr *lo,
> >                         set_bit(NFS_LSEG_LAYOUTRETURN, &lseg-
> > >pls_flags);
> >                 }
> >
> > -       if (remaining) {
> > +       if (remaining && return_range) {
> >                 pnfs_set_plh_return_info(lo, return_range->iomode,
> > seq);
> >                 return -EBUSY;
> >         }
> >
> > -       if (!list_empty(&lo->plh_return_segs)) {
> > +       if (return_range && !list_empty(&lo->plh_return_segs)) {
> >                 pnfs_set_plh_return_info(lo, return_range->iomode,
> > seq);
> >                 return 0;
>
> This patch would mean we fail to mark the layout for return in
> situations where we clearly should be doing so. The lack of a
> return_range doesn't indicate that we don't want to return any layouts,
> but rather that we want to return all layouts.
>
> I suggest rather changing the caller, _pnfs_return_layout() to move
> that declaration of 'struct pnfs_layout_range range' out of the if
> statement so that it can be passed as an argument instead of NULL.

Sure, I'll try that now.

Thanks!
Anna

>
> >         }
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
