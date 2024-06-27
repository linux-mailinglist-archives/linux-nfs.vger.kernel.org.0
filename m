Return-Path: <linux-nfs+bounces-4371-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5442D91ADB6
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 19:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793731C25ED5
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D8719A29E;
	Thu, 27 Jun 2024 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHYRG2qV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467619A2AA
	for <linux-nfs@vger.kernel.org>; Thu, 27 Jun 2024 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508446; cv=none; b=bpNgjmFP2NX1WGe3kMH58Jmp3MhfCZWdNt/k4dofOPitc8rX07p/SOn+CpX7SeHM8ZQN9bdVE4TdzyVVja5jGjuyKUQDn0k/8qXe2qHvTrPDqagsXXq5a0BYoF/ZgER9tS4oxhKA+IPNBM5uFczyngyiJqteLWlfZzQ71J8yQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508446; c=relaxed/simple;
	bh=DDJsh89jV6X8Qhj43cVdqEkjMmPUZqOsIy4Sfa9TFpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRxXl4YvehxQHt91/D8H7WisJW+KavKwxXvwlpg2zz8AyhIoRyGMc+2N3ddSGN0yAhZlw6qxFk+wr1ZzJhJK1zc+13nf83pkXDEd2QHBY2eSYG1IxEQpmiwTePjgwlMZXopXsdyAlwZgJEzghoOLlZhqoRQ+Agbwrw/dxI60zTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHYRG2qV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD855C4AF0A;
	Thu, 27 Jun 2024 17:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719508446;
	bh=DDJsh89jV6X8Qhj43cVdqEkjMmPUZqOsIy4Sfa9TFpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHYRG2qVx4S0zlac9Xm6uVdNSxfVWe6rfGBCyTvYT7/ZhppS2fIJ1THLwYYX5IyV2
	 nanIXG58UnvNsVt2KF/V7gesZuG7FZKNTBzLBlobKLXWI6C0LpkjVCmrHCu/j0EnTC
	 ADOnBOXtdcKqUZxpAseP9PjM7TAdpGJpGRNbmEKBV/r73fWhsnAJefsnuOOFXo0gDQ
	 NGkgY3idbNu/HI1rOY1ypWyS7U6yMtxAJ8O5/RGEXpaqaTypc5g/cdylqxVMDYmH+9
	 S1rJVot8gX8wqTMMN5qw01ecPaZ32HxM4hxDrXcHSmmvLdVg1zH4bK1QbJYBloCybu
	 ggHHV8dsrLAdw==
Date: Thu, 27 Jun 2024 13:14:04 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, snitzer@hammerspace.com
Subject: Re: [PATCH v8 09/18] nfsd: use percpu_ref to interlock
 nfsd_destroy_serv and nfsd_open_local_fh
Message-ID: <Zn2d3L-JMZ1snvPH@kernel.org>
References: <20240626182438.69539-1-snitzer@kernel.org>
 <20240626182438.69539-10-snitzer@kernel.org>
 <bf414725b1ee06a03f766a2b1c976b71161570a2.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf414725b1ee06a03f766a2b1c976b71161570a2.camel@kernel.org>

