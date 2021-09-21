Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BE0413D79
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 00:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbhIUWW7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Sep 2021 18:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbhIUWWw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Sep 2021 18:22:52 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85635C061756
        for <linux-nfs@vger.kernel.org>; Tue, 21 Sep 2021 15:21:23 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 59AD96CEE; Tue, 21 Sep 2021 18:21:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 59AD96CEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632262882;
        bh=jDGWOkND7U+j7YpEeD+9vc0mkdx50GQgg2Uw/Lrw9wM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F0diXBawWTQ9aLu7dG3AULjtAZuMW2D1YZB9+a+f3OhiT4UqVAfHncYWgIKNB9Suw
         C0KQXqmgtSl3YKsyJnHzRSdRt5PKP+4TQ7EFJIcBlGVhat3a7OVn9tLI54x7HSTgtV
         tysDjZ4Mj6hJ83x2ZD36OHvqR5wha/PBevWj43aM=
Date:   Tue, 21 Sep 2021 18:21:22 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC] NFSD: Optimize DRC bucket pruning
Message-ID: <20210921222122.GE21704@fieldses.org>
References: <163216587593.1058.15663218635528093628.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163216587593.1058.15663218635528093628.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 20, 2021 at 03:25:21PM -0400, Chuck Lever wrote:
> DRC bucket pruning is done by nfsd_cache_lookup(), which is part of
> every NFSv2 and NFSv3 dispatch (ie, it's done while the client is
> waiting).
> 
> I added a trace_printk() in prune_bucket() to see just how long
> it takes to prune. Here are two ends of the spectrum:
> 
>  prune_bucket: Scanned 1 and freed 0 in 90 ns, 62 entries remaining
>  prune_bucket: Scanned 2 and freed 1 in 716 ns, 63 entries remaining
> ...
>  prune_bucket: Scanned 75 and freed 74 in 34149 ns, 1 entries remaining

So how do we end up with so many to prune at once if we're pruning every
time we add a new item?

Oh, I guess they must all have about the same expiry time, so they all
became eligible for pruning at the same time.

> Pruning latency is noticeable on fast transports with fast storage.
> By noticeable, I mean that the latency measured here in the worst
> case is the same order of magnitude as the round trip time for
> cached server operations.
> 
> We could do something like moving expired entries to an expired list
> and then free them later instead of freeing them right in
> prune_bucket(). But simply limiting the number of entries that can
> be pruned by a lookup is simple and retains more entries in the
> cache, making the DRC somewhat more effective.

And when there's a bunch of expired entries to prune I guess it makes
sense that stopping at pruning 3 for each one you add will still keep
the DRC size under control.

Anyway, looks simple and makes sense to me; applying.

--b.

> 
> Comparison with a 70/30 fio 8KB 12 thread direct I/O test:
> 
> 
> Before:
> 
>   write: IOPS=61.6k, BW=481MiB/s (505MB/s)(14.1GiB/30001msec); 0 zone resets
> 
> WRITE:
> 	1848726 ops (30%)
> 	avg bytes sent per op: 8340 avg bytes received per op: 136
> 	backlog wait: 0.635158 	RTT: 0.128525 	total execute time: 0.827242 (milliseconds)
> 
> 
> After:
> 
>   write: IOPS=63.0k, BW=492MiB/s (516MB/s)(14.4GiB/30001msec); 0 zone resets
> 
> WRITE:
> 	1891144 ops (30%)
> 	avg bytes sent per op: 8340 avg bytes received per op: 136
> 	backlog wait: 0.616114 	RTT: 0.126842 	total execute time: 0.805348 (milliseconds)
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfscache.c |   17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> index 96cdf77925f3..6e0b6f3148dc 100644
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -241,8 +241,8 @@ lru_put_end(struct nfsd_drc_bucket *b, struct svc_cacherep *rp)
>  	list_move_tail(&rp->c_lru, &b->lru_head);
>  }
>  
> -static long
> -prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn)
> +static long prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn,
> +			 unsigned int max)
>  {
>  	struct svc_cacherep *rp, *tmp;
>  	long freed = 0;
> @@ -258,11 +258,17 @@ prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn)
>  		    time_before(jiffies, rp->c_timestamp + RC_EXPIRE))
>  			break;
>  		nfsd_reply_cache_free_locked(b, rp, nn);
> -		freed++;
> +		if (max && freed++ > max)
> +			break;
>  	}
>  	return freed;
>  }
>  
> +static long nfsd_prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn)
> +{
> +	return prune_bucket(b, nn, 3);
> +}
> +
>  /*
>   * Walk the LRU list and prune off entries that are older than RC_EXPIRE.
>   * Also prune the oldest ones when the total exceeds the max number of entries.
> @@ -279,7 +285,7 @@ prune_cache_entries(struct nfsd_net *nn)
>  		if (list_empty(&b->lru_head))
>  			continue;
>  		spin_lock(&b->cache_lock);
> -		freed += prune_bucket(b, nn);
> +		freed += prune_bucket(b, nn, 0);
>  		spin_unlock(&b->cache_lock);
>  	}
>  	return freed;
> @@ -453,8 +459,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
>  	atomic_inc(&nn->num_drc_entries);
>  	nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
>  
> -	/* go ahead and prune the cache */
> -	prune_bucket(b, nn);
> +	nfsd_prune_bucket(b, nn);
>  
>  out_unlock:
>  	spin_unlock(&b->cache_lock);
> 
