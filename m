Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31766443686
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Nov 2021 20:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhKBTje (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Nov 2021 15:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229844AbhKBTjd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Nov 2021 15:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635881818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3USCuMuR+iMO7AIYm0rnVgRoNG+I8guPCFc5bd3j9bQ=;
        b=Rh6rVwEd9EiSW6Mqkxu28MLvS+NXf/nCq5jEdw7VglrOpyccY67vlHUpEZKkO0rZhQvi+L
        6hx7Cuf+E0wvy5l6LahtygYXVQIrbXJ6xbTlxN7kbOG/RL3c4eptb+/E02YR+GmYDzr3Vm
        2BhwoWLfEOCNSoDsyDjGfQSFSAF9H30=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-JFa_r0uTNDGQZJtlSLdRlQ-1; Tue, 02 Nov 2021 15:36:57 -0400
X-MC-Unique: JFa_r0uTNDGQZJtlSLdRlQ-1
Received: by mail-ed1-f70.google.com with SMTP id t20-20020a056402525400b003e2ad6b5ee7so379312edd.8
        for <linux-nfs@vger.kernel.org>; Tue, 02 Nov 2021 12:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3USCuMuR+iMO7AIYm0rnVgRoNG+I8guPCFc5bd3j9bQ=;
        b=g5EAeBWN+jm4/frPIUgj5JMaizBChcjGdlFl+EzW7kX7IN95oBk6YZPm85bK/7+25P
         4jOlaaH+wFQjtyrU+5aWL45v4apxfeY3DLBVTfZ4TKID1X4Hcg1DOCxmqjNh82w7Ofp1
         Aln6IJAGfcDNBPZYEngXrvb2v8vNPS0XoZAHSRH8vqpB/EcwNOHiRqLnBaeXYfo3mL+5
         p/MQELFdZL0ltPwwkjDs6xLpiykXd2ey9snDH5gKSkSGsyng9kr54rsUdgxU6KAE2tV4
         lQqzP320YXeZ8rJWq/TLxQoPoQIttj7wYQ7eNtEn38IVYXOB69kjbAejcBtgutqq4d3f
         3aag==
X-Gm-Message-State: AOAM533mLNVZRATc7vxxSwdtPtiadV8TK10IbkeYODhy/zh16M22+QNG
        6V8yZYlO2vhsoe6PKRqunNjzwgfw+zWKjnG3rTHXZsst4eNXSP9Oz8//fHvlf4XGQNczeFIc9a8
        LIT4tgB6EtJ2N7bH/reyNPyTpNbnmE63IqAka
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr47918461ejp.427.1635881815768;
        Tue, 02 Nov 2021 12:36:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaNv1gAzOOfNHZnhMr3Zb2Bwn+AG4sokgH1JvxNdnBeYo1qLbBPxXedBNRkeHAIzahwQB8DfcoDujrKqvxQR8=
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr47918433ejp.427.1635881815510;
 Tue, 02 Nov 2021 12:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <163442096873.1585.8967342784030733636.stgit@morisot.1015granger.net>
 <163442177101.1585.8852378085253353318.stgit@morisot.1015granger.net>
In-Reply-To: <163442177101.1585.8852378085253353318.stgit@morisot.1015granger.net>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 2 Nov 2021 15:36:19 -0400
Message-ID: <CALF+zOm1gCuVOJ5bEf6_t=PvmTQ4KQPCYQsgLUenxMNhzUx_oQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] NFS: Replace dprintk callsites in nfs_readpage(s)
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Oct 16, 2021 at 6:03 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> These new events report slightly different information for readpage
> and readpages/readahead.
>
> For readpage:
>              fsx-1387  [006]   380.761896: nfs_aop_readpage:    fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355910932437 offset=131072
>              fsx-1387  [006]   380.761900: nfs_aop_readpage_done: fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355910932437 offset=131072 ret=0
>
> The index of a synchronous single-page read is reported.
>
> For readpages:
>
>              fsx-1387  [006]   380.760847: nfs_aop_readahead:   fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355909932456 nr_pages=3
>              fsx-1387  [006]   380.760853: nfs_aop_readahead_done: fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355909932456 nr_pages=3 ret=0
>

