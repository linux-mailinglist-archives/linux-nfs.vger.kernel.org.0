Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4482B0877
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 16:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgKLPem (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 10:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgKLPem (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 10:34:42 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9065BC0613D1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 07:34:41 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id w13so8386927eju.13
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 07:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Orfz2iJGsWP5JmhGofAn9Iukr+gLRmZi2dXpF2OK7I4=;
        b=oEjm5GFkJilAjoEhbKy6KBq4rEGhZ6j2Bsi4BuwkjxxeEIYr9kLtScjB1PIgQKqJUX
         O6MPajOoB10ZoPQq/7cjuim6LWVITKfSkhZoNYwaInZtWn7CebvJqoQif0lxJYzCrMgj
         UyAlev9LwOIWiB0GJKoY7RqMuVDmEEhmJj+7Ah9Y/+c/Ow34VS3tntduMXdpzjm+IB2V
         UrRiTTUVcIElXpXSHvdN/6s1uzHtRmEDS/zjyXQiSyPS8iz4gMx0LGZfrmn6AA0dZMmn
         JCqapY2o9PJpeZxa2vYl9mrKdtcI/zELQ3u97THsNW9tfFBUVTa7rzsb4WrHP5v4ROm0
         idOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Orfz2iJGsWP5JmhGofAn9Iukr+gLRmZi2dXpF2OK7I4=;
        b=la+I9smm+ABd546+xB7SDWMZTlNNIlXqB2Idt2pq1gfx7HK2A0MqzHZTnCNoYlrazk
         Tl8QE+VGkeXwO1jJGvWjCon1X4J9aA4LnobfitWtp04/1IB7Zx+whEzTOQ3FFsvgn7Rs
         XbwotDHhqCsiNRJkf3fv4Ol1eUerYY0cLpiC72xbLV1J+R1eUghdqRtSIQviplW1MaFR
         2JDHsaqb/ytWYbV+bt3waC7EWv1QV1XtqpFugfPODIRk1A03TQw6VQ/12nI4up99r6G+
         JdSk6bvr0bq5DecZ82WnDjGKFTF/XugxGkalVE8zoSXOsP6HOCDRAmGljvIPDLtVNf9A
         st2Q==
X-Gm-Message-State: AOAM531dSr9SL+Zjjw8Rtup8IdReHUMB3oHAixJddUwUBaR7+8xPuZ2r
        FyylT+dqMCgyaXrVTfuajsrdPq1TuWeXt2XPSxApxw==
X-Google-Smtp-Source: ABdhPJyi7MDQ/RGCV0o26qkf/NhAIBZetZcpGhSJLeyqH7HTDuBVnegL6NqzGKKFg3AtVB7Z2KGyvr3uT787TFadEug=
X-Received: by 2002:a17:906:114b:: with SMTP id i11mr29854024eja.106.1605195280103;
 Thu, 12 Nov 2020 07:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20201110213741.860745-1-trondmy@kernel.org> <CALF+zOkdXMDZ3TNGSNJQPtxy-ru_4iCYTz3U2uwkPAo3j55FZg@mail.gmail.com>
 <CALF+zO=-Si+CcEJvgzaYAjd2j8APV=4Xwm=FJibhuJRV+zWE5Q@mail.gmail.com>
In-Reply-To: <CALF+zO=-Si+CcEJvgzaYAjd2j8APV=4Xwm=FJibhuJRV+zWE5Q@mail.gmail.com>
From:   Guy Keren <guy@vastdata.com>
Date:   Thu, 12 Nov 2020 17:34:21 +0200
Message-ID: <CAENext7G47KvYO3q0_7g3KUX+QxQs3G17nuqs=Npsg2RBPdX7g@mail.gmail.com>
Subject: Re: [PATCH v5 00/22] Readdir enhancements
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     trondmy@kernel.org, linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

just a general question: since the cache seems to cause many problems
when dealing with very large directories, and since all solutions
proposed until now don't seem to fully solve those problems, won't an
approach such as "if the directory entries count exceeded X - stop
using the cache completely" - where X is proportional to the size of
the directory entries cache size limit - make the code simpler, and
less prone to bugs of this sort?

i *think* we can understand that for a directory with millions of
files, we'll not have efficient caching on the client side, while
limiting ourselves to reasonable RAM consumption?

--guy keren
Vast data

On Thu, Nov 12, 2020 at 1:46 PM David Wysochanski <dwysocha@redhat.com> wrote:
>
> On Wed, Nov 11, 2020 at 5:15 PM David Wysochanski <dwysocha@redhat.com> wrote:
> >
> > On Tue, Nov 10, 2020 at 4:48 PM <trondmy@kernel.org> wrote:
> > >
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > >
> > > The following patch series performs a number of cleanups on the readdir
> > > code.
> > > It also adds support for 1MB readdir RPC calls on-the-wire, and modifies
> > > the caching code to ensure that we cache the entire contents of that
> > > 1MB call (instead of discarding the data that doesn't fit into a single
> > > page).
> > > For filesystems that use ordered readdir cookie schemes (e.g. XFS), it
> > > optimises searching for cookies in the client's page cache by skipping
> > > over pages that contain cookie values that are not in the range we are
> > > searching for.
> > > Finally, it improves scalability when dealing with very large
> > > directories by turning off caching when those directories are changing,
> > > so as to avoid the need for a linear search on the client of the entire
> > > directory when looking for the first entry pointed to by the current
> > > file descriptor offset.
> > >
> > > v2: Fix the handling of the NFSv3/v4 directory verifier.
> > > v3: Optimise searching when the readdir cookies are seen to be ordered.
> > > v4: Optimise performance for large directories that are changing.
> > >     Add in llseek dependency patches.
> > > v5: Integrate Olga's patch for the READDIR security label handling.
> > >     Record more entries in the uncached readdir case. Bump the max
> > >     number of pages to 512, but allocate them on demand in case the
> > >     readdir RPC call returns fewer entries.
> > >
> > > Olga Kornievskaia (1):
> > >   NFSv4.2: condition READDIR's mask for security label based on LSM
> > >     state
> > >
> > > Trond Myklebust (21):
> > >   NFS: Remove unnecessary inode locking in nfs_llseek_dir()
> > >   NFS: Remove unnecessary inode lock in nfs_fsync_dir()
> > >   NFS: Ensure contents of struct nfs_open_dir_context are consistent
> > >   NFS: Clean up readdir struct nfs_cache_array
> > >   NFS: Clean up nfs_readdir_page_filler()
> > >   NFS: Clean up directory array handling
> > >   NFS: Don't discard readdir results
> > >   NFS: Remove unnecessary kmap in nfs_readdir_xdr_to_array()
> > >   NFS: Replace kmap() with kmap_atomic() in nfs_readdir_search_array()
> > >   NFS: Simplify struct nfs_cache_array_entry
> > >   NFS: Support larger readdir buffers
> > >   NFS: More readdir cleanups
> > >   NFS: nfs_do_filldir() does not return a value
> > >   NFS: Reduce readdir stack usage
> > >   NFS: Cleanup to remove nfs_readdir_descriptor_t typedef
> > >   NFS: Allow the NFS generic code to pass in a verifier to readdir
> > >   NFS: Handle NFS4ERR_NOT_SAME and NFSERR_BADCOOKIE from readdir calls
> > >   NFS: Improve handling of directory verifiers
> > >   NFS: Optimisations for monotonically increasing readdir cookies
> > >   NFS: Reduce number of RPC calls when doing uncached readdir
> > >   NFS: Do uncached readdir when we're seeking a cookie in an empty page
> > >     cache
> > >
> > >  fs/nfs/client.c         |   4 +-
> > >  fs/nfs/dir.c            | 734 +++++++++++++++++++++++++---------------
> > >  fs/nfs/inode.c          |   7 -
> > >  fs/nfs/internal.h       |   6 -
> > >  fs/nfs/nfs3proc.c       |  35 +-
> > >  fs/nfs/nfs4proc.c       |  48 +--
> > >  fs/nfs/proc.c           |  18 +-
> > >  include/linux/nfs_fs.h  |   9 +-
> > >  include/linux/nfs_xdr.h |  17 +-
> > >  9 files changed, 541 insertions(+), 337 deletions(-)
> > >
> > > --
> > > 2.28.0
> > >
> >
> > I wrote a test script and ran this patchset against 5.10-rc2 in a
> > variety of scenarios listing 1 million files and various directory
> > modification scenarios. The test checked ops, runtime and cookie
> > resets (via tcpdump).
> >
> > All runs performed very well on all scenarios I threw at it on all NFS
> > versions (I tested 3, 4.0, 4.1, and 4.2) with fairly dramatic
> > improvements vs the same runs on 5.10-rc2.   One scenario I found
> > where a single 'ls -l' could take a long time (about 5 minutes, but
> > not unbounded time) was when the directory was being modified with
> > both file adds and removed, but this seemed due to other ops unrelated
> > to readdir performance.   A second scenario that this patchset does
> > not fix is the scenario where the directory is large enough to exceed
> > the acdirmax, is being modified (adds and removes), and _multiple_
> > processes are listing it.  In this scenario a lister can still have
> > unbounded time, but the existing readdir code also has this problem
> > and fixing that probably requires another patch / approach (such as
> > reworking the structure of the cache or an approach such as the flag
> > on per-process dir context).
> >
>
> I think I am mistaken in my previous email that said multiple listers
> will not make forward progress.  After more testing I could not
> reproduce any indefinite wait but it was many minutes, and I think
> there is proof in the current code (patch 22) that an indefinite wait
> should not occur with any process (multiple processes does not change
> this).  Note that I did not trace this, but below is an attempt at a
> more detailed explanation from the code.  The summary of the argument
> is that periodically nfs_readdir_dont_search_cache() will be true for
> one iteration of nfs_readdir(), and this ensures forward progress,
> even if it may be slow.
>
> Some notation for the below explanation.
> Tu: Time to list unmodified (idle) directory
> Ax: acdirmax
> Assume Tu > acdirmax (time to list idle directory is larger than
> acdirmax) and i_size_read(dir) > NFS_SERVER(dir)->dtsize
> PL1: pid1 that is listing the directory
> DC1, DC2 and DC3: values of nfs_open_dir_context.dir_cookie for PL1
> PL1_dir_cookie: the current value of PL1's nfs_open_dir_context.dir_cookie
>
> Then consider the following timeline, with "Tn" various points on a
> timeline of PL1 listing a very large directory.
>
> T0: PL1 starts listing directory with repeated calls to nfs_readdir()
> T1: acdirmax is exceeded, and we drop the pagecache (mapping->nrpages
> == 0); at this point, PL1_dir_cookie = DC1 != 0
> T2: PL1 calls nfs_readdir and nfs_readdir_dont_search_cache() returns
> true (due to mapping->nrpages == 0), so enters uncached_readdir();
> thus, PL1_dir_cookie makes forward progress so PL1_dir_cookie is ahead
> of DC1 and the exit of nfs_readdir()
> T3: PL1 calls nfs_readdir() and nfs_readdir_dont_search_cache() is
> false, so it must restart filling the pagecache from cookie == 0 (we
> send READDIRs over the wire); at this point PL1_dir_cookie forward
> progress is stalled, and PL1's calls to nfs_readdir() will have to
> fetch entries and fill pages in the pagecache that does not pertain to
> its listing (they've already been returned to userspace in a previous
> nfs_readdir call)
> T4: acdirmax is exceeded, and we drop the pagecache again, setting
> mapping->nrpages == 0; at this point though, PL1_dir_cookie = DC2,
> where DC2 is ahead of DC1 (we made forward progress last time)
> T5: PL1 calls nfs_readdir and nfs_readdir_dont_search_cache() returns
> true, so enters uncached_readdir(); thus, PL1_dir_cookie makes forward
> progress again for this one call to nfs_readdir(), and PL1_dir_cookie
> = DC3 is ahead of DC2
>
> Thus, it seems PL1 will eventually complete, even if it is delayed a
> bit, and even if it has to re-fill pages in the page cache that is
> "extra work" that doesn't help PL1.  Forward progress is guaranteed
> due to the periodic calls to nfs_readdir() when
> nfs_readdir_dont_search_cache() returns true due to mapping->nrpages
> == 0 portion of the condition inside nfs_readdir_dont_search_cache()
> +static bool nfs_readdir_dont_search_cache(struct nfs_readdir_descriptor *desc)
> +{
> +       struct address_space *mapping = desc->file->f_mapping;
> +       struct inode *dir = file_inode(desc->file);
> +       unsigned int dtsize = NFS_SERVER(dir)->dtsize;
> +       loff_t size = i_size_read(dir);
> +
> +       /*
> +        * Default to uncached readdir if the page cache is empty, and
> +        * we're looking for a non-zero cookie in a large directory.
> +        */
> +       return desc->dir_cookie != 0 && mapping->nrpages == 0 && size > dtsize;
> +}
>
>
>
>
> > I think these patches make NFS readdir dramatically better, and they
> > fix a lot of underlying issues with the existing code, like the cookie
> > resets when pagecache is dropped, single page rx data problem, etc.
> > Thank you for doing these patches.
> >
> > Tested-by: Dave Wysochanski
>
