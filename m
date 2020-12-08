Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455DC2D33C2
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Dec 2020 21:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgLHUYo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Dec 2020 15:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbgLHUYn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Dec 2020 15:24:43 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A506BC0617B0
        for <linux-nfs@vger.kernel.org>; Tue,  8 Dec 2020 12:23:58 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id qw4so26445886ejb.12
        for <linux-nfs@vger.kernel.org>; Tue, 08 Dec 2020 12:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlj4UK3il+2KAt1ysOx7zIbvkKtF8xZn2Xthv4aZkxg=;
        b=k2ocHUFXS32np6ENC2e+tb0CELxVwpo/nAmIoIvJmZnZzoiyEaC9GyACRHCAxz3qXV
         daXydGgMSMErQGAGKW2MMChs3315uBne6/HFeuRVP3Na+ZPZYHarrnucttEP+iykXBcv
         pMtKxC20pGhtlwY6fjXe18b/8AJeoGfoVSeQyTz77Xr2+g1w1n97rXrJBT6DwxY1cSTU
         dU9sxEEXXbmk25pGgf2JXZb++iGTP7dRLGLYKc8lg2rsUsPJOncF8zEoV8WuP++WMf9F
         hBwY9iK02swGRUvm70RU4AtP2TWIl6Hgda9Kpu647jRV098pzPizSugqy8beRx6ChbBf
         rN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlj4UK3il+2KAt1ysOx7zIbvkKtF8xZn2Xthv4aZkxg=;
        b=jINZApvYqzwnOYQE9BPiZXxkdW6qVyLosudJ+Gwsw0yvE/p6auyJZXJk6gOHDLYhoz
         uircp7jcxiXsaYhXkAqPrsdTKIPa80kNaC41yx12EqjIAFcLsmXkkkz4M0Wsdpvqcvu/
         PDLKvgoY8fAM2ltdqnBtNpEZ6JqkGBbk8hLyGagtiKuZLtykJozuLVy28DmVpOwDRcs3
         xxi2MSFjcnj0xyMq4/sy7LHFWG8HPloTjBSt8mKqXxcUEY0YNGCT0sstJnMSXfcbDNWN
         PwOzTZhOh20Hv8tiKA9KoeB2W7silTMhQQvX0DamXaDkk11ikBusN/UxIGpisAma5xZF
         69gQ==
X-Gm-Message-State: AOAM531gxYSL3Lf89fFCugy35dYKmMAxd+tJkK2vlPUIgvLK2ipSRPlu
        S9iDa3MuSfQuYo89FaOkLmC8R4VxgevqIDl30/ORx+kH
X-Google-Smtp-Source: ABdhPJzIGxAzRP3esb7wWqexHMtnROJukgbSdNaWa1f3Rtil1PYUEWwqgju4N7RM5oRsr8StUUWBgg7/rucf/wncDHE=
X-Received: by 2002:aa7:d886:: with SMTP id u6mr26766822edq.139.1607456999651;
 Tue, 08 Dec 2020 11:49:59 -0800 (PST)
MIME-Version: 1.0
References: <160719971621.32538.11224487886769737849.stgit@manet.1015granger.net>
In-Reply-To: <160719971621.32538.11224487886769737849.stgit@manet.1015granger.net>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 8 Dec 2020 14:49:48 -0500
Message-ID: <CAN-5tyFAmWL_Y73pgnaBEP3y_QeFAogRqXjtzPhsOpTvZt_o8w@mail.gmail.com>
Subject: Re: [PATCH 4] xprtrdma: Fix XDRBUF_SPARSE_PAGES support
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Dec 5, 2020 at 3:24 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Olga K. observed that rpcrdma_marsh_req() allocates sparse pages
> only when it has determined that a Reply chunk is necessary. There
> are plenty of cases where no Reply chunk is needed, but the
> XDRBUF_SPARSE_PAGES flag is set. The result would be a crash in
> rpcrdma_inline_fixup() when it tries to copy parts of the received
> Reply into a missing page.
>
> To avoid crashing, handle sparse page allocation up front.
>
> Until XATTR support was added, this issue did not appear often
> because the only SPARSE_PAGES consumer always expected a reply large
> enough to always require a Reply chunk.

