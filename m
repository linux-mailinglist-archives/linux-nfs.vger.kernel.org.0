Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7596F425B8D
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 21:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbhJGTdt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 15:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232829AbhJGTdt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 15:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633635114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wWPQE8BEcXHf86gvNs2V3SXAZEcVjZfI1o1mcYtdjFQ=;
        b=AaUmGo7CjH3lTiXN25eaaG3i0uCES7GODTwc+wL1kNhGikvAEvHZS1zXOXbvsnONbIsTF0
        oVE7SwoyYllOf20MmUGWl7n6iLzLeJIxbNyjV2MYP7p3vfQKim+wl4oBSlA7rnkVcfw4De
        SrnX3YtsWgn17idosgBiB8BdG9Apd0g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-iuPTs8gxO42zQ_jeRnIqOQ-1; Thu, 07 Oct 2021 15:31:53 -0400
X-MC-Unique: iuPTs8gxO42zQ_jeRnIqOQ-1
Received: by mail-ed1-f72.google.com with SMTP id f4-20020a50e084000000b003db585bc274so1316109edl.17
        for <linux-nfs@vger.kernel.org>; Thu, 07 Oct 2021 12:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWPQE8BEcXHf86gvNs2V3SXAZEcVjZfI1o1mcYtdjFQ=;
        b=wZqL3gmnsIDi7ocHHujQ+u1rVGHgkldUyua3/s5KKb+18xGN10dzezabkFHVVxu8F/
         /gY7IxYEreGCQjB9HeLHU7tR7oSnlqcJRwkaC1nnaBNycDdwuuUjk7HHHyh30SFJY8G6
         1gsehSyeXRjOaQYvCS8yKHHnUtcPdpm0w1nmQcg+tO+Q0vQZlvmLjuZ7b5OPR7LpX5D+
         PAQBiapAMH/92ny3+Ama6o3Q4N++/jljFZRyc1qAE4pXhyjjXx2z5zGnlC4Jiwx088UX
         ScWYLU6ALho7xbwFRJepE8S1Jp2wg9OP8hYaCF06ENA5svIbpSnOXa6/Nb3Sb9g8PsAO
         iQyw==
X-Gm-Message-State: AOAM530xCziwSxmaISdggn04/g0IK4URtbPmYhMRU6+F/vr0ZSty2NjP
        mvcL/WmufbmHeEGLUfd//3i5GLrBnigbqHeaHjRlWtSywYV+MrZl/8tVH/PGNqsq41ibag/FaNr
        4KOkp0+M7rGUIQyiUOkyOlB2ZShpYDRBuz5l3
X-Received: by 2002:a05:6402:35d6:: with SMTP id z22mr8549261edc.227.1633635111954;
        Thu, 07 Oct 2021 12:31:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvc+ZIqLG7+1B2BBbwqPk9IyHZlMLMrQ1QEPjtYUeQXXPfbt8oX13goNjNXMS0em4CG1/onXyvAEyXjYHbRy8=
X-Received: by 2002:a05:6402:35d6:: with SMTP id z22mr8549228edc.227.1633635111744;
 Thu, 07 Oct 2021 12:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <163362342678.1680.15890862221793282300.stgit@morisot.1015granger.net>
 <350A3F30-43E1-488E-9742-2FAA9F2567C2@oracle.com> <CALF+zOm0Ey3iRyziN3TFHRZdXfDJwF1x3YuZuksLdvPdF8b0cQ@mail.gmail.com>
 <F269CA7E-BBBD-4CBB-8C82-25B945D8C4BE@oracle.com>
In-Reply-To: <F269CA7E-BBBD-4CBB-8C82-25B945D8C4BE@oracle.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 7 Oct 2021 15:31:15 -0400
Message-ID: <CALF+zO=BE7BjKkF8ft+oSgCmdcatheD4oevt_O49d58g0Qg=Jw@mail.gmail.com>
Subject: Re: [PATCH v2] NFS: Replace dprintk callsites in nfs_readpage(s)
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 7, 2021 at 3:25 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Oct 7, 2021, at 3:16 PM, David Wysochanski <dwysocha@redhat.com> wrote:
> >
> > On Thu, Oct 7, 2021 at 12:22 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Oct 7, 2021, at 12:17 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> >>>
> >>> There are two new events that report slightly different information
> >>> for readpage and readpages.
> >>>
> >>> For readpage:
> >>>            fsx-1387  [006]   380.761896: nfs_aops_readpage:    fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355910932437 page_index=32
> >>>
> >>> The index of a synchronous single-page read is reported.
> >>>
> >>> For readpages:
> >>>
> >>>            fsx-1387  [006]   380.760847: nfs_aops_readpages:   fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355909932456 nr_pages=3
> >>>
> >>> The count of pages requested is reported. readpages does not wait
> >>> for the READ requests to complete.
> >>>
> >>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> Well obviously I forgot to update the patch description.
> >> I can send a v3 later to do that.
> >>
> >>
> >
> > Why not just call the tracepoints nfs_readpage and nfs_readpages?
>
> Because there is already an nfs_readpage_done() tracepoint.
>
Ah ok.  FWIW, you could use nfs_readpage_enter() and
nfs_readpage_exit() similar to nfs_rmdir() for example.

