Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552CF2C906D
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 23:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgK3WAo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 17:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgK3WAo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 17:00:44 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BE5C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 13:59:57 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id d17so23039321ejy.9
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 13:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eccS/6KGXHmLcbxiA38hg0DVr3YzPrKQx1eAmZ7ug0A=;
        b=YdUiobbP5TvM2XIZglKzho1fTdUo6HMD8dM5dY4OGexJpg8JOCF77l1lBxjITY0Wij
         dFrTEN9xiGp43CD4ZUY1V0ONaf8crJ0V24IITdt57a2KysqeilFg1NPwGL8t8YlvzVG6
         9wd7A7Lz/fqz5hnx8RTNr1YHnvTtA34Z4IDsJXTaq/vtr+s9e1MvjYdWBl0o/V+G+b8y
         6OcZZrH6bkild1UsE22izCJlf2FPzyvum3H3w7kic8ndt2QkM9R3i5GwZWqEGqd7aDTt
         Rc/+rNPYAO98LkKMyWVsbr8rIpLmU8Gmr9b4f+SRsRzrUYXBKShXfC4Y5HRAA6cquG3L
         olqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eccS/6KGXHmLcbxiA38hg0DVr3YzPrKQx1eAmZ7ug0A=;
        b=Ns8tq1M5FUwunpKa4Zhb/6xwfYiMw4iudHVSa5nmhMk+PmfIyS8ygQnuZzGtEKthk+
         sCXm67qhUruqx+3/sOpBqk8dIt9KLMqstgAJcer1+N2M5cU6Hrk8Q9EHMR25NAFfLRZk
         SMvIncgm8r6hk8hm21BmPjgSqf3LWjtkex1N+zZxGJR09a95dvEI4+Y5Pc4t3K2104d8
         gcxU2w0pt6NyNd36x3nF5yk2i4J0kjYBPFMIIDy3TVBOav0ClW9vRxAIkcvP4OMNM76/
         1/8PBAax188QMuaESwM/2CpLmED2Ejhnr+zQfxeEURRV1y8/TfhRh7ZfPrDopaoZWr49
         BPAQ==
X-Gm-Message-State: AOAM530YtYJz8Ktp97UqpDfSGrw6YTA1oGR40J3xf3OGilXAJfYC0hSk
        55Nf+xRgdigSVy8y4ysKjqMNtjSlYoWVItvyudA=
X-Google-Smtp-Source: ABdhPJwphEJJUZW/acHnc/R+6ql6uFgpxNQeDjrY5+Nyt90p9xJ8Wzb22RVjY8bwsTBFkTDO1slopWHsonI2psrCu2g=
X-Received: by 2002:a17:906:1945:: with SMTP id b5mr24340207eje.388.1606773596325;
 Mon, 30 Nov 2020 13:59:56 -0800 (PST)
MIME-Version: 1.0
References: <160676629926.384675.11452129892621714986.stgit@klimt.1015granger.net>
In-Reply-To: <160676629926.384675.11452129892621714986.stgit@klimt.1015granger.net>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 30 Nov 2020 16:59:44 -0500
Message-ID: <CAN-5tyFc3vKMwn6_UcE-oUnr762j_zzP0bp-_FQx1ANbv8zqsg@mail.gmail.com>
Subject: Re: [PATCH v2] SUNRPC: Remove XDRBUF_SPARSE_PAGES flag in gss_proxy upcall
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Simo Sorce <simo@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 30, 2020 at 2:59 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> There's no need to defer allocation of pages for the receive buffer.
>
> - This upcall is quite infrequent
> - gssp_alloc_receive_pages() can allocate the pages with GFP_KERNEL,
>   unlike the transport
> - gssp_alloc_receive_pages() knows exactly how many pages are needed

Looks good to me now. Reviewed-by.

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/auth_gss/gss_rpc_upcall.c |   15 ++++++++++-----
>  net/sunrpc/auth_gss/gss_rpc_xdr.c    |    1 -
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/net/sunrpc/auth_gss/gss_rpc_upcall.c b/net/sunrpc/auth_gss/gss_rpc_upcall.c
> index af9c7f43859c..d1c003a25b0f 100644
> --- a/net/sunrpc/auth_gss/gss_rpc_upcall.c
> +++ b/net/sunrpc/auth_gss/gss_rpc_upcall.c
> @@ -200,7 +200,7 @@ static int gssp_call(struct net *net, struct rpc_message *msg)
>
>  static void gssp_free_receive_pages(struct gssx_arg_accept_sec_context *arg)
>  {
> -       int i;
> +       unsigned int i;
>
>         for (i = 0; i < arg->npages && arg->pages[i]; i++)
>                 __free_page(arg->pages[i]);
> @@ -210,14 +210,19 @@ static void gssp_free_receive_pages(struct gssx_arg_accept_sec_context *arg)
>
>  static int gssp_alloc_receive_pages(struct gssx_arg_accept_sec_context *arg)
>  {
> +       unsigned int i;
> +
>         arg->npages = DIV_ROUND_UP(NGROUPS_MAX * 4, PAGE_SIZE);
>         arg->pages = kcalloc(arg->npages, sizeof(struct page *), GFP_KERNEL);
> -       /*
> -        * XXX: actual pages are allocated by xdr layer in
> -        * xdr_partial_copy_from_skb.
> -        */
>         if (!arg->pages)
>                 return -ENOMEM;
> +       for (i = 0; i < arg->npages; i++) {
> +               arg->pages[i] = alloc_page(GFP_KERNEL);
> +               if (!arg->pages[i]) {
> +                       gssp_free_receive_pages(arg);
> +                       return -ENOMEM;
> +               }
> +       }
>         return 0;
>  }
>
> diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
> index c636c648849b..d79f12c2550a 100644
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
