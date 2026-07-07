Return-Path: <linux-nfs+bounces-23129-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oUz9EufUTGoNqgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23129-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 12:28:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC3271A5F1
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 12:28:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=YjtfsGHZ;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23129-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23129-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7ADA93056C9F
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 10:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67943E16A8;
	Tue,  7 Jul 2026 10:20:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1446D3DEADC;
	Tue,  7 Jul 2026 10:20:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419645; cv=none; b=c2YQNhGvcULuc1n3cB3k2sklseRsibeugZb4+NiNrFG/LjovohBiQo8pjGyT0FAoiBx3m2MJ5i/l2rzoT7hZPyb+JDYpsT+mnCZPgpL0exkYZUPgDri/xPbzuab9U0os88prbiSkfmjNTtIU3c0ZIBjQiIb3736aObv2DO4ieUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419645; c=relaxed/simple;
	bh=PGSzmnmHGWQxJ7r1STAWYypX1PjNgCY/0z7SvAfUqgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJuKyYjGkDyZsOS7FSDm/1JhEHGMlqlIFCct7DHyt/CQe5iXDc+9C1px6y3D9UcraGaqdqYchEGxi+8uzFzmX8x0S15eBRFcMPmmy2hmb6Iyr9BBb8D8SYxvkcYsD31yczrS6AkrEln9T31TKjJSaQMygc5/oNjFSM3npyYzw8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YjtfsGHZ; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id EF08620B716B; Tue,  7 Jul 2026 03:20:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF08620B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783419636;
	bh=441oD1++hubgGUElzvL75rwNbLNzT7P+xGK0zmQs+Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjtfsGHZJBrWJ+Vy4Ipz+WqFrtJd6xZWrR8UEtusUUwjXIr8jP+wo4On9qsOyJ+pA
	 JnztyI1H/EvD+jIspehtVLEjQwRJEGFtTbArD4gVwsHH9VlNuQr6y4XZuKoSYZUyRU
	 wdBJG2gkJwBJDu6T8/gqWpO/X6dc27dL+jU6UXmE=
