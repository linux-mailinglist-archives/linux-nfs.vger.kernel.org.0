Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C1E26CD19
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Sep 2020 22:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIPUxk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 16:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgIPQyL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 12:54:11 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861A2C0A8939
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 06:07:46 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id e23so10265749eja.3
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 06:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9XTgQF6bQPK08d5Xbkx+1lME9lFi0pAWDa6qELe+cpI=;
        b=F0sRO+Olmw04dCplgFjzoTYrQq6w+5Ik2f79ukFB9Go4YnWrRWDfh2CLRKEF/o1gR2
         kr2QQyye160adexQMQTiUylMRIzAFBUePxVUDyYbt+gxm14VJJZMIRwN5OBIdau+s7DZ
         C0LRE/IVuq0QTd5HtmL1tscY8OK3asrgGiJgfVgBj1B06hY9hZucEr1D1nPyp5x3McVa
         36mZc30rsQpHeqi9MbABWY/toPZ462UrZxtSCvUsW5rFjI3Z1YAog19BCXN/1nMIorO3
         BlI4OFHuAwnNwxJW8HcbtxkHa2Qdi7s/O/DxGr6n1QllsdBmPBitl3Pr9PFSadKBvLNl
         6XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XTgQF6bQPK08d5Xbkx+1lME9lFi0pAWDa6qELe+cpI=;
        b=qdtd7rQvyP088uZRUzhb8VYRwSPRx5r0Y6bPgsUMCu/Y9qoHCccdbIzL9ZWq382Vjz
         VUSawD5IuFn+CBZWHta9Yp5lC5+B8uo4jz+GaXA6vnZzNsIARdbQMQdX3G7Xuh4OE11H
         AQVriI3WYQC5YfBkCsuRHVx0aUKNaeBsIUPiW4LiEurXz/LY7IWqzwscLojpWRnLwpN3
         fQdIASCEn3bixuI1mUyfD6cX3lfz+n5E8Ye9R5y+Cgc7eAoRTwWCeZ6N/lAw60cWqVG2
         exvsyUEQlWVzktvp7RPKMOWZcQfFaFoeM4fPs/ugwrP9FCAZvQXXQJjTWg0lqtExEsUm
         qtpw==
X-Gm-Message-State: AOAM533abSTyyUtPQIjxQp5zY18Fkh/uU+EhkquQp9SNhFdODzgAoHeH
        eyjGOh/z6onX1j7XYOM/UUX4OuAqby1pl4uIRMP/BRIBh/4=
X-Google-Smtp-Source: ABdhPJyT0d2APXBgFJG7Ms8yjeD63cVxj1rMVYy/TEjBp3TOdWDKmPgiITNrtJTLdctBSJHg1BzONvPpT2rvNiTRJJc=
X-Received: by 2002:a17:906:a444:: with SMTP id cb4mr24686294ejb.432.1600261665130;
 Wed, 16 Sep 2020 06:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200914202334.7536-1-olga.kornievskaia@gmail.com> <20200916005129.ferojvuzniecdsbm@xzhoux.usersys.redhat.com>
In-Reply-To: <20200916005129.ferojvuzniecdsbm@xzhoux.usersys.redhat.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 16 Sep 2020 09:07:33 -0400
Message-ID: <CAN-5tyEBPpe=Td9DZ8a1HkT_HY6cnMi9YrAcM_hseRwe73HMBg@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2: fix client's attribute cache management for copy_file_range
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 15, 2020 at 8:51 PM Murphy Zhou <jencce.kernel@gmail.com> wrote:
>
> On Mon, Sep 14, 2020 at 04:23:34PM -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > After client is done with the COPY operation, it needs to invalidate
> > its pagecache (as it did no reading or writing of the data locally)
> > and it needs to invalidate it's attributes just like it would have
> > for a read on the source file and write on the destination file.
> >
> > Once the linux server started giving out read delegations to
> > read+write opens, the destination file of the copy_file range
> > started having delegations and not doing syncup on close of the
> > file leading to xfstest failures for generic/430,431,432,433,565.
>
> Tested OK. ltp and xfstests on v3/v4.* looks fine.

Thank you Murphy. I'm about to send a v2 as I didn't have appropriate
locking added.

> The other issue generic/464 warning I reported before is still
> there with Olga's patch. For the record.

Sorry I'm not seeing it but this doesn't look like copy_file_range
related and hopefully Bruce can take a look at this.

>
> Thanks!
> >
> > Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> > Fixes: 2e72448b07dc ("NFS: Add COPY nfs operation")
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/nfs42proc.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > index 142225f0af59..a9074f3366fa 100644
> > --- a/fs/nfs/nfs42proc.c
> > +++ b/fs/nfs/nfs42proc.c
> > @@ -356,7 +356,11 @@ static ssize_t _nfs42_proc_copy(struct file *src,
> >
> >       truncate_pagecache_range(dst_inode, pos_dst,
> >                                pos_dst + res->write_res.count);
> > -
> > +     NFS_I(dst_inode)->cache_validity |= (NFS_INO_REVAL_PAGECACHE |
> > +                     NFS_INO_REVAL_FORCED | NFS_INO_INVALID_SIZE |
> > +                     NFS_INO_INVALID_ATTR | NFS_INO_INVALID_DATA);
> > +     NFS_I(src_inode)->cache_validity |= (NFS_INO_REVAL_PAGECACHE |
> > +                     NFS_INO_REVAL_FORCED | NFS_INO_INVALID_ATIME);
> >       status = res->write_res.count;
> >  out:
> >       if (args->sync)
> > --
> > 2.18.1
> >
>
> --
> Murphy
