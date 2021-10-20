Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D94435426
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 21:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhJTT4V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 15:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230326AbhJTT4U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Oct 2021 15:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634759645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pniunILaSn/hzIB/5zP3tqKBdSvzKkZgYmhtJvDwjCU=;
        b=Qf7csb/j11fE7JD8TaYS9lquFUMJZRKyYbBNsJr17KYXDSbhWfOEAtyJa2zXu3toByHFV2
        p0jQ2Mg22ssJlCs9ZofGqoFcwnhKhe9w/L0JfHe0e2uOg2BxUoOYLFXOUuTsm0DKgo5+t7
        Q7TritZTHqoL470OdmHUMS3moIoIcQs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-Y2IHHSNJNmKP_CiVXthBGw-1; Wed, 20 Oct 2021 15:54:04 -0400
X-MC-Unique: Y2IHHSNJNmKP_CiVXthBGw-1
Received: by mail-ed1-f72.google.com with SMTP id f4-20020a50e084000000b003db585bc274so21999701edl.17
        for <linux-nfs@vger.kernel.org>; Wed, 20 Oct 2021 12:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pniunILaSn/hzIB/5zP3tqKBdSvzKkZgYmhtJvDwjCU=;
        b=Zi4KOqYKHaXo8tRB5ZDBgnBBJUUIn5vJsJewMMYlR1YGftEuRwUTUtzmL2mrn+iPbF
         KNQe3Ej621ZG8J1R135cZJ4WntzaEYJN4JOt6sXnJY+vXM05/5+7y0uo0sPouKni/R33
         GvBZguYZaghQvkU6ipaHKiXYt5dxaYXZ0zR49Hbmo6gx0o94uRaULhF3QzvksWyVQWKT
         SLfTg9vn0vHSVTeh1lggDNAXN5eJ7diRvEwR3AV5YpgQgslfPk5Vteu7YXbx3QFKq2+G
         sHAnoqof2mA2InIIDcNzTPRLfoPd3uE2gcVuxLJM5SZxg7dfGWI57yqneINXKnlKFE8c
         xwUQ==
X-Gm-Message-State: AOAM532Kup4Ot8rIYB6VYdznSHjgake2sAhJtvQVWu5d89i0GIt0ujGb
        iWKStv2LpYBm+fsxrrsFKhSlmvAXYi7ry78l7oXCBG0s7u+ep3RigX+qTE1Os57LldOXmJhPBr7
        yh54GwC7+OSnFsGqKQRCw+xhi42l9y3oExTn6
X-Received: by 2002:a50:bf4a:: with SMTP id g10mr1341909edk.11.1634759642920;
        Wed, 20 Oct 2021 12:54:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBw6V+b9V4aXsja4PT9xde9cTy3qTkYWyEyIxufDogutNv8meUsza2e2MtfOhvygkF0qVYjHe0F2YorMNP+zs=
X-Received: by 2002:a50:bf4a:: with SMTP id g10mr1341872edk.11.1634759642650;
 Wed, 20 Oct 2021 12:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <1633782962-18335-1-git-send-email-dwysocha@redhat.com>
 <1633782962-18335-2-git-send-email-dwysocha@redhat.com> <33f3ce883c7f874e2aa684f3ad83882bf7c38acb.camel@hammerspace.com>
