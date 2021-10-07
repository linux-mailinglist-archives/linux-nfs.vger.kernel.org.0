Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3852042547F
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 15:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbhJGNoT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 09:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33918 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233331AbhJGNoS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 09:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633614144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P5JU8C3BiXtpns0YyWc4B8OVs5rM6VtoDVkoZlDZM7I=;
        b=bqzv3LkYvwc6JNDe0lJ8qpwVGo2R/tU/eeFf02rqg7xzUjv/IgwMDuaO9LUCJsdAHrLD/R
        RjCeXJnNnyI8zP/E66aHEES/NoCw9TGv6GAwcCdjRTb2XnPsWLttIHxfOkHv8YardDbzfB
        RSllFvFijdm0BjHgsfVtx/JdEl6GJAQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-e_-avvx-Ne-KTcZaR2fhrA-1; Thu, 07 Oct 2021 09:42:09 -0400
X-MC-Unique: e_-avvx-Ne-KTcZaR2fhrA-1
Received: by mail-ed1-f72.google.com with SMTP id v9-20020a50d849000000b003db459aa3f5so3335487edj.15
        for <linux-nfs@vger.kernel.org>; Thu, 07 Oct 2021 06:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5JU8C3BiXtpns0YyWc4B8OVs5rM6VtoDVkoZlDZM7I=;
        b=SGs3RJVg4FerwurKAYFajxk0nn3RB+nGfElXJAMDjiYf7ZDH9EC9uiT/XodvA/LZpQ
         bd2YFSq+40R4LcI0/3jdcGvYdsj8WnQSDtKFB7s2oJFgJEoYI11M4j7MGAxrHXC07ziY
         l2Me7L6k/EBNt5qXkJ4wS2q3mEjnpw5uVb9va1dLPjy6BOeCG0QX6NOOSGhYz//h2Lfe
         kTUf5P5xtx1PC01Pt8xf7kuQlfwu9Z22fT9gGraFgrYSt+2dCy+6xbk4sNFnphuNB3jV
         vjCMwbTo0WmM96Vm+FGd9G0HVxvdSeN2gGgK2y/cBn/31gHT/AOhXL4yh+f6SLy8vlUn
         +0GA==
X-Gm-Message-State: AOAM531uoJEIsXFHLHh/zj05C+SIpLHtI5sfDDLrVf0/KmDAFVOQ3tH8
        iU+rTT0Kn40x1esEAorSF8YP64qvqF11ikTMH+LpdscmuummVFk1qQRMdqn5CTUuskQFPR5f6ti
        sFTUlS9og47ey4ml03UEv1kkVDVICxsZIqMO5
X-Received: by 2002:a50:d885:: with SMTP id p5mr6301283edj.255.1633614128421;
        Thu, 07 Oct 2021 06:42:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcvsxc+y8frXXhP7lqXdbtdnf4NIPXFFBdZ6nyc1k14xRTVCXUWIgFqYn0ldpiqb3SiRBVypusoATbszknLHU=
X-Received: by 2002:a50:d885:: with SMTP id p5mr6301251edj.255.1633614128211;
 Thu, 07 Oct 2021 06:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <1633288958-8481-1-git-send-email-dwysocha@redhat.com> <1633288958-8481-6-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1633288958-8481-6-git-send-email-dwysocha@redhat.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 7 Oct 2021 09:41:31 -0400
