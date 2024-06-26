Return-Path: <linux-nfs+bounces-4322-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D029187E8
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987061C212A1
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 16:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F391B18F2EE;
	Wed, 26 Jun 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtbVI9Ej"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C918F2C9
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420622; cv=none; b=homqDvkbodyQWKKFdOaBdyJt6Oyaicnav2JbROH6/k4o50WO0hiJTuSK62mdCXUnkEkTm049TYXyTT+5w4k9g1seiSc5G0kPSXMn+v7KCNVfK4i8S/KeDT1VTbyaavmzrtqyP/O0MdCn31ziy6Ul7EQie9EJb6wJTJ8uZSzNv+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420622; c=relaxed/simple;
	bh=mE15WwKaNh6H95xQH0sEkor66Do1M4TRC1Q8dHbh2qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpF8YmE50iKPN4CfWmjjyu2mnHhR4q+CysG3N1s0ugGMdpUzMk0CoVBicaA6vVrBiQRpqzv9JJtxK01B6XBeT+af3m8fSjBuIZPCGQK525XnGwvc9d4c7vX5L8SAY6kD+ceIJnidVooVdCSIJ5z9liffA9i06nnY6SVk4+eH3ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtbVI9Ej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C49C116B1;
	Wed, 26 Jun 2024 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719420622;
	bh=mE15WwKaNh6H95xQH0sEkor66Do1M4TRC1Q8dHbh2qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TtbVI9Ej7LHeUNzOayp1OhtcGaqibmLhQpNI2GK8sLMKyfdoewgRMXhkvNGV9P62D
	 kYHQaF7LoHBBv5YUvh6bmDerUAGNUQTJoCApvsYg2lK3w8+vTbNHiXKKHGA1ldlFU6
	 em9SEyL5uJaGRuhjNexBz6EU4kVpuEfRiqqxq0oyLXx+9iNAr4B3dWtBIK3eTNBLkr
	 tynQMpN4W3iHO5+tNcjoLHwuijseql+UH04wxVYl9mB3Msk1PGQbv7+VPKWrTcC6za
	 SCb518oSweBAXtMVXpwtlFP7GiMZD9KflnMJeAir01Hp+QdA6PcSYy5CtJdw2nxKIH
	 1dkHFhPBzodPQ==
Date: Wed, 26 Jun 2024 12:50:21 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v7 05/20] nfs_common: add NFS LOCALIO auxiliary protocol
 enablement
Message-ID: <ZnxGzYTkXjqy_f5Y@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>
 <20240624162741.68216-6-snitzer@kernel.org>
 <171935838369.14261.10478134782573516898@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171935838369.14261.10478134782573516898@noble.neil.brown.name>

On Wed, Jun 26, 2024 at 09:33:03AM +1000, NeilBrown wrote:
> On Tue, 25 Jun 2024, Mike Snitzer wrote:
> > First use is in nfsd, to add access to a global nfsd_uuids list that
> > will be used to identify local nfsd instances.
> > 
> > nfsd_uuids is protected by nfsd_mutex or RCU read lock.  List is
> > composed of nfsd_uuid_t instances that are managed as nfsd creates
> > them (per network namespace).
> > 
> > nfsd_uuid_is_local() will be used to search all local nfsd for the
> > client specified nfsd uuid.
> > 
> > This commit also adds all the nfs_client members required to implement
> > the entire localio feature (which depends on the LOCALIO protocol).
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfs/client.c            |  8 +++++
> >  fs/nfs_common/Makefile     |  3 ++
> >  fs/nfs_common/nfslocalio.c | 72 ++++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/netns.h            |  4 +++
> >  fs/nfsd/nfssvc.c           | 12 ++++++-
> >  include/linux/nfs_fs_sb.h  |  9 +++++
> >  include/linux/nfslocalio.h | 39 +++++++++++++++++++++
> >  7 files changed, 146 insertions(+), 1 deletion(-)
> >  create mode 100644 fs/nfs_common/nfslocalio.c
> >  create mode 100644 include/linux/nfslocalio.h
> > 
> > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > index de77848ae654..bcdf8d42cbc7 100644
> > --- a/fs/nfs/client.c
> > +++ b/fs/nfs/client.c
> > @@ -178,6 +178,14 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
> >  	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
> >  	clp->cl_net = get_net(cl_init->net);
> >  
> > +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > +	seqlock_init(&clp->cl_boot_lock);
> > +	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
> > +	clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
> > +	clp->nfsd_open_local_fh = NULL;
> > +	clp->cl_nfssvc_net = NULL;
> > +#endif /* CONFIG_NFS_LOCALIO */
> > +
> >  	clp->cl_principal = "*";
> >  	clp->cl_xprtsec = cl_init->xprtsec;
> >  	return clp;
> > diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
> > index 119c75ab9fd0..d81623b76aba 100644
> > --- a/fs/nfs_common/Makefile
> > +++ b/fs/nfs_common/Makefile
> > @@ -6,5 +6,8 @@
> >  obj-$(CONFIG_NFS_ACL_SUPPORT) += nfs_acl.o
> >  nfs_acl-objs := nfsacl.o
> >  
> > +obj-$(CONFIG_NFS_COMMON_LOCALIO_SUPPORT) += nfs_localio.o
> > +nfs_localio-objs := nfslocalio.o
> > +
> >  obj-$(CONFIG_GRACE_PERIOD) += grace.o
> >  obj-$(CONFIG_NFS_V4_2_SSC_HELPER) += nfs_ssc.o
> > diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> > new file mode 100644
> > index 000000000000..755b84b742a6
> > --- /dev/null
> > +++ b/fs/nfs_common/nfslocalio.c
> > @@ -0,0 +1,72 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/rculist.h>
> > +#include <linux/nfslocalio.h>
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("NFS localio protocol bypass support");
> > +
> > +/*
> > + * Global list of nfsd_uuid_t instances, add/remove
> > + * is protected by fs/nfsd/nfssvc.c:nfsd_mutex.
> > + * Reads are protected by RCU read lock (see below).
> > + */
> > +LIST_HEAD(nfsd_uuids);
> > +EXPORT_SYMBOL(nfsd_uuids);
> > +
> > +/* Must be called with RCU read lock held. */
> > +static const uuid_t * nfsd_uuid_lookup(const uuid_t *uuid,
> > +				struct net **netp)
> > +{
> > +	nfsd_uuid_t *nfsd_uuid;
> > +
> > +	list_for_each_entry_rcu(nfsd_uuid, &nfsd_uuids, list)
> > +		if (uuid_equal(&nfsd_uuid->uuid, uuid)) {
> > +			*netp = nfsd_uuid->net;
> > +			return &nfsd_uuid->uuid;
> > +		}
> > +
> > +	return &uuid_null;
> > +}
> > +
> > +bool nfsd_uuid_is_local(const uuid_t *uuid, struct net **netp)
> > +{
> > +	const uuid_t *nfsd_uuid;
> > +
> > +	rcu_read_lock();
> > +	nfsd_uuid = nfsd_uuid_lookup(uuid, netp);
> > +	rcu_read_unlock();
> > +
> > +	return !uuid_is_null(nfsd_uuid);
> 
> This is still unsafe.  You can only safely dereference nfsd_uuid while
> still holding the rcu_read_lock.

Fixed, thanks.

