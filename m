Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CBB2A4D7B
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 18:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgKCRuZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 12:50:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbgKCRuZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Nov 2020 12:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604425823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FanrZR+28tbGHlvck29X+0DEQpbsI2dYKaSKROIb+s4=;
        b=KPqNqRWAlF+fisDrRHbn3JDf16o1I9aYB8jK7tbtUuyOQc2BNOTv4oqnPyBOehzS98O6Xo
        3NJhdiyQi49m6/7N9mbiTuIl82dwGI2dVjz5SriN5q/FmOvuLk/t+aUEwlL9/YaVaPEvO0
        /yiTpfnmnABUO70av8R198M8SmN4efc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-BWp9aLYUONesJ2HsnzKbhQ-1; Tue, 03 Nov 2020 12:50:21 -0500
X-MC-Unique: BWp9aLYUONesJ2HsnzKbhQ-1
Received: by mail-ej1-f70.google.com with SMTP id gr9so3991324ejb.19
        for <linux-nfs@vger.kernel.org>; Tue, 03 Nov 2020 09:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FanrZR+28tbGHlvck29X+0DEQpbsI2dYKaSKROIb+s4=;
        b=tFCgnzRFOuQSE5kgDyoniBjL/+g3bp9hAU9sUOD1Acszr4bYiSTAAvCphGoGjauquz
         1ztkFEscRpxle2m3oTn5acJmZJSflEPa3Fqrf2Dfsre8tL4z/Rck4QVbhqMD4EauYiwh
         GwZIl878qTGcMUe576ZK7ecQE9e2AqTySqqPENKpoeWAUIrjOKKJaLLJ+iLG7jB+fgRW
         uWLxufadQkXHt9ziNSRt32pDQPNnrj2tzvLWWkizIUzDxokbhWwfHMjw1bdnUMYEfZYi
         +LU8rDqm90X1NFrw14xpPXgu2BDQbDf6pic2kntBi0QtoX4rpIt8kEdq1TeB3PBBDFjQ
         PIPQ==
X-Gm-Message-State: AOAM531bhcGjYk8ElTj/qeOpbFtlSpSYCCXvpVQJrTJVY4BwM/DYnjSP
        c7D/DWkblThu1vtR3FCW2IWQa4te9LGnlSigYgACLCclljDcZrx1tTphTlp9oNg0l46WePf0gLm
        w13bztpAmXdhzZXVnlugbN//+PjntN/cgqRMt
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr20798235eji.320.1604425819663;
        Tue, 03 Nov 2020 09:50:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGXP8Z/PelAqdQAwahBZJp9kIb7T8LcsuxDaCokChGhc06gz2Eud71J60FZd+CYdIUJoPR2fHTNuWE9Dr89Q0=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr20798213eji.320.1604425819343;
 Tue, 03 Nov 2020 09:50:19 -0800 (PST)
MIME-Version: 1.0
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
 <1604325011-29427-10-git-send-email-dwysocha@redhat.com> <2af057425352e05315b53c5b9bbd7fd277175a13.camel@hammerspace.com>
 <CALF+zOmK1RuwCZDYoSF=fuB-F=HxC+n4vNUFtxgW_Qo58Mk2_A@mail.gmail.com>
 <d0bce650791752805f5d03149d7ea709d07002bb.camel@hammerspace.com>
 <CALF+zOnBKsNdRg9pbDe8wki6rBQJy2R+datBXDWE-Kg2_L-SGw@mail.gmail.com> <20201103000903.GA23691@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
