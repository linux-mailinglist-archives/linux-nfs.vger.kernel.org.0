Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BDE2A466E
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 14:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgKCN3z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 08:29:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729200AbgKCN3y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Nov 2020 08:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604410193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n5NE/5ll7B6nGKw23TSWovEqW5QdgW7nprNsv58YngQ=;
        b=ASgBojage4wJ3opMGOBMW8+UIjYddiVAsuDsxZyWgLbMcDTsQHC1L6x+AUbA5uVFXTmMIc
        YHRmHBbcXXRruNJDWcxgzL3/WFfYhXb0RFmXHvkDQdVXFPr3aelRNCX5pkTeVElmCPafpr
        bzTAZ/6JIPhjNuToxfvZw10UY6Quuuw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-biqaj3nyNDShi2yt4WswVw-1; Tue, 03 Nov 2020 08:29:51 -0500
X-MC-Unique: biqaj3nyNDShi2yt4WswVw-1
Received: by mail-ed1-f70.google.com with SMTP id c2so2125523edw.21
        for <linux-nfs@vger.kernel.org>; Tue, 03 Nov 2020 05:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n5NE/5ll7B6nGKw23TSWovEqW5QdgW7nprNsv58YngQ=;
        b=KFdOZoIfpmpzPbJL/XAIQ9bY2dJ0NDqV/v+TRUnQLNgYyeCujhMOFNsXVcePFySTGm
         tgm4uyxQzNYlaLFKMZ3QxbK5HP7THLsPi8qXBV85+9WKWWD/hYJ22AAFJNIxF5nHZ4iG
         60+JFHD3RfvvKw8D0/ZdewC+3H6fc9DVx0oRv4NXHP04UHJ1ZAS/mgoy9/yS12d8tvNs
         ITyMBgX6dHgxbntcSWKmw+RIjFuxDwHJdx0iDeNvK3qO7bBWKYs99hLlpQcq+y+2sMXA
         xFLE12SSiGqivnjbj39sbLmxVZ29LJ1oQh1OWNZ4s3o33qIUaJSw2IlukeH/fXvc7MnJ
         76gw==
X-Gm-Message-State: AOAM531ozr5dAwmwUmQJ5FRU3lpsjYDBs/bIvAbwxof70GEV6aBtlIpb
        gqiZu0HOFbDaCIzkpNPNeMkUAQk3IhP1CjH8pZE5vuUZn7RL1Ob6aeWdqBTA53sJ+eApWlaHQbK
        U8St25/jdu+UC63IhhY+myZ2klIJ1P/tFNk1o
X-Received: by 2002:a17:906:3b89:: with SMTP id u9mr6484525ejf.436.1604410189853;
        Tue, 03 Nov 2020 05:29:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZULAr8+EYKqNtE2ufV+m//GubcY2rEkeVc4l4H/p9EMpFxtmkbnk2Z68afvnj79+NP8lZOFYHREXJmI/Wbpc=
X-Received: by 2002:a17:906:3b89:: with SMTP id u9mr6484496ejf.436.1604410189472;
 Tue, 03 Nov 2020 05:29:49 -0800 (PST)
MIME-Version: 1.0
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
 <1604325011-29427-10-git-send-email-dwysocha@redhat.com> <2af057425352e05315b53c5b9bbd7fd277175a13.camel@hammerspace.com>
 <CALF+zOmK1RuwCZDYoSF=fuB-F=HxC+n4vNUFtxgW_Qo58Mk2_A@mail.gmail.com>
 <d0bce650791752805f5d03149d7ea709d07002bb.camel@hammerspace.com>
 <CALF+zOnBKsNdRg9pbDe8wki6rBQJy2R+datBXDWE-Kg2_L-SGw@mail.gmail.com>
 <935f86485305d09cc169616a8af8e730d0f9ae4f.camel@hammerspace.com>
 <CALF+zOkRef85Z_D-oQYgTNq2EaX74ZUMRG4x1MMk8VoMFEkT7A@mail.gmail.com> <78cbccfd909c5f7216ce468cab8e99ff7fd6cbb3.camel@hammerspace.com>
