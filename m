Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7A97848F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2019 07:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfG2Ftk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jul 2019 01:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfG2Ftk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Jul 2019 01:49:40 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EF3D2073F;
        Mon, 29 Jul 2019 05:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564379378;
        bh=5FSf7zYaAcj4Rbx53EQ++OMWByWA3rHKkdAgYw393Jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FEhpg/VSfTXeZELoy7HVC7r+CT8/Qdny5rMk6KgKGYq7P4klXznvOTIuQUAYxPTod
         v9jgsogtOSTODkXX5MriGp0dNXPYGbH5gfMRD5UYSvHOh9v7cBLt/FRhA8K9hRvDYA
         /kA0KMR1UOPjbMFjzEv3MMTvFwIl5Z+ndNnB0vDE=
Date:   Mon, 29 Jul 2019 08:49:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v2] rdma: Enable ib_alloc_cq to spread work over a
 device's comp_vectors
Message-ID: <20190729054933.GK4674@mtr-leonro.mtl.com>
References: <20190728163027.3637.70740.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190728163027.3637.70740.stgit@manet.1015granger.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jul 28, 2019 at 12:30:27PM -0400, Chuck Lever wrote:
> Send and Receive completion is handled on a single CPU selected at
> the time each Completion Queue is allocated. Typically this is when
> an initiator instantiates an RDMA transport, or when a target
> accepts an RDMA connection.
>
> Some ULPs cannot open a connection per CPU to spread completion
> workload across available CPUs and MSI vectors. For such ULPs,
> provide an API that allows the RDMA core to select a completion
> vector based on the device's complement of available comp_vecs.
>
> ULPs that invoke ib_alloc_cq() with only comp_vector 0 are converted
> to use the new API so that their completion workloads interfere less
> with each other.
>
> Suggested-by: Håkon Bugge <haakon.bugge@oracle.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Cc: <linux-cifs@vger.kernel.org>
> Cc: <v9fs-developer@lists.sourceforge.net>
> ---
>  drivers/infiniband/core/cq.c             |   29 +++++++++++++++++++++++++++++
>  drivers/infiniband/ulp/srpt/ib_srpt.c    |    4 ++--
>  fs/cifs/smbdirect.c                      |   10 ++++++----
>  include/rdma/ib_verbs.h                  |   19 +++++++++++++++++++
>  net/9p/trans_rdma.c                      |    6 +++---
>  net/sunrpc/xprtrdma/svc_rdma_transport.c |    8 ++++----
>  net/sunrpc/xprtrdma/verbs.c              |   13 ++++++-------
>  7 files changed, 69 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index 7c59987..ea3bb0d 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -253,6 +253,35 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
>  EXPORT_SYMBOL(__ib_alloc_cq_user);
>
>  /**
> + * __ib_alloc_cq_any - allocate a completion queue
> + * @dev:		device to allocate the CQ for
> + * @private:		driver private data, accessible from cq->cq_context
> + * @nr_cqe:		number of CQEs to allocate
> + * @poll_ctx:		context to poll the CQ from.
> + * @caller:		module owner name.
> + *
> + * Attempt to spread ULP Completion Queues over each device's interrupt
> + * vectors.
> + */
> +struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void *private,
> +				int nr_cqe, enum ib_poll_context poll_ctx,
> +				const char *caller)
> +{
> +	static atomic_t counter;
> +	int comp_vector;

int comp_vector = 0;

> +
> +	comp_vector = 0;

This assignment is better to be part of initialization.

> +	if (dev->num_comp_vectors > 1)
> +		comp_vector =
> +			atomic_inc_return(&counter) %

Don't we need manage "free list" of comp_vectors? Otherwise we can find
ourselves providing already "taken" comp_vector.

Just as an example:
dev->num_comp_vectors = 2
num_online_cpus = 4

The following combination will give us same comp_vector:
1. ib_alloc_cq_any()
2. ib_alloc_cq_any()
3. ib_free_cq()
4. goto 2

> +			min_t(int, dev->num_comp_vectors, num_online_cpus());
> +
> +	return __ib_alloc_cq_user(dev, private, nr_cqe, comp_vector, poll_ctx,
> +				  caller, NULL);
> +}
> +EXPORT_SYMBOL(__ib_alloc_cq_any);
> +
> +/**
>   * ib_free_cq_user - free a completion queue
>   * @cq:		completion queue to free.
>   * @udata:	User data or NULL for kernel object
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 1a039f1..e25c70a 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -1767,8 +1767,8 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
>  		goto out;
>
>  retry:
> -	ch->cq = ib_alloc_cq(sdev->device, ch, ch->rq_size + sq_size,
> -			0 /* XXX: spread CQs */, IB_POLL_WORKQUEUE);
> +	ch->cq = ib_alloc_cq_any(sdev->device, ch, ch->rq_size + sq_size,
> +				 IB_POLL_WORKQUEUE);
>  	if (IS_ERR(ch->cq)) {
>  		ret = PTR_ERR(ch->cq);
>  		pr_err("failed to create CQ cqe= %d ret= %d\n",
> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
> index cd07e53..3c91fa9 100644
> --- a/fs/cifs/smbdirect.c
> +++ b/fs/cifs/smbdirect.c
> @@ -1654,15 +1654,17 @@ static struct smbd_connection *_smbd_get_connection(
>
>  	info->send_cq = NULL;
>  	info->recv_cq = NULL;
> -	info->send_cq = ib_alloc_cq(info->id->device, info,
> -			info->send_credit_target, 0, IB_POLL_SOFTIRQ);
> +	info->send_cq =
> +		ib_alloc_cq_any(info->id->device, info,
> +				info->send_credit_target, IB_POLL_SOFTIRQ);
>  	if (IS_ERR(info->send_cq)) {
>  		info->send_cq = NULL;
>  		goto alloc_cq_failed;
>  	}
>
> -	info->recv_cq = ib_alloc_cq(info->id->device, info,
> -			info->receive_credit_max, 0, IB_POLL_SOFTIRQ);
> +	info->recv_cq =
> +		ib_alloc_cq_any(info->id->device, info,
> +				info->receive_credit_max, IB_POLL_SOFTIRQ);
>  	if (IS_ERR(info->recv_cq)) {
>  		info->recv_cq = NULL;
>  		goto alloc_cq_failed;
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index c5f8a9f..2a1523cc 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -3711,6 +3711,25 @@ static inline struct ib_cq *ib_alloc_cq(struct ib_device *dev, void *private,
>  				NULL);
>  }
>
> +struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void *private,
> +				int nr_cqe, enum ib_poll_context poll_ctx,
> +				const char *caller);
> +
> +/**
> + * ib_alloc_cq_any: Allocate kernel CQ
> + * @dev: The IB device
> + * @private: Private data attached to the CQE
> + * @nr_cqe: Number of CQEs in the CQ
> + * @poll_ctx: Context used for polling the CQ
> + */
> +static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
> +					    void *private, int nr_cqe,
> +					    enum ib_poll_context poll_ctx)
> +{
> +	return __ib_alloc_cq_any(dev, private, nr_cqe, poll_ctx,
> +				 KBUILD_MODNAME);
> +}

This should be macro and not inline function, because compiler can be
instructed do not inline functions (there is kconfig option for that)
and it will cause that wrong KBUILD_MODNAME will be inserted (ib_core
instead of ulp).

And yes, commit c4367a26357b ("IB: Pass uverbs_attr_bundle down ib_x
destroy path") did it completely wrong.

> +
>  /**
>   * ib_free_cq_user - Free kernel/user CQ
>   * @cq: The CQ to free
> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> index bac8dad..b21c3c2 100644
> --- a/net/9p/trans_rdma.c
> +++ b/net/9p/trans_rdma.c
> @@ -685,9 +685,9 @@ static int p9_rdma_bind_privport(struct p9_trans_rdma *rdma)
>  		goto error;
>
>  	/* Create the Completion Queue */
> -	rdma->cq = ib_alloc_cq(rdma->cm_id->device, client,
> -			opts.sq_depth + opts.rq_depth + 1,
> -			0, IB_POLL_SOFTIRQ);
> +	rdma->cq = ib_alloc_cq_any(rdma->cm_id->device, client,
> +				   opts.sq_depth + opts.rq_depth + 1,
> +				   IB_POLL_SOFTIRQ);
>  	if (IS_ERR(rdma->cq))
>  		goto error;
>
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 3fe6651..4d3db6e 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -454,14 +454,14 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
>  		dprintk("svcrdma: error creating PD for connect request\n");
>  		goto errout;
>  	}
> -	newxprt->sc_sq_cq = ib_alloc_cq(dev, newxprt, newxprt->sc_sq_depth,
> -					0, IB_POLL_WORKQUEUE);
> +	newxprt->sc_sq_cq = ib_alloc_cq_any(dev, newxprt, newxprt->sc_sq_depth,
> +					    IB_POLL_WORKQUEUE);
>  	if (IS_ERR(newxprt->sc_sq_cq)) {
>  		dprintk("svcrdma: error creating SQ CQ for connect request\n");
>  		goto errout;
>  	}
> -	newxprt->sc_rq_cq = ib_alloc_cq(dev, newxprt, rq_depth,
> -					0, IB_POLL_WORKQUEUE);
> +	newxprt->sc_rq_cq =
> +		ib_alloc_cq_any(dev, newxprt, rq_depth, IB_POLL_WORKQUEUE);
>  	if (IS_ERR(newxprt->sc_rq_cq)) {
>  		dprintk("svcrdma: error creating RQ CQ for connect request\n");
>  		goto errout;
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 805b1f35..b10aa16 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -521,18 +521,17 @@ int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
>  	init_waitqueue_head(&ep->rep_connect_wait);
>  	ep->rep_receive_count = 0;
>
> -	sendcq = ib_alloc_cq(ia->ri_id->device, NULL,
> -			     ep->rep_attr.cap.max_send_wr + 1,
> -			     ia->ri_id->device->num_comp_vectors > 1 ? 1 : 0,
> -			     IB_POLL_WORKQUEUE);
> +	sendcq = ib_alloc_cq_any(ia->ri_id->device, NULL,
> +				 ep->rep_attr.cap.max_send_wr + 1,
> +				 IB_POLL_WORKQUEUE);
>  	if (IS_ERR(sendcq)) {
>  		rc = PTR_ERR(sendcq);
>  		goto out1;
>  	}
>
> -	recvcq = ib_alloc_cq(ia->ri_id->device, NULL,
> -			     ep->rep_attr.cap.max_recv_wr + 1,
> -			     0, IB_POLL_WORKQUEUE);
> +	recvcq = ib_alloc_cq_any(ia->ri_id->device, NULL,
> +				 ep->rep_attr.cap.max_recv_wr + 1,
> +				 IB_POLL_WORKQUEUE);
>  	if (IS_ERR(recvcq)) {
>  		rc = PTR_ERR(recvcq);
>  		goto out2;
>