Message-ID: <CALF+zO=J_W3a89J6BY7FYjSdz0_G04f00Ycgm7H6ax55heufug@mail.gmail.com>
Subject: Re: [Linux-cachefs] [PATCH v1 5/7] NFS: Replace dfprintks in favor of
 tracepoints in fscache IO paths
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Oct 3, 2021 at 3:23 PM Dave Wysochanski <dwysocha@redhat.com> wrote:
>
> Most of fscache and other NFS IO paths are now using tracepoints,
> so remove the dfprintks in these code paths and replace with a couple
> tracepoints to track page IO.
>
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  fs/nfs/fscache.c  | 22 +++----------
>  fs/nfs/nfstrace.h | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+), 18 deletions(-)
>
> diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> index a2b517846787..1db1e298b915 100644
> --- a/fs/nfs/fscache.c
> +++ b/fs/nfs/fscache.c
> @@ -335,22 +335,17 @@ int __nfs_readpage_from_fscache(struct inode *inode, struct page *page)
>  {
>         int ret;
>
> -       dfprintk(FSCACHE,
> -                "NFS: readpage_from_fscache(fsc:%p/p:%p(i:%lx f:%lx)/0x%p)\n",
> -                nfs_i_fscache(inode), page, page->index, page->flags, inode);
> -
>         if (PageChecked(page)) {
> -               dfprintk(FSCACHE, "NFS:    readpage_from_fscache: PageChecked\n");
>                 ClearPageChecked(page);
>                 return 1;
>         }
>
> +       trace_nfs_fscache_page_event_read(inode, page);
>         ret = fscache_fallback_read_page(nfs_i_fscache(inode), page);
> +       trace_nfs_fscache_page_event_read_done(inode, page, ret);
>
>         switch (ret) {
>         case 0: /* Read completed synchronously */
> -               dfprintk(FSCACHE,
> -                        "NFS:    readpage_from_fscache: read successful\n");
>                 nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK);
>                 SetPageUptodate(page);
>                 return 0;
> @@ -358,13 +353,10 @@ int __nfs_readpage_from_fscache(struct inode *inode, struct page *page)
>         case -ENOBUFS: /* inode not in cache */
>         case -ENODATA: /* page not in cache */
>                 nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
> -               dfprintk(FSCACHE,
> -                        "NFS:    readpage_from_fscache failed %d\n", ret);
>                 SetPageChecked(page);
>                 return 1;
>
>         default:
> -               dfprintk(FSCACHE, "NFS:    readpage_from_fscache %d\n", ret);
>                 nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
>                 SetPageChecked(page);
>         }
> @@ -378,15 +370,9 @@ void __nfs_readpage_to_fscache(struct inode *inode, struct page *page)
>  {
>         int ret;
>
> -       dfprintk(FSCACHE,
> -                "NFS: readpage_to_fscache(fsc:%p/p:%p(i:%lx f:%lx))\n",
> -                nfs_i_fscache(inode), page, page->index, page->flags);
> -
> +       trace_nfs_fscache_page_event_write(inode, page);
>         ret = fscache_fallback_write_page(nfs_i_fscache(inode), page);
> -
> -       dfprintk(FSCACHE,
> -                "NFS:     readpage_to_fscache: p:%p(i:%lu f:%lx) ret %d\n",
> -                page, page->index, page->flags, ret);
> +       trace_nfs_fscache_page_event_write_done(inode, page, ret);
>
>         if (ret != 0) {
>                 nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_WRITTEN_FAIL);
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index b4177f57f69b..662dddc2eb96 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -880,6 +880,103 @@
>                 )
>  );
>
> +DECLARE_EVENT_CLASS(nfs_fscache_page_event,
> +               TP_PROTO(
> +                       const struct inode *inode,
> +                       const struct page *page
> +               ),
> +
> +               TP_ARGS(inode, page),
> +
> +               TP_STRUCT__entry(
> +                       __field(dev_t, dev)
> +                       __field(u32, fhandle)
> +                       __field(u64, fileid)
> +                       __field(loff_t, offset)
> +                       __field(u32, count)
> +               ),
> +
> +               TP_fast_assign(
> +                       const struct nfs_inode *nfsi = NFS_I(inode);
> +                       const struct nfs_fh *fh = &nfsi->fh;
> +
> +                       __entry->offset = page->index << PAGE_SHIFT;
> +                       __entry->count = 4096;
> +                       __entry->dev = inode->i_sb->s_dev;
> +                       __entry->fileid = nfsi->fileid;
> +                       __entry->fhandle = nfs_fhandle_hash(fh);
> +               ),
> +
> +               TP_printk(
> +                       "fileid=%02x:%02x:%llu fhandle=0x%08x "
> +                       "offset=%lld count=%u",
> +                       MAJOR(__entry->dev), MINOR(__entry->dev),
> +                       (unsigned long long)__entry->fileid,
> +                       __entry->fhandle,
> +                       (long long)__entry->offset, __entry->count
> +               )
> +);
> +
> +DECLARE_EVENT_CLASS(nfs_fscache_page_event_done,
> +               TP_PROTO(
> +                       const struct inode *inode,
> +                       const struct page *page,
> +                       int error
> +               ),
> +
> +               TP_ARGS(inode, page, error),
> +
> +               TP_STRUCT__entry(
> +                       __field(int, error)
> +                       __field(dev_t, dev)
> +                       __field(u32, fhandle)
> +                       __field(u64, fileid)
> +                       __field(loff_t, offset)
> +                       __field(u32, count)
> +               ),
> +
> +               TP_fast_assign(
> +                       const struct nfs_inode *nfsi = NFS_I(inode);
> +                       const struct nfs_fh *fh = &nfsi->fh;
> +
> +                       __entry->offset = page->index << PAGE_SHIFT;
> +                       __entry->count = 4096;
> +                       __entry->dev = inode->i_sb->s_dev;
> +                       __entry->fileid = nfsi->fileid;
> +                       __entry->fhandle = nfs_fhandle_hash(fh);
> +                       __entry->error = error;
> +               ),
> +
> +               TP_printk(
> +                       "fileid=%02x:%02x:%llu fhandle=0x%08x "
> +                       "offset=%lld count=%u error=%d",
> +                       MAJOR(__entry->dev), MINOR(__entry->dev),
> +                       (unsigned long long)__entry->fileid,
> +                       __entry->fhandle,
> +                       (long long)__entry->offset, __entry->count,
> +                       __entry->error
> +               )
> +);
> +#define DEFINE_NFS_FSCACHE_PAGE_EVENT(name) \
> +       DEFINE_EVENT(nfs_fscache_page_event, name, \
> +                       TP_PROTO( \
> +                               const struct inode *inode, \
> +                               const struct page *page \
> +                       ), \
> +                       TP_ARGS(inode, page))
> +#define DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(name) \
> +       DEFINE_EVENT(nfs_fscache_page_event_done, name, \
> +                       TP_PROTO( \
> +                               const struct inode *inode, \
> +                               const struct page *page, \
> +                               int error \
> +                       ), \
> +                       TP_ARGS(inode, page, error))
> +DEFINE_NFS_FSCACHE_PAGE_EVENT(nfs_fscache_page_event_read);
> +DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(nfs_fscache_page_event_read_done);
> +DEFINE_NFS_FSCACHE_PAGE_EVENT(nfs_fscache_page_event_write);
> +DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(nfs_fscache_page_event_write_done);
> +
>  TRACE_EVENT(nfs_initiate_read,
>                 TP_PROTO(
>                         const struct nfs_pgio_header *hdr
> --
> 1.8.3.1
>
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
>

This is unnecessarily complicated.  I'm reworking this to:
- add a patch that renames nfs_readpage_to_fscache to
nfs_fscache_read_page and nfs_readpage_from_fscache to
nfs_fscache_write_page; this matches the fallback API and is clearer
- add a single tracepoint only at the return point of these two
functions, printing the return value

