Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5882C8E1E
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 20:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgK3Td5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 14:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgK3Td5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 14:33:57 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F1FC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 11:33:16 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id q16so17788061edv.10
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 11:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8ZMLfsyOI2AdPB7n7SLLmS5hEE0zcS1h41lJbJhvGY=;
        b=mnrRkvVWfpwNKxvcyMMDMuxoYi0fjhP8wo9yoKa6Liol1khQQMt0SwOsFhf5diVUOj
         T9S+aQnj0R6ncmmynW9311n3Av0o8bj+bRhmGIhr/IOY+YZ9QNbVedwYCGkcChcED57x
         LcrrBWwui6vhz9myC46RJZ8WltW//LiDwartni+lRrveSt4/bRS0PY9vtdNQDjxx3TCG
         S5qE44awrcHYD7aJMUhRDz1UPuJco27V7ojyxsMgyZ95BVJJZDCAdeadjo7S5rw3rW1M
         eKipEXLHJ5nPODiWpfSHSaKn0NfiVCTQY4ThpKtE9wDqqaxwnwOX7xgHtVbL8264+D3u
         Pe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8ZMLfsyOI2AdPB7n7SLLmS5hEE0zcS1h41lJbJhvGY=;
        b=W3JrbLmDalutVONC7mB9E2Tla9eY08jYFMtUZiB7hPx/x42JDezconViouu+kjtAfZ
         PutJHgW+I4OyUvFFFC2NLWjFLBkHHpZMRxHgAufRxa8zUKvm0vfxbaIEonIp/FrY9mlA
         T4Qm/bDINBJOqD8DeYOdzJ9rmBalRaB+fmIxSKLgQHrhibPLhzMZ9WxqVRqhG1BWwTro
         YbZSptyG+vM4fQmVtX+ABwSV3abq6LHJ65YvBOgDlFi0P7/QxDs3uYwO9N3ghH+0InDi
         Z0l8CPxghKohVqveoQEU6gN5pv1LxD4Up0t/ZALkkrPo76crQekzN8Ig9+g+3wdiw5rI
         /Z8Q==
X-Gm-Message-State: AOAM531wUMHk9DdzC1/kaORYMv/W5YrQdLv5NP0tC0sPcsSWZLz2fYPH
        sjd+PwUpQOX//0cU4/k95q8ys7Ey/WQc2DCcQM1boTEA
X-Google-Smtp-Source: ABdhPJxoIQ0ANAJBhYe/9XRb4Zfpdsivh3TG0oYvSR5tWeQawiDtx44YZAAiUTvtsaxUiMhEnVvlHaYsCKBHRT78+zU=
X-Received: by 2002:a50:ed04:: with SMTP id j4mr643910eds.84.1606764795533;
 Mon, 30 Nov 2020 11:33:15 -0800 (PST)
MIME-Version: 1.0
References: <160625754220.280431.690992380938118353.stgit@klimt.1015granger.net>
In-Reply-To: <160625754220.280431.690992380938118353.stgit@klimt.1015granger.net>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 30 Nov 2020 14:33:04 -0500
Message-ID: <CAN-5tyFP6F1Q+gGBLwfwazuaw7WYu-UGfd=Bb0nOmxgU0e_uxw@mail.gmail.com>
Subject: Re: [PATCH v1] SUNRPC: Remove XDRBUF_SPARSE_PAGES flag in gss_proxy upcall
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Simo Sorce <simo@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 24, 2020 at 7:04 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Commit 9dfd87da1aeb ("rpc: fix huge kmalloc's in gss-proxy") added
> gssp_alloc_receive_pages() to fully allocate the receive buffer
> for gss_proxy upcalls.
>
> However, later, 431f6eb3570f ("SUNRPC: Add a label for RPC calls
> that require allocation on receive") sets the XDRBUF_SPARSE_PAGES
> flag for this receive buffer anyway. That doesn't appear to have
> been necessary, since gssp_alloc_receive_pages() still exists.

But the gssp_alloc_receive_pages() only allocates the array of page
pointers not the actual pages, so I believe the flag is still needed
to have those pages allocated by something? What is allocating those
pages if not the SPARSE_PAGES method, what am I missing?


> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/auth_gss/gss_rpc_xdr.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
> index 2ff7b7083eba..44838f6ea25e 100644
> --- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
> +++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
> @@ -771,7 +771,6 @@ void gssx_enc_accept_sec_context(struct rpc_rqst *req,
>         xdr_inline_pages(&req->rq_rcv_buf,
>                 PAGE_SIZE/2 /* pretty arbitrary */,
>                 arg->pages, 0 /* page base */, arg->npages * PAGE_SIZE);
> -       req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
>  done:
>         if (err)
>                 dprintk("RPC:       gssx_enc_accept_sec_context: %d\n", err);
>
>
