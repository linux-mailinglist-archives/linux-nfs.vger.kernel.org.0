Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CFC310DE4
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Feb 2021 17:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhBEOtL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Feb 2021 09:49:11 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:33573 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhBEOqs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Feb 2021 09:46:48 -0500
Received: by mail-ej1-f42.google.com with SMTP id sa23so12887559ejb.0
        for <linux-nfs@vger.kernel.org>; Fri, 05 Feb 2021 08:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1sLhgz2bT0hmAoAP4UKLb4wyMBm5V3HOnBLPmXbkr6w=;
        b=f2mQXP4w8PSx2hNRI97LEY8mbAk81+rtulRe3HQi2kY/kBqU9/uQJFGKONV5+m4AmK
         n9BkqDg368SPkOBITYWk3nI+t3GL23Uvayu7XDO5I5LZWCD4ncWsdrypANF1rh//jXR4
         7ukR6gUAo6QTq7CfHwvWFJY1Lq8/8WlJNTwIv3QPePpM76OsO5LF38oGBN1zCytsnPrb
         9mTYXGsM12iQnxthaVo0zcrw6wiZDb628SwJAfj0OX2yYLmXo3yAG5nPw9Yr/i84UahB
         vKrtPgn6Kc2VCD1NRdpAqRdRTFSiNrV/PGm+FnRCfr80rBSDFCQ+jdani761in0ZA5NX
         QoYw==
X-Gm-Message-State: AOAM533QI3h/LaX6h1LIj/JM8KnFf9OsrEGmO2BXKsOtxWF4ljKiLd6P
        42MsRUcuoUakQi/HeR35MqfRP71k196dDZJXx9E=
X-Google-Smtp-Source: ABdhPJwnOvB9mqKLxzgkjyWBlHn04aLvWzlRRQQmHwy+/JglhxDklZCJViyvMiQ8/6Cn3KwDEPLafFS3a+GXHqgJpA8=
X-Received: by 2002:a17:906:6407:: with SMTP id d7mr4659993ejm.133.1612542267054;
 Fri, 05 Feb 2021 08:24:27 -0800 (PST)
MIME-Version: 1.0
References: <1611845708-6752-1-git-send-email-dwysocha@redhat.com>
 <1611845708-6752-7-git-send-email-dwysocha@redhat.com> <CALF+zOm=rnet4cXpSVs+7azC7P5W8oBgyu+NW8UCGeughCXi5A@mail.gmail.com>
In-Reply-To: <CALF+zOm=rnet4cXpSVs+7azC7P5W8oBgyu+NW8UCGeughCXi5A@mail.gmail.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Fri, 5 Feb 2021 11:24:10 -0500
Message-ID: <CAFX2Jf=XCQfATM6kTwtEZ+hQNEU=DsojpdH=YWtf-Kd_rTNXnA@mail.gmail.com>
Subject: Re: [PATCH 06/10] NFS: Allow internal use of read structs and functions
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 5, 2021 at 8:53 AM David Wysochanski <dwysocha@redhat.com> wrote:
>
> On Thu, Jan 28, 2021 at 9:59 AM Dave Wysochanski <dwysocha@redhat.com> wrote:
> >
> > The conversion of the NFS read paths to the new fscache API
> > will require use of a few read structs and functions,
> > so move these declarations as required.
> >
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> >  fs/nfs/internal.h |  8 ++++++++
> >  fs/nfs/read.c     | 13 ++++---------
> >  2 files changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> > index 62d3189745cd..8514d002c922 100644
> > --- a/fs/nfs/internal.h
> > +++ b/fs/nfs/internal.h
> > @@ -457,9 +457,17 @@ extern char *nfs_path(char **p, struct dentry *dentry,
> >
> >  struct nfs_pgio_completion_ops;
> >  /* read.c */
> > +extern const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
> >  extern void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
> >                         struct inode *inode, bool force_mds,
> >                         const struct nfs_pgio_completion_ops *compl_ops);
> > +struct nfs_readdesc {
> > +       struct nfs_pageio_descriptor pgio;
> > +       struct nfs_open_context *ctx;
> > +};
> > +extern int readpage_async_filler(void *data, struct page *page);
> > +extern void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
> > +                                    struct inode *inode);
> >  extern void nfs_read_prepare(struct rpc_task *task, void *calldata);
> >  extern void nfs_pageio_reset_read_mds(struct nfs_pageio_descriptor *pgio);
> >
> > diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> > index d2b6dce1f99f..9618abf01136 100644
> > --- a/fs/nfs/read.c
> > +++ b/fs/nfs/read.c
> > @@ -30,7 +30,7 @@
> >
> >  #define NFSDBG_FACILITY                NFSDBG_PAGECACHE
> >
> > -static const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
> > +const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
> >  static const struct nfs_rw_ops nfs_rw_read_ops;
> >
> >  static struct kmem_cache *nfs_rdata_cachep;
> > @@ -74,7 +74,7 @@ void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
> >  }
> >  EXPORT_SYMBOL_GPL(nfs_pageio_init_read);
> >
> > -static void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
> > +void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
> >                                      struct inode *inode)
> >  {
> >         struct nfs_pgio_mirror *pgm;
> > @@ -132,11 +132,6 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
> >         nfs_release_request(req);
> >  }
> >
> > -struct nfs_readdesc {
> > -       struct nfs_pageio_descriptor pgio;
> > -       struct nfs_open_context *ctx;
> > -};
> > -
> >  static void nfs_page_group_set_uptodate(struct nfs_page *req)
> >  {
> >         if (nfs_page_group_sync_on_bit(req, PG_UPTODATE))
> > @@ -215,7 +210,7 @@ static void nfs_initiate_read(struct nfs_pgio_header *hdr,
> >         }
> >  }
> >
> > -static const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
> > +const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
> >         .error_cleanup = nfs_async_read_error,
> >         .completion = nfs_read_completion,
> >  };
> > @@ -290,7 +285,7 @@ static void nfs_readpage_result(struct rpc_task *task,
> >                 nfs_readpage_retry(task, hdr);
> >  }
> >
> > -static int
> > +int
> >  readpage_async_filler(void *data, struct page *page)
> >  {
> >         struct nfs_readdesc *desc = data;
> > --
> > 1.8.3.1
> >
>
> Anna, FYI, you could drop this from your linux-next branch if you want.
> Since the fscache conversion patches are not included, we don't really
> need this patch.
> The other patches 1-5 I are valid cleanups but this really goes with
> the conversion patches.
> It's your call though.

Sounds good. I've dropped the patch from my tree.

Anna
>
