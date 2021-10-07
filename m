Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE13425B6E
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 21:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhJGTS4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 15:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243882AbhJGTSz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 15:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633634221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S1/Z3DZc+I2RPy14srZGOlnwqXbfICa3nq39b6k9by8=;
        b=iraKdMYlVvZu+Ca6gtbUaOekUd+nAtlzrVH+D5R5yHPe6NcJCR2aTs0sW3dPdbf0zoeG4+
        ygCgMaxmpZGg40JgdtTZ2RI+Lu2V2kxTfKIxCiFHjjSOURM9EY+HMtt4YTZrfWK8mylz6C
        SA/LnPKbwKL5JWEYdV8VhpCyiQcfCJg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-brDoNpk_Os6cknroWYxKTQ-1; Thu, 07 Oct 2021 15:16:59 -0400
X-MC-Unique: brDoNpk_Os6cknroWYxKTQ-1
Received: by mail-ed1-f71.google.com with SMTP id v2-20020a50f082000000b003db24e28d59so6880854edl.5
        for <linux-nfs@vger.kernel.org>; Thu, 07 Oct 2021 12:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1/Z3DZc+I2RPy14srZGOlnwqXbfICa3nq39b6k9by8=;
        b=lNSvbwQdIg6jL+nd2AG9cBZ9UXca9gNvW8VG3MBewTqTwITcY0o2JtLxxFvegTNkZ7
         20pl4yC8LP3e4BLs4rwXxLO36K5nzAQyxesQWspuv4U46NYpjTL/lGprEwIceRjhORzH
         8jnLJXarEA6gnqZgt6xBXMLVXojvgrkPlbut/FdZ09cIrdBhjS4YqLurSpXYVFDxcOp0
         N9zmyXau04hrh873YxUv16+nfjLX8O7fQziMFpqPGs7F2XvjrWnlce5+X8SMAjF+TRcG
         xZs4Zm5C1OZM6S93zcMmVhitvRK6C1GzRg7Pz50cexDh8FCzodAre/1uNnuM6zSnfQRg
         uP7A==
X-Gm-Message-State: AOAM531og0yFGdhQ7s7fRBW2DKRBms6i0O4A1vRs6GNvqqzZM9knrR7e
        V2hW1vqVRxIJwDv0+u5nYJUaT59YdD97zp1D/hzVaNIvnPqMJ0qckwsOyfMXzUgOC+mHD8/SqVJ
        yIeYIS7s4N+aiiX2CVtxyeiwem0S74FG84TsA
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr7883550ejp.427.1633634218656;
        Thu, 07 Oct 2021 12:16:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL9py6MSLar7GDhV/siIkcKbqmddwIsbwMWwnt9aVVDlWr0KleNrBcpNmznGNFpF8ww+0eG7GjQFptTRKuw/k=
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr7883529ejp.427.1633634218412;
 Thu, 07 Oct 2021 12:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <163362342678.1680.15890862221793282300.stgit@morisot.1015granger.net>
 <350A3F30-43E1-488E-9742-2FAA9F2567C2@oracle.com>
In-Reply-To: <350A3F30-43E1-488E-9742-2FAA9F2567C2@oracle.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 7 Oct 2021 15:16:21 -0400
Message-ID: <CALF+zOm0Ey3iRyziN3TFHRZdXfDJwF1x3YuZuksLdvPdF8b0cQ@mail.gmail.com>
Subject: Re: [PATCH v2] NFS: Replace dprintk callsites in nfs_readpage(s)
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 7, 2021 at 12:22 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Oct 7, 2021, at 12:17 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > There are two new events that report slightly different information
> > for readpage and readpages.
> >
> > For readpage:
> >             fsx-1387  [006]   380.761896: nfs_aops_readpage:    fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355910932437 page_index=32
> >
> > The index of a synchronous single-page read is reported.
> >
> > For readpages:
> >
> >             fsx-1387  [006]   380.760847: nfs_aops_readpages:   fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355909932456 nr_pages=3
> >
> > The count of pages requested is reported. readpages does not wait
> > for the READ requests to complete.
> >
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>
> Well obviously I forgot to update the patch description.
> I can send a v3 later to do that.
>
>