In-Reply-To: <20201103000903.GA23691@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 3 Nov 2020 12:49:43 -0500
Message-ID: <CALF+zOnhbGR28SBgtXT6FNf03kqXcMF99_cGRWtbDefJxfEnxw@mail.gmail.com>
Subject: Re: [PATCH 09/11] NFS: Improve performance of listing directories
 being modified
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 2, 2020 at 7:09 PM Frank van der Linden <fllinden@amazon.com> wrote:
>
> Hi Dave,
>
> Thanks for looking at this.
>
> On Mon, Nov 02, 2020 at 02:45:09PM -0500, David Wysochanski wrote:
> > On Mon, Nov 2, 2020 at 12:31 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> > >
> > > On Mon, 2020-11-02 at 11:26 -0500, David Wysochanski wrote:
> > > > On Mon, Nov 2, 2020 at 11:22 AM Trond Myklebust <
> > > > trondmy@hammerspace.com> wrote:
> > > > >
> > > > > On Mon, 2020-11-02 at 08:50 -0500, Dave Wysochanski wrote:
> > > > > > A process can hang forever to 'ls -l' a directory while the
> > > > > > directory
> > > > > > is being modified such as another NFS client adding files to the
> > > > > > directory.  The problem is seen specifically with larger
> > > > > > directories
> > > > > > (I tested with 1 million) and/or slower NFS server responses to
> > > > > > READDIR.  If a combination of the NFS directory size, the NFS
> > > > > > server
> > > > > > responses to READDIR is such that the 'ls' process gets partially
> > > > > > through the listing before the attribute cache expires (time
> > > > > > exceeds acdirmax), we drop the pagecache and have to re-fill it,
> > > > > > and as a result, the process may never complete.  One could argue
> > > > > > for larger directories the acdirmin/acdirmax should be increased,
> > > > > > but it's not always possible to tune this effectively.
> > > > > >
> > > > > > The root cause of this problem is due to how the NFS readdir
> > > > > > cache
> > > > > > currently works.  The main search function,
> > > > > > readdir_search_pagecache(),
> > > > > > always starts searching at page_index and cookie == 0, and for
> > > > > > any
> > > > > > page not in the cache, fills in the page with entries obtained in
> > > > > > a READDIR NFS call.  If a page already exists, we proceed to
> > > > > > nfs_readdir_search_for_cookie(), which searches for the cookie
> > > > > > (pos) of the readdir call.  The search is O(n), where n is the
> > > > > > directory size before the cookie in question is found, and every
> > > > > > entry to nfs_readdir() pays this penalty, irrespective of the
> > > > > > current directory position (dir_context.pos).  The search is
> > > > > > expensive due to the opaque nature of readdir cookies, and the
> > > > > > fact
> > > > > > that no mapping (hash) exists from cookies to pages.  In the case
> > > > > > of a directory being modified, the above behavior can become an
> > > > > > excessive penalty, since the same process is forced to fill pages
> > > > > > it
> > > > > > may be no longer interested in (the entries were passed in a
> > > > > > previous
> > > > > > nfs_readdir call), and this can essentially lead no forward
> > > > > > progress.
> > > > > >
> > > > > > To fix this problem, at the end of nfs_readdir(), save the
> > > > > > page_index
> > > > > > corresponding to the directory position (cookie) inside the
> > > > > > process's
> > > > > > nfs_open_dir_context.  Then at the next entry of nfs_readdir(),
> > > > > > use
> > > > > > the saved page_index as the starting search point rather than
> > > > > > starting
> > > > > > at page_index == 0.  Not only does this fix the problem of
> > > > > > listing
> > > > > > a directory being modified, it also significantly improves
> > > > > > performance
> > > > > > in the unmodified case since no extra search penalty is paid at
> > > > > > each
> > > > > > entry to nfs_readdir().
> > > > > >
> > > > > > In the case of lseek, since there is no hash or other mapping
> > > > > > from a
> > > > > > cookie value to the page->index, just reset
> > > > > > nfs_open_dir_context.page_index
> > > > > > to 0, which will reset the search to the old behavior.
> > > > > >
> > > > > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > > > > ---
> > > > > >  fs/nfs/dir.c           | 8 +++++++-
> > > > > >  include/linux/nfs_fs.h | 1 +
> > > > > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > > > > > index 52e06c8fc7cd..b266f505b521 100644
> > > > > > --- a/fs/nfs/dir.c
> > > > > > +++ b/fs/nfs/dir.c
> > > > > > @@ -78,6 +78,7 @@ static struct nfs_open_dir_context
> > > > > > *alloc_nfs_open_dir_context(struct inode *dir
> > > > > >                 ctx->attr_gencount = nfsi->attr_gencount;
> > > > > >                 ctx->dir_cookie = 0;
> > > > > >                 ctx->dup_cookie = 0;
> > > > > > +               ctx->page_index = 0;
> > > > > >                 ctx->cred = get_cred(cred);
> > > > > >                 spin_lock(&dir->i_lock);
> > > > > >                 if (list_empty(&nfsi->open_files) &&
> > > > > > @@ -763,7 +764,7 @@ int
> > > > > > find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
> > > > > >         return res;
> > > > > >  }
> > > > > >
> > > > > > -/* Search for desc->dir_cookie from the beginning of the page
> > > > > > cache
> > > > > > */
> > > > > > +/* Search for desc->dir_cookie starting at desc->page_index */
> > > > > >  static inline
> > > > > >  int readdir_search_pagecache(nfs_readdir_descriptor_t *desc)
> > > > > >  {
> > > > > > @@ -885,6 +886,8 @@ static int nfs_readdir(struct file *file,
> > > > > > struct
> > > > > > dir_context *ctx)
> > > > > >                 .ctx = ctx,
> > > > > >                 .dir_cookie = &dir_ctx->dir_cookie,
> > > > > >                 .plus = nfs_use_readdirplus(inode, ctx),
> > > > > > +               .page_index = dir_ctx->page_index,
> > > > > > +               .last_cookie = nfs_readdir_use_cookie(file) ?
> > > > > > ctx-
> > > > > > > pos : 0,
> > > > > >         },
> > > > > >                         *desc = &my_desc;
> > > > > >         int res = 0;
> > > > > > @@ -938,6 +941,7 @@ static int nfs_readdir(struct file *file,
> > > > > > struct
> > > > > > dir_context *ctx)
> > > > > >  out:
> > > > > >         if (res > 0)
> > > > > >                 res = 0;
> > > > > > +       dir_ctx->page_index = desc->page_index;
> > > > > >         trace_nfs_readdir_exit(inode, ctx->pos, dir_ctx-
> > > > > > >dir_cookie,
> > > > > >                                NFS_SERVER(inode)->dtsize,
> > > > > > my_desc.plus, res);
> > > > > >         return res;
> > > > > > @@ -975,6 +979,8 @@ static loff_t nfs_llseek_dir(struct file
> > > > > > *filp,
> > > > > > loff_t offset, int whence)
> > > > > >                 else
> > > > > >                         dir_ctx->dir_cookie = 0;
> > > > > >                 dir_ctx->duped = 0;
> > > > > > +               /* Force readdir_search_pagecache to start over
> > > > > > */
> > > > > > +               dir_ctx->page_index = 0;
> > > > > >         }
> > > > > >         inode_unlock(inode);
> > > > > >         return offset;
> > > > > > diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> > > > > > index a2c6455ea3fa..0e55c0154ccd 100644
> > > > > > --- a/include/linux/nfs_fs.h
> > > > > > +++ b/include/linux/nfs_fs.h
> > > > > > @@ -93,6 +93,7 @@ struct nfs_open_dir_context {
> > > > > >         __u64 dir_cookie;
> > > > > >         __u64 dup_cookie;
> > > > > >         signed char duped;
> > > > > > +       unsigned long   page_index;
> > > > > >  };
> > > > > >
> > > > > >  /*
> > > > >
> > > > > NACK. It makes no sense to store the page index as a cursor.
> > > > >
> > > >
> > > > A similar thing was done recently with:
> > > > 227823d2074d nfs: optimise readdir cache page invalidation
> > > >
> > >
> > > That's a very different thing. It is about discarding page data in
> > > order to force a re-read of the contents into cache.
> > >
> > Right - I only pointed it out because it is in effect a cursor about
> > the last access into the cache but it's on a global basis, not
> > process context.
> >
> > > What you're doing is basically trying to guess where the data is
> > > located. which might work in some cases where the directory is
> > > completely static, but if it shrinks (e.g. due to a few unlink() or
> > > rename() calls) so that you overshoot the cookie, then you can end up
> > > reading all the way to the end of the directory before doing an
> > > uncached readdir.
> > >
> > First, consider the unmodified (idle directory) scenario.  Today the
> > performance is bad the larger the directory goes - do you see why?
> > I tried to explain in the cover letter and header but maybe it's not clear?
>
> I agree with you that the patch is good for that case. It seems
> like a bug that, if the cache is not invalidated in the meantime,
> nfs_readdir would start at offset 0 of the cache while searching.
>
> But, as Trond said, page_index isn't a good cursor once the
> page cache was invalidated, you don't know what data you are
> leaving out inadvertently.
>

Hey Frank - thanks for looking at this too.  Yes I see it this is probably
not a good approach especially since you and Trond seem to come
to the same conclusion.


> >
> > Second, the modified scenario today the performance is very bad
> > because of the same problem - the cookie is reset and the process
> > needs to start over at cookie 0, repeating READDIRs.  But maybe
> > there's a specific scenario I'm not thinking about.
> >
> > The way I thought about this is that if you're in a heavily modified
> > scenario with a large directory and you're past the 'acdirmax' time,
> > you have to make the choice of either:
> > a) ignoring 'acdirmax' (this is what the NFSv3 patch did) and even
> > though you know the cache expired you keep going as though it
> > did not (at least until a different process starts a listing)
> > b) honoring 'acdirmax' (drop the pagecache), but keep going the
> > best you can based on the previous information and don't try to
> > rebuild the cache before continuing.
>
> Yeah, it seems like those are your options. The only other way
> of doing this that I can think of would be to add logic that
> says something like:
>
>         if (pos != 0 and the cache is invalid)
>                 uncached_readdir()
>
> ..which is, by the looks of it, easily done by having
> readdir_search_pagecache() return EBADCOOKIE if
> there's no cache, and the offset is not 0. E.g. it
> shouldn't try to fill the cache in that case, but
> just let uncached reads take over.
>
I thought about other logic, but this seems simple
enough - just check for 0 and probably the number
of pages in the cache to see if it's invalid.

> The idea here is that the only information that is possibly
> still valid is the cookie - and that the server will know
> how to use the cookie to keep going where you left off.
>
Makes sense.

> Of course, this mean that, in the case of another client
> modifying the directory, you'll end up doing mostly / all
> uncached readdirs after an invalidate. Same for a scenario
> where a client did: open llseek(<nonzero_offset), getdents().
> Until another process starts at offset 0 and re-fills the
> cache, of course.
>
> I'm not sure if that's all that bad, though, it depends
> on common usage patterns.
>

Yeah I was wondering about this too - what side effects would
happen when going uncached and how far should we go
to try to detect we're in this pattern.

I guess I was hoping to avoid going uncached because that
means we have to ask the server again for the same info,
which could very well be a lot.  But then again if we're blowing
past acdirmax then we're making the best of a bad situation
and just need to make forward progress.

I also considered whether it would be possible to improve the readdir
cache data structure and search to handle this, especially now that it
looks like Trond's latest patches have given us 16 bytes of free space in
each page.  I was thinking for example of adding a 'next_page_index'
into nfs_cache_array but then I think we get into a mess of overlap of
entries, etc. So far I don't see a clean way forward on that, and the
added complexity does not seem worthwhile.  So trying uncached
like you and Trond suggest may be the best approach.


> - Frank
>

