Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113EF42568D
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 17:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhJGP22 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 11:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230410AbhJGP22 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 11:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633620394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qjj6eRYdRDiLdMitRRGksBLtdHoH1PkUPypta0xA+5E=;
        b=ESi0f8+Zzu3g+UnNIojfpjyjXr2+2IASjSIZN0o/o/a1BUG+g66CARkN1ggT0VZly3t+dS
        Zyxl1iFzJSycjbGo2uz+qwSTB3Q4M1O5SqWSlumSzxqarugZjqANpNRdBSj/ks6eCwnDKY
        gSl9k5Me0jWBEWDAuoHp+bagKn93fYM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-E7BUV3ipPhCxf5PNRoKx4A-1; Thu, 07 Oct 2021 11:26:33 -0400
X-MC-Unique: E7BUV3ipPhCxf5PNRoKx4A-1
Received: by mail-ed1-f71.google.com with SMTP id q26-20020aa7da9a000000b003db531e7acbso1888268eds.22
        for <linux-nfs@vger.kernel.org>; Thu, 07 Oct 2021 08:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qjj6eRYdRDiLdMitRRGksBLtdHoH1PkUPypta0xA+5E=;
        b=r8P3e4VYVkwg1vikiDb8tK1j/npGJcXxK8yZcyDrmIbjaJwPk6W/Pyl0LFstBTo7tU
         kpjUNY7k6Tr5bXsyfnepA1JZAVrCAKpCJ1ze3NUKIX3Uv0WasR74pGKXZv1UQlMdOoiL
         zGoRbK8Sk87tUQ82VYa947on6qqxqTBGJHS3++SeU1ctc0pDxgDR/woVl0LW4HBWlmdv
         0d6mx9ye2Fn2RrvqOATPnPjuLXqb3xpd+QKV6xHKACoGI278/SMGXQcKOrBoA6obvJ39
         o0AuGAGncfsR3uu0ae6WJVtOjPkZMuHtOq00M0fKZsdRTH7Q9jTyPv+nd66eL59i1Zjg
         aBVQ==
X-Gm-Message-State: AOAM530fli/l9H7xLCM+Gxx2nhcxUBresLGcpga/O/konNcUyQsM0WZ2
        XFXwNTXZSCndMLaQAEx1HvkR27PGKU4/9hBB/lKw1QApS5ZFoxpKnHERjwJ/enwX/DH/nhH4+KV
        aL9v8bS5kW75vWojL0uC3pdc6jVqnbBfz+1qr
X-Received: by 2002:a05:6402:35d6:: with SMTP id z22mr6931968edc.227.1633620391501;
        Thu, 07 Oct 2021 08:26:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjNq61RpTco7QLbuL3HccU1OIEA3RUouo9YxLgG5tISBNakCbUn0cpu7ZWIoJfQY3GbPVPKStCU9rrq/LIGYM=
X-Received: by 2002:a05:6402:35d6:: with SMTP id z22mr6931939edc.227.1633620391242;
 Thu, 07 Oct 2021 08:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net>
 <163345406901.524558.6277128986656130592.stgit@morisot.1015granger.net>
 <CALF+zOmKJTg-qx2J69QZAhG7KQOfra9noR5=bmaLfAFg1kZf-g@mail.gmail.com> <027FEF08-ABD1-47D1-A527-67B4F2184C43@oracle.com>
