Return-Path: <linux-nfs+bounces-7860-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA2C9C41F5
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 16:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804961F223E3
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 15:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C7819F12D;
	Mon, 11 Nov 2024 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osPN9bRD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E819F113
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339241; cv=none; b=gip/SyUcfMPWifyM7I4QsGt5a/376RPEkfhatpAolYsQqfL11x4BWbEszTE5Zwhr3LAi1mpRFmUIFXLsxdvpNdZ43FFh6+1lgfXAtWTt8d88JVmFEsl9R1ZvHeaispJ5hhebNdlKZiBJLqqsAJR+ePxlSCVxHJyj+qrQi6PZ+Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339241; c=relaxed/simple;
	bh=IWgUqyU99r4EMDKSc5OhGcKVR47Cg+XD24IRSRAiQkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EG+YqUwkZQ9WQZobec7I2VLw9Qe/N3Xex6fjgYycu38vsp3PEECZ81gpZhph+cftZWSgnsYoejaIhI0y+njS/D5j2OgeoQDIWORt4miCxWlE3/I24/4oa8Wh9wiHnpuKyimNrxWkkkNJHrO7XZVF+FtJxid6en1Pfw61GUM4eJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osPN9bRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3119C4CECF;
	Mon, 11 Nov 2024 15:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731339240;
	bh=IWgUqyU99r4EMDKSc5OhGcKVR47Cg+XD24IRSRAiQkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=osPN9bRDSBgUho0KmhN4XqJLhEHjKqmLwJTjbP5YL3cQ7n/hChF06aWSMmlBhiv4T
	 nsu8+88q51L9+fq1YdIm9FeZDFamPk73EIZGUhna3cpi92odBIXEc4wgMw4bzrlqmr
	 uH5Z2u7NUlZslPirBgrFKYa/fFNu1AyJjvMf8U7iMbWProHbhEFd3GaPj2fjPEYCWD
	 8GdRmFLU/ngV36vJF9j0fpAZAYJHBwy9farU+1SXHoFTGhznqMr75EMEUhkIl5h24Z
	 G2s4eKA+TcTQJqXCsc6IitqPZrzap/66vTOo1Em4m525aQPEIZL+kb3FLz8IS7UdmA
	 x4w6IIjH4uwhw==
Date: Mon, 11 Nov 2024 10:33:59 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [for-6.13 PATCH 10/19] nfs_common: move localio_lock to new lock
 member of nfs_uuid_t
Message-ID: <ZzIj52LUYVgu-wZh@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
 <20241108234002.16392-11-snitzer@kernel.org>
 <173129012433.1734440.14130461870880893050@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173129012433.1734440.14130461870880893050@noble.neil.brown.name>

On Mon, Nov 11, 2024 at 12:55:24PM +1100, NeilBrown wrote:
> On Sat, 09 Nov 2024, Mike Snitzer wrote:
> > Remove cl_localio_lock from 'struct nfs_client' in favor of adding a
> > lock to the nfs_uuid_t struct (which is embedded in each nfs_client).
> > 
> > Push nfs_local_{enable,disable} implementation down to nfs_common.
> > Those methods now call nfs_localio_{enable,disable}_client.
> > 
> > This allows implementing nfs_localio_invalidate_clients in terms of
> > nfs_localio_disable_client.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfs/client.c            |  1 -
> >  fs/nfs/localio.c           | 18 ++++++------
> >  fs/nfs_common/nfslocalio.c | 57 ++++++++++++++++++++++++++------------
> >  include/linux/nfs_fs_sb.h  |  1 -
> >  include/linux/nfslocalio.h |  8 +++++-
> >  5 files changed, 55 insertions(+), 30 deletions(-)
> > 
> > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > index 03ecc7765615..124232054807 100644
> > --- a/fs/nfs/client.c
> > +++ b/fs/nfs/client.c
> > @@ -182,7 +182,6 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
> >  	seqlock_init(&clp->cl_boot_lock);
> >  	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
> >  	nfs_uuid_init(&clp->cl_uuid);
> > -	spin_lock_init(&clp->cl_localio_lock);
> >  #endif /* CONFIG_NFS_LOCALIO */
> >  
> >  	clp->cl_principal = "*";
> > diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> > index cab2a8819259..4c75ffc5efa2 100644
> > --- a/fs/nfs/localio.c
> > +++ b/fs/nfs/localio.c
> > @@ -125,10 +125,8 @@ const struct rpc_program nfslocalio_program = {
> >   */
> >  static void nfs_local_enable(struct nfs_client *clp)
> >  {
> > -	spin_lock(&clp->cl_localio_lock);
> > -	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> >  	trace_nfs_local_enable(clp);
> > -	spin_unlock(&clp->cl_localio_lock);
> > +	nfs_localio_enable_client(clp);
> >  }
> 
> Why do we need this function?  The one caller could call
> nfs_localio_enable_client() directly instead.  The tracepoint could be
> placed in that one caller.

Yeah, I saw that too but felt it useful to differentiate between calls
that occur during NFS client initialization and those that happen as a
side-effect of callers from other contexts (in later patch this
manifests as nfs_localio_disable_client vs nfs_local_disable).

Hence my adding secondary tracepoints for nfs_common (see "[PATCH
17/19] nfs_common: add nfs_localio trace events).

