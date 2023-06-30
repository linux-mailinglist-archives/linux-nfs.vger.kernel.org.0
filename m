Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D517444FD
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Jul 2023 01:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjF3XBP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jun 2023 19:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjF3XBO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jun 2023 19:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E182D69
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 16:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 706AB617A2
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 23:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF0AC433C7;
        Fri, 30 Jun 2023 23:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688166071;
        bh=bndu219xYWB1jFVK3ddHCkDInlFkoSdRu85wZh2m1hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qAhzLWftAdGVOAKAAI2MhDsouGXZRXBr2VaW+8560OIwE9MbRExPyObs0K8HJSiry
         tZsxhgKvuUhllUWUxKYaTvM1NaiIyWNo8vlpWinp1Cr5P/gRJ/uVnd6waZhm1PQEhe
         8naPjAAyXXOcVQv2IA2ZsYKj1D3RYMtiJkhHirR8r/k1YPrgVfZfgd6bKNj/tw3CkK
         elgOLnurNIONQL29IYy1/xus347+i4A2/6vgRH1KcWWzTi3gtiaU9e78o3LrLR/rSB
         VdhP6TyYFq31xC7TeT6Rnl5SLla/rwVhwHdcBxhhlLhLNfPTX1013T0eUaMdCCODv4
         ILCiegsZdGRPA==
Date:   Fri, 30 Jun 2023 19:01:08 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Subject: Re: [PATCH v4 4/4] SUNRPC: kmap() the xdr pages during decode
Message-ID: <ZJ9etMtEYB+hXfH5@manet.1015granger.net>
References: <20230630204240.653492-1-anna@kernel.org>
 <20230630204240.653492-5-anna@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630204240.653492-5-anna@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 30, 2023 at 04:42:40PM -0400, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> If the pages are in HIGHMEM then we need to make sure they're mapped
> before trying to read data off of them, otherwise we could end up with a
> NULL pointer dereference.
> 
> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>  include/linux/sunrpc/xdr.h |  2 ++
>  net/sunrpc/clnt.c          |  1 +
>  net/sunrpc/xdr.c           | 17 ++++++++++++++++-
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index d917618a3058..f562aab468f5 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -228,6 +228,7 @@ struct xdr_stream {
>  	struct kvec *iov;	/* pointer to the current kvec */
>  	struct kvec scratch;	/* Scratch buffer */
>  	struct page **page_ptr;	/* pointer to the current page */
> +	void *page_kaddr;	/* kmapped address of the current page */
>  	unsigned int nwords;	/* Remaining decode buffer length */
>  
>  	struct rpc_rqst *rqst;	/* For debugging */
> @@ -254,6 +255,7 @@ extern void xdr_truncate_decode(struct xdr_stream *xdr, size_t len);
>  extern int xdr_restrict_buflen(struct xdr_stream *xdr, int newbuflen);
>  extern void xdr_write_pages(struct xdr_stream *xdr, struct page **pages,
>  		unsigned int base, unsigned int len);
> +extern void xdr_stream_unmap_current_page(struct xdr_stream *xdr);
>  extern unsigned int xdr_stream_pos(const struct xdr_stream *xdr);
>  extern unsigned int xdr_page_pos(const struct xdr_stream *xdr);
>  extern void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf,
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index d2ee56634308..3b7e676d8935 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2590,6 +2590,7 @@ call_decode(struct rpc_task *task)
>  	case 0:
>  		task->tk_action = rpc_exit_task;
>  		task->tk_status = rpcauth_unwrap_resp(task, &xdr);
> +		xdr_stream_unmap_current_page(&xdr);

The server uses xdr_inline_decode() as well. Wouldn't it also need
some kind of clean up?

I'm curious why this issue hasn't been a problem until now.


>  		return;
>  	case -EAGAIN:
>  		task->tk_status = 0;
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 391b336d97de..fb5203337608 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -1308,6 +1308,14 @@ static unsigned int xdr_set_tail_base(struct xdr_stream *xdr,
>  	return xdr_set_iov(xdr, buf->tail, base, len);
>  }
>  
> +void xdr_stream_unmap_current_page(struct xdr_stream *xdr)
> +{
> +	if (xdr->page_kaddr) {
> +		kunmap_local(xdr->page_kaddr);
> +		xdr->page_kaddr = NULL;
> +	}
> +}
> +
>  static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
>  				      unsigned int base, unsigned int len)
>  {
> @@ -1325,12 +1333,18 @@ static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
>  	if (len > maxlen)
>  		len = maxlen;
>  
> +	xdr_stream_unmap_current_page(xdr);
>  	xdr_stream_page_set_pos(xdr, base);
>  	base += xdr->buf->page_base;
>  
>  	pgnr = base >> PAGE_SHIFT;
>  	xdr->page_ptr = &xdr->buf->pages[pgnr];
> -	kaddr = page_address(*xdr->page_ptr);
> +
> +	if (PageHighMem(*xdr->page_ptr)) {
> +		xdr->page_kaddr = kmap_local_page(*xdr->page_ptr);
> +		kaddr = xdr->page_kaddr;
> +	} else
> +		kaddr = page_address(*xdr->page_ptr);
>  
>  	pgoff = base & ~PAGE_MASK;
>  	xdr->p = (__be32*)(kaddr + pgoff);
> @@ -1384,6 +1398,7 @@ void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf, __be32 *p,
>  		     struct rpc_rqst *rqst)
>  {
>  	xdr->buf = buf;
> +	xdr->page_kaddr = NULL;
>  	xdr_reset_scratch_buffer(xdr);
>  	xdr->nwords = XDR_QUADLEN(buf->len);
>  	if (xdr_set_iov(xdr, buf->head, 0, buf->len) == 0 &&
> -- 
> 2.41.0
> 