>
> >>> ---
> >>> fs/nfs/nfstrace.h |  146 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>> fs/nfs/read.c     |   11 ++--
> >>> 2 files changed, 151 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> >>> index e9be65b52bfe..85e67b326bcd 100644
> >>> --- a/fs/nfs/nfstrace.h
> >>> +++ b/fs/nfs/nfstrace.h
> >>> @@ -862,6 +862,152 @@ TRACE_EVENT(nfs_sillyrename_unlink,
> >>>              )
> >>> );
> >>>
> >>> +TRACE_EVENT(nfs_aop_readpage,
> >>> +             TP_PROTO(
> >>> +                     const struct inode *inode,
> >>> +                     struct page *page
> >>> +             ),
> >>> +
> >>> +             TP_ARGS(inode, page),
> >>> +
> >>> +             TP_STRUCT__entry(
> >>> +                     __field(dev_t, dev)
> >>> +                     __field(u32, fhandle)
> >>> +                     __field(u64, fileid)
> >>> +                     __field(u64, version)
> >>> +                     __field(pgoff_t, index)
> >>> +             ),
> >>> +
> >>> +             TP_fast_assign(
> >>> +                     const struct nfs_inode *nfsi = NFS_I(inode);
> >>> +
> >>> +                     __entry->dev = inode->i_sb->s_dev;
> >>> +                     __entry->fileid = nfsi->fileid;
> >>> +                     __entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
> >>> +                     __entry->version = inode_peek_iversion_raw(inode);
> >>> +                     __entry->index = page_index(page);
> >>> +             ),
> >>> +
> >>> +             TP_printk(
> >>> +                     "fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu page_index=%lu",
> >>> +                     MAJOR(__entry->dev), MINOR(__entry->dev),
> >>> +                     (unsigned long long)__entry->fileid,
> >>> +                     __entry->fhandle, __entry->version,
> >>> +                     __entry->index
> >>> +             )
> >>> +);
> >>> +
> >>> +TRACE_EVENT(nfs_aop_readpage_done,
> >>> +             TP_PROTO(
> >>> +                     const struct inode *inode,
> >>> +                     struct page *page,
> >>> +                     int ret
> >>> +             ),
> >>> +
> >>> +             TP_ARGS(inode, page, ret),
> >>> +
> >>> +             TP_STRUCT__entry(
> >>> +                     __field(dev_t, dev)
> >>> +                     __field(u32, fhandle)
> >>> +                     __field(int, ret)
> >>> +                     __field(u64, fileid)
> >>> +                     __field(u64, version)
> >>> +                     __field(pgoff_t, index)
> >>> +             ),
> >>> +
> >>> +             TP_fast_assign(
> >>> +                     const struct nfs_inode *nfsi = NFS_I(inode);
> >>> +
> >>> +                     __entry->dev = inode->i_sb->s_dev;
> >>> +                     __entry->fileid = nfsi->fileid;
> >>> +                     __entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
> >>> +                     __entry->version = inode_peek_iversion_raw(inode);
> >>> +                     __entry->index = page_index(page);
> >>> +                     __entry->ret = ret;
> >>> +             ),
> >>> +
> >>> +             TP_printk(
> >>> +                     "fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu page_index=%lu ret=%d",
> >>> +                     MAJOR(__entry->dev), MINOR(__entry->dev),
> >>> +                     (unsigned long long)__entry->fileid,
> >>> +                     __entry->fhandle, __entry->version,
> >>> +                     __entry->index, __entry->ret
> >>> +             )
> >>> +);
> >>> +
> >>> +TRACE_EVENT(nfs_aop_readahead,
> >>> +             TP_PROTO(
> >>> +                     const struct inode *inode,
> >>> +                     unsigned int nr_pages
> >>> +             ),
> >>> +
> >>> +             TP_ARGS(inode, nr_pages),
> >>> +
> >>> +             TP_STRUCT__entry(
> >>> +                     __field(dev_t, dev)
> >>> +                     __field(u32, fhandle)
> >>> +                     __field(u64, fileid)
> >>> +                     __field(u64, version)
> >>> +                     __field(unsigned int, nr_pages)
> >>> +             ),
> >>> +
> >>> +             TP_fast_assign(
> >>> +                     const struct nfs_inode *nfsi = NFS_I(inode);
> >>> +
> >>> +                     __entry->dev = inode->i_sb->s_dev;
> >>> +                     __entry->fileid = nfsi->fileid;
> >>> +                     __entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
> >>> +                     __entry->version = inode_peek_iversion_raw(inode);
> >>> +                     __entry->nr_pages = nr_pages;
> >>> +             ),
> >>> +
> >>> +             TP_printk(
> >>> +                     "fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu nr_pages=%u",
> >>> +                     MAJOR(__entry->dev), MINOR(__entry->dev),
> >>> +                     (unsigned long long)__entry->fileid,
> >>> +                     __entry->fhandle, __entry->version,
> >>> +                     __entry->nr_pages
> >>> +             )
> >>> +);
> >>> +
> >>> +TRACE_EVENT(nfs_aop_readahead_done,
> >>> +             TP_PROTO(
> >>> +                     const struct inode *inode,
> >>> +                     unsigned int nr_pages,
> >>> +                     int ret
> >>> +             ),
> >>> +
> >>> +             TP_ARGS(inode, nr_pages, ret),
> >>> +
> >>> +             TP_STRUCT__entry(
> >>> +                     __field(dev_t, dev)
> >>> +                     __field(u32, fhandle)
> >>> +                     __field(int, ret)
> >>> +                     __field(u64, fileid)
> >>> +                     __field(u64, version)
> >>> +                     __field(unsigned int, nr_pages)
> >>> +             ),
> >>> +
> >>> +             TP_fast_assign(
> >>> +                     const struct nfs_inode *nfsi = NFS_I(inode);
> >>> +
> >>> +                     __entry->dev = inode->i_sb->s_dev;
> >>> +                     __entry->fileid = nfsi->fileid;
> >>> +                     __entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
> >>> +                     __entry->version = inode_peek_iversion_raw(inode);
> >>> +                     __entry->nr_pages = nr_pages;
> >>> +                     __entry->ret = ret;
> >>> +             ),
> >>> +
> >>> +             TP_printk(
> >>> +                     "fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu nr_pages=%u ret=%d",
> >>> +                     MAJOR(__entry->dev), MINOR(__entry->dev),
> >>> +                     (unsigned long long)__entry->fileid,
> >>> +                     __entry->fhandle, __entry->version,
> >>> +                     __entry->nr_pages, __entry->ret
> >>> +             )
> >>> +);
> >>> +
> >>> TRACE_EVENT(nfs_initiate_read,
> >>>              TP_PROTO(
> >>>                      const struct nfs_pgio_header *hdr
> >>> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> >>> index 08d6cc57cbc3..c8273d4b12ad 100644
> >>> --- a/fs/nfs/read.c
> >>> +++ b/fs/nfs/read.c
> >>> @@ -337,8 +337,7 @@ int nfs_readpage(struct file *file, struct page *page)
> >>>      struct inode *inode = page_file_mapping(page)->host;
> >>>      int ret;
> >>>
> >>> -     dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
> >>> -             page, PAGE_SIZE, page_index(page));
> >>> +     trace_nfs_aop_readpage(inode, page);
> >>>      nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
> >>>
> >>>      /*
> >>> @@ -390,9 +389,11 @@ int nfs_readpage(struct file *file, struct page *page)
> >>>      }
> >>> out:
> >>>      put_nfs_open_context(desc.ctx);
> >>> +     trace_nfs_aop_readpage_done(inode, page, ret);
> >>>      return ret;
> >>> out_unlock:
> >>>      unlock_page(page);
> >>> +     trace_nfs_aop_readpage_done(inode, page, ret);
> >>>      return ret;
> >>> }
> >>>
> >>> @@ -403,10 +404,7 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
> >>>      struct inode *inode = mapping->host;
> >>>      int ret;
> >>>
> >>> -     dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
> >>> -                     inode->i_sb->s_id,
> >>> -                     (unsigned long long)NFS_FILEID(inode),
> >>> -                     nr_pages);
> >>> +     trace_nfs_aop_readahead(inode, nr_pages);
> >>>      nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
> >>>
> >>>      ret = -ESTALE;
> >>> @@ -439,6 +437,7 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
> >>> read_complete:
> >>>      put_nfs_open_context(desc.ctx);
> >>> out:
> >>> +     trace_nfs_aop_readahead_done(inode, nr_pages, ret);
> >>>      return ret;
> >>> }
> >>>
> >>>
> >>
> >> --
> >> Chuck Lever
>
> --
> Chuck Lever
>
>
>