But sure, we can just eliminate nfs_local_{enable,disable} and the
corresponding tracepoints (which will have moved down to nfs_common).

> >  /*
> > @@ -136,12 +134,8 @@ static void nfs_local_enable(struct nfs_client *clp)
> >   */
> >  void nfs_local_disable(struct nfs_client *clp)
> >  {
> > -	spin_lock(&clp->cl_localio_lock);
> > -	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
> > -		trace_nfs_local_disable(clp);
> > -		nfs_localio_disable_client(&clp->cl_uuid);
> > -	}
> > -	spin_unlock(&clp->cl_localio_lock);
> > +	trace_nfs_local_disable(clp);
> > +	nfs_localio_disable_client(clp);
> >  }
> 
> Ditto.  Though there are more callers so the tracepoint solution isn't
> quite so obvious.

Right... as I just explained: that's why I preserved nfs_local_disable
(and the tracepoint).


> >  /*
> > @@ -183,8 +177,12 @@ static bool nfs_server_uuid_is_local(struct nfs_client *clp)
> >  	rpc_shutdown_client(rpcclient_localio);
> >  
> >  	/* Server is only local if it initialized required struct members */
> > -	if (status || !clp->cl_uuid.net || !clp->cl_uuid.dom)
> > +	rcu_read_lock();
> > +	if (status || !rcu_access_pointer(clp->cl_uuid.net) || !clp->cl_uuid.dom) {
> > +		rcu_read_unlock();
> >  		return false;
> > +	}
> > +	rcu_read_unlock();
> 
> What value does RCU provide here?  I don't think this change is needed.
> rcu_access_pointer does not require rcu_read_lock().

OK, not sure why I though RCU read-side needed for rcu_access_pointer()...

> >  	return true;
> >  }
> > diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> > index 904439e4bb85..cf2f47ea4f8d 100644
> > --- a/fs/nfs_common/nfslocalio.c
> > +++ b/fs/nfs_common/nfslocalio.c
> > @@ -7,6 +7,9 @@
> >  #include <linux/module.h>
> >  #include <linux/list.h>
> >  #include <linux/nfslocalio.h>
> > +#include <linux/nfs3.h>
> > +#include <linux/nfs4.h>
> > +#include <linux/nfs_fs_sb.h>
> 
> I don't feel good about adding this nfs client knowledge in to nfs_common.

I hear you.. I was "OK with it".

> >  #include <net/netns/generic.h>
> >  
> >  MODULE_LICENSE("GPL");
> > @@ -25,6 +28,7 @@ void nfs_uuid_init(nfs_uuid_t *nfs_uuid)
> >  	nfs_uuid->net = NULL;
> >  	nfs_uuid->dom = NULL;
> >  	INIT_LIST_HEAD(&nfs_uuid->list);
> > +	spin_lock_init(&nfs_uuid->lock);
> >  }
> >  EXPORT_SYMBOL_GPL(nfs_uuid_init);
> >  
> > @@ -94,12 +98,23 @@ void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
> >  }
> >  EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
> >  
> > +void nfs_localio_enable_client(struct nfs_client *clp)
> > +{
> > +	nfs_uuid_t *nfs_uuid = &clp->cl_uuid;
> > +
> > +	spin_lock(&nfs_uuid->lock);
> > +	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> > +	spin_unlock(&nfs_uuid->lock);
> > +}
> > +EXPORT_SYMBOL_GPL(nfs_localio_enable_client);
> 
> And I don't feel good about nfs_local accessing nfs_client directly.
> It only uses it for NFS_CS_LOCAL_IO.  Can we ditch that flag and instead
> so something like testing nfs_uuid.net ??

