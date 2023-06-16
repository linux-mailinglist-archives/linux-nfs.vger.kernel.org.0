Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E019733AC8
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jun 2023 22:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjFPU10 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Jun 2023 16:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjFPU1Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Jun 2023 16:27:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B73A82;
        Fri, 16 Jun 2023 13:27:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F147D6325B;
        Fri, 16 Jun 2023 20:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4C6C433CA;
        Fri, 16 Jun 2023 20:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686947242;
        bh=plXJiqvgKkOVdiaa7vvfF88BboasQSb668iEyQIZC1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alXKApDh90s8xLc047aLm94D3eEm5j24keQKaObyqUsdhhXzdxVtAqGUGEIGLptGu
         1UfbtNPdFKMvw0PL6FmNtX0rPZVwTbM9c4cYJzWH7reX1SowOPPCG2dlAa4S8iGLO8
         6pjX2Wk36NJOyRLKTkyzjdg7oOB6tvd8Q/pKtabCCZZsZl4eFV7MeEz/Qya+TdLg1I
         oZA1sZjMaZ9Ff3K5a0ar0jDcBLzwwiTuTZcnNSfPvIavXQejSk8brbPSSBAfW/sL0L
         wZVqv3Ia8+S8Cqhq/8M9JdQl9yJ2wWsRHPHLF5Lb4DnzD+d++l9B5Zwufo+I45Q5+P
         Wvi8OLUA39b/A==
Date:   Fri, 16 Jun 2023 16:27:19 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        stable@vger.kernel.org, Eirik Fuller <efuller@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: move init of percpu reply_cache_stats counters
 back to nfsd_init_net
Message-ID: <ZIzFp3ViiU2SCi6J@manet.1015granger.net>
References: <20230616191744.202292-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616191744.202292-1-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks Eirik and Jeff.

At this point in the release cycle, I plan to apply this for the
next merge window (6.5).

A few cosmetic remarks below. I can take this as-is and make
adjustments, or you can redrive. Just let me know.


On Fri, Jun 16, 2023 at 03:17:43PM -0400, Jeff Layton wrote:
> f5f9d4a314da moved the initialization of the reply cache into the nfsd
> startup, but it didn't account for the stats counters which can be
> accessed before nfsd is ever started, causing a NULL pointer
> dereference.
> 
> This is easy to trigger on some arches (like aarch64), but on x86_64,
> calling this_cpu_ptr(NULL) evidently returns a pointer to the
> fixed_percpu_data, which I guess this looks just enough like a newly
> initialized percpu var to allow nfsd_reply_cache_stats_show to access it
> without Oopsing.
> 
> Move the initialization of the per-net+per-cpu reply-cache counters back
> into nfsd_init_net, while leaving the rest of the reply cache
> allocations to be done at nfsd startup time.
> 
> Kudos to Eirik who did most of the legwork to track this down.
> 
> Cc: stable@vger.kernel.org # v6.3+
> Fixes: f5f9d4a314da ("nfsd: move reply cache initialization into nfsd startup")

Why both Fixes: and Cc: stable?


> Reported-and-Tested-by: Eirik Fuller <efuller@redhat.com>

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2215429  ?


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/cache.h    |  2 ++
>  fs/nfsd/nfscache.c | 13 +++----------
>  fs/nfsd/nfsctl.c   |  8 ++++++++
>  3 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
> index f21259ead64b..a4b12d6c41d3 100644
> --- a/fs/nfsd/cache.h
> +++ b/fs/nfsd/cache.h
> @@ -80,6 +80,8 @@ enum {
>  
>  int	nfsd_drc_slab_create(void);
>  void	nfsd_drc_slab_free(void);
> +int	nfsd_reply_cache_stats_init(struct nfsd_net *nn);
> +void	nfsd_reply_cache_stats_destroy(struct nfsd_net *nn);
>  int	nfsd_reply_cache_init(struct nfsd_net *);
>  void	nfsd_reply_cache_shutdown(struct nfsd_net *);
>  int	nfsd_cache_lookup(struct svc_rqst *);
> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> index 041faa13b852..b696dc629c0b 100644
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -148,12 +148,12 @@ void nfsd_drc_slab_free(void)
>  	kmem_cache_destroy(drc_slab);
>  }
>  
> -static int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
> +int nfsd_reply_cache_stats_init(struct nfsd_net *nn)

As part of making these two functions into a more public API, I
would prefer to rename this nfsd_net_reply_cache_init(), and it
should include a KDOC comment out front.

I'm having some trouble easily distinguishing between the purpose of

   static __net_init int nfsd_init_net(struct net *net)

and

   static int nfsd_startup_net(struct net *net, const struct cred *cred)

The former is invoked when a net namespace is created. The latter is
called by write_threads, therefore /proc/fs/nfsd/ must already be
mounted.

The function names are confusingly similar and there's no KDOC to be
found. I might add a clean-up patch to this one.

>  {
>  	return nfsd_percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM);
>  }
>  
> -static void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
> +void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)

Ditto, rename this nfsd_net_reply_cache_destroy(), plus KDOC.


>  {
>  	nfsd_percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
>  }
> @@ -169,17 +169,13 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
>  	hashsize = nfsd_hashsize(nn->max_drc_entries);
>  	nn->maskbits = ilog2(hashsize);
>  
> -	status = nfsd_reply_cache_stats_init(nn);
> -	if (status)
> -		goto out_nomem;
> -
>  	nn->nfsd_reply_cache_shrinker.scan_objects = nfsd_reply_cache_scan;
>  	nn->nfsd_reply_cache_shrinker.count_objects = nfsd_reply_cache_count;
>  	nn->nfsd_reply_cache_shrinker.seeks = 1;
>  	status = register_shrinker(&nn->nfsd_reply_cache_shrinker,
>  				   "nfsd-reply:%s", nn->nfsd_name);
>  	if (status)
> -		goto out_stats_destroy;
> +		return status;
>  
>  	nn->drc_hashtbl = kvzalloc(array_size(hashsize,
>  				sizeof(*nn->drc_hashtbl)), GFP_KERNEL);
> @@ -195,9 +191,6 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
>  	return 0;
>  out_shrinker:
>  	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
> -out_stats_destroy:
> -	nfsd_reply_cache_stats_destroy(nn);
> -out_nomem:
>  	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
>  	return -ENOMEM;
>  }
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 1489e0b703b4..7c837afcf615 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1505,6 +1505,9 @@ static __net_init int nfsd_init_net(struct net *net)
>  	retval = nfsd_idmap_init(net);
>  	if (retval)
>  		goto out_idmap_error;
> +	retval = nfsd_reply_cache_stats_init(nn);
> +	if (retval)
> +		goto out_repcache_error;
>  	nn->nfsd_versions = NULL;
>  	nn->nfsd4_minorversions = NULL;
>  	nfsd4_init_leases_net(nn);
> @@ -1513,6 +1516,8 @@ static __net_init int nfsd_init_net(struct net *net)
>  
>  	return 0;
>  
> +out_repcache_error:
> +	nfsd_idmap_shutdown(net);
>  out_idmap_error:
>  	nfsd_export_shutdown(net);
>  out_export_error:
> @@ -1521,6 +1526,9 @@ static __net_init int nfsd_init_net(struct net *net)
>  
>  static __net_exit void nfsd_exit_net(struct net *net)
>  {
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +
> +	nfsd_reply_cache_stats_destroy(nn);
>  	nfsd_idmap_shutdown(net);
>  	nfsd_export_shutdown(net);
>  	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));

We should update this nfsd_netns_free_versions() call site to take
the new @nn variable.


> -- 
> 2.40.1
> 
