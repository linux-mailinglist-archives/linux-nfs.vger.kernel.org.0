Return-Path: <linux-nfs+bounces-5222-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F0B94651A
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Aug 2024 23:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2433C281764
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Aug 2024 21:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F00C481AB;
	Fri,  2 Aug 2024 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imCwwzg9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB451396
	for <linux-nfs@vger.kernel.org>; Fri,  2 Aug 2024 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634483; cv=none; b=XzY2MkrQWpmK3K7HI+1NwbQoWzTU3523wMbOuXFSrkbiSdLag0N+hCs8o+z+XGsKi8MTJgZq45SSCuRs2quB0s1pxsJiDXQNWmH/NWM/mRLKBsQ2tBVTeYA5rhuC0Tywk6Cx80IV4TnMC2oIs2f9HmipPW+7ry3KbfFQKpS+wM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634483; c=relaxed/simple;
	bh=zSwgWDdv8vviMsEYv/8BO4CIfw7J/0Dxq8nsQkNWPpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lO8rG/0/7v9b/i9Bka1PW62RDuqcX8gcsyhxDAy9sKCztmXxgibQsumKzrEX1Uy3Ky3dNGWXhi4NF7aVrb22fzsClD0b71y2S5M8iQsmFcH94wrWsIeT57J0FwijY8TkVU344CJLr8MAdHLkgqXhMM6VAMwQE2rJRcO+cR5VaBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imCwwzg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D3EC4AF09;
	Fri,  2 Aug 2024 21:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722634482;
	bh=zSwgWDdv8vviMsEYv/8BO4CIfw7J/0Dxq8nsQkNWPpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imCwwzg93AtV7CZUh8fsMxiZ38Y8LtDkSgAkL9NBjE1jZ5urA8BzXO68I58IFUefa
	 aX8uPtE/mDhU8pilgYB3XdRrssXF2o5HvInFuhQjhXa6ySb3ORP6TRLPWmYzYWVggx
	 x/btd8Y6pwRvLMmwYZ7whcBCgaiZfPHC/knp/f2IU3762nQX5h1Inpx4K7p8i8srZC
	 kXkFOIYgnTS6dyTuvtWUQEbiN0BSNZ+4PwVqdqmEZmI3843qhGEmYC5hdNO7hZXBqJ
	 a48ns11qU/gUsIoG9oWEEljRd4mxghBiPXk25rEHpX8E9jGjJzYbvIQkhw7B5lMxq9
	 kIEcQKLchm0Mw==
Date: Fri, 2 Aug 2024 17:34:41 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: Re: [PATCH 04/14] nfsd: don't allocate the versions array.
Message-ID: <Zq1Q8f1Dslc2Cvjo@kernel.org>
References: <20240715074657.18174-1-neilb@suse.de>
 <20240715074657.18174-5-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715074657.18174-5-neilb@suse.de>

On Mon, Jul 15, 2024 at 05:14:17PM +1000, NeilBrown wrote:
> Instead of using kmalloc to allocate an array for storing active version
> info, just declare and array to the max size - it is only 5 or so.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfs/nfs4state.c |   2 +
>  fs/nfsd/cache.h    |   2 +-
>  fs/nfsd/netns.h    |   6 +--
>  fs/nfsd/nfsctl.c   |  10 +++--
>  fs/nfsd/nfsd.h     |   9 +++-
>  fs/nfsd/nfssvc.c   | 100 ++++++++-------------------------------------
>  6 files changed, 36 insertions(+), 93 deletions(-)
> 
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 5b452411e8fd..68c663626480 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -1953,6 +1953,8 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
>  				if (lost_locks)
>  					pr_warn("NFS: %s: lost %d locks\n",
>  						clp->cl_hostname, lost_locks);
> +				nfs4_free_state_owners(&freeme);
> +
>  				set_bit(ops->owner_flag_bit, &sp->so_flags);
>  				nfs4_put_state_owner(sp);
>  				status = nfs4_recovery_handle_error(clp, status);

Hey Neil,

This call to nfs4_free_state_owners() feels out of place given the
rest of this patch.  Was it meant to be folded into a different
patch?

Thanks,
Mike


> diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
> index 66a05fefae98..bb7addef4a31 100644
> --- a/fs/nfsd/cache.h
> +++ b/fs/nfsd/cache.h
> @@ -10,7 +10,7 @@
>  #define NFSCACHE_H
>  
>  #include <linux/sunrpc/svc.h>
> -#include "netns.h"
> +#include "nfsd.h"
>  
>  /*
>   * Representation of a reply cache entry.
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 14ec15656320..238fc4e56e53 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -152,8 +152,8 @@ struct nfsd_net {
>  	/*
>  	 * Version information
>  	 */
> -	bool *nfsd_versions;
> -	bool *nfsd4_minorversions;
> +	bool nfsd_versions[NFSD_MAXVERS + 1];
> +	bool nfsd4_minorversions[NFSD_SUPPORTED_MINOR_VERSION + 1];
>  
>  	/*
>  	 * Duplicate reply cache
> @@ -219,8 +219,6 @@ struct nfsd_net {
>  #define nfsd_netns_ready(nn) ((nn)->sessionid_hashtbl)
>  
>  extern bool nfsd_support_version(int vers);
> -extern void nfsd_netns_free_versions(struct nfsd_net *nn);
> -
>  extern unsigned int nfsd_net_id;
>  
>  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 9b47723fc110..5b0f2e0d7ccf 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2232,8 +2232,9 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info)
>   */
>  static __net_init int nfsd_net_init(struct net *net)
>  {
> -	int retval;
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	int retval;
> +	int i;
>  
>  	retval = nfsd_export_init(net);
>  	if (retval)
> @@ -2247,8 +2248,10 @@ static __net_init int nfsd_net_init(struct net *net)
>  		goto out_repcache_error;
>  	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
>  	nn->nfsd_svcstats.program = &nfsd_program;
> -	nn->nfsd_versions = NULL;
> -	nn->nfsd4_minorversions = NULL;
> +	for (i = 0; i < sizeof(nn->nfsd_versions); i++)
> +		nn->nfsd_versions[i] = nfsd_support_version(i);
> +	for (i = 0; i < sizeof(nn->nfsd4_minorversions); i++)
> +		nn->nfsd4_minorversions[i] = nfsd_support_version(4);
>  	nn->nfsd_info.mutex = &nfsd_mutex;
>  	nn->nfsd_serv = NULL;
>  	nfsd4_init_leases_net(nn);
> @@ -2279,7 +2282,6 @@ static __net_exit void nfsd_net_exit(struct net *net)
>  	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>  	nfsd_idmap_shutdown(net);
>  	nfsd_export_shutdown(net);
> -	nfsd_netns_free_versions(nn);
>  }
>  
>  static struct pernet_operations nfsd_net_ops = {
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 39e109a7d56d..369c3b3ce53e 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -23,9 +23,7 @@
>  
>  #include <uapi/linux/nfsd/debug.h>
>  
> -#include "netns.h"
>  #include "export.h"
> -#include "stats.h"
>  
>  #undef ifdebug
>  #ifdef CONFIG_SUNRPC_DEBUG
> @@ -37,7 +35,14 @@
>  /*
>   * nfsd version
>   */
> +#define NFSD_MINVERS			2
> +#define	NFSD_MAXVERS			4
>  #define NFSD_SUPPORTED_MINOR_VERSION	2
> +bool nfsd_support_version(int vers);
> +
> +#include "netns.h"
> +#include "stats.h"
> +
>  /*
>   * Maximum blocksizes supported by daemon under various circumstances.
>   */
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index f25b26bc5670..4438cdcd4873 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -116,15 +116,12 @@ static const struct svc_version *nfsd_version[] = {
>  #endif
>  };
>  
> -#define NFSD_MINVERS    	2
> -#define NFSD_NRVERS		ARRAY_SIZE(nfsd_version)
> -
>  struct svc_program		nfsd_program = {
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>  	.pg_next		= &nfsd_acl_program,
>  #endif
>  	.pg_prog		= NFS_PROGRAM,		/* program number */
> -	.pg_nvers		= NFSD_NRVERS,		/* nr of entries in nfsd_version */
> +	.pg_nvers		= NFSD_MAXVERS+1,	/* nr of entries in nfsd_version */
>  	.pg_vers		= nfsd_version,		/* version table */
>  	.pg_name		= "nfsd",		/* program name */
>  	.pg_class		= "nfsd",		/* authentication class */
> @@ -135,78 +132,24 @@ struct svc_program		nfsd_program = {
>  
>  bool nfsd_support_version(int vers)
>  {
> -	if (vers >= NFSD_MINVERS && vers < NFSD_NRVERS)
> +	if (vers >= NFSD_MINVERS && vers <= NFSD_MAXVERS)
>  		return nfsd_version[vers] != NULL;
>  	return false;
>  }
>  
> -static bool *
> -nfsd_alloc_versions(void)
> -{
> -	bool *vers = kmalloc_array(NFSD_NRVERS, sizeof(bool), GFP_KERNEL);
> -	unsigned i;
> -
> -	if (vers) {
> -		/* All compiled versions are enabled by default */
> -		for (i = 0; i < NFSD_NRVERS; i++)
> -			vers[i] = nfsd_support_version(i);
> -	}
> -	return vers;
> -}
> -
> -static bool *
> -nfsd_alloc_minorversions(void)
> -{
> -	bool *vers = kmalloc_array(NFSD_SUPPORTED_MINOR_VERSION + 1,
> -			sizeof(bool), GFP_KERNEL);
> -	unsigned i;
> -
> -	if (vers) {
> -		/* All minor versions are enabled by default */
> -		for (i = 0; i <= NFSD_SUPPORTED_MINOR_VERSION; i++)
> -			vers[i] = nfsd_support_version(4);
> -	}
> -	return vers;
> -}
> -
> -void
> -nfsd_netns_free_versions(struct nfsd_net *nn)
> -{
> -	kfree(nn->nfsd_versions);
> -	kfree(nn->nfsd4_minorversions);
> -	nn->nfsd_versions = NULL;
> -	nn->nfsd4_minorversions = NULL;
> -}
> -
> -static void
> -nfsd_netns_init_versions(struct nfsd_net *nn)
> -{
> -	if (!nn->nfsd_versions) {
> -		nn->nfsd_versions = nfsd_alloc_versions();
> -		nn->nfsd4_minorversions = nfsd_alloc_minorversions();
> -		if (!nn->nfsd_versions || !nn->nfsd4_minorversions)
> -			nfsd_netns_free_versions(nn);
> -	}
> -}
> -
>  int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change)
>  {
> -	if (vers < NFSD_MINVERS || vers >= NFSD_NRVERS)
> +	if (vers < NFSD_MINVERS || vers > NFSD_MAXVERS)
>  		return 0;
>  	switch(change) {
>  	case NFSD_SET:
> -		if (nn->nfsd_versions)
> -			nn->nfsd_versions[vers] = nfsd_support_version(vers);
> +		nn->nfsd_versions[vers] = nfsd_support_version(vers);
>  		break;
>  	case NFSD_CLEAR:
> -		nfsd_netns_init_versions(nn);
> -		if (nn->nfsd_versions)
> -			nn->nfsd_versions[vers] = false;
> +		nn->nfsd_versions[vers] = false;
>  		break;
>  	case NFSD_TEST:
> -		if (nn->nfsd_versions)
> -			return nn->nfsd_versions[vers];
> -		fallthrough;
> +		return nn->nfsd_versions[vers];
>  	case NFSD_AVAIL:
>  		return nfsd_support_version(vers);
>  	}
> @@ -233,23 +176,16 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
>  
>  	switch(change) {
>  	case NFSD_SET:
> -		if (nn->nfsd4_minorversions) {
> -			nfsd_vers(nn, 4, NFSD_SET);
> -			nn->nfsd4_minorversions[minorversion] =
> -				nfsd_vers(nn, 4, NFSD_TEST);
> -		}
> +		nfsd_vers(nn, 4, NFSD_SET);
> +		nn->nfsd4_minorversions[minorversion] =
> +			nfsd_vers(nn, 4, NFSD_TEST);
>  		break;
>  	case NFSD_CLEAR:
> -		nfsd_netns_init_versions(nn);
> -		if (nn->nfsd4_minorversions) {
> -			nn->nfsd4_minorversions[minorversion] = false;
> -			nfsd_adjust_nfsd_versions4(nn);
> -		}
> +		nn->nfsd4_minorversions[minorversion] = false;
> +		nfsd_adjust_nfsd_versions4(nn);
>  		break;
>  	case NFSD_TEST:
> -		if (nn->nfsd4_minorversions)
> -			return nn->nfsd4_minorversions[minorversion];
> -		return nfsd_vers(nn, 4, NFSD_TEST);
> +		return nn->nfsd4_minorversions[minorversion];
>  	case NFSD_AVAIL:
>  		return minorversion <= NFSD_SUPPORTED_MINOR_VERSION &&
>  			nfsd_vers(nn, 4, NFSD_AVAIL);
> @@ -568,11 +504,11 @@ void nfsd_reset_versions(struct nfsd_net *nn)
>  {
>  	int i;
>  
> -	for (i = 0; i < NFSD_NRVERS; i++)
> +	for (i = 0; i <= NFSD_MAXVERS; i++)
>  		if (nfsd_vers(nn, i, NFSD_TEST))
>  			return;
>  
> -	for (i = 0; i < NFSD_NRVERS; i++)
> +	for (i = 0; i <= NFSD_MAXVERS; i++)
>  		if (i != 4)
>  			nfsd_vers(nn, i, NFSD_SET);
>  		else {
> @@ -905,17 +841,17 @@ nfsd_init_request(struct svc_rqst *rqstp,
>  	if (likely(nfsd_vers(nn, rqstp->rq_vers, NFSD_TEST)))
>  		return svc_generic_init_request(rqstp, progp, ret);
>  
> -	ret->mismatch.lovers = NFSD_NRVERS;
> -	for (i = NFSD_MINVERS; i < NFSD_NRVERS; i++) {
> +	ret->mismatch.lovers = NFSD_MAXVERS + 1;
> +	for (i = NFSD_MINVERS; i <= NFSD_MAXVERS; i++) {
>  		if (nfsd_vers(nn, i, NFSD_TEST)) {
>  			ret->mismatch.lovers = i;
>  			break;
>  		}
>  	}
> -	if (ret->mismatch.lovers == NFSD_NRVERS)
> +	if (ret->mismatch.lovers > NFSD_MAXVERS)
>  		return rpc_prog_unavail;
>  	ret->mismatch.hivers = NFSD_MINVERS;
> -	for (i = NFSD_NRVERS - 1; i >= NFSD_MINVERS; i--) {
> +	for (i = NFSD_MAXVERS; i >= NFSD_MINVERS; i--) {
>  		if (nfsd_vers(nn, i, NFSD_TEST)) {
>  			ret->mismatch.hivers = i;
>  			break;
> -- 
> 2.44.0
> 
> 

