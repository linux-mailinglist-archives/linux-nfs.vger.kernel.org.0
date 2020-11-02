Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CD42A2FC6
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 17:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgKBQ1Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 11:27:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726633AbgKBQ1Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 11:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604334443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7958s1TJSviy3Ay04c6a1q5B7/0e/Cp6TphJsNH6Elk=;
        b=ezgFcyI+s9d+ABpnglt2cU42NainYkTy63TArmtAYQeGcXnZHsZMe+qI3XLrT9cy1nMc1U
        iebPBFKYyQW0bo0tmjNcuTFLGXrz3kktJjFSOJf2cQ90kMGHIgPyYPbEI+qU34U1lxC8a3
        lLv/Biq/13/3xEv9DFKyf2kbxZ7efOI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-NP-hUdksMheMkRBw_zM0Fw-1; Mon, 02 Nov 2020 11:27:21 -0500
X-MC-Unique: NP-hUdksMheMkRBw_zM0Fw-1
Received: by mail-ej1-f72.google.com with SMTP id z9so4447670ejg.10
        for <linux-nfs@vger.kernel.org>; Mon, 02 Nov 2020 08:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7958s1TJSviy3Ay04c6a1q5B7/0e/Cp6TphJsNH6Elk=;
        b=AWlrbLoNNH1yjjwaa5oUnpoJ7XlM2SIOz84WdjhnBmy+ATQzpTuIK4SftyMsS5gO+W
         LLMpBXonoVR9/0583azJ+2FtWMqf2Cx7nS5wzAGfM6rjzCSSCxI26PoQ1Jya86IFSCdR
         o2kUD29nhG0P0NSE+P0+K/ZuEiDApfCHvYtewIlNYpFRb52bYsQNolF+FDa3ZPiY5v1w
         AvfXmCwdld+4Ty3JVOpE2S2eU1HnjHDNSisIIO40qlke64VCvZbRxjMidpTZnIW1/oVy
         WhpheXuYe1x4hLgcFbnk4CmRaSwdwaDaqmBfSseWYUOgLucjT2/5Hl4LfPCJZRd62XvM
         ZFlw==
X-Gm-Message-State: AOAM533aM4jzuNFedOzM9M0+QFXwrxVWZ1AI6RCIq61kZthECiatxyp/
        qWK+u36ciGC4TK1rKXEvctmeggGLEYJKxCbyGN5lPp7kbWW/PH++GHfnyvq1ntYN2exN6mrAi4E
        xJc3TppfUJ2P1iYhobN4WFSz6cQJ3hEBAm+SS
X-Received: by 2002:a50:e705:: with SMTP id a5mr17508735edn.29.1604334440274;
        Mon, 02 Nov 2020 08:27:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAgollr1vcBirNc6UAwfMMhtoJ2Y8zeCAJ9S1+3ntlJJajdHY5Y9lQ79LqdoPN3tFUEBJy2L8oNsJ+m/h0wTk=
X-Received: by 2002:a50:e705:: with SMTP id a5mr17508714edn.29.1604334440004;
 Mon, 02 Nov 2020 08:27:20 -0800 (PST)
MIME-Version: 1.0
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
 <1604325011-29427-10-git-send-email-dwysocha@redhat.com> <2af057425352e05315b53c5b9bbd7fd277175a13.camel@hammerspace.com>
