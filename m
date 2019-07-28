Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFB577FF7
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2019 17:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfG1PFa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Jul 2019 11:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfG1PFa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 28 Jul 2019 11:05:30 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 381942077C;
        Sun, 28 Jul 2019 15:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564326329;
        bh=PX3PZFGRpr8V8vSLOd/unWFANFyFrclDhmFeAEPCXp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EqQ94mND/8ycs5nMMX5yt70he4nWFRAHHfEi34eqQLEaYiB75GzyZYLFqmwVRS0yc
         J+DaLlBZOKg0UE7wUGOpE6K26y+HRvtlpAKoliKZVZEBPkV8fYpq+jjImsI+oIEZxF
         ThnwQxpkjDnJEKqehUO1JLUqrksIT9yO9pzNgY9s=
Date:   Sun, 28 Jul 2019 18:05:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] rdma: Enable ib_alloc_cq to spread work over a
 device's comp_vectors
Message-ID: <20190728150523.GI4674@mtr-leonro.mtl.com>
References: <156390915496.6759.4305845732131573253.stgit@seurat29.1015granger.net>
 <20190724054736.GW5125@mtr-leonro.mtl.com>
 <8AC10EC7-5203-4D82-A455-2589DA6ADB9D@oracle.com>
 <20190725131715.GF4674@mtr-leonro.mtl.com>
 <9A698820-DE08-44F2-BA30-F62FDD035D22@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9A698820-DE08-44F2-BA30-F62FDD035D22@oracle.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 25, 2019 at 10:03:13AM -0400, Chuck Lever wrote:
>
>
> > On Jul 25, 2019, at 9:17 AM, Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Jul 24, 2019 at 10:01:36AM -0400, Chuck Lever wrote:
> >> Hi Leon, thanks for taking a look. Responses below.
> >>
> >>
> >>> On Jul 24, 2019, at 1:47 AM, Leon Romanovsky <leon@kernel.org> wrote:
> >>>
> >>> On Tue, Jul 23, 2019 at 03:13:37PM -0400, Chuck Lever wrote:
> >>>> Send and Receive completion is handled on a single CPU selected at
> >>>> the time each Completion Queue is allocated. Typically this is when
> >>>> an initiator instantiates an RDMA transport, or when a target
> >>>> accepts an RDMA connection.
> >>>>
> >>>> Some ULPs cannot open a connection per CPU to spread completion
> >>>> workload across available CPUs. For these ULPs, allow the RDMA core
> >>>> to select a completion vector based on the device's complement of
> >>>> available comp_vecs.
> >>>>
> >>>> When a ULP elects to use RDMA_CORE_ANY_COMPVEC, if multiple CPUs are
> >>>> available, a different CPU will be selected for each Completion
> >>>> Queue. For the moment, a simple round-robin mechanism is used.
> >>>>
> >>>> Suggested-by: Håkon Bugge <haakon.bugge@oracle.com>
> >>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >>>
> >>> It make me wonder why do we need comp_vector as an argument to ib_alloc_cq?
> >>> From what I see, or callers are internally implementing similar logic
> >>> to proposed here, or they don't care (set 0).
> >>
> >> The goal of this patch is to deduplicate that "similar logic".
> >> Callers that implement this logic already can use
> >> RDMA_CORE_ANY_COMPVEC and get rid of their own copy.
> >
> > Can you please send removal patches together with this API proposal?
> > It will ensure that ULPs authors will notice such changes and we won't
> > end with special function for one ULP.
>
> I prefer that the maintainers of those ULPs make those changes.
> It would require testing that I am not in a position to do myself.
>
> I can add a couple of other ULPs, like cifs and 9p, which look
> like straightforward modifications; but my understanding was that
> only one user of a new API was required for adoption.
>
>
> >>> Can we enable this comp_vector for everyone and simplify our API?
> >>
> >> We could create a new CQ allocation API that does not take a
> >> comp vector. That might be cleaner than passing in a -1.
> >
> > +1
>
> I'll send a v2 with this suggestion.
>
>
> >> But I think some ULPs still want to use the existing API to
> >> allocate one CQ for each of a device's comp vectors.
> >
> > It can be "legacy implementation", which is not really needed,
> > but I don't really know about it.
>
> Have a look at the iSER initiator. There are legitimate use cases
> in the kernel for the current ib_alloc_cq() API.
>
> And don't forget the many users of ib_create_cq that remain in
> the kernel.
>
>
> >>>> ---
> >>>> drivers/infiniband/core/cq.c             |   20 +++++++++++++++++++-
> >>>> include/rdma/ib_verbs.h                  |    3 +++
> >>>> net/sunrpc/xprtrdma/svc_rdma_transport.c |    6 ++++--
> >>>> net/sunrpc/xprtrdma/verbs.c              |    5 ++---
> >>>> 4 files changed, 28 insertions(+), 6 deletions(-)
> >>>>
> >>>> Jason-
> >>>>
> >>>> If this patch is acceptable to all, then I would expect you to take
> >>>> it through the RDMA tree.
> >>>>
> >>>>
> >>>> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> >>>> index 7c599878ccf7..a89d549490c4 100644
> >>>> --- a/drivers/infiniband/core/cq.c
> >>>> +++ b/drivers/infiniband/core/cq.c
> >>>> @@ -165,12 +165,27 @@ static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
> >>>> 	queue_work(cq->comp_wq, &cq->work);
> >>>> }
> >>>>
> >>>> +/*
> >>>> + * Attempt to spread ULP completion queues over a device's completion
> >>>> + * vectors so that all available CPU cores can help service the device's
> >>>> + * interrupt workload. This mechanism may be improved at a later point
> >>>> + * to dynamically take into account the system's actual workload.
> >>>> + */
> >>>> +static int ib_get_comp_vector(struct ib_device *dev)
> >>>> +{
> >>>> +	static atomic_t cv;
> >>>> +
> >>>> +	if (dev->num_comp_vectors > 1)
> >>>> +		return atomic_inc_return(&cv) % dev->num_comp_vectors;
> >>>
> >>> It is worth to take into account num_online_cpus(),
> >>
> >> I don't believe it is.
> >>
> >> Håkon has convinced me that assigning interrupt vectors to
> >> CPUs is in the domain of user space (ie, driven by policy).
> >> In addition, one assumes that taking a CPU offline properly
> >> will also involve re-assigning interrupt vectors that point
> >> to that core.
> >>
> >> In any event, this code can be modified after it is merged
> >> if it is necessary to accommodate such requirements.
> >
> > It is a simple change, which is worth to do now as long as
> > we have interested parties involved here.
>
> Can you propose some code, or point out an example of how you
> would prefer it to work?
>

I had in mind drivers/infiniband/ulp/iser/iser_verbs.c

 77         device->comps_used = min_t(int, num_online_cpus(),
 78                                  ib_dev->num_comp_vectors);

>
> --
> Chuck Lever
>
>
>
