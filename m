Return-Path: <linux-nfs+bounces-22399-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1kXMD/YzKGpXAAMAu9opvQ
	(envelope-from <linux-nfs+bounces-22399-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 17:40:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89924661E1F
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 17:40:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=H0G+XJ5b;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22399-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22399-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E1CF30C4252
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291E6367B64;
	Tue,  9 Jun 2026 15:24:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1269635E1D7;
	Tue,  9 Jun 2026 15:24:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018695; cv=none; b=A2NHcR5ClKzOAjBGne7x5Jmtvbee/YjYXvO8ZzSG377od+0kgksI/3hJjz6FGmiNg/NjmLw+eWUFIT68k6gEePbTghIcCLs6ZayKiqW8tUhP9PcaURiGyqR+1MwWzvT6jR8CIJTVYoh3O5T8DQrc+S3FTAS/yqNuVRufbuur2QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018695; c=relaxed/simple;
	bh=HBoPFGOXGybi9zPjNvhBs4GVWkRnbZRL7P47phF5uJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hin+eoFCcgAQShKajG0m11q4PTGYpm/hB2rIShaWLOubXuigRe3kMtKA+YsyMnlJ1L/8maJ99hE2Xu6dIg9yUdjV5klIRfXYetq9Cm0cPs22CvVq6xKSyBRczZAq5Tsy1g3mJ5L2a9XgBAytGmRrw2W/x+myhC4RQAtMgs6XY8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0G+XJ5b; arc=none smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781018693; x=1812554693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HBoPFGOXGybi9zPjNvhBs4GVWkRnbZRL7P47phF5uJE=;
  b=H0G+XJ5bIYimtJQcJLuS3eLXT1WH3dQ8er+6Apt7BaefoAV44r46WzWE
   8N3WXL8F6zQ5yWOJrnS9blKfAE7c1xg8eKxeVp3moDZ45w4EJfcNx29yQ
   mdn4Knlgii/qCTJVR8TGlWId9WTxhQMpIWsvLF7j5lyITJeAydfkHGBWu
   dFqbwQo63yd8hDnQlf/BO5z0ywFwwmBI4LL9YOntjNofRwN0oEfKzU7AA
   WOqBYq2Ghyh7ReCyVaAybPZVJXGifSJiy0nmXe5wimG798BKZdH1cbX3P
   yPY3comgXso9fzJZ9y27aysjXvQVKOGZTNUYQlZvqauxLIe9MPEJ64PXT
   A==;
X-CSE-ConnectionGUID: UI4WHEsZQ6aSIwE11oMzHg==
X-CSE-MsgGUID: Fzj+RrxzSwiu9YKVcopZrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="84352283"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="84352283"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 08:24:51 -0700
X-CSE-ConnectionGUID: SIFLfa6ORfeM1YV6G9lz1g==
X-CSE-MsgGUID: 6n6rabJGS8qCw/q/3/ezcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="247759332"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 08:24:42 -0700
Date: Tue, 9 Jun 2026 18:24:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: mkalderon@marvell.com, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
	sagi@grimberg.me, mgurtovoy@nvidia.com, haris.iqbal@ionos.com,
	jinpu.wang@ionos.com, bvanassche@acm.org, kbusch@kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	kch@nvidia.com, smfrench@gmail.com, linkinjeon@kernel.org,
	metze@samba.org, tom@talpey.com, trondmy@kernel.org,
	anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
	achender@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	kees@kernel.org, ebadger@purestorage.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	target-devel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v7] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <aigwONAwxQx6rLef@ashevche-desk.local>
