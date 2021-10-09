Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DD9427AAB
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Oct 2021 15:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhJINp2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 Oct 2021 09:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233861AbhJINp2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 Oct 2021 09:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633787010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvYUcGmozvzYzMnFhJW310OPBNNWW48Bd8FVBdQwLhU=;
        b=cxB40KCGuZWfe6j72iq2Q4kaaoHDuJe9oc97XeMsXc5eVyuO3/CtEYWTFjDp/Z8OwcIoOc
        s3EShIh6zvgii3EOw5PP82SkLSwnQ293+f5PmBEBWKMu+QXYoa6S8ieXOVgw794v8jbAJK
        KkrhktDtR1joB6AUDQN8alkNS7qbLQI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-TzdeEYppOVSa1hJvGFqW7Q-1; Sat, 09 Oct 2021 09:43:29 -0400
X-MC-Unique: TzdeEYppOVSa1hJvGFqW7Q-1
Received: by mail-ed1-f69.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso11622886edj.20
        for <linux-nfs@vger.kernel.org>; Sat, 09 Oct 2021 06:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvYUcGmozvzYzMnFhJW310OPBNNWW48Bd8FVBdQwLhU=;
        b=zmjdYf+ttuuLDwH8nRU3mZ/a+cTKEfNy9W4xkpEDesvpkInU7vkc0B6gXj8webiXY0
         WGXHZ3ZbatKEUhOt/DeOc8cjiEnRQqZDiVmve1Te2XiVLQZ8MMHc1uKOCsDz/E4/Kkz7
         MQfnAakTyFVEJ5cnrK3M5vguzKcmvZ6cmRTublCTTdR1w6rw93qiAHw+g5MablmHcw7r
         /q0Hz20pvmQSL2QR/P9qoAUKCr1Agn6GvSHS9YfooslAxHbrkNE18kq0Aiqie3zLxAHv
         Rl7Cxs6SjoFtGnKg26JZIeoma5c3ysQGD6NdKmrokJPyKRNEz3oe1ENoY7It8Mn5gazj
         9AaA==
X-Gm-Message-State: AOAM5310W28mWvBmj6DvjD8JIRhfSSe4/PwujO7sEFx6gg6DplI8qpJg
        ZGkCqvYELY4g9G8r12NPMqg4ilM0tYJxWTlATxd7vEv0yQp02CIzPDKQtZUz1PxrX3NtDIUZRUy
        w5u7JsuzyVBxwQH0PFdvo4nnok0WXPC66KhaN
X-Received: by 2002:a17:906:80c5:: with SMTP id a5mr5766757ejx.119.1633787008461;
        Sat, 09 Oct 2021 06:43:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQjkjvpDtK0CbCjQot6SR74W5x6dXmBnEKXUIRWAzk8JQBFJBfY+A6iacCPeYFIoSs+7o/dIm4XpZQnu0phEQ=
X-Received: by 2002:a17:906:80c5:: with SMTP id a5mr5766739ejx.119.1633787008216;
 Sat, 09 Oct 2021 06:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <1633649528-1321-1-git-send-email-dwysocha@redhat.com>
 <1633649528-1321-2-git-send-email-dwysocha@redhat.com> <3F1E7B93-EB8D-4744-8143-D44654CA6451@oracle.com>
 <CALF+zO=pEs2-8eDzVz7PPFZc-pv+X7e0FbOiUt3Ce86fMV=NRQ@mail.gmail.com>