In-Reply-To: <2af057425352e05315b53c5b9bbd7fd277175a13.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 2 Nov 2020 11:26:43 -0500
Message-ID: <CALF+zOmK1RuwCZDYoSF=fuB-F=HxC+n4vNUFtxgW_Qo58Mk2_A@mail.gmail.com>
Subject: Re: [PATCH 09/11] NFS: Improve performance of listing directories
 being modified
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 2, 2020 at 11:22 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Mon, 2020-11-02 at 08:50 -0500, Dave Wysochanski wrote:
> > A process can hang forever to 'ls -l' a directory while the directory
> > is being modified such as another NFS client adding files to the
> > directory.  The problem is seen specifically with larger directories
> > (I tested with 1 million) and/or slower NFS server responses to
> > READDIR.  If a combination of the NFS directory size, the NFS server
> > responses to READDIR is such that the 'ls' process gets partially
> > through the listing before the attribute cache expires (time
> > exceeds acdirmax), we drop the pagecache and have to re-fill it,
> > and as a result, the process may never complete.  One could argue
> > for larger directories the acdirmin/acdirmax should be increased,
> > but it's not always possible to tune this effectively.
> >
> > The root cause of this problem is due to how the NFS readdir cache
> > currently works.  The main search function,
> > readdir_search_pagecache(),
> > always starts searching at page_index and cookie == 0, and for any
> > page not in the cache, fills in the page with entries obtained in
> > a READDIR NFS call.  If a page already exists, we proceed to
> > nfs_readdir_search_for_cookie(), which searches for the cookie
> > (pos) of the readdir call.  The search is O(n), where n is the
> > directory size before the cookie in question is found, and every
> > entry to nfs_readdir() pays this penalty, irrespective of the
> > current directory position (dir_context.pos).  The search is
> > expensive due to the opaque nature of readdir cookies, and the fact
> > that no mapping (hash) exists from cookies to pages.  In the case
> > of a directory being modified, the above behavior can become an
> > excessive penalty, since the same process is forced to fill pages it
> > may be no longer interested in (the entries were passed in a previous
> > nfs_readdir call), and this can essentially lead no forward progress.
> >
> > To fix this problem, at the end of nfs_readdir(), save the page_index
> > corresponding to the directory position (cookie) inside the process's
> > nfs_open_dir_context.  Then at the next entry of nfs_readdir(), use
> > the saved page_index as the starting search point rather than
> > starting
> > at page_index == 0.  Not only does this fix the problem of listing
> > a directory being modified, it also significantly improves
> > performance
> > in the unmodified case since no extra search penalty is paid at each
> > entry to nfs_readdir().
> >
> > In the case of lseek, since there is no hash or other mapping from a
> > cookie value to the page->index, just reset
> > nfs_open_dir_context.page_index
> > to 0, which will reset the search to the old behavior.
> >
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> >  fs/nfs/dir.c           | 8 +++++++-
> >  include/linux/nfs_fs.h | 1 +
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index 52e06c8fc7cd..b266f505b521 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -78,6 +78,7 @@ static struct nfs_open_dir_context
> > *alloc_nfs_open_dir_context(struct inode *dir
> >                 ctx->attr_gencount = nfsi->attr_gencount;
> >                 ctx->dir_cookie = 0;
> >                 ctx->dup_cookie = 0;
> > +               ctx->page_index = 0;
> >                 ctx->cred = get_cred(cred);
> >                 spin_lock(&dir->i_lock);
> >                 if (list_empty(&nfsi->open_files) &&
> > @@ -763,7 +764,7 @@ int
> > find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
> >         return res;
> >  }
> >
> > -/* Search for desc->dir_cookie from the beginning of the page cache
> > */
> > +/* Search for desc->dir_cookie starting at desc->page_index */
> >  static inline
> >  int readdir_search_pagecache(nfs_readdir_descriptor_t *desc)
> >  {
> > @@ -885,6 +886,8 @@ static int nfs_readdir(struct file *file, struct
> > dir_context *ctx)
> >                 .ctx = ctx,
> >                 .dir_cookie = &dir_ctx->dir_cookie,
> >                 .plus = nfs_use_readdirplus(inode, ctx),
> > +               .page_index = dir_ctx->page_index,
> > +               .last_cookie = nfs_readdir_use_cookie(file) ? ctx-
> > >pos : 0,
> >         },
> >                         *desc = &my_desc;
> >         int res = 0;
> > @@ -938,6 +941,7 @@ static int nfs_readdir(struct file *file, struct
> > dir_context *ctx)
> >  out:
> >         if (res > 0)
> >                 res = 0;
> > +       dir_ctx->page_index = desc->page_index;
> >         trace_nfs_readdir_exit(inode, ctx->pos, dir_ctx->dir_cookie,
> >                                NFS_SERVER(inode)->dtsize,
> > my_desc.plus, res);
> >         return res;
> > @@ -975,6 +979,8 @@ static loff_t nfs_llseek_dir(struct file *filp,
> > loff_t offset, int whence)
> >                 else
> >                         dir_ctx->dir_cookie = 0;
> >                 dir_ctx->duped = 0;
> > +               /* Force readdir_search_pagecache to start over */
> > +               dir_ctx->page_index = 0;
> >         }
> >         inode_unlock(inode);
> >         return offset;
> > diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> > index a2c6455ea3fa..0e55c0154ccd 100644
> > --- a/include/linux/nfs_fs.h
> > +++ b/include/linux/nfs_fs.h
> > @@ -93,6 +93,7 @@ struct nfs_open_dir_context {
> >         __u64 dir_cookie;
> >         __u64 dup_cookie;
> >         signed char duped;
> > +       unsigned long   page_index;
> >  };
> >
> >  /*
>
> NACK. It makes no sense to store the page index as a cursor.
>

A similar thing was done recently with:
227823d2074d nfs: optimise readdir cache page invalidation