In-Reply-To: <027FEF08-ABD1-47D1-A527-67B4F2184C43@oracle.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 7 Oct 2021 11:25:52 -0400
Message-ID: <CALF+zOnHf04LYt-weSB2vwpLZNZMe71_r-dOc2uztnwmJQesHQ@mail.gmail.com>
Subject: Re: [PATCH RFC 5/5] NFS: Replace dprintk callsites in nfs_readpage(s)
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 7, 2021 at 11:01 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Oct 7, 2021, at 9:05 AM, David Wysochanski <dwysocha@redhat.com> wrote:
> >
> > On Tue, Oct 5, 2021 at 1:14 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> > >
> > > There are two new events that report slightly different information
> > > for readpage and readpages.
> > >
> > > For readpage:
> > >              fsx-1387  [006]   380.761896: nfs_aops_readpage:    fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355910932437 page_index=32
> > >
> > > The index of a synchronous single-page read is reported.
> > >
> > > For readpages:
> > >
> > >              fsx-1387  [006]   380.760847: nfs_aops_readpages:   fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355909932456 nr_pages=3
> > >
> > > The count of pages requested is reported. readpages does not wait
> > > for the READ requests to complete.
> > >
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > >  fs/nfs/nfstrace.h |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  fs/nfs/read.c     |    8 ++----
> > >  2 files changed, 72 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> > > index e9be65b52bfe..0534d090ee55 100644
> > > --- a/fs/nfs/nfstrace.h
> > > +++ b/fs/nfs/nfstrace.h
> > > @@ -862,6 +862,76 @@ TRACE_EVENT(nfs_sillyrename_unlink,
> > >                 )
> > >  );
> > >
> > > +TRACE_EVENT(nfs_aops_readpage,
> > > +               TP_PROTO(
> > > +                       const struct inode *inode,
> > > +                       struct page *page
> > > +               ),
> > > +
> > > +               TP_ARGS(inode, page),
> > > +
> > > +               TP_STRUCT__entry(
> > > +                       __field(dev_t, dev)
> > > +                       __field(u32, fhandle)
> > > +                       __field(u64, fileid)
> > > +                       __field(u64, version)
> > > +                       __field(pgoff_t, index)
> > > +               ),
> > > +
> > > +               TP_fast_assign(
> > > +                       const struct nfs_inode *nfsi = NFS_I(inode);
> > > +
> > > +                       __entry->dev = inode->i_sb->s_dev;
> > > +                       __entry->fileid = nfsi->fileid;
> > > +                       __entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
> > > +                       __entry->version = inode_peek_iversion_raw(inode);
> > > +                       __entry->index = page_index(page);
> > > +               ),
> > > +
> > > +               TP_printk(
> > > +                       "fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu page_index=%lu",
> > > +                       MAJOR(__entry->dev), MINOR(__entry->dev),
> > > +                       (unsigned long long)__entry->fileid,
> > > +                       __entry->fhandle, __entry->version,
> > > +                       __entry->index
> > > +               )
> > > +);
> > > +
> > > +TRACE_EVENT(nfs_aops_readpages,
> > > +               TP_PROTO(
> > > +                       const struct inode *inode,
> > > +                       unsigned int nr_pages
> > > +               ),
> > > +
> > > +               TP_ARGS(inode, nr_pages),
> > > +
> > > +               TP_STRUCT__entry(
> > > +                       __field(dev_t, dev)
> > > +                       __field(u32, fhandle)
> > > +                       __field(u64, fileid)
> > > +                       __field(u64, version)
> > > +                       __field(unsigned int, nr_pages)
> > > +               ),
> > > +
> > > +               TP_fast_assign(
> > > +                       const struct nfs_inode *nfsi = NFS_I(inode);
> > > +
> > > +                       __entry->dev = inode->i_sb->s_dev;
> > > +                       __entry->fileid = nfsi->fileid;
> > > +                       __entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
> > > +                       __entry->version = inode_peek_iversion_raw(inode);
> > > +                       __entry->nr_pages = nr_pages;
> > > +               ),
> > > +
> > > +               TP_printk(
> > > +                       "fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu nr_pages=%u",
> > > +                       MAJOR(__entry->dev), MINOR(__entry->dev),
> > > +                       (unsigned long long)__entry->fileid,
> > > +                       __entry->fhandle, __entry->version,
> > > +                       __entry->nr_pages
> > > +               )
> > > +);
> > > +
> > >  TRACE_EVENT(nfs_initiate_read,
> > >                 TP_PROTO(
> > >                         const struct nfs_pgio_header *hdr
> > > diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> > > index 08d6cc57cbc3..94690eda2a88 100644
> > > --- a/fs/nfs/read.c
> > > +++ b/fs/nfs/read.c
> > > @@ -337,8 +337,7 @@ int nfs_readpage(struct file *file, struct page *page)
> > >         struct inode *inode = page_file_mapping(page)->host;
> > >         int ret;
> > >
> > > -       dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
> > > -               page, PAGE_SIZE, page_index(page));
> > > +       trace_nfs_aops_readpage(inode, page);
> > >         nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
> > >
> > >         /*
> > > @@ -403,10 +402,7 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
> > >         struct inode *inode = mapping->host;
> > >         int ret;
> > >
> > > -       dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
> > > -                       inode->i_sb->s_id,
> > > -                       (unsigned long long)NFS_FILEID(inode),
> > > -                       nr_pages);
> > > +       trace_nfs_aops_readpages(inode, nr_pages);
> > >         nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
> > >
> > >         ret = -ESTALE;
> > >
> > >
> >
> > I added this on top of my fscache patches and have been testing.
> > Should we be tracing (only?) the return point with the return
> > value?
>
> The purpose of the entry point is: you get a timestamp, filehandle
> information, and you know what is driving the READ request (sync
> read or async readahead).
>
> There is a dprintk() at the top of the function as well as a
> performance metric counter, but there currently isn't a dprintk()
> at the bottom of the function. So I assumed the return code is
> not a critical piece of information. I'm willing to be educated,
> though.
>

Well, I was trying to understand the various approaches in nfstrace.h.
There are tracepoints that are paired with entry and exit, but I guess
these have multiple pieces of information that may change from
start to finish.  Examples:
nfs_refresh_inode_enter
nfs_refresh_inode_exit
nfs_lookup_revalidate_enter
nfs_lookup_revalidate_exit

> A return point trace event could be generated only when there
> is an unexpected error condition, for example, to reduce trace
> log noise?
>
Ok so you would just add a second tracepoint for non-zero returns?

>
> >          bigfile-6279    [004] ..... 11550.387232: nfs_aops_readpages: fileid=00:2f:26127 fhandle=0xb6d0e8f0 version=1633611037513339503 nr_pages=32
> >          bigfile-6279    [004] ..... 11550.387236: nfs_fscache_page_event_read: fileid=00:2f:26127 fhandle=0xb6d0e8f0 offset=0 count=4096
> >          bigfile-6279    [004] ..... 11550.387237: nfs_fscache_page_event_read_done: fileid=00:2f:26127 fhandle=0xb6d0e8f0 offset=0 count=4096 error=-105
> >          bigfile-6279    [004] ..... 11550.387248: nfs_fscache_page_event_read: fileid=00:2f:26127 fhandle=0xb6d0e8f0 offset=4096 count=4096
> >          bigfile-6279    [004] ..... 11550.387248: nfs_fscache_page_event_read_done: fileid=00:2f:26127 fhandle=0xb6d0e8f0 offset=4096 count=4096 error=-105
> >          bigfile-6279    [004] ..... 11550.387250: nfs_fscache_page_event_read: fileid=00:2f:26127 fhandle=0xb6d0e8f0 offset=8192 count=4096
> >          bigfile-6279    [004] ..... 11550.387250: nfs_fscache_page_event_read_done: fileid=00:2f:26127 fhandle=0xb6d0e8f0 offset=8192 count=4096 error=-105

Example:
bigfile-6279    [004] ..... 11550.387252: nfs_aops_readpages_error:
fileid=00:2f:26127 fhandle=0xb6d0e8f0 version=1633611037513339503
nr_pages=6 error=-5



>
> --
> Chuck Lever
>
>
>

