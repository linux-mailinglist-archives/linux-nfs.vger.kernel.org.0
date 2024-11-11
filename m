Return-Path: <linux-nfs+bounces-7880-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C1F9C4910
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 23:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612DA281E19
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 22:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED5E16C451;
	Mon, 11 Nov 2024 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC7fDRKa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5833315886D
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731364075; cv=none; b=P4vHKH76flA8V5QpSNg3KbzGwVhj7jwEPIRaAVC40SQOYjbTUpU8OvoYk54Rbz02w7IhBsKDcAvT08ffM2pqW5ds0CsE8j9CVCcUHK5ijrViCrYwVLIlQZSvkD7r8y1GHESH2zJ3qSaN/LMUIzra0DT0GqdaViy2ySoqEZj3lxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731364075; c=relaxed/simple;
	bh=8XXfgrssIC2H1xBBVZRADraLSFvs7pKfT38shWXPWxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgY0cXUuwudkZgxwZ2WbFTiYRLIQz+cALExlI5yISEYzCXx7x1B/oy2SHcoRH/llOy8gTUhg7I0Hek8fCEItwE1j7z8FP0eUYJO0GiLDUM11WOnY3ov3fqZIEIGkZTyaMEfShVQI+0evpJUGxdONNQt7WGOsCXVvhU4Wris502Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC7fDRKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9998CC4CECF;
	Mon, 11 Nov 2024 22:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731364074;
	bh=8XXfgrssIC2H1xBBVZRADraLSFvs7pKfT38shWXPWxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mC7fDRKa1DpUks74WP4NctJKAYRFu4I4WsPfL812rnx++zQWmvnSTWEpyucub0U+O
	 dMdh7YzdibxArPiC5DH1W8//eFaKHuAO7Qh+L6OmznNR/ArJHcdDYHF57EuKA+cbv2
	 XxPEO0F8iBB+dbPOYVCGFWf8/WYzQhZSoiBFkQj7P4DCcKbB1zhJ0YBQBx2z7cVkRc
	 vmfti+B3WRxc2Ih2jqQljTTwRrcej+QS3KafGZxT7Lt6UkZLocnRHj3j+JZCAFTaxC
	 sA4IBNQV6dat9SqjwicQc1atZseocV/g/Hxmc2hCqN5ZnLK3H94fhVVmZoUo716A6t
	 4ndBsbnUpTSzw==
Date: Mon, 11 Nov 2024 17:27:53 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [for-6.13 PATCH 10/19] nfs_common: move localio_lock to new lock
 member of nfs_uuid_t
Message-ID: <ZzKE6aQyEKiIgMLG@kernel.org>
References: <>
 <ZzIj52LUYVgu-wZh@kernel.org>
 <173135730484.1734440.14401027783167324575@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173135730484.1734440.14401027783167324575@noble.neil.brown.name>

