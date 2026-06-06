Return-Path: <linux-nfs+bounces-22334-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z3jEHtfFI2pByAEAu9opvQ
	(envelope-from <linux-nfs+bounces-22334-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 09:01:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1114464CC8D
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 09:01:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=lfiYLgAy;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22334-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22334-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51437301348E
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jun 2026 07:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C10309DDF;
	Sat,  6 Jun 2026 07:01:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3851D2309AA;
	Sat,  6 Jun 2026 07:01:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780729291; cv=none; b=VDSjR0qszphfqDqZfPn/wXNORYubVUzbNcBRhneu9e7KH3e0t8nmIZILR7nePnbIoSRNAe8t9VwbXz3B63TK/ucZg2wsVeWTTwJLwgqJczI9+616DsfBAx1boLGIG/I1c+h+x6hBXoLMRbZarff3Hsjrk1/gZEiSj7NvC+fHSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780729291; c=relaxed/simple;
	bh=50E34gE5VHddO0NTCTLmIghu1TtNR4sFpaf2gC/8Pak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAiaQy+/1iQoTgPKGdpZas4YMG062Bi6syAamX6+PhPS1iOJb2iGVoWoGudVTXD4q3vN9RpGd2bsq55Zuyv8cjMpcWmtqsN0lb1lRmUcONfSFdlR77noyB+U8SYmalo9xcA7nY52N/fQyi3TCfs8O4DTSIkY1LcfZvKtyE0qtxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lfiYLgAy; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 36F9220B7168; Sat,  6 Jun 2026 00:01:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36F9220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780729274;
	bh=cMzcioYuB6Di79ZAvhskrIxXkdQtLzFhYkxDW4jk4RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfiYLgAyM5X/Pp8g7mBNzlfTZuGrIEceOzfPeiO/YB1r6+Ng/0LarUrvfKUDmqic6
	 1yqjSp4BBat3h2X0imFMfW3HbOFJ3MP7LYUm2rV90O1SlNLucv3fblEEH+a83yxxU3
	 tC0IfjxdahYBZIqi0Rl7RSFPogCClEYIOy+uUBRM=
Date: Sat, 6 Jun 2026 00:01:14 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: mkalderon@marvell.com, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
	sagi@grimberg.me, mgurtovoy@nvidia.com, haris.iqbal@ionos.com,
	jinpu.wang@ionos.com, bvanassche@acm.org, kbusch@kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	kch@nvidia.com, smfrench@gmail.com, linkinjeon@kernel.org,
	metze@samba.org, tom@talpey.com, chuck.lever@oracle.com,
	jlayton@kernel.org, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, trondmy@kernel.org, anna@kernel.org,
	achender@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	kees@kernel.org, andriy.shevchenko@linux.intel.com,
	ebadger@purestorage.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v6] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <aiPFuqrpy0gJQB73@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260601092534.1764560-1-ernis@linux.microsoft.com>
 <20260602123327.35aa286a@pumpkin>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602123327.35aa286a@pumpkin>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:mkalderon@marvell.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:zyjzyj2000@gmail.com,m:sagi@grimberg.me,m:mgurtovoy@nvidia.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:bvanassche@acm.org,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:kch@nvidia.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:metze@samba.org,m:tom@talpey.com,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:andriy.shevchenko@linux.intel.com,m:ebadger@purestorage.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:rds-devel@oss
 .oracle.com,m:jgg@nvidia.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ernis@linux.microsoft.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_FROM(0.00)[bounces-22334-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[marvell.com,ziepe.ca,kernel.org,gmail.com,grimberg.me,nvidia.com,ionos.com,acm.org,kernel.dk,lst.de,samba.org,talpey.com,oracle.com,brown.name,redhat.com,davemloft.net,google.com,linux.intel.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:from_mime,linux.microsoft.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1114464CC8D

On Tue, Jun 02, 2026 at 12:33:27PM +0100, David Laight wrote:
 > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index 6482ad859bd1..852213365ecd 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -1731,7 +1731,7 @@ static int create_con(struct rtrs_srv_path *srv_path,
> >  		 * All receive and all send (each requiring invalidate)
> >  		 * + 2 for drain and heartbeat
> >  		 */
> > -		max_send_wr = min_t(int, wr_limit,
> > +		max_send_wr = min_t(u32, wr_limit,
> >  				    SERVICE_CON_QUEUE_DEPTH * 2 + 2);
> 
> That should compile as min().
> (The constant is known to be non-negative.)

Okay, I'll update this in the next version.
> 
> ...
> > diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> > index e6e2c3f9afdf..fd6923198ec1 100644
> > --- a/drivers/nvme/target/rdma.c
> > +++ b/drivers/nvme/target/rdma.c
> ...
> > @@ -1553,8 +1554,8 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
> >  
> >  	param.rnr_retry_count = 7;
> >  	param.flow_control = 1;
> > -	param.initiator_depth = min_t(u8, p->initiator_depth,
> > -		queue->dev->device->attrs.max_qp_init_rd_atom);
> > +	param.initiator_depth = (u8)min_t(u32, p->initiator_depth,
> > +		min_t(u32, U8_MAX, queue->dev->device->attrs.max_qp_init_rd_atom));
> 
> I think you've change one of those to min_3().
> Nesting min() is a good way to bloat the pre-processor output.
> You don't need any of the casts.
> 	
> 	param.initiator_depth = min_3(p->initiator_depth,
> 		queue->dev->device->attrs.max_qp_init_rd_atom, U8_MAX);
> should be fine - if a bit long.
> 
> There are also (u32)U8_MAX casts lurking - pointless.
> 
Okay. I'll use min3 as suggested in the next version and remove
unneccesary casts.

Thanks,
Vennela
> -- David

