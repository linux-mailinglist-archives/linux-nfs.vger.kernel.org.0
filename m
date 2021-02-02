Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2BD30CC03
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 20:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhBBTmY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 14:42:24 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:36903 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239910AbhBBTlJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 14:41:09 -0500
Received: by mail-ed1-f49.google.com with SMTP id q2so9531567edi.4;
        Tue, 02 Feb 2021 11:40:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pk50pD6HeHLWwu0BfXE8tBkYN61Z4yD2b6PqlsPCRNQ=;
        b=CjHX9xr7gw3bNI2QqnmIUCCir8me9mjDm+Z2DC4YyeL2Nqa9468zYlQau7axcVPyS5
         vl2h+zLexm3adPYW/Vr7N/gpKuau1c2HYfcJR0fixa82aCzYfvY8J+OjzIvRqHzQsWLo
         gReGgZHXMuyNpG8/LeBA/vroH9TKXO8E7ImLdYEY1t3yTTrjl+qMV8JNQpce0oQwBA9/
         mdfbtTic7lgwTAFgtrBoWlC2d1p/qlnS0cCZ2OO9YiW7dfmHUUWyBawvp3F4DBS37Mbj
         qqJ92Xe9PzUlfH5QJgLnPHfW6i+/T1Upk+W5eW/3MvkKf4aN7RJNY5Bi6YPC70h2/3Q8
         ybUw==
X-Gm-Message-State: AOAM532+wVpGKKEi2Yinfee17HxlvrpSFuPuGfpXUOiQix+VGeu26N81
        PJ67nFm/HPvyckcUtC9lmaJtihqk3FJH+SyXLzc=
X-Google-Smtp-Source: ABdhPJyvUPT8QuQHqukraUdcc0aDreyER/PZSzvE78SJ/wQjg4ZiNLmvxnrZsd0M+U2TNXcxAWzv2pt7mSg4iY/T9lQ=
X-Received: by 2002:a05:6402:34d2:: with SMTP id w18mr534620edc.102.1612294825813;
 Tue, 02 Feb 2021 11:40:25 -0800 (PST)
MIME-Version: 1.0
References: <161227696787.3689758.305854118266206775.stgit@manet.1015granger.net>
 <e53cc3c2-2209-5f35-c487-9e59b9b9e526@talpey.com>
In-Reply-To: <e53cc3c2-2209-5f35-c487-9e59b9b9e526@talpey.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 2 Feb 2021 14:40:09 -0500
Message-ID: <CAFX2Jf=FtQ-2NvgY59a-bote8XOnYWEKiYQ+MW0o4np+2_=hzw@mail.gmail.com>
Subject: Re: [PATCH v1] xprtrdma: Simplify rpcrdma_convert_kvec() and frwr_map()
To:     Tom Talpey <tom@talpey.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        List Linux RDMA Mailing <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 2, 2021 at 2:24 PM Tom Talpey <tom@talpey.com> wrote:
>
> What's not to like about a log that uses the words "with aplomb"? :)

As far as I can tell, it'll be the first use of "aplomb" in the entire
kernel git history

>
> Minor related comment/question below.
>
> On 2/2/2021 9:42 AM, Chuck Lever wrote:
> > Clean up.
> >
> > Support for FMR was removed by commit ba69cd122ece ("xprtrdma:
> > Remove support for FMR memory registration") [Dec 2018]. That means
> > the buffer-splitting behavior of rpcrdma_convert_kvec(), added by
> > commit 821c791a0bde ("xprtrdma: Segment head and tail XDR buffers
> > on page boundaries") [Mar 2016], is no longer necessary. FRWR
> > memory registration handles this case with aplomb.
> >
> > A related simplification removes an extra conditional branch from
> > the SGL set-up loop in frwr_map(): Instead of using either
> > sg_set_page() or sg_set_buf(), initialize the mr_page field properly
> > when rpcrdma_convert_kvec() converts the kvec to an SGL entry.
> > frwr_map() can then invoke sg_set_page() unconditionally.
> >
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >   net/sunrpc/xprtrdma/frwr_ops.c  |   10 ++--------
> >   net/sunrpc/xprtrdma/rpc_rdma.c  |   21 +++++----------------
> >   net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
> >   3 files changed, 8 insertions(+), 25 deletions(-)
> >
> > diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
> > index baca49fe83af..5eb044a5f0be 100644
> > --- a/net/sunrpc/xprtrdma/frwr_ops.c
> > +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> > @@ -306,14 +306,8 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
> >       if (nsegs > ep->re_max_fr_depth)
> >               nsegs = ep->re_max_fr_depth;
> >       for (i = 0; i < nsegs;) {
> > -             if (seg->mr_page)
> > -                     sg_set_page(&mr->mr_sg[i],
> > -                                 seg->mr_page,
> > -                                 seg->mr_len,
> > -                                 offset_in_page(seg->mr_offset));
> > -             else
> > -                     sg_set_buf(&mr->mr_sg[i], seg->mr_offset,
> > -                                seg->mr_len);
> > +             sg_set_page(&mr->mr_sg[i], seg->mr_page,
> > +                         seg->mr_len, offset_in_page(seg->mr_offset));
> >
> >               ++seg;
> >               ++i;
> > diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
> > index 8f5d0cb68360..529adb6ad4db 100644
> > --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> > +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> > @@ -204,9 +204,7 @@ rpcrdma_alloc_sparse_pages(struct xdr_buf *buf)
> >       return 0;
> >   }
> >
> > -/* Split @vec on page boundaries into SGEs. FMR registers pages, not
> > - * a byte range. Other modes coalesce these SGEs into a single MR
> > - * when they can.
> > +/* Convert @vec to a single SGL element.
> >    *
> >    * Returns pointer to next available SGE, and bumps the total number
> >    * of SGEs consumed.
> > @@ -215,21 +213,12 @@ static struct rpcrdma_mr_seg *
> >   rpcrdma_convert_kvec(struct kvec *vec, struct rpcrdma_mr_seg *seg,
> >                    unsigned int *n)
> >   {
> > -     u32 remaining, page_offset;
> > -     char *base;
> > -
> > -     base = vec->iov_base;
> > -     page_offset = offset_in_page(base);
> > -     remaining = vec->iov_len;
> > -     while (remaining) {
> > -             seg->mr_page = NULL;
> > -             seg->mr_offset = base;
> > -             seg->mr_len = min_t(u32, PAGE_SIZE - page_offset, remaining);
> > -             remaining -= seg->mr_len;
> > -             base += seg->mr_len;
> > +     if (vec->iov_len) {
> > +             seg->mr_page = virt_to_page(vec->iov_base);
> > +             seg->mr_offset = vec->iov_base;
> > +             seg->mr_len = vec->iov_len;
> >               ++seg;
> >               ++(*n);
> > -             page_offset = 0;
> >       }
> >       return seg;
> >   }
> > diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
> > index 94b28657aeeb..4a9fe6592795 100644
> > --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> > +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> > @@ -285,7 +285,7 @@ enum {
> >
> >   struct rpcrdma_mr_seg {             /* chunk descriptors */
> >       u32             mr_len;         /* length of chunk or segment */
> > -     struct page     *mr_page;       /* owning page, if any */
> > +     struct page     *mr_page;       /* underlying struct page */
> >       char            *mr_offset;     /* kva if no page, else offset */
>
> Is this comment ("kva if no page") actually correct? The hunk just
> above is an example of a case where mr_page is set, yet mr_offset
> is an iov_base. Is iov_base not a kva?
>
> Tom.
>
> >   };
> >
> >
> >
> >
