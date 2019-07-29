Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD02D791D3
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2019 19:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfG2RMF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jul 2019 13:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfG2RMF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Jul 2019 13:12:05 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6298206BA;
        Mon, 29 Jul 2019 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564420324;
        bh=ekpbK+Fura14peaaAT1tvUqSV0rNrJNhzNho9n7q3HU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDzMTv/qYk+oX2kbDjbHqDGE85LjRNjlpYthX4C1cUgUs/KBG9SYIiY32rpBxiGhJ
         ulsE2qNtpvKFs5AdR9+iMykQJkdXElw11tcCNhCMIsqJFrRvSj49bdowErsaWdC/71
         p1JizJ+p+dkB9jCUZLzKesbiFTp0sRiueNDV+NT4=
Date:   Mon, 29 Jul 2019 20:12:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-cifs@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v2] rdma: Enable ib_alloc_cq to spread work over a
 device's comp_vectors
Message-ID: <20190729171201.GO4674@mtr-leonro.mtl.com>
References: <20190728163027.3637.70740.stgit@manet.1015granger.net>
 <20190729054933.GK4674@mtr-leonro.mtl.com>
 <9AF784D9-E0B4-473F-9D5F-7858F6FE1FDD@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9AF784D9-E0B4-473F-9D5F-7858F6FE1FDD@oracle.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 29, 2019 at 10:24:12AM -0400, Chuck Lever wrote:
>
>
> > On Jul 29, 2019, at 1:49 AM, Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Sun, Jul 28, 2019 at 12:30:27PM -0400, Chuck Lever wrote:
> >> Send and Receive completion is handled on a single CPU selected at
> >> the time each Completion Queue is allocated. Typically this is when
> >> an initiator instantiates an RDMA transport, or when a target
> >> accepts an RDMA connection.
> >>
> >> Some ULPs cannot open a connection per CPU to spread completion
> >> workload across available CPUs and MSI vectors. For such ULPs,
> >> provide an API that allows the RDMA core to select a completion
> >> vector based on the device's complement of available comp_vecs.
> >>
> >> ULPs that invoke ib_alloc_cq() with only comp_vector 0 are converted
> >> to use the new API so that their completion workloads interfere less
> >> with each other.
> >>
> >> Suggested-by: Håkon Bugge <haakon.bugge@oracle.com>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> Cc: <linux-cifs@vger.kernel.org>
> >> Cc: <v9fs-developer@lists.sourceforge.net>
> >> ---
> >> drivers/infiniband/core/cq.c             |   29 +++++++++++++++++++++++++++++
> >> drivers/infiniband/ulp/srpt/ib_srpt.c    |    4 ++--
> >> fs/cifs/smbdirect.c                      |   10 ++++++----
> >> include/rdma/ib_verbs.h                  |   19 +++++++++++++++++++
> >> net/9p/trans_rdma.c                      |    6 +++---
> >> net/sunrpc/xprtrdma/svc_rdma_transport.c |    8 ++++----
> >> net/sunrpc/xprtrdma/verbs.c              |   13 ++++++-------
> >> 7 files changed, 69 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> >> index 7c59987..ea3bb0d 100644
> >> --- a/drivers/infiniband/core/cq.c
> >> +++ b/drivers/infiniband/core/cq.c
> >> @@ -253,6 +253,35 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
> >> EXPORT_SYMBOL(__ib_alloc_cq_user);
> >>
> >> /**
> >> + * __ib_alloc_cq_any - allocate a completion queue
> >> + * @dev:		device to allocate the CQ for
> >> + * @private:		driver private data, accessible from cq->cq_context
> >> + * @nr_cqe:		number of CQEs to allocate
> >> + * @poll_ctx:		context to poll the CQ from.
> >> + * @caller:		module owner name.
> >> + *
> >> + * Attempt to spread ULP Completion Queues over each device's interrupt
> >> + * vectors.
> >> + */
> >> +struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void *private,
> >> +				int nr_cqe, enum ib_poll_context poll_ctx,
> >> +				const char *caller)
> >> +{
> >> +	static atomic_t counter;
> >> +	int comp_vector;
> >
> > int comp_vector = 0;
> >
> >> +
> >> +	comp_vector = 0;
> >
> > This assignment is better to be part of initialization.
> >
> >> +	if (dev->num_comp_vectors > 1)
> >> +		comp_vector =
> >> +			atomic_inc_return(&counter) %
> >
> > Don't we need manage "free list" of comp_vectors? Otherwise we can find
> > ourselves providing already "taken" comp_vector.
>
> Many ULPs use only comp_vector 0 today. It is obviously harmless
> to have more than one ULP using the same comp_vector.
>
> The point of this patch is best effort spreading. This algorithm
> has been proposed repeatedly for several years on this list, and
> each time the consensus has been this is simple and good enough.

Agree, it is better than current implementation.

Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

Thanks