Chuck,

I was doing more debugging and thought about the readahead trace event.
Are you set on "nr_pages" output here, or was that mainly due to the parameter?
I think maybe it would be better to have byte fields, "offset" and
"count" like the other IO tracepoints (trace_nfs_initiate_read() for
example). Or do you see some advantages to using nr_pages?

We can get the offset with lru_to_page(pages) and of course "count"
with nr_pages*PAGE_SIZE



> The count of pages requested is reported. nfs_readpages does not
> wait for the READ requests to complete.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/nfstrace.h |  146 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfs/read.c     |   11 ++--
>  2 files changed, 151 insertions(+), 6 deletions(-)
>
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index e9be65b52bfe..898308780df8 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -862,6 +862,152 @@ TRACE_EVENT(nfs_sillyrename_unlink,
>                 )
>  );
>
> +TRACE_EVENT(nfs_aop_readpage,
> +               TP_PROTO(
> +                       const struct inode *inode,
> +                       struct page *page
> +               ),
> +
> +               TP_ARGS(inode, page),
> +
> +               TP_STRUCT__entry(
> +                       __field(dev_t, dev)
> +                       __field(u32, fhandle)
> +                       __field(u64, fileid)
> +                       __field(u64, version)
> +                       __field(loff_t, offset)
> +               ),
> +
> +               TP_fast_assign(
> +                       const struct nfs_inode *nfsi = NFS_I(inode);
> +
> +                       __entry->dev = inode->i_sb->s_dev;
> +                       __entry->fileid = nfsi->fileid;
> +                       __entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
> +                       __entry->version = inode_peek_iversion_raw(inode);
> +                       __entry->offset = page_index(page) << PAGE_SHIFT;
> +               ),
> +
> +               TP_printk(
> +                       "fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu offset=%lld",
> +                       MAJOR(__entry->dev), MINOR(__entry->dev),
> +                       (unsigned long long)__entry->fileid,
> +                       __entry->fhandle, __entry->version,
> +                       __entry->offset
> +               )
> +);
> +
> +TRACE_EVENT(nfs_aop_readpage_done,
> +               TP_PROTO(
> +                       const struct inode *inode,
> +                       struct page *page,
> +                       int ret
> +               ),
> +
> +               TP_ARGS(inode, page, ret),
> +
> +               TP_STRUCT__entry(
> +                       __field(dev_t, dev)
> +                       __field(u32, fhandle)
> +                       __field(int, ret)
> +                       __field(u64, fileid)
> +                       __field(u64, version)
> +                       __field(loff_t, offset)
> +               ),
> +
> +               TP_fast_assign(
> +                       const struct nfs_inode *nfsi = NFS_I(inode);
> +
> +                       __entry->dev = inode->i_sb->s_dev;
> +                       __entry->fileid = nfsi->fileid;
> +                       __entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
> +                       __entry->version = inode_peek_iversion_raw(inode);
> +                       __entry->offset = page_index(page) << PAGE_SHIFT;
> +                       __entry->ret = ret;
> +               ),
> +
> +               TP_printk(
> +                       "fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu offset=%lld ret=%d",
> +                       MAJOR(__entry->dev), MINOR(__entry->dev),
> +                       (unsigned long long)__entry->fileid,
> +                       __entry->fhandle, __entry->version,
> +                       __entry->offset, __entry->ret
> +               )
> +);
> +
> +TRACE_EVENT(nfs_aop_readahead,
> +               TP_PROTO(
> +                       const struct inode *inode,
> +                       unsigned int nr_pages
> +               ),
> +
> +               TP_ARGS(inode, nr_pages),
> +
> +               TP_STRUCT__entry(
> +                       __field(dev_t, dev)
> +                       __field(u32, fhandle)
> +                       __field(u64, fileid)
> +                       __field(u64, version)
> +                       __field(unsigned int, nr_pages)
> +               ),
> +
> +               TP_fast_assign(
> +                       const struct nfs_inode *nfsi = NFS_I(inode);
> +
> +                       __entry->dev = inode->i_sb->s_dev;
> +                       __entry->fileid = nfsi->fileid;
> +                       __entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
> +                       __entry->version = inode_peek_iversion_raw(inode);
> +                       __entry->nr_pages = nr_pages;
> +               ),
> +
> +               TP_printk(
> +                       "fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu nr_pages=%u",
> +                       MAJOR(__entry->dev), MINOR(__entry->dev),
> +                       (unsigned long long)__entry->fileid,
> +                       __entry->fhandle, __entry->version,
> +                       __entry->nr_pages
> +               )
> +);
> +
> +TRACE_EVENT(nfs_aop_readahead_done,
> +               TP_PROTO(
> +                       const struct inode *inode,
> +                       unsigned int nr_pages,
> +                       int ret
> +               ),
> +
> +               TP_ARGS(inode, nr_pages, ret),
> +
> +               TP_STRUCT__entry(
> +                       __field(dev_t, dev)
> +                       __field(u32, fhandle)
> +                       __field(int, ret)
> +                       __field(u64, fileid)
> +                       __field(u64, version)
> +                       __field(unsigned int, nr_pages)
> +               ),
> +
> +               TP_fast_assign(
> +                       const struct nfs_inode *nfsi = NFS_I(inode);
> +
> +                       __entry->dev = inode->i_sb->s_dev;
> +                       __entry->fileid = nfsi->fileid;
> +                       __entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
> +                       __entry->version = inode_peek_iversion_raw(inode);
> +                       __entry->nr_pages = nr_pages;
> +                       __entry->ret = ret;
> +               ),
> +
> +               TP_printk(
> +                       "fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu nr_pages=%u ret=%d",
> +                       MAJOR(__entry->dev), MINOR(__entry->dev),
> +                       (unsigned long long)__entry->fileid,
> +                       __entry->fhandle, __entry->version,
> +                       __entry->nr_pages, __entry->ret
> +               )
> +);
> +
>  TRACE_EVENT(nfs_initiate_read,
>                 TP_PROTO(
>                         const struct nfs_pgio_header *hdr
> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> index 08d6cc57cbc3..c8273d4b12ad 100644
> --- a/fs/nfs/read.c
> +++ b/fs/nfs/read.c
> @@ -337,8 +337,7 @@ int nfs_readpage(struct file *file, struct page *page)
>         struct inode *inode = page_file_mapping(page)->host;
>         int ret;
>
> -       dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
> -               page, PAGE_SIZE, page_index(page));
> +       trace_nfs_aop_readpage(inode, page);
>         nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
>
>         /*
> @@ -390,9 +389,11 @@ int nfs_readpage(struct file *file, struct page *page)
>         }
>  out:
>         put_nfs_open_context(desc.ctx);
> +       trace_nfs_aop_readpage_done(inode, page, ret);
>         return ret;
>  out_unlock:
>         unlock_page(page);
> +       trace_nfs_aop_readpage_done(inode, page, ret);
>         return ret;
>  }
>
> @@ -403,10 +404,7 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
>         struct inode *inode = mapping->host;
>         int ret;
>
> -       dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
> -                       inode->i_sb->s_id,
> -                       (unsigned long long)NFS_FILEID(inode),
> -                       nr_pages);
> +       trace_nfs_aop_readahead(inode, nr_pages);
>         nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
>
>         ret = -ESTALE;
> @@ -439,6 +437,7 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
>  read_complete:
>         put_nfs_open_context(desc.ctx);
>  out:
> +       trace_nfs_aop_readahead_done(inode, nr_pages, ret);
>         return ret;
>  }
>
>