In-Reply-To: <33f3ce883c7f874e2aa684f3ad83882bf7c38acb.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 20 Oct 2021 15:53:26 -0400
Message-ID: <CALF+zO=F+2xETFg2kJXO+bC5Z2B52Rz_MQeSdcRF+cnfZ3WdxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] NFS: Convert from readpages() to readahead()
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 20, 2021 at 3:27 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Sat, 2021-10-09 at 08:36 -0400, Dave Wysochanski wrote:
> > Convert to the new VM readahead() API which is the preferred API
> > to read multiple pages, and rename the NFSIOS_* counters and the
> > tracepoint as needed.
> >
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> >  fs/nfs/file.c              |  2 +-
> >  fs/nfs/read.c              | 18 +++++++++++++-----
> >  include/linux/nfs_fs.h     |  3 +--
> >  include/linux/nfs_iostat.h |  6 +++---
> >  4 files changed, 18 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> > index 209dac208477..cc76d17fa97f 100644
> > --- a/fs/nfs/file.c
> > +++ b/fs/nfs/file.c
> > @@ -519,7 +519,7 @@ static void nfs_swap_deactivate(struct file
> > *file)
> >
> >  const struct address_space_operations nfs_file_aops = {
> >         .readpage = nfs_readpage,
> > -       .readpages = nfs_readpages,
> > +       .readahead = nfs_readahead,
> >         .set_page_dirty = __set_page_dirty_nobuffers,
> >         .writepage = nfs_writepage,
> >         .writepages = nfs_writepages,
> > diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> > index d06b91a101d2..296ea9a9b6ce 100644
> > --- a/fs/nfs/read.c
> > +++ b/fs/nfs/read.c
> > @@ -397,15 +397,19 @@ int nfs_readpage(struct file *file, struct page
> > *page)
> >         return ret;
> >  }
> >
> > -int nfs_readpages(struct file *file, struct address_space *mapping,
> > -               struct list_head *pages, unsigned nr_pages)
> > +void nfs_readahead(struct readahead_control *ractl)
> >  {
> > +       struct file *file = ractl->file;
> > +       struct address_space *mapping = ractl->mapping;
> > +       struct page *page;
> > +       unsigned int nr_pages = readahead_count(ractl);
> > +
> >         struct nfs_readdesc desc;
> >         struct inode *inode = mapping->host;
> >         int ret;
> >
> >         trace_nfs_aop_readahead(inode, nr_pages);
> > -       nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
> > +       nfs_inc_stats(inode, NFSIOS_VFSREADAHEAD);
> >
> >         ret = -ESTALE;
> >         if (NFS_STALE(inode))
> > @@ -422,14 +426,18 @@ int nfs_readpages(struct file *file, struct
> > address_space *mapping,
>
>
> This function fails to compile due to the call to
> nfs_readpages_from_fscache() taking a 'pages' argument.
>

Sorry about the confusion.  See the "PATCH 0/1" description [1].
This patch as posted assumes dhowells "fallback API" series.
Are you ok with that series, or do you still have concerns?

I am not sure if I can redo this patch without that series but I can
try if you're opposed to the fallback API series or see problems
such as merging conflicts or want this patch only for some reason.

Let me know what you want and I'll try to make it happen.

[1] https://marc.info/?l=linux-nfs&m=163378294028491&w=2




> >         nfs_pageio_init_read(&desc.pgio, inode, false,
> >                              &nfs_async_read_completion_ops);
> >
> > -       ret = read_cache_pages(mapping, pages, readpage_async_filler,
> > &desc);
> > +       ret = 0;
> > +       while (!ret && (page = readahead_page(ractl))) {
> > +               prefetchw(&page->flags);
> > +               ret = readpage_async_filler(&desc, page);
> > +               put_page(page);
> > +       }
> >
> >         nfs_pageio_complete_read(&desc.pgio);
> >
> >         put_nfs_open_context(desc.ctx);
> >  out:
> >         trace_nfs_aop_readahead_done(inode, nr_pages, ret);
> > -       return ret;
> >  }
> >
> >  int __init nfs_init_readpagecache(void)
> > diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> > index 140187b57db8..a5aef2cbe4ee 100644
> > --- a/include/linux/nfs_fs.h
> > +++ b/include/linux/nfs_fs.h
> > @@ -586,8 +586,7 @@ extern int nfs_access_get_cached(struct inode
> > *inode, const struct cred *cred, s
> >   * linux/fs/nfs/read.c
> >   */
> >  extern int  nfs_readpage(struct file *, struct page *);
> > -extern int  nfs_readpages(struct file *, struct address_space *,
> > -               struct list_head *, unsigned);
> > +extern void nfs_readahead(struct readahead_control *);
> >
> >  /*
> >   * inline functions
> > diff --git a/include/linux/nfs_iostat.h b/include/linux/nfs_iostat.h
> > index 027874c36c88..418145f23700 100644
> > --- a/include/linux/nfs_iostat.h
> > +++ b/include/linux/nfs_iostat.h
> > @@ -22,7 +22,7 @@
> >  #ifndef _LINUX_NFS_IOSTAT
> >  #define _LINUX_NFS_IOSTAT
> >
> > -#define NFS_IOSTAT_VERS                "1.1"
> > +#define NFS_IOSTAT_VERS                "1.2"
> >
> >  /*
> >   * NFS byte counters
> > @@ -53,7 +53,7 @@
> >   * NFS page counters
> >   *
> >   * These count the number of pages read or written via
> > nfs_readpage(),
> > - * nfs_readpages(), or their write equivalents.
> > + * nfs_readahead(), or their write equivalents.
> >   *
> >   * NB: When adding new byte counters, please include the measured
> >   * units in the name of each byte counter to help users of this
> > @@ -98,7 +98,7 @@ enum nfs_stat_eventcounters {
> >         NFSIOS_VFSACCESS,
> >         NFSIOS_VFSUPDATEPAGE,
> >         NFSIOS_VFSREADPAGE,
> > -       NFSIOS_VFSREADPAGES,
> > +       NFSIOS_VFSREADAHEAD,
> >         NFSIOS_VFSWRITEPAGE,
> >         NFSIOS_VFSWRITEPAGES,
> >         NFSIOS_VFSGETDENTS,
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

