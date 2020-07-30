Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CD22338E8
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jul 2020 21:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgG3TXy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jul 2020 15:23:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45728 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726581AbgG3TXx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jul 2020 15:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596137032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+aT95YXKHydqNbmosDDInfhjNMhb1Txx1Ai8NlXUGyE=;
        b=Nt98Cg9XGC4bbcx0K/rvaJem26Ybjwc0jux/2Era4gHhJthoBDD+tukUiPHgOpon80pKGg
        oMf2/QQlfXoGOS4LJOw5ta3rL9UlemOAGp7R+weiTSkSLdtc+ZWxeNhNuycBPQzI90UDDR
        62DvtXf9hRqhJL7K+6abpoNU5JAGM/4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-ZYVn8Z8IM56mjJVVjr9-Ag-1; Thu, 30 Jul 2020 15:23:50 -0400
X-MC-Unique: ZYVn8Z8IM56mjJVVjr9-Ag-1
Received: by mail-ej1-f69.google.com with SMTP id d16so10224509eje.20
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jul 2020 12:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+aT95YXKHydqNbmosDDInfhjNMhb1Txx1Ai8NlXUGyE=;
        b=T2ngc9wvrapj743dEbkab6kmYcMrNUWNtDRbmfqiJO46lBW8vPk7vBUhhLpw3UhXhA
         75+2M1FpUuj6qHtbt5x0lfX3llTvJpCZPdgKND7ggIx+6xvogoP9kq1vHjZ2FqGIAMdQ
         UKdRj3BVJYaUkPFKuG9igaXDsik6xY/JgdRuuaPOetfkjjCRCz37q0PhcvfgaEm+ErXp
         7GMZq6CVVea6YmigXcrxYhN3X0u6/3ihGiFewU6aH+Wk42MeQEL+05WFGaVjg/pkOIC7
         Nt/pKAohw1QtyyJnziV3+DKpFdqTe1L0m7oBderiC5CJvjsrqv9voN4TMDIbnrUdHslF
         V+fQ==
X-Gm-Message-State: AOAM530aQA3R9wYG0Yn4IsBSTnb7eheUi/PhgGb/XWQKGuYurYrvKEOT
        ert7kdL6rqlnqzkmcBO/22iQjMlesIb6bQ8ihYNG9NSpX2zlueddrxQE9vwmdmNSyMSmZgFXsm6
        dvz7fOuW/YoDAKfrjNgt0ZjLkF/l7Bcyw4Y86
X-Received: by 2002:a17:906:80d3:: with SMTP id a19mr603279ejx.217.1596137028989;
        Thu, 30 Jul 2020 12:23:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycG9rBeUIHsgCY8h2f2jn12IQbdGXlTp7BsljVwDyNbNh3/sq0WRMoFb/ZExGnFfUpmFrQ7PWIDo82WDWHly0=
X-Received: by 2002:a17:906:80d3:: with SMTP id a19mr603265ejx.217.1596137028761;
 Thu, 30 Jul 2020 12:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
 <1596031949-26793-14-git-send-email-dwysocha@redhat.com> <43e8a8ff1ea015bb7bd335d5616268d36155327a.camel@redhat.com>
In-Reply-To: <43e8a8ff1ea015bb7bd335d5616268d36155327a.camel@redhat.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 30 Jul 2020 15:23:12 -0400
Message-ID: <CALF+zOnYLbibbYxvbyUJFJQ+NtcreuAvFkZYr9h3_qQswbMxRw@mail.gmail.com>
Subject: Re: [Linux-cachefs] [RFC PATCH v2 13/14] NFS: Call
 fscache_resize_cookie() when inode size changes due to setattr
To:     Jeff Layton <jlayton@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>, linux-cachefs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 30, 2020 at 2:39 PM Jeff Layton <jlayton@redhat.com> wrote:
>
> On Wed, 2020-07-29 at 10:12 -0400, Dave Wysochanski wrote:
> > Handle truncate / setattr when fscache is enabled by calling
> > fscache_resize_cookie().
> >
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> >  fs/nfs/inode.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > index 45067303348c..6b814246d07d 100644
> > --- a/fs/nfs/inode.c
> > +++ b/fs/nfs/inode.c
> > @@ -667,6 +667,7 @@ static int nfs_vmtruncate(struct inode * inode, loff_t offset)
> >       spin_unlock(&inode->i_lock);
> >       truncate_pagecache(inode, offset);
> >       spin_lock(&inode->i_lock);
> > +     fscache_resize_cookie(nfs_i_fscache(inode), i_size_read(inode));
> >  out:
> >       return err;
> >  }
>
> truncate can happen even when you have no open file descriptors on the
> file and therefore w/o the cookie being "used". In the ceph vmtruncate
> handling code, I do an explicit use/unuse around this call. Do you need
> to do the same here?
> --
> Jeff Layton <jlayton@redhat.com>
>

Actually I think the case you mention is covered by a patch that I've just
added today on top of my v2 posting.
This was the result of looking deeper into a few xfstest failures with
NFSv4.2.  I think this covers the truncate without a file open:

commit 91d6922df9390ca1c090911be6e5c5ab1a79ea83
Author: Dave Wysochanski <dwysocha@redhat.com>
Date:   Thu Jul 30 12:33:40 2020 -0400

    NFS: Call fscache_invalidate() from nfs_invalidate_mapping()

    Be sure to invalidate fscache cookie for any call to
    nfs_invalidate_mapping().

    This patch fixes the following xfstests on NFS4.x:
      generic/240
    as well as fixes the following xfstests on NFSv4.2:
      generic/029 generic/030

    Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 6b814246d07d..62243ec05917 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1233,6 +1233,7 @@ static int nfs_invalidate_mapping(struct inode
*inode, struct address_space *map
        struct nfs_inode *nfsi = NFS_I(inode);
        int ret;

+       nfs_fscache_invalidate(inode, 0);
        if (mapping->nrpages != 0) {
                if (S_ISREG(inode->i_mode)) {
                        ret = nfs_sync_mapping(mapping);