On Tue, Nov 12, 2024 at 07:35:04AM +1100, NeilBrown wrote:
> On Tue, 12 Nov 2024, Mike Snitzer wrote:
> > On Mon, Nov 11, 2024 at 12:55:24PM +1100, NeilBrown wrote:
> > > On Sat, 09 Nov 2024, Mike Snitzer wrote:
> > > > Remove cl_localio_lock from 'struct nfs_client' in favor of adding a
> > > > lock to the nfs_uuid_t struct (which is embedded in each nfs_client).
> > > > 
> > > > Push nfs_local_{enable,disable} implementation down to nfs_common.
> > > > Those methods now call nfs_localio_{enable,disable}_client.
> > > > 
> > > > This allows implementing nfs_localio_invalidate_clients in terms of
> > > > nfs_localio_disable_client.
> > > > 
> > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > ---
> > > >  fs/nfs/client.c            |  1 -
> > > >  fs/nfs/localio.c           | 18 ++++++------
> > > >  fs/nfs_common/nfslocalio.c | 57 ++++++++++++++++++++++++++------------
> > > >  include/linux/nfs_fs_sb.h  |  1 -
> > > >  include/linux/nfslocalio.h |  8 +++++-
> > > >  5 files changed, 55 insertions(+), 30 deletions(-)
> > > > 
> > > > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > > > index 03ecc7765615..124232054807 100644
> > > > --- a/fs/nfs/client.c
> > > > +++ b/fs/nfs/client.c
> > > > @@ -182,7 +182,6 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
> > > >  	seqlock_init(&clp->cl_boot_lock);
> > > >  	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
> > > >  	nfs_uuid_init(&clp->cl_uuid);
> > > > -	spin_lock_init(&clp->cl_localio_lock);
> > > >  #endif /* CONFIG_NFS_LOCALIO */
> > > >  
> > > >  	clp->cl_principal = "*";
> > > > diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> > > > index cab2a8819259..4c75ffc5efa2 100644
> > > > --- a/fs/nfs/localio.c
> > > > +++ b/fs/nfs/localio.c
> > > > @@ -125,10 +125,8 @@ const struct rpc_program nfslocalio_program = {
> > > >   */
> > > >  static void nfs_local_enable(struct nfs_client *clp)
> > > >  {
> > > > -	spin_lock(&clp->cl_localio_lock);
> > > > -	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> > > >  	trace_nfs_local_enable(clp);
> > > > -	spin_unlock(&clp->cl_localio_lock);
> > > > +	nfs_localio_enable_client(clp);
> > > >  }
> > > 
> > > Why do we need this function?  The one caller could call
> > > nfs_localio_enable_client() directly instead.  The tracepoint could be
> > > placed in that one caller.
> > 
> > Yeah, I saw that too but felt it useful to differentiate between calls
> > that occur during NFS client initialization and those that happen as a
> > side-effect of callers from other contexts (in later patch this
> > manifests as nfs_localio_disable_client vs nfs_local_disable).
> > 
> > Hence my adding secondary tracepoints for nfs_common (see "[PATCH
> > 17/19] nfs_common: add nfs_localio trace events).
> > 
> > But sure, we can just eliminate nfs_local_{enable,disable} and the
> > corresponding tracepoints (which will have moved down to nfs_common).
> 
> I don't feel strongly about this.  If you think these is value in these
> wrapper functions then I won't argue.  As a general rule I don't like
> multiple interfaces that do (much) the same thing as keeping track of
> them increases the mental load.
> 
> > 
> > > >  /*
> > > > @@ -136,12 +134,8 @@ static void nfs_local_enable(struct nfs_client *clp)
> > > >   */
> > > >  void nfs_local_disable(struct nfs_client *clp)
> > > >  {
> > > > -	spin_lock(&clp->cl_localio_lock);
> > > > -	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
> > > > -		trace_nfs_local_disable(clp);
> > > > -		nfs_localio_disable_client(&clp->cl_uuid);
> > > > -	}
> > > > -	spin_unlock(&clp->cl_localio_lock);
> > > > +	trace_nfs_local_disable(clp);
> > > > +	nfs_localio_disable_client(clp);
> > > >  }
> > > 
> > > Ditto.  Though there are more callers so the tracepoint solution isn't
> > > quite so obvious.
> > 
> > Right... as I just explained: that's why I preserved nfs_local_disable
> > (and the tracepoint).
> > 
> > 
> > > >  /*
> > > > @@ -183,8 +177,12 @@ static bool nfs_server_uuid_is_local(struct nfs_client *clp)
> > > >  	rpc_shutdown_client(rpcclient_localio);
> > > >  
> > > >  	/* Server is only local if it initialized required struct members */
> > > > -	if (status || !clp->cl_uuid.net || !clp->cl_uuid.dom)
> > > > +	rcu_read_lock();
> > > > +	if (status || !rcu_access_pointer(clp->cl_uuid.net) || !clp->cl_uuid.dom) {
> > > > +		rcu_read_unlock();
> > > >  		return false;
> > > > +	}
> > > > +	rcu_read_unlock();
> > > 
> > > What value does RCU provide here?  I don't think this change is needed.
> > > rcu_access_pointer does not require rcu_read_lock().
> > 
> > OK, not sure why I though RCU read-side needed for rcu_access_pointer()...
> > 
> > > >  	return true;
> > > >  }
> > > > diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> > > > index 904439e4bb85..cf2f47ea4f8d 100644
> > > > --- a/fs/nfs_common/nfslocalio.c
> > > > +++ b/fs/nfs_common/nfslocalio.c
> > > > @@ -7,6 +7,9 @@
> > > >  #include <linux/module.h>
> > > >  #include <linux/list.h>
> > > >  #include <linux/nfslocalio.h>
> > > > +#include <linux/nfs3.h>
> > > > +#include <linux/nfs4.h>
> > > > +#include <linux/nfs_fs_sb.h>
> > > 
> > > I don't feel good about adding this nfs client knowledge in to nfs_common.
> > 
> > I hear you.. I was "OK with it".
> > 
> > > >  #include <net/netns/generic.h>
> > > >  
> > > >  MODULE_LICENSE("GPL");
> > > > @@ -25,6 +28,7 @@ void nfs_uuid_init(nfs_uuid_t *nfs_uuid)
> > > >  	nfs_uuid->net = NULL;
> > > >  	nfs_uuid->dom = NULL;
> > > >  	INIT_LIST_HEAD(&nfs_uuid->list);
> > > > +	spin_lock_init(&nfs_uuid->lock);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(nfs_uuid_init);
> > > >  
> > > > @@ -94,12 +98,23 @@ void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
> > > >  
> > > > +void nfs_localio_enable_client(struct nfs_client *clp)
> > > > +{
> > > > +	nfs_uuid_t *nfs_uuid = &clp->cl_uuid;
> > > > +
> > > > +	spin_lock(&nfs_uuid->lock);
> > > > +	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> > > > +	spin_unlock(&nfs_uuid->lock);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(nfs_localio_enable_client);
> > > 
> > > And I don't feel good about nfs_local accessing nfs_client directly.
> > > It only uses it for NFS_CS_LOCAL_IO.  Can we ditch that flag and instead
> > > so something like testing nfs_uuid.net ??
> > 
> > That'd probably be OK for the equivalent of NFS_CS_LOCAL_IO but the last
> > patch in this series ("nfs: probe for LOCALIO when v3 client
> > reconnects to server") adds NFS_CS_LOCAL_IO_CAPABLE to provide a hint
> > that the client and server successfully established themselves local
> > via LOCALIO protocol.  This is needed so that NFSv3 (stateless) has a
> > hint that reestablishing LOCALIO needed if/when the client loses
> > connectivity to the server (because it was shutdown and restarted).
> 
> I don't like NFS_CS_LOCAL_IO_CAPABLE.
> A use case that I imagine (and a customer does something like this) is an
> HA cluster where the NFS server can move from one node to another.  All
> the node access the filesystem, most over NFS.  If a server-migration
> happens (e.g.  the current server node failed) then the new server node
> would suddenly become LOCALIO-capable even though it wasn't at
> mount-time.  I would like it to be able to detect this and start doing
> localio.

Server migration while retaining the client being local to the new
server?  So client migrates too?

If the client migrates then it will negotiate with server using
LOCALIO protocol.

Anyway, this HA hypothetical feels contrived.  It is fine that you
dislike NFS_CS_LOCAL_IO_CAPABLE but I don't understand what you'd like
as an alternative.  Or why the simplicity in my approach lacking.

> So I don't want NFS_CS_LOCAL_IO_CAPABLE.  I think tracking when the
> network connection is re-established is sufficient.

Eh, that type of tracking doesn't really buy me anything if I've lost
context (that LOCALIO was previously established and should be
re-established).

NFS v3 is stateless, hence my hooking off read and write paths to
trigger nfs_local_probe_async().  Unlike NFS v4, with its grace, more
care is needed to avoid needless calls to nfs_local_probe_async().

Your previous email about just tracking network connection change was
an optimization for avoiding repeat (pointless) probes.  We still
need to know to do the probe to begin with.  Are you saying you want
to backfill the equivalent of grace (or pseudo-grace) to NFSv3?

My approach works.  Not following what you are saying will be better.

Thanks,
Mike

