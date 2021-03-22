Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3CA344D0F
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Mar 2021 18:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhCVRQZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 13:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhCVRQP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 13:16:15 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21727C061574;
        Mon, 22 Mar 2021 10:16:15 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 87B9323D8; Mon, 22 Mar 2021 13:16:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 87B9323D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1616433374;
        bh=IUtcA93D5ZgqT7m1tC3FtnqKwTFZQ/8ibZcHlIvFvvU=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=pLS2ClkBNMawxDuZeTvopf9xCytEeWH4SGAvG2p4mBtQZ5BAYodqw7KElEbQrO2+6
         UblsXbU6ewKb9tn6K67LLKY8iNN9noiNRTOPQzQ4s1PE4kbxukxGO18udACh6k8dsy
         xJnnSthjA8B4rU5Rm3XgPTfvKRJSM9uYe2+Yyxxc=
Date:   Mon, 22 Mar 2021 13:16:14 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 4/6] svcrdma: Add a batch Receive posting mechanism
Message-ID: <20210322171614.GB24580@fieldses.org>
References: <161616413550.173092.13403865110684484953.stgit@klimt.1015granger.net>
 <161616429593.173092.14052996014785354959.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161616429593.173092.14052996014785354959.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 19, 2021 at 10:31:35AM -0400, Chuck Lever wrote:
> Introduce a server-side mechanism similar to commit e340c2d6ef2a
> ("xprtrdma: Reduce the doorbell rate (Receive)") to post Receive
> WRs in batch. It's first consumer is svc_rdma_post_recvs().

s/It's/Its'/.

Patches look OK to me.--b.

> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   56 +++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> index 04148a656b2a..0c6aa8693f20 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> @@ -264,6 +264,47 @@ void svc_rdma_release_rqst(struct svc_rqst *rqstp)
>  		svc_rdma_recv_ctxt_put(rdma, ctxt);
>  }
>  
> +static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
> +				   unsigned int wanted, bool temp)
> +{
> +	const struct ib_recv_wr *bad_wr = NULL;
> +	struct svc_rdma_recv_ctxt *ctxt;
> +	struct ib_recv_wr *recv_chain;
> +	int ret;
> +
> +	if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
> +		return false;
> +
> +	recv_chain = NULL;
> +	while (wanted--) {
> +		ctxt = svc_rdma_recv_ctxt_get(rdma);
> +		if (!ctxt)
> +			break;
> +
> +		trace_svcrdma_post_recv(ctxt);
> +		ctxt->rc_temp = temp;
> +		ctxt->rc_recv_wr.next = recv_chain;
> +		recv_chain = &ctxt->rc_recv_wr;
> +	}
> +	if (!recv_chain)
> +		return false;
> +
> +	ret = ib_post_recv(rdma->sc_qp, recv_chain, &bad_wr);
> +	if (ret)
> +		goto err_free;
> +	return true;
> +
> +err_free:
> +	trace_svcrdma_rq_post_err(rdma, ret);
> +	while (bad_wr) {
> +		ctxt = container_of(bad_wr, struct svc_rdma_recv_ctxt,
> +				    rc_recv_wr);
> +		bad_wr = bad_wr->next;
> +		svc_rdma_recv_ctxt_put(rdma, ctxt);
> +	}
> +	return false;
> +}
> +
>  static int __svc_rdma_post_recv(struct svcxprt_rdma *rdma,
>  				struct svc_rdma_recv_ctxt *ctxt)
>  {
> @@ -301,20 +342,7 @@ static int svc_rdma_post_recv(struct svcxprt_rdma *rdma)
>   */
>  bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
>  {
> -	struct svc_rdma_recv_ctxt *ctxt;
> -	unsigned int i;
> -	int ret;
> -
> -	for (i = 0; i < rdma->sc_max_requests; i++) {
> -		ctxt = svc_rdma_recv_ctxt_get(rdma);
> -		if (!ctxt)
> -			return false;
> -		ctxt->rc_temp = true;
> -		ret = __svc_rdma_post_recv(rdma, ctxt);
> -		if (ret)
> -			return false;
> -	}
> -	return true;
> +	return svc_rdma_refresh_recvs(rdma, rdma->sc_max_requests, true);
>  }
>  
>  /**
> 
