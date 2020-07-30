Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE12233972
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jul 2020 22:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgG3UBV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jul 2020 16:01:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55262 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728396AbgG3UBV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jul 2020 16:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596139279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NPdZyLicOie2yuhM6uwppOmu13ULBAeVkvM5uHH6Cco=;
        b=f48p0RaUnzcN4cxWY+B/M133/M9i5KZcpDBLjEsR8aKZOmkicLdkbA39On4ios6MDEtZrR
        7qIt2S9ofMBU1i198yXyYBYoivJXbuK2vMzlDKq6TdcaXPEFRlxSgqQnPDc8LahhuxYEhe
        Sxl7kNdGByTNju2jQrFgzPMCjDrfWQA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-xssJaOc_OR2Bn6PvdVjPuw-1; Thu, 30 Jul 2020 16:00:12 -0400
X-MC-Unique: xssJaOc_OR2Bn6PvdVjPuw-1
Received: by mail-ed1-f71.google.com with SMTP id v13so5605453edx.9
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jul 2020 13:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPdZyLicOie2yuhM6uwppOmu13ULBAeVkvM5uHH6Cco=;
        b=Gq+sjkL0Y48h9qA+WpEEmlb0hTnxT8bNqtat36Ads8wIQ8iZpBcYPDPWR9UEIGHyxp
         1DGfr/4XipxzWoDS8isC2RTZCW4OVO0f1KzFXX4BxgK2qM7bOfIGVAdfQIHh0aNiVfIv
         8VXk/JMmKKp6sccwqrgNyd31/mDyad0GBTR+DC6ikdOf1V0ASOqg/DLAdrtSkhvTefgL
         BjqjzTpTd2f4XcIa98y0qyw5gaQ3w9iSbcWIbqu5vzZ1ysue3X9lZN6kU6wwvg/i4LaK
         yXrSKIXF3Ayioaf2lQdIPZyNXwSliqTdOhDyh+XKnCSqkX8kVMjqnv6VGcTEYVUEUPZ2
         MkXg==
X-Gm-Message-State: AOAM532HsDzgwSs4qP+amXBRpttUSLyJ82E+tX87X0+ZsJuWfpIsA3oM
        X3F3Cs0FhsL4igiOi0mCVDFhbBOopwHWAK2p8UvXyTbZNZz3se8suohauHV2PjH/ShIv9Um8YKD
        rIVUoeVc4xnVz08gXGVIxVR9vMVhY5UgRCZaX
X-Received: by 2002:a05:6402:3048:: with SMTP id bu8mr636869edb.367.1596139210872;
        Thu, 30 Jul 2020 13:00:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytEI6jQOO+iNyhha6KDoOFKhoYduot0O0a9ho32t/vGiBcPlnl+5o5Uo6oUzU6/robXMSAfn8L2+GkpUR56m8=
X-Received: by 2002:a05:6402:3048:: with SMTP id bu8mr636844edb.367.1596139210667;
 Thu, 30 Jul 2020 13:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
 <1596031949-26793-14-git-send-email-dwysocha@redhat.com> <43e8a8ff1ea015bb7bd335d5616268d36155327a.camel@redhat.com>
 <CALF+zOnYLbibbYxvbyUJFJQ+NtcreuAvFkZYr9h3_qQswbMxRw@mail.gmail.com>
In-Reply-To: <CALF+zOnYLbibbYxvbyUJFJQ+NtcreuAvFkZYr9h3_qQswbMxRw@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 30 Jul 2020 15:59:34 -0400
Message-ID: <CALF+zOn9tSft_QkPaJ7w8v_OLTfon+acUB_W9MSb8EEMQGc94w@mail.gmail.com>
Subject: Re: [Linux-cachefs] [RFC PATCH v2 13/14] NFS: Call
 fscache_resize_cookie() when inode size changes due to setattr
To:     Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>, linux-cachefs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 30, 2020 at 3:23 PM David Wysochanski <dwysocha@redhat.com> wrote:
>
> On Thu, Jul 30, 2020 at 2:39 PM Jeff Layton <jlayton@redhat.com> wrote:
> >
> > On Wed, 2020-07-29 at 10:12 -0400, Dave Wysochanski wrote:
> > > Handle truncate / setattr when fscache is enabled by calling
> > > fscache_resize_cookie().
> > >
> > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > ---
> > >  fs/nfs/inode.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > > index 45067303348c..6b814246d07d 100644
> > > --- a/fs/nfs/inode.c
> > > +++ b/fs/nfs/inode.c
> > > @@ -667,6 +667,7 @@ static int nfs_vmtruncate(struct inode * inode, loff_t offset)
> > >       spin_unlock(&inode->i_lock);
> > >       truncate_pagecache(inode, offset);
> > >       spin_lock(&inode->i_lock);
> > > +     fscache_resize_cookie(nfs_i_fscache(inode), i_size_read(inode));
> > >  out:
> > >       return err;
> > >  }
> >
> > truncate can happen even when you have no open file descriptors on the
> > file and therefore w/o the cookie being "used". In the ceph vmtruncate
> > handling code, I do an explicit use/unuse around this call. Do you need
> > to do the same here?
> > --
> > Jeff Layton <jlayton@redhat.com>
> >
>
> Actually I think the case you mention is covered by a patch that I've just
> added today on top of my v2 posting.
> This was the result of looking deeper into a few xfstest failures with
> NFSv4.2.  I think this covers the truncate without a file open:
>
> commit 91d6922df9390ca1c090911be6e5c5ab1a79ea83
> Author: Dave Wysochanski <dwysocha@redhat.com>
> Date:   Thu Jul 30 12:33:40 2020 -0400
>
>     NFS: Call fscache_invalidate() from nfs_invalidate_mapping()
>
>     Be sure to invalidate fscache cookie for any call to
>     nfs_invalidate_mapping().
>
>     This patch fixes the following xfstests on NFS4.x:
>       generic/240
>     as well as fixes the following xfstests on NFSv4.2:
>       generic/029 generic/030
>
>     Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
>
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 6b814246d07d..62243ec05917 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -1233,6 +1233,7 @@ static int nfs_invalidate_mapping(struct inode
> *inode, struct address_space *map
>         struct nfs_inode *nfsi = NFS_I(inode);
>         int ret;
>
> +       nfs_fscache_invalidate(inode, 0);
>         if (mapping->nrpages != 0) {
>                 if (S_ISREG(inode->i_mode)) {
>                         ret = nfs_sync_mapping(mapping);


Actually the above patch fixes truncates when a file is open, not the
case that Jeff mentions.

To be honest I'm not sure about needing a call to fscache_use/unuse_cookie()
around the call to fscache_resize_cookie().  If the cookie has a
refcount of 1 when it is created, and a file is never opened, so
we never call fscache_use_cookie(), what might happen inside
fscache_resize_cookie()?  The header on use_cookie() says
/*
 * Start using the cookie for I/O.  This prevents the backing object from being
 * reaped by VM pressure.
 */

But we're not using it for I/O in this case.
I will have to dig deeper to be sure, or maybe David H will elaborate further.

