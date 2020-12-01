Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD812CAFB9
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 23:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbgLAWEp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 17:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgLAWEp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 17:04:45 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E9BC0613CF
        for <linux-nfs@vger.kernel.org>; Tue,  1 Dec 2020 14:03:59 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id f23so7614604ejt.8
        for <linux-nfs@vger.kernel.org>; Tue, 01 Dec 2020 14:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lkqFsauelkSisynaINp/KdUZl4IJWAVB2oeV+UtU0CY=;
        b=BWF3oLpQhoOYUSbpjxSvRHQ74jDqNT7isHnVZwpmkyOyvecxIemoCLiCSfWRzcvOs9
         c3zf7cRA+LCsl7PoHapbp8z1PQY0M9NrKgsLbKRvfCe2BlN8hjsPX0t5Sp2AKNRjRbAX
         Q6OcJbPVyg8s2GzK5uGkjty2JmBxtxS1B2URygPsD9FEWByqZLPHIzT5OmGwzzQglrkt
         /m+yU8/gMVDORPsaYhl3EMtOUa+Q68vn2c+wGmiwA7kCbWv2KsrA5wjhdtZWR2sSluPQ
         L8uht6Mmk8C8gXjJMK2IztWjBi2CbCEXOHprL3s1p+wrmw1c0NmyR8uYLUnATPafH+/O
         vekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkqFsauelkSisynaINp/KdUZl4IJWAVB2oeV+UtU0CY=;
        b=elnl1wfJoJBDaU8iVCa9RtzDQKQEjUjIyiXX8Hx2NpKRgM9zO8FeKSM0gheY1stP1c
         HI352A4XZ0cRJmpj5GMQd0CxXFUvPTfJ1ALIsL3yGe7SzF0qSKhp+UJcNYFO0AW1y5n9
         3KZgi9+x2xH57hFBRFrUV2NABbtoMZQSTBvB1H5DepI3IHKuGu9pl0CJzbyACrlk28zb
         P49tKJAA+B5aHVgSyy/6DRx7T4F1fB0uY6E8QiKUTtt35pmL7ml2MpQA7oFovIPKi4D7
         0zgHkj/NaDKJC8wSifx8/sDY1iWo/97udbHk/ZZoDm0qlvBresvjEttCmxAPAR75VjZc
         Wghg==
X-Gm-Message-State: AOAM533IqahwxjjHZW/O47OZe6eJwgQSDRkd0BaGzOoZ/p3loPX0+LVq
        gaAOpbzlzugb+q1PJQ90nPaUoxG7DAbqjmFaS4c=
X-Google-Smtp-Source: ABdhPJwlko7+fKDVVi86sf7K7VzdbKZiHcxuK8lyWv/cAXOlD7wfv74XKsM9uil0HB4mG3IZgGbAntsbOZjKrJ2/KMA=
X-Received: by 2002:a17:907:206a:: with SMTP id qp10mr956895ejb.432.1606860237901;
 Tue, 01 Dec 2020 14:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20201201213128.13624-1-fllinden@amazon.com>