References: <20260606070735.2163063-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606070735.2163063-1-ernis@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22399-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[43];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ernis@linux.microsoft.com,m:mkalderon@marvell.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:zyjzyj2000@gmail.com,m:sagi@grimberg.me,m:mgurtovoy@nvidia.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:bvanassche@acm.org,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:kch@nvidia.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:metze@samba.org,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:ebadger@purestorage.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:rds-devel@oss.oracle.com,m:jgg@nvidia.com,s:lists@lf
 dr.de];
	FREEMAIL_CC(0.00)[marvell.com,ziepe.ca,kernel.org,gmail.com,grimberg.me,nvidia.com,ionos.com,acm.org,kernel.dk,lst.de,samba.org,talpey.com,oracle.com,brown.name,redhat.com,davemloft.net,google.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ashevche-desk.local:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89924661E1F

On Sat, Jun 06, 2026 at 12:07:15AM -0700, Erni Sri Satya Vennela wrote:
> The capability counter fields in struct ib_device_attr are declared
> as signed int, but these values are inherently non-negative. Drivers
> maintain their cached caps as u32 and assign them directly into these
> int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
> negative value visible to the IB core.
> 
> Change the signed int capability fields to u32 to match the
> underlying nature of the data. Also update consumers across the IB
> core, ULPs, NVMe-oF target, RDS, and NFS/RDMA so the new u32 values
> are not forced back through signed int or u8 via min()/min_t() or
> narrowing local variables.

...

>  	attr->max_qp_init_rd_atom =
>  	    1 << (fls(qattr->max_qp_req_rd_atomic_resc) - 1);

FWIW, this one and below looks like reinvention of rounddown_pow_of_two().

>  	attr->max_qp_rd_atom =
> -	    min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
> +	    min(1U << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
>  		attr->max_qp_init_rd_atom);

...

>  int ipoib_cm_dev_init(struct net_device *dev)
>  {
>  	struct ipoib_dev_priv *priv = ipoib_priv(dev);
> -	int max_srq_sge, i;
> +	int i;
> +	u32 max_srq_sge;
>  	u8 addr;

It seems the order is reversed xmas tree, why not preserving it?

...

> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c

>  		max_send_wr =
> -			min_t(int, wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
> +			min(wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);

Now perfectly a single line

		max_send_wr = min(wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);

>  		max_recv_wr = max_send_wr;

...

> -		max_send_wr = min_t(int, wr_limit,
> -			      /* QD * (REQ + RSP + FR REGS or INVS) + drain */
> -			      clt_path->queue_depth * 4 + 1);
> -		max_recv_wr = min_t(int, wr_limit,
> -			      clt_path->queue_depth * 3 + 1);
> +		max_send_wr = min_t(u32, wr_limit,
> +				    /* QD * (REQ + RSP + FR REGS or INVS) + drain */
> +				    clt_path->queue_depth * 4 + 1);
> +		max_recv_wr = min_t(u32, wr_limit,
> +				    clt_path->queue_depth * 3 + 1);

Can we rather update the type of one of them and use min() instead?

...

> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c

Ditto.

...

> -static int srpt_srq_size = DEFAULT_SRPT_SRQ_SIZE;
> -module_param(srpt_srq_size, int, 0444);
> +static unsigned int srpt_srq_size = DEFAULT_SRPT_SRQ_SIZE;
> +module_param(srpt_srq_size, uint, 0444);

Theoretically this might break ABI (if somebody uses negative values for
anything. I don't think it's the case, but just be informed.

>  MODULE_PARM_DESC(srpt_srq_size,
>  		 "Shared receive queue (SRQ) size.");

...

> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c

> -	ndev->srq_size = min(ndev->device->attrs.max_srq_wr,
> -			     nvmet_rdma_srq_size);
> -	ndev->srq_count = min(ndev->device->num_comp_vectors,
> -			      ndev->device->attrs.max_srq);
> +	ndev->srq_size = min_t(u32, ndev->device->attrs.max_srq_wr,
> +			       nvmet_rdma_srq_size);
> +	ndev->srq_count = min_t(u32, ndev->device->num_comp_vectors,
> +				ndev->device->attrs.max_srq);

Same question, can we change type type of variables instead?

>  	mutex_lock(&device_list_mutex);

...

>  	inline_page_count = num_pages(nport->inline_data_size);
>  	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
> -				cm_id->device->attrs.max_recv_sge) - 1;
> +				cm_id->device->attrs.max_recv_sge);
> +	inline_sge_count = inline_sge_count ? inline_sge_count - 1 : 0;

Simple conditional might be better

	if (inline_sge_count)
		inline_sge_count--;
	OR
		inline_sge_count -= 1;

...

> +++ b/include/rdma/ib_verbs.h

> -	int			max_qp;
> -	int			max_qp_wr;
> +	u32			max_qp;
> +	u32			max_qp_wr;

Nice, but please check that none of these (and beyond) were not used in signed
multiplication or (which is more disasterous) division. Otherwise it might be
subtle issues that will be hard to debug.

...

>  	conn_param->responder_resources =
> -		min_t(u32, rds_ibdev->max_responder_resources, max_responder_resources);
> +		min3(rds_ibdev->max_responder_resources,
> +		     max_responder_resources, U8_MAX);
>  	conn_param->initiator_depth =
> -		min_t(u32, rds_ibdev->max_initiator_depth, max_initiator_depth);
> +		min3(rds_ibdev->max_initiator_depth,
> +		     max_initiator_depth, U8_MAX);

I believe we can go a few characters over and leave them to be single lines.

>  	conn_param->retry_count = min_t(unsigned int, rds_ib_retry_count, 7);

What about this one?

>  	conn_param->rnr_retry_count = 7;

...

>  int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
>  {
>  	const struct ib_device_attr *attrs = &device->attrs;
> -	int max_qp_wr, depth, delta;
> +	u32 max_qp_wr;
> +	int depth, delta;
>  	unsigned int max_sge;

Reversed xmas tree order.

-- 
With Best Regards,
Andy Shevchenko



