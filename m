Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A3F2D307F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Dec 2020 18:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgLHREO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Dec 2020 12:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbgLHREL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Dec 2020 12:04:11 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE4FC0613D6
        for <linux-nfs@vger.kernel.org>; Tue,  8 Dec 2020 09:03:31 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id lt17so25636680ejb.3
        for <linux-nfs@vger.kernel.org>; Tue, 08 Dec 2020 09:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKzOcey9uGfSeqVTB/TgTW1Go/hEoRMsdXo2WuKtzVA=;
        b=oOYwe3RcDTS5SU1oYIITMIIDeogg58m3GpELN/8ZxiZTHHAdp/vVT8Bts8la8O2wcz
         euq2odyeC8jTPGGYrb1cgabQI7Q7IdIdx1d6Frh+nPZcvOMRU8xINcZzc87wL0a5iU8m
         qKoqpqg1GOZ4z6nq63LW9w4FbmjkVQJhzC6U0ku8EoTzgdG5TrSZaN58WYys4b8pJrE0
         RZJ7DqeYN/saPYhWg3QEiY4P6zaa7BVZzAmu6XMuVTHGhxLwXQhDWKYfmQ6B3Lg1vvzD
         qdVri54wWyHikKShJjrU9Y0RRXCyn4epu6dQ72RlwSXxCHfSTYQY2YS5x8WhHKMb93XJ
         /72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKzOcey9uGfSeqVTB/TgTW1Go/hEoRMsdXo2WuKtzVA=;
        b=eg+Cd6o48KbnX8gT45WokVZbxuKboV4HJxHj4tzlbNYuFRDpcbQk5KQnXqQiswNKXC
         3F9Xzzw5DGHiH39C8BCf+t63m9mMlCIyPmzVVcfTpt6MXgg4IlPfyo/d1EskNys8M2D6
         Ni1/Y6XDB3WVoM1VPwFEfx6NwrLcnVC0514HNiBdLoiP62II5b0vmMl5jKY6L63cxVcW
         rXn3FHyjH0/3myEfZxi2W+809Jo8UQbH1jXJ1c/L3V0Gr4op7Yk830tV5dbdIvzoOhYO
         LPj3OwMTVAL1OYMCXqlj7/nItxjO/HLFz4P9hD+hvdC8A8KHXaGn7ls5PxZreJWFkFX3
         5FmA==
X-Gm-Message-State: AOAM533K2vKI1R7ubPw83uTfVEwY8Zx7tBPc1xaa3Vg2Z+Yw5hygkL1r
        K57liwphdInTxD/ayzsGR/roiPWJ55BPq0ZB9xY=
X-Google-Smtp-Source: ABdhPJyRItQhE4/kwBAUYcrJ40qrCTAa03Yqub4ymlUmXmw/y7jSS5rkf5oHIPXsUjNdeYSoePS+ntX4xIcehBMrVQE=
X-Received: by 2002:a17:907:206a:: with SMTP id qp10mr24332590ejb.432.1607447010140;
 Tue, 08 Dec 2020 09:03:30 -0800 (PST)
MIME-Version: 1.0
References: <160711969521.12486.14622797339746381076.stgit@manet.1015granger.net>
In-Reply-To: <160711969521.12486.14622797339746381076.stgit@manet.1015granger.net>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 8 Dec 2020 12:03:18 -0500
Message-ID: <CAN-5tyFTMj8ed7Q+4KYgwtJhUGN3i_MVV60N7f0oZH8PL=77Pw@mail.gmail.com>
Subject: Re: [PATCH RFC] xprtrdma: Fix XDRBUF_SPARSE_PAGES support
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Olga Kornievskaia <kolga@netapp.com>,
        Frank van der Linden <fllinden@amazon.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

Is the only user of SPARSE_PAGES is v3 ACLs? Are you fixing this so
that v3 ACLs would work over rdma?

On Fri, Dec 4, 2020 at 5:13 PM Chuck Lever <chuck.lever@oracle.com> wrote:
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
> enough to require a Reply chunk.
>
> Reported-by: Olga Kornievskaia <kolga@netapp.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtrdma/rpc_rdma.c |   41 +++++++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 9 deletions(-)
>
> Here's a stop-gap that can be back-ported to earlier kernels if needed.
> Untested. Comments welcome.
>
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
> index 0f5120c7668f..09b7649fa112 100644
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
> +static int
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
