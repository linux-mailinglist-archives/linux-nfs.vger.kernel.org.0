Return-Path: <linux-nfs+bounces-22724-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yUrINFeZNWrL0wYAu9opvQ
	(envelope-from <linux-nfs+bounces-22724-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:32:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3382C6A7883
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:32:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=axv1ytRK;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22724-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22724-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0844C30570E9
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D559351C2A;
	Fri, 19 Jun 2026 19:32:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD9E349B0D;
	Fri, 19 Jun 2026 19:32:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897557; cv=none; b=L640veypqBp/N1f2M7vWjMlU4mqMW0PYffvpNBBxhNYB9Qcz58XkstFWRs9csS5+vfNqmNrOk8cE2VOoCbZDOSqq5HAJcQHaNcI6a5SaegAx02wnACsG7eJq6vyd416qOriJPhFRqy65qNpE4Fh9jyCeCGCF/EhdfLCVUvJOBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897557; c=relaxed/simple;
	bh=gHc8zi5miNpM28ukI1VhOAt03eXkjT0Uh8qx72KdouQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2HHIcoqXGTzR4nef8D7PBzVyVkaf6mmMgvzi9XZaZ8sk0/FTD1WeGO6+ythhKRsgkfg/vxGXN6S0abES9xIgvMJGsqTy9gHSF0euqZ4C4hcogytSnHMSuYHaS9x7tSzeY4sgP/ThafCI+ZLbdYdhWLcqEsceKqT2EzqLJVSQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=axv1ytRK; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 3C65C20B7168; Fri, 19 Jun 2026 12:32:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C65C20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781897554;
	bh=m2uMxxexDXuJiyEDGdvQW8jMxy4JG/jFpxhsKw2zxso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axv1ytRKW9J9dLaykB85E5RKw778VJTsAnGBgDm54K5ccP6TuM1idVXo84/+eHuA0
	 rEC8iInJgqFqMKMf6s7++kxm8T936/8OoShGjH6mw/Xl4Bb8B3sMcaXsLnzJw+eHpX
	 ZxXYnk/scEgxxjar87N3D8G9YDGhrBnCnlT+j+lw=
Date: Fri, 19 Jun 2026 12:32:34 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <ajWZUjSoUCTe0Pb7@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260606070735.2163063-1-ernis@linux.microsoft.com>
 <aigwONAwxQx6rLef@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aigwONAwxQx6rLef@ashevche-desk.local>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:mkalderon@marvell.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:zyjzyj2000@gmail.com,m:sagi@grimberg.me,m:mgurtovoy@nvidia.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:bvanassche@acm.org,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:kch@nvidia.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:metze@samba.org,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:ebadger@purestorage.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:rds-devel@oss.oracle.com,m:jgg@nvidia.com,s:
 lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ernis@linux.microsoft.com,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22724-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[marvell.com,ziepe.ca,kernel.org,gmail.com,grimberg.me,nvidia.com,ionos.com,acm.org,kernel.dk,lst.de,samba.org,talpey.com,oracle.com,brown.name,redhat.com,davemloft.net,google.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3382C6A7883

Hi Andy,

Sorry for delayed response.

> >  	attr->max_qp_init_rd_atom =
> >  	    1 << (fls(qattr->max_qp_req_rd_atomic_resc) - 1);
> 
> FWIW, this one and below looks like reinvention of rounddown_pow_of_two().

Acked.
> 
> >  	attr->max_qp_rd_atom =
> > -	    min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
> > +	    min(1U << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
> >  		attr->max_qp_init_rd_atom);
> 
> ...
> 
> >  int ipoib_cm_dev_init(struct net_device *dev)
> >  {
> >  	struct ipoib_dev_priv *priv = ipoib_priv(dev);
> > -	int max_srq_sge, i;
> > +	int i;
> > +	u32 max_srq_sge;
> >  	u8 addr;
> 
> It seems the order is reversed xmas tree, why not preserving it?
> 
Right. I'll fix it in the next version.
> ...
> 
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> 
> >  		max_send_wr =
> > -			min_t(int, wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
> > +			min(wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
> 
> Now perfectly a single line
> 
> 		max_send_wr = min(wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
> 
> >  		max_recv_wr = max_send_wr;
> 
> ...
> 
> > -		max_send_wr = min_t(int, wr_limit,
> > -			      /* QD * (REQ + RSP + FR REGS or INVS) + drain */
> > -			      clt_path->queue_depth * 4 + 1);
> > -		max_recv_wr = min_t(int, wr_limit,
> > -			      clt_path->queue_depth * 3 + 1);
> > +		max_send_wr = min_t(u32, wr_limit,
> > +				    /* QD * (REQ + RSP + FR REGS or INVS) + drain */
> > +				    clt_path->queue_depth * 4 + 1);
> > +		max_recv_wr = min_t(u32, wr_limit,
> > +				    clt_path->queue_depth * 3 + 1);
> 
> Can we rather update the type of one of them and use min() instead?
> 
I'll remove all the min_t usages in the next version.
> ...
> 
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> 
> Ditto.
> 
> ...
> 
> > -static int srpt_srq_size = DEFAULT_SRPT_SRQ_SIZE;
> > -module_param(srpt_srq_size, int, 0444);
> > +static unsigned int srpt_srq_size = DEFAULT_SRPT_SRQ_SIZE;
> > +module_param(srpt_srq_size, uint, 0444);
> 
> Theoretically this might break ABI (if somebody uses negative values for
> anything. I don't think it's the case, but just be informed.
> 
Okay. Thankyou for the information. 

> >  MODULE_PARM_DESC(srpt_srq_size,
> >  		 "Shared receive queue (SRQ) size.");
> 
> ...
> 
> > --- a/drivers/nvme/target/rdma.c
> > +++ b/drivers/nvme/target/rdma.c
> 
> > -	ndev->srq_size = min(ndev->device->attrs.max_srq_wr,
> > -			     nvmet_rdma_srq_size);
> > -	ndev->srq_count = min(ndev->device->num_comp_vectors,
> > -			      ndev->device->attrs.max_srq);
> > +	ndev->srq_size = min_t(u32, ndev->device->attrs.max_srq_wr,
> > +			       nvmet_rdma_srq_size);
> > +	ndev->srq_count = min_t(u32, ndev->device->num_comp_vectors,
> > +				ndev->device->attrs.max_srq);
> 
> Same question, can we change type type of variables instead?
>
Yes. I'll be doing it in the next version.
 
> >  	mutex_lock(&device_list_mutex);
> 
> ...
> 
> >  	inline_page_count = num_pages(nport->inline_data_size);
> >  	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
> > -				cm_id->device->attrs.max_recv_sge) - 1;
> > +				cm_id->device->attrs.max_recv_sge);
> > +	inline_sge_count = inline_sge_count ? inline_sge_count - 1 : 0;
> 
> Simple conditional might be better
> 
> 	if (inline_sge_count)
> 		inline_sge_count--;
> 	OR
> 		inline_sge_count -= 1;
Okay. I'll update all such instances.

> 
> ...
> 
> > +++ b/include/rdma/ib_verbs.h
> 
> > -	int			max_qp;
> > -	int			max_qp_wr;
> > +	u32			max_qp;
> > +	u32			max_qp_wr;
> 
> Nice, but please check that none of these (and beyond) were not used in signed
> multiplication or (which is more disasterous) division. Otherwise it might be
> subtle issues that will be hard to debug.
Yes I have checked that for all the variables I updated.

> 
> ...
> 
> >  	conn_param->responder_resources =
> > -		min_t(u32, rds_ibdev->max_responder_resources, max_responder_resources);
> > +		min3(rds_ibdev->max_responder_resources,
> > +		     max_responder_resources, U8_MAX);
> >  	conn_param->initiator_depth =
> > -		min_t(u32, rds_ibdev->max_initiator_depth, max_initiator_depth);
> > +		min3(rds_ibdev->max_initiator_depth,
> > +		     max_initiator_depth, U8_MAX);
> 
> I believe we can go a few characters over and leave them to be single lines.
> 
Okay.

> >  	conn_param->retry_count = min_t(unsigned int, rds_ib_retry_count, 7);
> 
> What about this one?
Sorry. I missed this one, I'll update it.

> 
> >  	conn_param->rnr_retry_count = 7;
> 
> ...
> 
> >  int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
> >  {
> >  	const struct ib_device_attr *attrs = &device->attrs;
> > -	int max_qp_wr, depth, delta;
> > +	u32 max_qp_wr;
> > +	int depth, delta;
> >  	unsigned int max_sge;
> 
> Reversed xmas tree order.
Okay

Thankyou for all your suggestions.
The next version will be incorporated with all these changes.

- Vennela
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

