Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC96B2C3177
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 20:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgKXTxv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 14:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgKXTxu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 14:53:50 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9789C0613D6
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 11:53:49 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id f23so30292067ejk.2
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 11:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMjJGilD9W50HCTRrCZZdcqkP1RpTqn68XBY41XUzkw=;
        b=rHYNHatRNRWnCEukJElm/EJTQxP2tFxWPrk8VltLhg5PMzh7I0D3L4FkYOlnA+S1Vk
         1nlwxa9re/PJVuIZ5EkoQ3FY9W919bOOwta//h+rJZWYM/FGWQHbeF4ickhZX2x4LfC2
         5zr+cIpvCDqemKnGR9hfmmg62NqBCOAgpgCWOS15A0phb/nsSy2GCO64zrhuI5ANBVij
         uiqUpSNRRDu59Rpd9hu3V/mllpJFevW8krenlGwfePMvSgsf1M4Sa1+BZKtZZKzDLihg
         EYCUcf18S7Ak/sjkVS1MEpsLhjPnAE9OJ9ro+Hj/yoBUFUin71HlZmJgmY+PxoDYGMQZ
         PSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMjJGilD9W50HCTRrCZZdcqkP1RpTqn68XBY41XUzkw=;
        b=lu3LYHvEwjYkcQVLkR+FEqz33KdR0lAGpImPBBW2shmSCnvbd3e1O4j1J6W5R0BnZ1
         TQJdh8ur5rLg6HIbOdJ96PvksLiSYnAcIFHFuF9wKlJ+iHlRap2hJxdwPfrh0UURTPJR
         V+CdH7MUUhgwxZUr43GCsJPM2DOnfgQs6nNPWcUNMAj1n0Y5A/Gkb/9W3w9e+h+LKtOb
         NiR050tvCrk0DyJvF7KvmtaULqrS6jCaQdi/m/JEOjVGR9/BuaXBcrfXowN8cXiBBW5z
         5XZ3pu6lz0JRz8BfrkBwmXuhLtxDyegaNR+12pY+kwYUgjmysm5IM+7mNOmWg9vf9oMk
         WS0w==
X-Gm-Message-State: AOAM530Znsq9JVJgu2yKqZLO8jE3uHhIQsQrzaWbjcaDE2o6kUIcKep1
        4sg3PrFNC2ovLuZpBrY/WQnhGU4y5x/g6Ewp8II=
X-Google-Smtp-Source: ABdhPJwdun1TYeNCHLejn5zBEcNCnMlZfSDM1NgJm45pxyIFVjuf7x56y5qvcTZbMLEcbK2LL4LIESfQwhyQur4Jf5U=
X-Received: by 2002:a17:906:1918:: with SMTP id a24mr36286eje.432.1606247628470;
 Tue, 24 Nov 2020 11:53:48 -0800 (PST)
MIME-Version: 1.0
References: <160623862874.1534.4471924380357882531.stgit@manet.1015granger.net>
In-Reply-To: <160623862874.1534.4471924380357882531.stgit@manet.1015granger.net>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 24 Nov 2020 14:53:37 -0500
Message-ID: <CAN-5tyFuA=jm7pubhiJB+eEXN1gJmrUL1jPOfOb=G-9Tro_-=Q@mail.gmail.com>
Subject: Re: [PATCH v1] NFS: Fix rpcrdma_inline_fixup() crash with new
 LISTXATTRS operation
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Olga Kornievskaia <kolga@netapp.com>,
        Frank van der Linden <fllinden@amazon.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 24, 2020 at 12:30 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> By switching to an XFS-backed export, I am able to reproduce the
> ibcomp worker crash on my client with xfstests generic/013.
>
> For the failing LISTXATTRS operation, xdr_inline_pages() is called
> with page_len=12 and buflen=128. Then:
>
> - Because buflen is small, rpcrdma_marshal_req will not set up a
>   Reply chunk and the rpcrdma's XDRBUF_SPARSE_PAGES logic does not
>   get invoked at all.
>
> - Because page_len is non-zero, rpcrdma_inline_fixup() tries to
>   copy received data into rq_rcv_buf->pages, but they're missing.
>
> The result is that the ibcomp worker faults and dies. Sometimes that
> causes a visible crash, and sometimes it results in a transport
> hang without other symptoms.
>
> RPC/RDMA's XDRBUF_SPARSE_PAGES support is not entirely correct, and
> should eventually be fixed or replaced. However, my preference is
> that upper-layer operations should explicitly allocate their receive
> buffers (using GFP_KERNEL) when possible, rather than relying on
> XDRBUF_SPARSE_PAGES.
>
> Reported-by: Olga kornievskaia <kolga@netapp.com>
> Suggested-by: Olga kornievskaia <kolga@netapp.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Yes!
Reviewed-by && Tested-by.

> ---
>  fs/nfs/nfs42proc.c |   17 ++++++++++-------
>  fs/nfs/nfs42xdr.c  |    1 -
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> Hi-
>
> I like Olga's proposed approach. What do you think of this patch?
>
>
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 2b2211d1234e..24810305ec1c 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -1241,7 +1241,7 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
>                 .rpc_resp       = &res,
>         };
>         u32 xdrlen;
> -       int ret, np;
> +       int ret, np, i;
>
>
>         res.scratch = alloc_page(GFP_KERNEL);
> @@ -1253,10 +1253,14 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
>                 xdrlen = server->lxasize;
>         np = xdrlen / PAGE_SIZE + 1;
>
> +       ret = -ENOMEM;
>         pages = kcalloc(np, sizeof(struct page *), GFP_KERNEL);
> -       if (pages == NULL) {
> -               __free_page(res.scratch);
> -               return -ENOMEM;
> +       if (pages == NULL)
> +               goto out_free;
> +       for (i = 0; i < np; i++) {
> +               pages[i] = alloc_page(GFP_KERNEL);
> +               if (!pages[i])
> +                       goto out_free;
>         }
>
>         arg.xattr_pages = pages;
> @@ -1271,14 +1275,13 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
>                 *eofp = res.eof;
>         }
>
> +out_free:
>         while (--np >= 0) {
>                 if (pages[np])
>                         __free_page(pages[np]);
>         }
> -
> -       __free_page(res.scratch);
>         kfree(pages);
> -
> +       __free_page(res.scratch);
>         return ret;
>
>  }
> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> index 6e060a88f98c..8432bd6b95f0 100644
> --- a/fs/nfs/nfs42xdr.c
> +++ b/fs/nfs/nfs42xdr.c
> @@ -1528,7 +1528,6 @@ static void nfs4_xdr_enc_listxattrs(struct rpc_rqst *req,
>
>         rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->count,
>             hdr.replen);
> -       req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
>
>         encode_nops(&hdr);
>  }
>
>
