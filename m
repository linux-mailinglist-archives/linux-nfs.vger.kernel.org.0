Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1143E1A1BBF
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2020 08:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgDHGCr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Apr 2020 02:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDHGCr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 Apr 2020 02:02:47 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A796E20692;
        Wed,  8 Apr 2020 06:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586325766;
        bh=8v8ZKXib54k0pnUocYC3djwt29r0O8csFX6JxH9NeOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8Hl/5DKmnHwOdThCnnANV+OtdCemNc0qjoKCUprQdh3GmAP+u63XbrZRgae0SlFx
         /d/lnSiF5W4FUGiUNdzfMuJmeTr8ysGLIaMlWMGYXPWs5tiaV9u6G8UTAxSObkLeUg
         RH9+LVDKJbhP9R2hJ/A/jX6dRkhu9Tl71aMPAk8Q=
Date:   Wed, 8 Apr 2020 09:02:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 3/3] svcrdma: Fix leak of svc_rdma_recv_ctxt objects
Message-ID: <20200408060242.GB3310@unreal>
References: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
 <20200407191106.24045.88035.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407191106.24045.88035.stgit@klimt.1015granger.net>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 07, 2020 at 03:11:06PM -0400, Chuck Lever wrote:
> Utilize the xpo_release_rqst transport method to ensure that each
> rqstp's svc_rdma_recv_ctxt object is released even when the server
> cannot return a Reply for that rqstp.
>
> Without this fix, each RPC whose Reply cannot be sent leaks one
> svc_rdma_recv_ctxt. This is a 2.5KB structure, a 4KB DMA-mapped
> Receive buffer, and any pages that might be part of the Reply
> message.
>
> The leak is infrequent unless the network fabric is unreliable or
> Kerberos is in use, as GSS sequence window overruns, which result
> in connection loss, are more common on fast transports.
>
> Fixes: 3a88092ee319 ("svcrdma: Preserve Receive buffer until ... ")

Chuck,

Can you please don't mangle the Fixes line?
A lot of automatization is relying on the fact that this line is canonical,
both in format and in the actual content.

Thanks

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc_rdma.h          |    1 +
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |   22 ++++++++++++++++++++++
>  net/sunrpc/xprtrdma/svc_rdma_sendto.c    |   13 +++----------
>  net/sunrpc/xprtrdma/svc_rdma_transport.c |    5 -----
>  4 files changed, 26 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
> index 78fe2ac6dc6c..cbcfbd0521e3 100644
> --- a/include/linux/sunrpc/svc_rdma.h
> +++ b/include/linux/sunrpc/svc_rdma.h
> @@ -170,6 +170,7 @@ extern bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma);
>  extern void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
>  				   struct svc_rdma_recv_ctxt *ctxt);
>  extern void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma);
> +extern void svc_rdma_release_rqst(struct svc_rqst *rqstp);
>  extern int svc_rdma_recvfrom(struct svc_rqst *);
>
>  /* svc_rdma_rw.c */
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> index 54469b72b25f..efa5fcb5793f 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> @@ -223,6 +223,26 @@ void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
>  		svc_rdma_recv_ctxt_destroy(rdma, ctxt);
>  }
>
> +/**
> + * svc_rdma_release_rqst - Release transport-specific per-rqst resources
> + * @rqstp: svc_rqst being released
> + *
> + * Ensure that the recv_ctxt is released whether or not a Reply
> + * was sent. For example, the client could close the connection,
> + * or svc_process could drop an RPC, before the Reply is sent.
> + */
> +void svc_rdma_release_rqst(struct svc_rqst *rqstp)
> +{
> +	struct svc_rdma_recv_ctxt *ctxt = rqstp->rq_xprt_ctxt;
> +	struct svc_xprt *xprt = rqstp->rq_xprt;
> +	struct svcxprt_rdma *rdma =
> +		container_of(xprt, struct svcxprt_rdma, sc_xprt);
> +
> +	rqstp->rq_xprt_ctxt = NULL;
> +	if (ctxt)
> +		svc_rdma_recv_ctxt_put(rdma, ctxt);
> +}
> +
>  static int __svc_rdma_post_recv(struct svcxprt_rdma *rdma,
>  				struct svc_rdma_recv_ctxt *ctxt)
>  {
> @@ -820,6 +840,8 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>  	__be32 *p;
>  	int ret;
>
> +	rqstp->rq_xprt_ctxt = NULL;
> +
>  	spin_lock(&rdma_xprt->sc_rq_dto_lock);
>  	ctxt = svc_rdma_next_recv_ctxt(&rdma_xprt->sc_read_complete_q);
>  	if (ctxt) {
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> index 6a87a2379e91..b6c8643867f2 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> @@ -926,12 +926,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
>  	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
>  	if (ret < 0)
>  		goto err1;
> -	ret = 0;
> -
> -out:
> -	rqstp->rq_xprt_ctxt = NULL;
> -	svc_rdma_recv_ctxt_put(rdma, rctxt);
> -	return ret;
> +	return 0;
>
>   err2:
>  	if (ret != -E2BIG && ret != -EINVAL)
> @@ -940,16 +935,14 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
>  	ret = svc_rdma_send_error_msg(rdma, sctxt, rqstp);
>  	if (ret < 0)
>  		goto err1;
> -	ret = 0;
> -	goto out;
> +	return 0;
>
>   err1:
>  	svc_rdma_send_ctxt_put(rdma, sctxt);
>   err0:
>  	trace_svcrdma_send_failed(rqstp, ret);
>  	set_bit(XPT_CLOSE, &xprt->xpt_flags);
> -	ret = -ENOTCONN;
> -	goto out;
> +	return -ENOTCONN;
>  }
>
>  /**
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 8bb99980ae85..ea54785db4f8 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -71,7 +71,6 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
>  					struct sockaddr *sa, int salen,
>  					int flags);
>  static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt);
> -static void svc_rdma_release_rqst(struct svc_rqst *);
>  static void svc_rdma_detach(struct svc_xprt *xprt);
>  static void svc_rdma_free(struct svc_xprt *xprt);
>  static int svc_rdma_has_wspace(struct svc_xprt *xprt);
> @@ -552,10 +551,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
>  	return NULL;
>  }
>
> -static void svc_rdma_release_rqst(struct svc_rqst *rqstp)
> -{
> -}
> -
>  /*
>   * When connected, an svc_xprt has at least two references:
>   *
>