On Thu, Jun 27, 2024 at 07:24:54AM -0400, Jeff Layton wrote:
> On Wed, 2024-06-26 at 14:24 -0400, Mike Snitzer wrote:
> > Introduce nfsd_serv_get and nfsd_serv_put and update the nfsd code to
> > prevent nfsd_destroy_serv from destroying nn->nfsd_serv until any
> > client initiated localio calls to nfsd (that are _not_ in the context
> > of nfsd) are complete.
> > 
> > nfsd_open_local_fh is updated to nfsd_serv_get before opening its file
> > handle and then drop the reference using nfsd_serv_put at the end of
> > nfsd_open_local_fh.
> > 
> > This "interlock" working relies heavily on nfsd_open_local_fh()'s
> > maybe_get_net() safely dealing with the possibility that the struct
> > net (and nfsd_net by association) may have been destroyed by
> > nfsd_destroy_serv() via nfsd_shutdown_net().
> > 
> > Verified to fix an easy to hit crash that would occur if an nfsd
> > instance running in a container, with a localio client mounted, is
> > shutdown. Upon restart of the container and associated nfsd the client
> > would go on to crash due to NULL pointer dereference that occuured due
> > to the nfs client's localio attempting to nfsd_open_local_fh(), using
> > nn->nfsd_serv, without having a proper reference on nn->nfsd_serv.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/localio.c |  2 ++
> >  fs/nfsd/netns.h   |  8 +++++++-
> >  fs/nfsd/nfssvc.c  | 39 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 48 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > index 48118db801b5..819589ae2008 100644
> > --- a/fs/nfsd/localio.c
> > +++ b/fs/nfsd/localio.c
> > @@ -204,6 +204,7 @@ int nfsd_open_local_fh(struct net *net,
> >  	}
> >  	nn = net_generic(net, nfsd_net_id);
> >  
> > +	nfsd_serv_get(nn);
> >  	serv = READ_ONCE(nn->nfsd_serv);
> >  	if (unlikely(!serv)) {
> >  		dprintk("%s: localio denied. Server not running\n", __func__);
> > @@ -244,6 +245,7 @@ int nfsd_open_local_fh(struct net *net,
> >  out_revertcred:
> >  	revert_creds(save_cred);
> >  out_net:
> > +	nfsd_serv_put(nn);
> >  	put_net(net);
> >  	return status;
> >  }
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index 0c5a1d97e4ac..17a73c780ca1 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -13,6 +13,7 @@
> >  #include <linux/filelock.h>
> >  #include <linux/nfs4.h>
> >  #include <linux/percpu_counter.h>
> > +#include <linux/percpu-refcount.h>
> >  #include <linux/siphash.h>
> >  #include <linux/sunrpc/stats.h>
> >  #include <linux/nfslocalio.h>
> > @@ -140,7 +141,9 @@ struct nfsd_net {
> >  
> >  	struct svc_info nfsd_info;
> >  #define nfsd_serv nfsd_info.serv
> > -
> > +	struct percpu_ref nfsd_serv_ref;
> > +	struct completion nfsd_serv_confirm_done;
> > +	struct completion nfsd_serv_free_done;
> >  
> >  	/*
> >  	 * clientid and stateid data for construction of net unique COPY
> > @@ -225,6 +228,9 @@ struct nfsd_net {
> >  extern bool nfsd_support_version(int vers);
> >  extern void nfsd_netns_free_versions(struct nfsd_net *nn);
> >  
> > +void nfsd_serv_get(struct nfsd_net *nn);
> > +void nfsd_serv_put(struct nfsd_net *nn);
> > +
> >  extern unsigned int nfsd_net_id;
> >  
> >  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index a477d2c5088a..be5acb7a4057 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -258,6 +258,30 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
> >  	return 0;
> >  }
> >  
> > +void nfsd_serv_get(struct nfsd_net *nn)
> > +{
> > +	percpu_ref_get(&nn->nfsd_serv_ref);
> > +}
> > +
> > +void nfsd_serv_put(struct nfsd_net *nn)
> > +{
> > +	percpu_ref_put(&nn->nfsd_serv_ref);
> > +}
> > +
> > +static void nfsd_serv_done(struct percpu_ref *ref)
> > +{
> > +	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
> > +
> > +	complete(&nn->nfsd_serv_confirm_done);
> > +}
> > +
> > +static void nfsd_serv_free(struct percpu_ref *ref)
> > +{
> > +	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
> > +
> > +	complete(&nn->nfsd_serv_free_done);
> > +}
> > +
> >  /*
> >   * Maximum number of nfsd processes
> >   */
> > @@ -462,6 +486,7 @@ static void nfsd_shutdown_net(struct net *net)
> >  		lockd_down(net);
> >  		nn->lockd_up = false;
> >  	}
> > +	percpu_ref_exit(&nn->nfsd_serv_ref);
> >  #if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> >  	list_del_rcu(&nn->nfsd_uuid.list);
> >  #endif
> > @@ -544,6 +569,13 @@ void nfsd_destroy_serv(struct net *net)
> >  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> >  	struct svc_serv *serv = nn->nfsd_serv;
> >  
> > +	lockdep_assert_held(&nfsd_mutex);
> > +
> > +	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref, nfsd_serv_done);
> > +	wait_for_completion(&nn->nfsd_serv_confirm_done);
> > +	wait_for_completion(&nn->nfsd_serv_free_done);
> > +	/* percpu_ref_exit is called in nfsd_shutdown_net */
> > +
> 
> At this point where you're waiting on these completion vars, what stops
> the client from issuing new localio requests?

The server going down.  The interlock is with nfsd_open_local_fh, so
once any active file opens complete the server will get these
completions and the server will go down.  The client will reconnect
if/when the server comes back up.

Maybe I'm not imaginative enough, but is there risk of never-ending
overlapping file opens that prevent nfsd_destroy_serv() from
progressing?

Mike