In-Reply-To: <20201201213128.13624-1-fllinden@amazon.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 1 Dec 2020 17:03:46 -0500
Message-ID: <CAN-5tyF8P9J8DhHZhFyEq97BpjAe9bFg786QH6eF_1r0jPi-Fg@mail.gmail.com>
Subject: Re: [PATCH] NFSv4.2: improve page handling for GETXATTR
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 1, 2020 at 4:44 PM Frank van der Linden <fllinden@amazon.com> wrote:
>
> XDRBUF_SPARSE_PAGES can cause problems for the RDMA transport,
> and it's easy enough to allocate enough pages for the request
> up front, so do that.
>
> Also, since we've allocated the pages anyway, use the full
> page aligned length for the receive buffer. This will allow
> caching of valid replies that are too large for the caller,
> but that still fit in the allocated pages.
>
> Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> ---
>  fs/nfs/nfs42proc.c | 39 ++++++++++++++++++++++++++++++---------
>  fs/nfs/nfs42xdr.c  | 22 +++++++++++++++++-----
>  2 files changed, 47 insertions(+), 14 deletions(-)
>
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 2b2211d1234e..bfe15ac77bd9 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -1176,11 +1176,9 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
>                                 void *buf, size_t buflen)
>  {
>         struct nfs_server *server = NFS_SERVER(inode);
> -       struct page *pages[NFS4XATTR_MAXPAGES] = {};
> +       struct page **pages;
>         struct nfs42_getxattrargs arg = {
>                 .fh             = NFS_FH(inode),
> -               .xattr_pages    = pages,
> -               .xattr_len      = buflen,
>                 .xattr_name     = name,
>         };
>         struct nfs42_getxattrres res;
> @@ -1189,12 +1187,31 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
>                 .rpc_argp       = &arg,
>                 .rpc_resp       = &res,
>         };
> -       int ret, np;
> +       ssize_t ret, np, i;
> +
> +       arg.xattr_len = buflen ?: XATTR_SIZE_MAX;
> +
> +       ret = -ENOMEM;
> +       np = DIV_ROUND_UP(arg.xattr_len, PAGE_SIZE);
> +
> +       pages = kcalloc(np, sizeof(struct page *), GFP_KERNEL);
> +       if (pages == NULL)
> +               return ret;
> +
> +       for (i = 0; i < np; i++) {
> +               pages[i] = alloc_page(GFP_KERNEL);
> +               if (!pages[i])
> +                       goto out_free;
> +       }
> +
> +       arg.xattr_pages = pages;
>
>         ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
>             &res.seq_res, 0);
>         if (ret < 0)
> -               return ret;
> +               goto out_free;
> +
> +       ret = res.xattr_len;
>
>         /*
>          * Normally, the caching is done one layer up, but for successful
> @@ -1209,16 +1226,20 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
>         nfs4_xattr_cache_add(inode, name, NULL, pages, res.xattr_len);
>
>         if (buflen) {
> -               if (res.xattr_len > buflen)
> -                       return -ERANGE;
> +               if (res.xattr_len > buflen) {
> +                       ret = -ERANGE;
> +                       goto out_free;
> +               }
>                 _copy_from_pages(buf, pages, 0, res.xattr_len);
>         }
>
> -       np = DIV_ROUND_UP(res.xattr_len, PAGE_SIZE);
> +out_free:
>         while (--np >= 0)
>                 __free_page(pages[np]);

Looking at Chuck's page for listxattr, I think we need to check if
(pages[np) before freeing?

Otherwise, looks fine to me. Reviewed-by.

> -       return res.xattr_len;
> +       kfree(pages);
> +
> +       return ret;
>  }
>
>  static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> index 6e060a88f98c..8dfe674d1301 100644
> --- a/fs/nfs/nfs42xdr.c
> +++ b/fs/nfs/nfs42xdr.c
> @@ -489,6 +489,12 @@ static int decode_getxattr(struct xdr_stream *xdr,
>                 return -EIO;
>
>         len = be32_to_cpup(p);
> +
> +       /*
> +        * Only check against the page length here. The actual
> +        * requested length may be smaller, but that is only
> +        * checked against after possibly caching a valid reply.
> +        */
>         if (len > req->rq_rcv_buf.page_len)
>                 return -ERANGE;
>
> @@ -1483,11 +1489,17 @@ static void nfs4_xdr_enc_getxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
>         encode_putfh(xdr, args->fh, &hdr);
>         encode_getxattr(xdr, args->xattr_name, &hdr);
>
> -       plen = args->xattr_len ? args->xattr_len : XATTR_SIZE_MAX;
> -
> -       rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
> -           hdr.replen);
> -       req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
> +       /*
> +        * The GETXATTR op has no length field in the call, and the
> +        * xattr data is at the end of the reply.
> +        *
> +        * Since the pages have already been allocated, there is no
> +        * downside in using the page-aligned length. It will allow
> +        * receiving and caching xattrs that are too large for the
> +        * caller but still fit in the page-rounded value.
> +        */
> +       plen = round_up(args->xattr_len, PAGE_SIZE);
> +       rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen, hdr.replen);
>
>         encode_nops(&hdr);
>  }
> --
> 2.23.3
>