That'd probably be OK for the equivalent of NFS_CS_LOCAL_IO but the last
patch in this series ("nfs: probe for LOCALIO when v3 client
reconnects to server") adds NFS_CS_LOCAL_IO_CAPABLE to provide a hint
that the client and server successfully established themselves local
via LOCALIO protocol.  This is needed so that NFSv3 (stateless) has a
hint that reestablishing LOCALIO needed if/when the client loses
connectivity to the server (because it was shutdown and restarted).

Could introduce flags local to nfs_uuid_t structure as a means of
nfs_common/nfslocalio.c not needing to know internals of nfs_client at
all -- conversely: probably best to not bloat nfs_uuid_t (and
nfs_client) further, so should just ensure nfs_client treated as an
opaque pointer in nfs_common by introducing accessors?

> > +
> >  static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
> >  {
> > -	if (nfs_uuid->net) {
> > -		module_put(nfsd_mod);
> > -		nfs_uuid->net = NULL;
> > -	}
> > +	if (!nfs_uuid->net)
> > +		return;
> > +	module_put(nfsd_mod);
> > +	rcu_assign_pointer(nfs_uuid->net, NULL);
> > +
> 
> I much prefer RCU_INIT_POINTER for assigning NULL as there is no need
> for ordering here.

OK.

> >  	if (nfs_uuid->dom) {
> >  		auth_domain_put(nfs_uuid->dom);
> >  		nfs_uuid->dom = NULL;
> > @@ -107,27 +122,35 @@ static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
> >  	list_del_init(&nfs_uuid->list);
> >  }
> >  
> > -void nfs_localio_invalidate_clients(struct list_head *list)
> > +void nfs_localio_disable_client(struct nfs_client *clp)
> > +{
> > +	nfs_uuid_t *nfs_uuid = &clp->cl_uuid;
> > +
> > +	spin_lock(&nfs_uuid->lock);
> > +	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
> > +		spin_lock(&nfs_uuid_lock);
> > +		nfs_uuid_put_locked(nfs_uuid);
> > +		spin_unlock(&nfs_uuid_lock);
> > +	}
> > +	spin_unlock(&nfs_uuid->lock);
> > +}
> > +EXPORT_SYMBOL_GPL(nfs_localio_disable_client);
> > +
> > +void nfs_localio_invalidate_clients(struct list_head *cl_uuid_list)
> >  {
> >  	nfs_uuid_t *nfs_uuid, *tmp;
> >  
> >  	spin_lock(&nfs_uuid_lock);
> > -	list_for_each_entry_safe(nfs_uuid, tmp, list, list)
> > -		nfs_uuid_put_locked(nfs_uuid);
> > +	list_for_each_entry_safe(nfs_uuid, tmp, cl_uuid_list, list) {
> > +		struct nfs_client *clp =
> > +			container_of(nfs_uuid, struct nfs_client, cl_uuid);
> > +
> > +		nfs_localio_disable_client(clp);
> > +	}
> >  	spin_unlock(&nfs_uuid_lock);
> >  }
> >  EXPORT_SYMBOL_GPL(nfs_localio_invalidate_clients);
> >  
> > -void nfs_localio_disable_client(nfs_uuid_t *nfs_uuid)
> > -{
> > -	if (nfs_uuid->net) {
> > -		spin_lock(&nfs_uuid_lock);
> > -		nfs_uuid_put_locked(nfs_uuid);
> > -		spin_unlock(&nfs_uuid_lock);
> > -	}
> > -}
> > -EXPORT_SYMBOL_GPL(nfs_localio_disable_client);
> > -
> >  struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
> >  		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> >  		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> > diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> > index b804346a9741..239d86ef166c 100644
> > --- a/include/linux/nfs_fs_sb.h
> > +++ b/include/linux/nfs_fs_sb.h
> > @@ -132,7 +132,6 @@ struct nfs_client {
> >  	struct timespec64	cl_nfssvc_boot;
> >  	seqlock_t		cl_boot_lock;
> >  	nfs_uuid_t		cl_uuid;
> > -	spinlock_t		cl_localio_lock;
> >  #endif /* CONFIG_NFS_LOCALIO */
> >  };
> >  
> > diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> > index a05d1043f2b0..4d5583873f41 100644
> > --- a/include/linux/nfslocalio.h
> > +++ b/include/linux/nfslocalio.h
> > @@ -6,6 +6,7 @@
> >  #ifndef __LINUX_NFSLOCALIO_H
> >  #define __LINUX_NFSLOCALIO_H
> >  
> > +
> >  /* nfsd_file structure is purposely kept opaque to NFS client */
> >  struct nfsd_file;
> >  
> > @@ -19,6 +20,8 @@ struct nfsd_file;
> >  #include <linux/nfs.h>
> >  #include <net/net_namespace.h>
> >  
> > +struct nfs_client;
> > +
> >  /*
> >   * Useful to allow a client to negotiate if localio
> >   * possible with its server.
> > @@ -27,6 +30,8 @@ struct nfsd_file;
> >   */
> >  typedef struct {
> >  	uuid_t uuid;
> > +	/* sadly this struct is just over a cacheline, avoid bouncing */
> > +	spinlock_t ____cacheline_aligned lock;
> >  	struct list_head list;
> >  	struct net __rcu *net; /* nfsd's network namespace */
> >  	struct auth_domain *dom; /* auth_domain for localio */
> > @@ -38,7 +43,8 @@ void nfs_uuid_end(nfs_uuid_t *);
> >  void nfs_uuid_is_local(const uuid_t *, struct list_head *,
> >  		       struct net *, struct auth_domain *, struct module *);
> >  
> > -void nfs_localio_disable_client(nfs_uuid_t *nfs_uuid);
> > +void nfs_localio_enable_client(struct nfs_client *clp);
> > +void nfs_localio_disable_client(struct nfs_client *clp);
> >  void nfs_localio_invalidate_clients(struct list_head *list);
> >  
> >  /* localio needs to map filehandle -> struct nfsd_file */
> > -- 
> > 2.44.0
> > 
> > 
> 
> I think this is a good refactoring to do, but I don't like some of the
> details, or some of the RCU code.

Sure, I'll clean it up further.

Thanks for your review.

Mike