In-Reply-To: <78cbccfd909c5f7216ce468cab8e99ff7fd6cbb3.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 3 Nov 2020 08:29:13 -0500
Message-ID: <CALF+zO=KN3BStGLx8wU9WLnSq-NGNz3fd2cvf+-fyAiwXGb58g@mail.gmail.com>
Subject: Re: [PATCH 09/11] NFS: Improve performance of listing directories
 being modified
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 2, 2020 at 10:39 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Mon, 2020-11-02 at 17:05 -0500, David Wysochanski wrote:
> > On Mon, Nov 2, 2020 at 4:30 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > >
> > > On Mon, 2020-11-02 at 14:45 -0500, David Wysochanski wrote:
> > > > On Mon, Nov 2, 2020 at 12:31 PM Trond Myklebust <
> > > > trondmy@hammerspace.com> wrote:
> > > > >
> > > > > On Mon, 2020-11-02 at 11:26 -0500, David Wysochanski wrote:
> > > > > > On Mon, Nov 2, 2020 at 11:22 AM Trond Myklebust <
> > > > > > trondmy@hammerspace.com> wrote:
> > > > > > >
> > > > > > > On Mon, 2020-11-02 at 08:50 -0500, Dave Wysochanski wrote:
> > > > > > > > A process can hang forever to 'ls -l' a directory while
> > > > > > > > the
> > > > > > > > directory
> > > > > > > > is being modified such as another NFS client adding files
> > > > > > > > to
> > > > > > > > the
> > > > > > > > directory.  The problem is seen specifically with larger
> > > > > > > > directories
> > > > > > > > (I tested with 1 million) and/or slower NFS server
> > > > > > > > responses
> > > > > > > > to
> > > > > > > > READDIR.  If a combination of the NFS directory size, the
> > > > > > > > NFS
> > > > > > > > server
> > > > > > > > responses to READDIR is such that the 'ls' process gets
> > > > > > > > partially
> > > > > > > > through the listing before the attribute cache expires
> > > > > > > > (time
> > > > > > > > exceeds acdirmax), we drop the pagecache and have to re-
> > > > > > > > fill
> > > > > > > > it,
> > > > > > > > and as a result, the process may never complete.  One
> > > > > > > > could
> > > > > > > > argue
> > > > > > > > for larger directories the acdirmin/acdirmax should be
> > > > > > > > increased,
> > > > > > > > but it's not always possible to tune this effectively.
> > > > > > > >
> > > > > > > > The root cause of this problem is due to how the NFS
> > > > > > > > readdir
> > > > > > > > cache
> > > > > > > > currently works.  The main search function,
> > > > > > > > readdir_search_pagecache(),
> > > > > > > > always starts searching at page_index and cookie == 0,
> > > > > > > > and
> > > > > > > > for
> > > > > > > > any
> > > > > > > > page not in the cache, fills in the page with entries
> > > > > > > > obtained in
> > > > > > > > a READDIR NFS call.  If a page already exists, we proceed
> > > > > > > > to
> > > > > > > > nfs_readdir_search_for_cookie(), which searches for the
> > > > > > > > cookie
> > > > > > > > (pos) of the readdir call.  The search is O(n), where n
> > > > > > > > is
> > > > > > > > the
> > > > > > > > directory size before the cookie in question is found,
> > > > > > > > and
> > > > > > > > every
> > > > > > > > entry to nfs_readdir() pays this penalty, irrespective of
> > > > > > > > the
> > > > > > > > current directory position (dir_context.pos).  The search
> > > > > > > > is
> > > > > > > > expensive due to the opaque nature of readdir cookies,
> > > > > > > > and
> > > > > > > > the
> > > > > > > > fact
> > > > > > > > that no mapping (hash) exists from cookies to pages.  In
> > > > > > > > the
> > > > > > > > case
> > > > > > > > of a directory being modified, the above behavior can
> > > > > > > > become
> > > > > > > > an
> > > > > > > > excessive penalty, since the same process is forced to
> > > > > > > > fill
> > > > > > > > pages
> > > > > > > > it
> > > > > > > > may be no longer interested in (the entries were passed
> > > > > > > > in a
> > > > > > > > previous
> > > > > > > > nfs_readdir call), and this can essentially lead no
> > > > > > > > forward
> > > > > > > > progress.
> > > > > > > >
> > > > > > > > To fix this problem, at the end of nfs_readdir(), save
> > > > > > > > the
> > > > > > > > page_index
> > > > > > > > corresponding to the directory position (cookie) inside
> > > > > > > > the
> > > > > > > > process's
> > > > > > > > nfs_open_dir_context.  Then at the next entry of
> > > > > > > > nfs_readdir(),
> > > > > > > > use
> > > > > > > > the saved page_index as the starting search point rather
> > > > > > > > than
> > > > > > > > starting
> > > > > > > > at page_index == 0.  Not only does this fix the problem
> > > > > > > > of
> > > > > > > > listing
> > > > > > > > a directory being modified, it also significantly
> > > > > > > > improves
> > > > > > > > performance
> > > > > > > > in the unmodified case since no extra search penalty is
> > > > > > > > paid
> > > > > > > > at
> > > > > > > > each
> > > > > > > > entry to nfs_readdir().
> > > > > > > >
> > > > > > > > In the case of lseek, since there is no hash or other
> > > > > > > > mapping
> > > > > > > > from a
> > > > > > > > cookie value to the page->index, just reset
> > > > > > > > nfs_open_dir_context.page_index
> > > > > > > > to 0, which will reset the search to the old behavior.
> > > > > > > >
> > > > > > > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > > > > > > ---
> > > > > > > >  fs/nfs/dir.c           | 8 +++++++-
> > > > > > > >  include/linux/nfs_fs.h | 1 +
> > > > > > > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > > > > > > > index 52e06c8fc7cd..b266f505b521 100644
> > > > > > > > --- a/fs/nfs/dir.c
> > > > > > > > +++ b/fs/nfs/dir.c
> > > > > > > > @@ -78,6 +78,7 @@ static struct nfs_open_dir_context
> > > > > > > > *alloc_nfs_open_dir_context(struct inode *dir
> > > > > > > >                 ctx->attr_gencount = nfsi->attr_gencount;
> > > > > > > >                 ctx->dir_cookie = 0;
> > > > > > > >                 ctx->dup_cookie = 0;
> > > > > > > > +               ctx->page_index = 0;
> > > > > > > >                 ctx->cred = get_cred(cred);
> > > > > > > >                 spin_lock(&dir->i_lock);
> > > > > > > >                 if (list_empty(&nfsi->open_files) &&
> > > > > > > > @@ -763,7 +764,7 @@ int
> > > > > > > > find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
> > > > > > > >         return res;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -/* Search for desc->dir_cookie from the beginning of the
> > > > > > > > page
> > > > > > > > cache
> > > > > > > > */
> > > > > > > > +/* Search for desc->dir_cookie starting at desc-
> > > > > > > > >page_index
> > > > > > > > */
> > > > > > > >  static inline
> > > > > > > >  int readdir_search_pagecache(nfs_readdir_descriptor_t
> > > > > > > > *desc)
> > > > > > > >  {
> > > > > > > > @@ -885,6 +886,8 @@ static int nfs_readdir(struct file
> > > > > > > > *file,
> > > > > > > > struct
> > > > > > > > dir_context *ctx)
> > > > > > > >                 .ctx = ctx,
> > > > > > > >                 .dir_cookie = &dir_ctx->dir_cookie,
> > > > > > > >                 .plus = nfs_use_readdirplus(inode, ctx),
> > > > > > > > +               .page_index = dir_ctx->page_index,
> > > > > > > > +               .last_cookie =
> > > > > > > > nfs_readdir_use_cookie(file) ?
> > > > > > > > ctx-
> > > > > > > > > pos : 0,
> > > > > > > >         },
> > > > > > > >                         *desc = &my_desc;
> > > > > > > >         int res = 0;
> > > > > > > > @@ -938,6 +941,7 @@ static int nfs_readdir(struct file
> > > > > > > > *file,
> > > > > > > > struct
> > > > > > > > dir_context *ctx)
> > > > > > > >  out:
> > > > > > > >         if (res > 0)
> > > > > > > >                 res = 0;
> > > > > > > > +       dir_ctx->page_index = desc->page_index;
> > > > > > > >         trace_nfs_readdir_exit(inode, ctx->pos, dir_ctx-
> > > > > > > > > dir_cookie,
> > > > > > > >                                NFS_SERVER(inode)->dtsize,
> > > > > > > > my_desc.plus, res);
> > > > > > > >         return res;
> > > > > > > > @@ -975,6 +979,8 @@ static loff_t nfs_llseek_dir(struct
> > > > > > > > file
> > > > > > > > *filp,
> > > > > > > > loff_t offset, int whence)
> > > > > > > >                 else
> > > > > > > >                         dir_ctx->dir_cookie = 0;
> > > > > > > >                 dir_ctx->duped = 0;
> > > > > > > > +               /* Force readdir_search_pagecache to
> > > > > > > > start
> > > > > > > > over
> > > > > > > > */
> > > > > > > > +               dir_ctx->page_index = 0;
> > > > > > > >         }
> > > > > > > >         inode_unlock(inode);
> > > > > > > >         return offset;
> > > > > > > > diff --git a/include/linux/nfs_fs.h
> > > > > > > > b/include/linux/nfs_fs.h
> > > > > > > > index a2c6455ea3fa..0e55c0154ccd 100644
> > > > > > > > --- a/include/linux/nfs_fs.h
> > > > > > > > +++ b/include/linux/nfs_fs.h
> > > > > > > > @@ -93,6 +93,7 @@ struct nfs_open_dir_context {
> > > > > > > >         __u64 dir_cookie;
> > > > > > > >         __u64 dup_cookie;
> > > > > > > >         signed char duped;
> > > > > > > > +       unsigned long   page_index;
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  /*
> > > > > > >
> > > > > > > NACK. It makes no sense to store the page index as a
> > > > > > > cursor.
> > > > > > >
> > > > > >
> > > > > > A similar thing was done recently with:
> > > > > > 227823d2074d nfs: optimise readdir cache page invalidation
> > > > > >
> > > > >
> > > > > That's a very different thing. It is about discarding page data
> > > > > in
> > > > > order to force a re-read of the contents into cache.
> > > > >
> > > > Right - I only pointed it out because it is in effect a cursor
> > > > about
> > > > the last access into the cache but it's on a global basis, not
> > > > process context.
> > > >
> > > > > What you're doing is basically trying to guess where the data
> > > > > is
> > > > > located. which might work in some cases where the directory is
> > > > > completely static, but if it shrinks (e.g. due to a few
> > > > > unlink() or
> > > > > rename() calls) so that you overshoot the cookie, then you can
> > > > > end
> > > > > up
> > > > > reading all the way to the end of the directory before doing an
> > > > > uncached readdir.
> > > > >
> > > > First, consider the unmodified (idle directory) scenario.  Today
> > > > the
> > > > performance is bad the larger the directory goes - do you see
> > > > why?
> > > > I tried to explain in the cover letter and header but maybe it's
> > > > not
> > > > clear?
> > > >
> > > > Second, the modified scenario today the performance is very bad
> > > > because of the same problem - the cookie is reset and the process
> > > > needs to start over at cookie 0, repeating READDIRs.  But maybe
> > > > there's a specific scenario I'm not thinking about.
> > > >
> > > > The way I thought about this is that if you're in a heavily
> > > > modified
> > > > scenario with a large directory and you're past the 'acdirmax'
> > > > time,
> > > > you have to make the choice of either:
> > > > a) ignoring 'acdirmax' (this is what the NFSv3 patch did) and
> > > > even
> > > > though you know the cache expired you keep going as though it
> > > > did not (at least until a different process starts a listing)
> > > > b) honoring 'acdirmax' (drop the pagecache), but keep going the
> > > > best you can based on the previous information and don't try to
> > > > rebuild the cache before continuing.
> > > >
> > > > > IOW: This will have a detrimental effect for some workloads,
> > > > > which
> > > > > needs to be weighed up against the benefits. I saw that you've
> > > > > tested
> > > > > with large directories, but what workloads were you testing on
> > > > > those
> > > > > directories?
> > > > >
> > > > I can definitely do further testing and any scenario you want to
> > > > try
> > > > to
> > > > break it or find a pathological scenario. So far I've tested the
> > > > reader ("ls -lf") in parallel with one of the two writers:
> > > > 1) random add a file every 0.1s:
> > > > while true; do i=$((1 + RANDOM % $NUM_FILES)); echo $i; touch
> > > > $MNT2/file$i.bin; builtin sleep 0.1; done > /dev/null 2>&1 &
> > > > 2) random delete a file every 0.1 s:
> > > > while true; do i=$((1 + RANDOM % $NUM_FILES)); echo $i; rm -f
> > > > $MNT2/file$i; builtin sleep 0.1; done > /dev/null 2>&1 &
> > > >
> > > > In no case did I see it take a longer time or ops vs vanilla 5.9,
> > > > the
> > > > idle
> > > > and modified performance is better (measured in seconds and ops)
> > > > with this patch.  Below is a short summary.  Note that the first
> > > > time
> > > > and
> > > > ops is with an idle directory, and the second one is the
> > > > modified.
> > > >
> > > > 5.9 (vanilla): random delete a file every 0.1 s:
> > > > Ops increased from 4734 to 8834
> > > > Time increased from 23 to 44
> > > >
> > > > 5.9 (this patch): random delete a file every 0.1 s:
> > > > Ops increased from 4697 to 4696
> > > > Time increased from 20 to 30
> > > >
> > > >
> > > > 5.9 (vanilla): random add a file every 0.1s:
> > > > Ops increased from 4734 to 9168
> > > > Time increased from 23 to 43
> > > >
> > > > 5.9 (this patch): random add a file every 0.1s:
> > > > Ops increased from 4697 to 4702
> > > > Time increased from 21 to 32
> > > >
> > >
> > > If you're not seeing any change in number of ops then those numbers
> > > are
> > > basically telling you that you're not seeing any cache
> > > invalidation.
> > > You should be seeing cache invalidation when you are creating and
> > > deleting files and are doing simultaneous readdirs.
> > >
> >
> > No I think you're misunderstanding or we're not on the same page.
> > The difference is, with 5.9 vanilla when the invalidation occurs, the
> > reader process has to go back to cookie 0 and pays the penalty
> > to refill all the cache pages up to cookie 'N'.  With the patch this
> > is not the case - it continues on with cookie 'N' and does not pay
> > the
> > penalty - the next reader does
> >
>
> Then I still don't see how you can avoid corrupting the page cache when
> you're in effect just starting filling in cookies at a random page
> cache index + offset that bears no relation to where the cookie would
> end up if the reader started from 0.
>
I was concerned about this too.

I don't have absolute proof of the pagecache state, but I did do
some tests in live crash listing the pages on the directory inode
while I had deleted a portion of the files in the directory and a
listing was going to see if the pagecache got messed up.  I
think we may end up with pages that get in effect "temporarily orphaned"
by the one reader that runs into this condition, but the next reader
will start at 0 and so those pages will only be temporary and not
findable by anyone else.  If the directory is constantly changing,
then the pagecache will get dumped again soon.  But as you point
out it probably is not a good approach.

> However leaving aside that issue, what's the point of using the page
> cache if the next reader has to clear out the data and start afresh
> anyway? Why not just let all the threads avoid the page cache and just
> do uncached readdir?
>
Yes I agree.  The problem I'm working on finding a solution for is
such that the cache is not valuable anymore - basically we have
timers (acdirmin/acdirmax) that govern how long the cache is valid
and we blow past those when doing one pass through the directory.
In that instance we mainly want to ensure forward progress, so
it would make sense to shift to uncached operation.



> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