Date: Tue, 7 Jul 2026 03:20:36 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, mkalderon@marvell.com,
	zyjzyj2000@gmail.com, sagi@grimberg.me, mgurtovoy@nvidia.com,
	haris.iqbal@ionos.com, jinpu.wang@ionos.com, bvanassche@acm.org,
	kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
	linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
	cel@kernel.org, jlayton@kernel.org, neil@brown.name,
	okorniev@redhat.com, Dai.Ngo@oracle.com, trondmy@kernel.org,
	anna@kernel.org, achender@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kees@kernel.org,
	andriy.shevchenko@linux.intel.com, clm@meta.com,
	ebadger@purestorage.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v9] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <akzS9EdxScQsx9n8@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260703060329.896125-1-ernis@linux.microsoft.com>
 <20260706084950.GK15188@unreal>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706084950.GK15188@unreal>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:mkalderon@marvell.com,m:zyjzyj2000@gmail.com,m:sagi@grimberg.me,m:mgurtovoy@nvidia.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:bvanassche@acm.org,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:kch@nvidia.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:metze@samba.org,m:tom@talpey.com,m:cel@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:andriy.shevchenko@linux.intel.com,m:clm@meta.com,m:ebadger@purestorage.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:rds-devel@oss.oracle.com,m:jgg@nvidia
 .com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ernis@linux.microsoft.com,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23129-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[ziepe.ca,marvell.com,gmail.com,grimberg.me,nvidia.com,ionos.com,acm.org,kernel.org,kernel.dk,lst.de,samba.org,talpey.com,brown.name,redhat.com,oracle.com,davemloft.net,google.com,linux.intel.com,meta.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.microsoft.com:from_mime,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BC3271A5F1

On Mon, Jul 06, 2026 at 11:49:50AM +0300, Leon Romanovsky wrote:
> > ---
> >  drivers/infiniband/core/cq.c               |  3 +-
> >  drivers/infiniband/hw/qedr/verbs.c         |  2 +-
> >  drivers/infiniband/sw/rxe/rxe_qp.c         | 22 +++++-----
> >  drivers/infiniband/sw/rxe/rxe_srq.c        | 16 +++----
> >  drivers/infiniband/ulp/ipoib/ipoib_cm.c    | 10 ++---
> >  drivers/infiniband/ulp/ipoib/ipoib_verbs.c |  3 +-
> >  drivers/infiniband/ulp/iser/iser_verbs.c   |  5 +--
> >  drivers/infiniband/ulp/isert/ib_isert.c    |  7 ++-
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c     | 11 ++---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c     | 11 ++---
> >  drivers/infiniband/ulp/srp/ib_srp.c        |  2 +-
> >  drivers/infiniband/ulp/srpt/ib_srpt.c      | 21 +++++----
> >  drivers/nvme/host/rdma.c                   |  8 ++--
> >  drivers/nvme/target/rdma.c                 | 22 ++++++----
> >  fs/smb/smbdirect/accept.c                  |  5 ++-
> >  fs/smb/smbdirect/connect.c                 |  5 ++-
> >  fs/smb/smbdirect/connection.c              |  8 ++--
> >  include/linux/sunrpc/svc_rdma.h            |  4 +-
> >  include/rdma/ib_verbs.h                    | 50 +++++++++++-----------
> >  net/rds/ib.c                               | 10 ++---
> >  net/rds/ib_cm.c                            | 10 ++---
> >  net/sunrpc/xprtrdma/frwr_ops.c             |  7 +--
> >  net/sunrpc/xprtrdma/svc_rdma_transport.c   |  5 +--
> >  net/sunrpc/xprtrdma/verbs.c                |  2 +-
> >  24 files changed, 122 insertions(+), 127 deletions(-)
> 
> The following code is still missing. 

I'll make this change in the next version.

>Also, what about mxa_srq?
> Why wasn't it converted as well?

I originally left max_srq as int because its only consumer pairs it with
num_comp_vectors (a signed int) in nvmet_rdma, so keeping it int let
that site stay a plain min() instead of a min_t().

num_comp_vectors is the completion-vector count, legitimately int and
never anywhere near INT_MAX, so I'd prefer to leave it signed rather
than convert it everywhere. Does that work for you, or would you rather
num_comp_vectors be converted too?

If it needs converting, I'll do it as a separate patch, since it lives
in a different struct (ib_device) and touches many call sites.
Otherwise, using min_t() for just this one call is fine too.

Thanks,
Vennela

> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index f599c24b34e8..aae4f3f6bcba 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -454,7 +454,8 @@ static int fill_res_info(struct sk_buff *msg, struct ib_device *device,
>         };
> 
>         struct nlattr *table_attr;
> -       int ret, i, curr, max;
> +       u64 curr, max;
> +       int ret, i;
> 
>         if (fill_nldev_handle(msg, device))
>                 return -EMSGSIZE;
> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> index cfee2071586c..1b2f9df49e28 100644
> --- a/drivers/infiniband/core/restrack.c
> +++ b/drivers/infiniband/core/restrack.c
> @@ -61,7 +61,7 @@ void rdma_restrack_clean(struct ib_device *dev)
>   * @type: actual type of object to operate
>   * @show_details: count driver specific objects
>   */
> -int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
> +u32 rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
>                         bool show_details)
>  {
>         struct rdma_restrack_root *rt = &dev->res[type];
> diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
> index 451f99e3717d..c081384740ce 100644
> --- a/include/rdma/restrack.h
> +++ b/include/rdma/restrack.h
> @@ -123,7 +123,7 @@ struct rdma_restrack_entry {
>         u32 id;
>  };
> 
> -int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
> +u32 rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
>                         bool show_details);
>  /**
>   * rdma_is_kernel_res() - check the owner of resource