Why not just call the tracepoints nfs_readpage and nfs_readpages?


> > ---
> > fs/nfs/nfstrace.h |  146 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > fs/nfs/read.c     |   11 ++--
> > 2 files changed, 151 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> > index e9be65b52bfe..85e67b326bcd 100644
> > --- a/fs/nfs/nfstrace.h
> > +++ b/fs/nfs/nfstrace.h
> > @@ -862,6 +862,152 @@ TRACE_EVENT(nfs_sillyrename_unlink,
> >               )
> > );
> >
> > +TRACE_EVENT(nfs_aop_readpage,
> > +             TP_PROTO(
> > +                     const struct inode *inode,
> > +                     struct page *page
> > +             ),
> > +
> > +             TP_ARGS(inode, page),
> > +
> > +             TP_STRUCT__entry(
> > +                     __field(dev_t, dev)
> > +                     __field(u32, fhandle)
> > +                     __field(u64, fileid)
> > +                     __field(u64, version)
> > +                     __field(pgoff_t, index)
> > +             ),
> > +
> > +             TP_fast_assign(
> > +                     const struct nfs_inode *nfsi = NFS_I(inode);
> > +
> > +                     __entry->dev = inode->i_sb->s_dev;
> > +                     __entry->fileid = nfsi->fileid;
> > +                     __entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
> > +                     __entry->version = inode_peek_iversion_raw(inode);
> > +                     __entry->index = page_index(page);
> > +             ),
> > +
> > +             TP_printk(
> > +                     "fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu page_index=%lu",
> > +                     MAJOR(__entry->dev), MINOR(__entry->dev),
> > +                     (unsigned long long)__entry->fileid,
> > +                     __entry->fhandle, __entry->version,
> > +                     __entry->index
> > +             )
> > +);
> > +
> > +TRACE_EVENT(nfs_aop_readpage_done,
> > +             TP_PROTO(
> > +                     const struct inode *inode,
> > +                     struct page *page,
> > +                     int ret
> > +             ),
> > +
> > +             TP_ARGS(inode, page, ret),
> > +
> > +             TP_STRUCT__entry(
> > +                     __field(dev_t, dev)
> > +                     __field(u32, fhandle)
> > +                     __field(int, ret)
> > +                     __field(u64, fileid)
> > +                     __field(u64, version)
> > +                     __field(pgoff_t, index)
> > +             ),
> > +
> > +             TP_fast_assign(
> > +                     const struct nfs_inode *nfsi = NFS_I(inode);
> > +
> > +                     __entry->dev = inode->i_sb->s_dev;
> > +                     __entry->fileid = nfsi->fileid;
> > +                     __entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
> > +                     __entry->version = inode_peek_iversion_raw(inode);
> > +                     __entry->index = page_index(page);
> > +                     __entry->ret = ret;
> > +             ),
> > +
> > +             TP_printk(
> > +                     "fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu page_index=%lu ret=%d",
> > +                     MAJOR(__entry->dev), MINOR(__entry->dev),
> > +                     (unsigned long long)__entry->fileid,
> > +                     __entry->fhandle, __entry->version,
> > +                     __entry->index, __entry->ret
> > +             )
> > +);
> > +
> > +TRACE_EVENT(nfs_aop_readahead,
> > +             TP_PROTO(
> > +                     const struct inode *inode,
> > +                     unsigned int nr_pages
> > +             ),
> > +
> > +             TP_ARGS(inode, nr_pages),
> > +
> > +             TP_STRUCT__entry(
> > +                     __field(dev_t, dev)
> > +                     __field(u32, fhandle)
> > +                     __field(u64, fileid)
> > +                     __field(u64, version)
> > +                     __field(unsigned int, nr_pages)
> > +             ),
> > +
> > +             TP_fast_assign(
> > +                     const struct nfs_inode *nfsi = NFS_I(inode);
> > +
> > +                     __entry->dev = inode->i_sb->s_dev;
> > +                     __entry->fileid = nfsi->fileid;
> > +                     __entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
> > +                     __entry->version = inode_peek_iversion_raw(inode);
> > +                     __entry->nr_pages = nr_pages;
> > +             ),
> > +
> > +             TP_printk(
> > +                     "fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu nr_pages=%u",
> > +                     MAJOR(__entry->dev), MINOR(__entry->dev),
> > +                     (unsigned long long)__entry->fileid,
> > +                     __entry->fhandle, __entry->version,
> > +                     __entry->nr_pages
> > +             )
> > +);
> > +
> > +TRACE_EVENT(nfs_aop_readahead_done,
> > +             TP_PROTO(
> > +                     const struct inode *inode,
> > +                     unsigned int nr_pages,
> > +                     int ret
> > +             ),
> > +
> > +             TP_ARGS(inode, nr_pages, ret),
> > +
> > +             TP_STRUCT__entry(
> > +                     __field(dev_t, dev)
> > +                     __field(u32, fhandle)
> > +                     __field(int, ret)
> > +                     __field(u64, fileid)
> > +                     __field(u64, version)
> > +                     __field(unsigned int, nr_pages)
> > +             ),
> > +
> > +             TP_fast_assign(
> > +                     const struct nfs_inode *nfsi = NFS_I(inode);
> > +
> > +                     __entry->dev = inode->i_sb->s_dev;
> > +                     __entry->fileid = nfsi->fileid;
> > +                     __entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
> > +                     __entry->version = inode_peek_iversion_raw(inode);
> > +                     __entry->nr_pages = nr_pages;
> > +                     __entry->ret = ret;
> > +             ),
> > +
> > +             TP_printk(
> > +                     "fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu nr_pages=%u ret=%d",
> > +                     MAJOR(__entry->dev), MINOR(__entry->dev),
> > +                     (unsigned long long)__entry->fileid,
> > +                     __entry->fhandle, __entry->version,
> > +                     __entry->nr_pages, __entry->ret
> > +             )
> > +);
> > +
> > TRACE_EVENT(nfs_initiate_read,
> >               TP_PROTO(
> >                       const struct nfs_pgio_header *hdr
> > diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> > index 08d6cc57cbc3..c8273d4b12ad 100644
> > --- a/fs/nfs/read.c
> > +++ b/fs/nfs/read.c
> > @@ -337,8 +337,7 @@ int nfs_readpage(struct file *file, struct page *page)
> >       struct inode *inode = page_file_mapping(page)->host;
> >       int ret;
> >
> > -     dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
> > -             page, PAGE_SIZE, page_index(page));
> > +     trace_nfs_aop_readpage(inode, page);
> >       nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
> >
> >       /*
> > @@ -390,9 +389,11 @@ int nfs_readpage(struct file *file, struct page *page)
> >       }
> > out:
> >       put_nfs_open_context(desc.ctx);
> > +     trace_nfs_aop_readpage_done(inode, page, ret);
> >       return ret;
> > out_unlock:
> >       unlock_page(page);
> > +     trace_nfs_aop_readpage_done(inode, page, ret);
> >       return ret;
> > }
> >
> > @@ -403,10 +404,7 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
> >       struct inode *inode = mapping->host;
> >       int ret;
> >
> > -     dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
> > -                     inode->i_sb->s_id,
> > -                     (unsigned long long)NFS_FILEID(inode),
> > -                     nr_pages);
> > +     trace_nfs_aop_readahead(inode, nr_pages);
> >       nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
> >
> >       ret = -ESTALE;
> > @@ -439,6 +437,7 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
> > read_complete:
> >       put_nfs_open_context(desc.ctx);
> > out:
> > +     trace_nfs_aop_readahead_done(inode, nr_pages, ret);
> >       return ret;
> > }
> >
> >
>
> --
> Chuck Lever
>
>
>

