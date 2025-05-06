Return-Path: <linux-nfs+bounces-11484-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7AEAAC55B
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7D71B62740
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC03A28033C;
	Tue,  6 May 2025 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PDWaBo8C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B83F280326;
	Tue,  6 May 2025 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536944; cv=none; b=ZJ2fpNsd6y9EObKfWFDNSe4Are1JhIeLqGkaAyp2yw8GYaDIEoWnSNr6Tnq8ZLw1HfiL3Mr17wEA2CP/CJdbF/EWER7aiOZo6Vr+mKIxnXd7dIMFBu7qvQyKWhgTkK+vPNAgnLN75IgnlA2XpIKBZRJaFxwamBNK7gZjJAzliSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536944; c=relaxed/simple;
	bh=Hwj/xeTq7krBbKNukeyBLfm5RTw9Lzh7tVcC0oFDiZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnMIqb0ujbOAUXrE5lDwHvY/hF1UZTEYP7HMIkEUOzyPsff2byaF47Xj/uKaWrfXMZsZwGuvzAxdm/7IAznbhRomVlOP/s0p9do0EyDDFfFsqJqL5KBRRDkgjgpxQoNjcz2DjyAHTmYziBuqRu5yXWx7B0UNntX8Z/D6Y4N6frM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PDWaBo8C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aNmZTIcbW0aSrz/Kcaj6TpwaMA5Ej10o71tVW3QwAv4=; b=PDWaBo8Cs16Duyyuw4N8AqEuC/
	JGh9Dp0rtM+AQHCfrf1fxNFFfKJ8Iibi4r8jmuplW4SK7owOs/y0Rz/NTMO6zw1Ei+RjND44v8ZKh
	7IvZVYbC+6U4tDWawafxaavTptkQ9ANSJV+Ew87olumb1qu9VlsRKg4HsdPPhzJjjKFXQjd6MHPd7
	tYADwNC8cba7wada3y3gfnVsxR2d8PR5D0MmMBVdt/cTWjw4RpvVh8jwc8ghOgOEv4XWjJaUyN09m
	O8Q+mD/BeJU9OxdGXZqkRLWuiJ8ltzshOw275VZ1oVEW8vkwMatGBuN4CmwUEntyNSA19Dwj/Wc9a
	GVvdyeLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCI2d-0000000C2D2-3DUY;
	Tue, 06 May 2025 13:08:59 +0000
Date: Tue, 6 May 2025 06:08:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: cel@kernel.org
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v4 01/14] svcrdma: Reduce the number of rdma_rw contexts
 per-QP
Message-ID: <aBoJ64qDSp7U3twh@infradead.org>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428193702.5186-2-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 28, 2025 at 03:36:49PM -0400, cel@kernel.org wrote:
> qp_attr.cap.max_rdma_ctxs. The QP's actual Send Queue length is on
> the order of the sum of qp_attr.cap.max_send_wr and a factor times
> qp_attr.cap.max_rdma_ctxs. The factor can be up to three, depending
> on whether MR operations are required before RDMA Reads.
> 
> This limit is not visible to RDMA consumers via dev->attrs. When the
> limit is surpassed, QP creation fails with -ENOMEM. For example:

Can we find a way to expose this limit from the HCA drivers and the
RDMA core?

Having to guess it in ULP feels rather cumbersome.

In the meantime this patch looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> 
> svcrdma's estimate of the number of rdma_rw contexts it needs is
> three times the number of pages in RPCSVC_MAXPAGES. When MAXPAGES
> is about 260, the internally-computed SQ length should be:
> 
> 64 credits + 10 backlog + 3 * (3 * 260) = 2414
> 
> Which is well below the advertised qp_max_wr of 32768.
> 
> If RPCSVC_MAXPAGES is increased to 4MB, that's 1040 pages:
> 
> 64 credits + 10 backlog + 3 * (3 * 1040) = 9434
> 
> However, QP creation fails. Dynamic printk for mlx5 shows:
> 
> calc_sq_size:618:(pid 1514): send queue size (9326 * 256 / 64 -> 65536) exceeds limits(32768)
> 
> Although 9326 is still far below qp_max_wr, QP creation still
> fails.
> 
> Because the total SQ length calculation is opaque to RDMA consumers,
> there doesn't seem to be much that can be done about this except for
> consumers to try to keep the requested rdma_rw ctxt count low.
> 
> Fixes: 2da0f610e733 ("svcrdma: Increase the per-transport rw_ctx count")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 5940a56023d1..3d7f1413df02 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -406,12 +406,12 @@ static void svc_rdma_xprt_done(struct rpcrdma_notification *rn)
>   */
>  static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
>  {
> +	unsigned int ctxts, rq_depth, maxpayload;
>  	struct svcxprt_rdma *listen_rdma;
>  	struct svcxprt_rdma *newxprt = NULL;
>  	struct rdma_conn_param conn_param;
>  	struct rpcrdma_connect_private pmsg;
>  	struct ib_qp_init_attr qp_attr;
> -	unsigned int ctxts, rq_depth;
>  	struct ib_device *dev;
>  	int ret = 0;
>  	RPC_IFDEBUG(struct sockaddr *sap);
> @@ -462,12 +462,14 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
>  		newxprt->sc_max_bc_requests = 2;
>  	}
>  
> -	/* Arbitrarily estimate the number of rw_ctxs needed for
> -	 * this transport. This is enough rw_ctxs to make forward
> -	 * progress even if the client is using one rkey per page
> -	 * in each Read chunk.
> +	/* Arbitrary estimate of the needed number of rdma_rw contexts.
>  	 */
> -	ctxts = 3 * RPCSVC_MAXPAGES;
> +	maxpayload = min(xprt->xpt_server->sv_max_payload,
> +			 RPCSVC_MAXPAYLOAD_RDMA);
> +	ctxts = newxprt->sc_max_requests * 3 *
> +		rdma_rw_mr_factor(dev, newxprt->sc_port_num,
> +				  maxpayload >> PAGE_SHIFT);
> +
>  	newxprt->sc_sq_depth = rq_depth + ctxts;
>  	if (newxprt->sc_sq_depth > dev->attrs.max_qp_wr)
>  		newxprt->sc_sq_depth = dev->attrs.max_qp_wr;
> -- 
> 2.49.0
> 
> 
---end quoted text---