Ok so given that ACL never utilizes this, the only way to test this is
to remove the xattr fixes and try this and run the xfstest generic/013
would that be correct?

If so, then just applying this patch on top of pure say -rc4 produces problems.

This patch on top of all the fixes (getxattr + listxattr patches),
seems ok but I'm not sure if it gets exercised.
>
> Reported-by: Olga Kornievskaia <kolga@netapp.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Cc: <stable@vger.kernel.org>
> ---
>  net/sunrpc/xdr.c               |    1 +
>  net/sunrpc/xprtrdma/rpc_rdma.c |   41 +++++++++++++++++++++++++++++++---------
>  2 files changed, 33 insertions(+), 9 deletions(-)
>
> Changes since v3:
> - I swear I am not drunk. I forgot to commit the change before mailing it.
>
> Changes since v2:
> - Actually fix the xdr_buf_pagecount() problem
>
> Changes since RFC:
> - Ensure xdr_buf_pagecount() is defined in rpc_rdma.c
> - noinline the sparse page allocator -- it's an uncommon path
>
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 71e03b930b70..878f4c4fec1a 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -141,6 +141,7 @@ xdr_buf_pagecount(struct xdr_buf *buf)
>                 return 0;
>         return (buf->page_base + buf->page_len + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  }
> +EXPORT_SYMBOL_GPL(xdr_buf_pagecount);
>
>  int
>  xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp)
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
> index 0f5120c7668f..6c9a1810a70a 100644
> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> @@ -179,6 +179,32 @@ rpcrdma_nonpayload_inline(const struct rpcrdma_xprt *r_xprt,
>                 r_xprt->rx_ep->re_max_inline_recv;
>  }
>
> +/* ACL likes to be lazy in allocating pages. For TCP, these
> + * pages can be allocated during receive processing. Not true
> + * for RDMA, which must always provision receive buffers
> + * up front.
> + */
> +static noinline int
> +rpcrdma_alloc_sparse_pages(struct rpc_rqst *rqst)
> +{
> +       struct xdr_buf *xb = &rqst->rq_rcv_buf;
> +       struct page **ppages;
> +       int len;
> +
> +       len = xb->page_len;
> +       ppages = xb->pages + xdr_buf_pagecount(xb);
> +       while (len > 0) {
> +               if (!*ppages)
> +                       *ppages = alloc_page(GFP_NOWAIT | __GFP_NOWARN);
> +               if (!*ppages)
> +                       return -ENOBUFS;
> +               ppages++;
> +               len -= PAGE_SIZE;
> +       }
> +
> +       return 0;
> +}
> +
>  /* Split @vec on page boundaries into SGEs. FMR registers pages, not
>   * a byte range. Other modes coalesce these SGEs into a single MR
>   * when they can.
> @@ -233,15 +259,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
>         ppages = xdrbuf->pages + (xdrbuf->page_base >> PAGE_SHIFT);
>         page_base = offset_in_page(xdrbuf->page_base);
>         while (len) {
> -               /* ACL likes to be lazy in allocating pages - ACLs
> -                * are small by default but can get huge.
> -                */
> -               if (unlikely(xdrbuf->flags & XDRBUF_SPARSE_PAGES)) {
> -                       if (!*ppages)
> -                               *ppages = alloc_page(GFP_NOWAIT | __GFP_NOWARN);
> -                       if (!*ppages)
> -                               return -ENOBUFS;
> -               }
>                 seg->mr_page = *ppages;
>                 seg->mr_offset = (char *)page_base;
>                 seg->mr_len = min_t(u32, PAGE_SIZE - page_base, len);
> @@ -867,6 +884,12 @@ rpcrdma_marshal_req(struct rpcrdma_xprt *r_xprt, struct rpc_rqst *rqst)
>         __be32 *p;
>         int ret;
>
> +       if (unlikely(rqst->rq_rcv_buf.flags & XDRBUF_SPARSE_PAGES)) {
> +               ret = rpcrdma_alloc_sparse_pages(rqst);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         rpcrdma_set_xdrlen(&req->rl_hdrbuf, 0);
>         xdr_init_encode(xdr, &req->rl_hdrbuf, rdmab_data(req->rl_rdmabuf),
>                         rqst);
>
>