In-Reply-To: <CALF+zO=pEs2-8eDzVz7PPFZc-pv+X7e0FbOiUt3Ce86fMV=NRQ@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Sat, 9 Oct 2021 09:42:51 -0400
Message-ID: <CALF+zOktQ=FVY0QX=gkzrNEm5DQSJk-XJSpa6_ZbQsz9hvgEwA@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFS: Convert from readpages() to readahead()
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Oct 9, 2021 at 8:35 AM David Wysochanski <dwysocha@redhat.com> wrote:
>
> On Fri, Oct 8, 2021 at 10:10 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >
> >
> >
> > > On Oct 7, 2021, at 7:32 PM, Dave Wysochanski <dwysocha@redhat.com> wrote:
> > >
> > > Convert to the new VM readahead() API which is the preferred API
> > > to read multiple pages, and rename the NFSIOS_* counters and the
> > > tracepoint as needed.
> > >
> > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > ---
> > > fs/nfs/file.c              |  2 +-
> > > fs/nfs/nfstrace.h          |  2 +-
> > > fs/nfs/read.c              | 21 +++++++++++++++------
> > > include/linux/nfs_fs.h     |  3 +--
> > > include/linux/nfs_iostat.h |  6 +++---
> > > 5 files changed, 21 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> > > index 209dac208477..cc76d17fa97f 100644
> > > --- a/fs/nfs/file.c
> > > +++ b/fs/nfs/file.c
> > > @@ -519,7 +519,7 @@ static void nfs_swap_deactivate(struct file *file)
> > >
> > > const struct address_space_operations nfs_file_aops = {
> > >       .readpage = nfs_readpage,
> > > -     .readpages = nfs_readpages,
> > > +     .readahead = nfs_readahead,
> > >       .set_page_dirty = __set_page_dirty_nobuffers,
> > >       .writepage = nfs_writepage,
> > >       .writepages = nfs_writepages,
> > > diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> > > index 78b0f649dd09..d2b2080765a6 100644
> > > --- a/fs/nfs/nfstrace.h
> > > +++ b/fs/nfs/nfstrace.h
> > > @@ -915,7 +915,7 @@
> > >               )
> > > );
> > >
> > > -TRACE_EVENT(nfs_aops_readpages,
> > > +TRACE_EVENT(nfs_aops_readahead,
> >
> > In v2 and v3 of my patch, this tracepoint has already been
> > renamed to nfs_aop_readahead.
> >
>
> Ack.
>
> >
> > >               TP_PROTO(
> > >                       const struct inode *inode,
> > >                       unsigned int nr_pages
> > > diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> > > index 927504605e0f..5c2aab47cf1d 100644
> > > --- a/fs/nfs/read.c
> > > +++ b/fs/nfs/read.c
> > > @@ -395,15 +395,19 @@ int nfs_readpage(struct file *file, struct page *page)
> > >       return ret;
> > > }
> > >
> > > -int nfs_readpages(struct file *file, struct address_space *mapping,
> > > -             struct list_head *pages, unsigned nr_pages)
> > > +void nfs_readahead(struct readahead_control *ractl)
> > > {
> > > +     struct file *file = ractl->file;
> > > +     struct address_space *mapping = ractl->mapping;
> > > +     struct page *page;
> > > +     unsigned int nr_pages = readahead_count(ractl);
> > > +
> > >       struct nfs_readdesc desc;
> > >       struct inode *inode = mapping->host;
> > >       int ret;
> > >
> > > -     trace_nfs_aops_readpages(inode, nr_pages);
> > > -     nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
> > > +     trace_nfs_aops_readahead(inode, nr_pages);
> > > +     nfs_inc_stats(inode, NFSIOS_VFSREADAHEAD);
> > >
> > >       ret = -ESTALE;
> > >       if (NFS_STALE(inode))
> > > @@ -420,13 +424,18 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
> > >       nfs_pageio_init_read(&desc.pgio, inode, false,
> > >                            &nfs_async_read_completion_ops);
> > >
> > > -     ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
> > > +     ret = 0;
> > > +     while (!ret && (page = readahead_page(ractl))) {
> > > +             prefetchw(&page->flags);
> > > +             ret = readpage_async_filler(&desc, page);
> > > +             put_page(page);
> > > +     }
> > >
> > >       nfs_pageio_complete_read(&desc.pgio);
> > >
> > >       put_nfs_open_context(desc.ctx);
> > > out:
> > > -     return ret;
> > > +     return;
> > > }
> > >
> > > int __init nfs_init_readpagecache(void)
> > > diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> > > index b9a8b925db43..6cbe3f2c5669 100644
> > > --- a/include/linux/nfs_fs.h
> > > +++ b/include/linux/nfs_fs.h
> > > @@ -580,8 +580,7 @@ extern int nfs_access_get_cached(struct inode *inode, const struct cred *cred, s
> > >  * linux/fs/nfs/read.c
> > >  */
> > > extern int  nfs_readpage(struct file *, struct page *);
> > > -extern int  nfs_readpages(struct file *, struct address_space *,
> > > -             struct list_head *, unsigned);
> > > +extern void nfs_readahead(struct readahead_control *);
> > >
> > > /*
> > >  * inline functions
> > > diff --git a/include/linux/nfs_iostat.h b/include/linux/nfs_iostat.h
> > > index 027874c36c88..418145f23700 100644
> > > --- a/include/linux/nfs_iostat.h
> > > +++ b/include/linux/nfs_iostat.h
> > > @@ -22,7 +22,7 @@
> > > #ifndef _LINUX_NFS_IOSTAT
> > > #define _LINUX_NFS_IOSTAT
> > >
> > > -#define NFS_IOSTAT_VERS              "1.1"
> > > +#define NFS_IOSTAT_VERS              "1.2"
> > >
> > > /*
> > >  * NFS byte counters
> > > @@ -53,7 +53,7 @@
> > >  * NFS page counters
> > >  *
> > >  * These count the number of pages read or written via nfs_readpage(),
> > > - * nfs_readpages(), or their write equivalents.
> > > + * nfs_readahead(), or their write equivalents.
> > >  *
> > >  * NB: When adding new byte counters, please include the measured
> > >  * units in the name of each byte counter to help users of this
> > > @@ -98,7 +98,7 @@ enum nfs_stat_eventcounters {
> > >       NFSIOS_VFSACCESS,
> > >       NFSIOS_VFSUPDATEPAGE,
> > >       NFSIOS_VFSREADPAGE,
> > > -     NFSIOS_VFSREADPAGES,
> > > +     NFSIOS_VFSREADAHEAD,
> >
> > I'm wondering if you should add NFSIOS_VFSREADAHEAD
> > but leave NFSIOS_VFSREADPAGES? I don't remember exactly
> > how the mountstats API versioning is supposed to work.
> >
>
> I don't think we need to keep this but correct me if I'm wrong.
> That would mean we would have a 0 count for later kernels and I'm not
> sure about that given the similarities.

It may matter in the case of "old nfs-utils" and newer kernel.
Do we want nfs-utils to display 0 for VFSREADPAGES count in that case?
Or would users be more confused by the fact this value is always 0 and
there's no notion of "VFSREADAHEAD" counts in older nfs-utils?
Would users be more surprised by 0 here or the fact there's a more
subtle change in the interface?
I would say the permanent 0 value would be most surprising to users so
I'd shy away from it.

> You can see my nfs-utils patch for the attempt to use the versioning
> in nfs-iostat.
>
> >
> > >       NFSIOS_VFSWRITEPAGE,
> > >       NFSIOS_VFSWRITEPAGES,
> > >       NFSIOS_VFSGETDENTS,
> > > --
> > > 1.8.3.1
> > >
> >
> > --
> > Chuck Lever
> >
> >
> >

