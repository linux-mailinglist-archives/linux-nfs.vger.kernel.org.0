Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E9A7277C
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2019 07:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfGXFrp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Jul 2019 01:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfGXFrp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 24 Jul 2019 01:47:45 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9123227BF;
        Wed, 24 Jul 2019 05:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563947264;
        bh=4pUsLkr3sSWA9bQ01QQSVrCjqBcz3gXUD2rLqhLl5gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d81tVcBSuyP9AAaLAWvIxf6hNzgO5lV5QqVwFHsQFoF6L+wi0Kkg3QPLdRcX+0e4d
         EeVuLcfN7wBP6ZzRbgfzT31zIjBSpLzv2EuIyzqFCUGep/A7VK+ujEblm3JjjlEXxM
         AA4dfgcZNJld3TSIoP4UTDzOmAy9KDsWV3U//SVI=
Date:   Wed, 24 Jul 2019 08:47:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1] rdma: Enable ib_alloc_cq to spread work over a
 device's comp_vectors
Message-ID: <20190724054736.GW5125@mtr-leonro.mtl.com>
References: <156390915496.6759.4305845732131573253.stgit@seurat29.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <156390915496.6759.4305845732131573253.stgit@seurat29.1015granger.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 23, 2019 at 03:13:37PM -0400, Chuck Lever wrote:
> Send and Receive completion is handled on a single CPU selected at
> the time each Completion Queue is allocated. Typically this is when
> an initiator instantiates an RDMA transport, or when a target
> accepts an RDMA connection.
>
> Some ULPs cannot open a connection per CPU to spread completion
> workload across available CPUs. For these ULPs, allow the RDMA core
> to select a completion vector based on the device's complement of
> available comp_vecs.
>
> When a ULP elects to use RDMA_CORE_ANY_COMPVEC, if multiple CPUs are
> available, a different CPU will be selected for each Completion
> Queue. For the moment, a simple round-robin mechanism is used.
>
> Suggested-by: Håkon Bugge <haakon.bugge@oracle.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

It make me wonder why do we need comp_vector as an argument to ib_alloc_cq?
From what I see, or callers are internally implementing similar logic
to proposed here, or they don't care (set 0).

Can we enable this comp_vector for everyone and simplify our API?

> ---
>  drivers/infiniband/core/cq.c             |   20 +++++++++++++++++++-
>  include/rdma/ib_verbs.h                  |    3 +++
>  net/sunrpc/xprtrdma/svc_rdma_transport.c |    6 ++++--
>  net/sunrpc/xprtrdma/verbs.c              |    5 ++---
>  4 files changed, 28 insertions(+), 6 deletions(-)
>
> Jason-
>
> If this patch is acceptable to all, then I would expect you to take
> it through the RDMA tree.
>
>
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index 7c599878ccf7..a89d549490c4 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -165,12 +165,27 @@ static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
>  	queue_work(cq->comp_wq, &cq->work);
>  }
>
> +/*
> + * Attempt to spread ULP completion queues over a device's completion
> + * vectors so that all available CPU cores can help service the device's
> + * interrupt workload. This mechanism may be improved at a later point
> + * to dynamically take into account the system's actual workload.
> + */
> +static int ib_get_comp_vector(struct ib_device *dev)
> +{
> +	static atomic_t cv;
> +
> +	if (dev->num_comp_vectors > 1)
> +		return atomic_inc_return(&cv) % dev->num_comp_vectors;

It is worth to take into account num_online_cpus(),

Thanks
