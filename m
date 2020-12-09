Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A686B2D471C
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 17:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgLIQsT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 11:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbgLIQsT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Dec 2020 11:48:19 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CE9C0613D6
        for <linux-nfs@vger.kernel.org>; Wed,  9 Dec 2020 08:47:38 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id b2so2304175edm.3
        for <linux-nfs@vger.kernel.org>; Wed, 09 Dec 2020 08:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NkrfGfVmB/rh2NNSXp/zzxtQtABbjO2ui/jOi8HsGbk=;
        b=PWGOLD2ZLBkFuDz+lEv4APUHRUUJVNZ0WMiU0gyXuUe9e4/tUYKGWv9XGokdnPKpD2
         g/xRNK+WOelHITh+ztiU8B6RbYYBRydzE4h/c853Wsd+8EHZQE1F1vWcQGRh+p8kfZpm
         3eaTJO834RRlRfiX7fPz+HKgO6xdRakt2HeryNGeTU1puGARakcS8opVDzMwn+YDGmqg
         +pLYvqXGQntLGyOu/JNbY0f2EHPBZ1FyUi6aOvDrN/Jqn1LjFuJb6zWUgC7QzlXKYqJp
         DMrN4ldexdZpfuO7UnE9BlNSZ96iCgTOF+GezqXUDYAY/+6Xl12l0O8CQirFB83rH0Nl
         kEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NkrfGfVmB/rh2NNSXp/zzxtQtABbjO2ui/jOi8HsGbk=;
        b=J7B+dxnqJddkKVNrEE1wV1lC83FJfol10gcyu6c4kBMaCiLIyhsy8lf8J1EYsRMbZu
         dK7b+0OnvEFeKCPmmQDD0NtYeG3XD83kYCS1+TvXyv6vl0agfxQW2MWyRS/mUDNIWbUY
         snabPfgPYYZGWeRiD+JpIqjj8xWrK3XDSGSVkydiFbPSaRy47fQEgDAiR5PmrgcJ/Oy3
         A8KIEX3OcEP1hXZQGPHgkUYU/7bEWj4d1z1xkKRuiy1qmiHYpz65hpc4ds7VbN1MyMAh
         mENaZYrwBwrLZJMIz1F9wt4zYQe7f7XMN3W+R6T5nHDHA/JDQBWnWRy/y7Dw0WsHrKpl
         Mkiw==
X-Gm-Message-State: AOAM531xHHPjzutClGKcWmGqpNLsQ7nW31bjMXumqvWMlcOl5sue/GkH
        LOn6fAHR++DmUKlMeAkRtqFX0kxoWKtIpFwMX9I=
X-Google-Smtp-Source: ABdhPJxTSGpaLhp36Q4PM9agv73CiA5C+M8JLVeKpTG03jeCGQc7c9qyicjPYukcXmRDRMFjofgdXm4KmY/hOtSDVSU=
X-Received: by 2002:a50:c406:: with SMTP id v6mr2923429edf.367.1607532457589;
 Wed, 09 Dec 2020 08:47:37 -0800 (PST)
MIME-Version: 1.0
References: <160746979784.1926.1490061321200284214.stgit@manet.1015granger.net>
In-Reply-To: <160746979784.1926.1490061321200284214.stgit@manet.1015granger.net>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 9 Dec 2020 11:47:26 -0500
Message-ID: <CAN-5tyGPzJUSSb3SGixo0L+CcFV=A12Er5+R=egc3orA9rz8Aw@mail.gmail.com>
Subject: Re: [PATCH v5] xprtrdma: Fix XDRBUF_SPARSE_PAGES support
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 8, 2020 at 6:31 PM Chuck Lever <chuck.lever@oracle.com> wrote:
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
>
> Reported-by: Olga Kornievskaia <kolga@netapp.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Cc: <stable@vger.kernel.org>
> ---
>  net/sunrpc/xprtrdma/rpc_rdma.c |   40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
>
> Hi-
>
> v4 had a bug, which I've fixed. This version has been tested.

This version on top of the same commit  (rc4) passes generic/013
without oopsing for me too.

> In kernels before 5.10-rc5, there are still problems with the way
> LISTXATTRS and GETXATTR deal with the tail / XDR pad for the page
> content that this patch does not address. So backporting this fix
> alone is not enough to get those working again -- more surgery would
> be required.
>
> Since none of the other SPARSE_PAGES users have a problem, let's
> leave this one on the cutting room floor. It's here in the mail
> archive if anyone needs it.
>
>
> Changes since v4:
> - xdr_buf_pagecount() was simply the wrong thing to use.
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
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
> index 0f5120c7668f..c48536f2121f 100644
> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> @@ -179,6 +179,31 @@ rpcrdma_nonpayload_inline(const struct rpcrdma_xprt *r_xprt,
>                 r_xprt->rx_ep->re_max_inline_recv;
>  }
>
> +/* ACL likes to be lazy in allocating pages. For TCP, these
> + * pages can be allocated during receive processing. Not true
> + * for RDMA, which must always provision receive buffers
> + * up front.
> + */
> +static noinline int
> +rpcrdma_alloc_sparse_pages(struct xdr_buf *buf)
> +{
> +       struct page **ppages;
> +       int len;
> +
> +       len = buf->page_len;
> +       ppages = buf->pages + (buf->page_base >> PAGE_SHIFT);
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
> @@ -233,15 +258,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
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
> @@ -867,6 +883,12 @@ rpcrdma_marshal_req(struct rpcrdma_xprt *r_xprt, struct rpc_rqst *rqst)
>         __be32 *p;
>         int ret;
>
> +       if (unlikely(rqst->rq_rcv_buf.flags & XDRBUF_SPARSE_PAGES)) {
> +               ret = rpcrdma_alloc_sparse_pages(&rqst->rq_rcv_buf);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         rpcrdma_set_xdrlen(&req->rl_hdrbuf, 0);
>         xdr_init_encode(xdr, &req->rl_hdrbuf, rdmab_data(req->rl_rdmabuf),
>                         rqst);
>
>
