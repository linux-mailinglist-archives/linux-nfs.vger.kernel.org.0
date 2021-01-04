Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCA82E9FB0
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 22:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbhADV4N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 16:56:13 -0500
Received: from fieldses.org ([173.255.197.46]:49204 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbhADV4N (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 Jan 2021 16:56:13 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id E43686E99; Mon,  4 Jan 2021 16:55:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E43686E99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1609797328;
        bh=ZLasn6lWDIYMEP+JqCqbB9Bb/FzzK0LGCXLZQg0y7MU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wKaTkhhRn98cq8WxIAoSRTvVPNzjItCjbpY54OPM/ftFd7vWWKT7vfzevE/c400QU
         1PJQS6tsob/efMW5G7J7PAdnWSOfJPjOzk7FG6Gou6cLxlxPUbA6Ciu0BfmYYyvU5m
         6kM41OrP0Mz+J6iPdjsNTGlrLcgccxf+VO5YzbCA=
Date:   Mon, 4 Jan 2021 16:55:28 -0500
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@poochiereds.net>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] nfsd: protect concurrent access to nfsd stats
 counters
Message-ID: <20210104215528.GA27763@fieldses.org>
References: <20201228170344.22867-1-amir73il@gmail.com>
 <20201228170344.22867-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228170344.22867-2-amir73il@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for looking at this, it's long overdue!

On Mon, Dec 28, 2020 at 07:03:43PM +0200, Amir Goldstein wrote:
> nfsd stats counters can be updated by concurrent nfsd threads without any
> protection.
> 
> Convert some nfsd_stats and nfsd_net struct members to use percpu counters.
> 
> There are several members of struct nfsd_stats that are reported in file
> /proc/net/rpc/nfsd by never updated. Those have been left untouched.

Looking through the history, the code that updated fh_lookup, for
example, was removed in 2002.

I'd be OK with removing those entirely, maybe just leave a /* deprecated
field */ comment where we printk the hard-coded 0's.  If somebody wants
to know more they can still find the answers in git.

> The longest_chain* members of struct nfsd_net remain unprotected.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/nfsd/netns.h    | 20 +++++++----
>  fs/nfsd/nfs4proc.c |  2 +-
>  fs/nfsd/nfscache.c | 52 +++++++++++++++++++--------
>  fs/nfsd/nfsctl.c   |  5 ++-
>  fs/nfsd/nfsfh.c    |  2 +-
>  fs/nfsd/stats.c    | 87 ++++++++++++++++++++++++++++++++++++----------
>  fs/nfsd/stats.h    | 42 +++++++++++++++-------
>  fs/nfsd/vfs.c      |  4 +--
>  8 files changed, 156 insertions(+), 58 deletions(-)
> 
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 7346acda9d76..080c5389b2e7 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -10,6 +10,7 @@
>  
>  #include <net/net_namespace.h>
>  #include <net/netns/generic.h>
> +#include <linux/percpu_counter.h>
>  
>  /* Hash tables for nfs4_clientid state */
>  #define CLIENT_HASH_BITS                 4
> @@ -149,20 +150,25 @@ struct nfsd_net {
>  
>  	/*
>  	 * Stats and other tracking of on the duplicate reply cache.
> -	 * These fields and the "rc" fields in nfsdstats are modified
> -	 * with only the per-bucket cache lock, which isn't really safe
> -	 * and should be fixed if we want the statistics to be
> -	 * completely accurate.
> +	 * The longest_chain* fields are modified with only the per-bucket
> +	 * cache lock, which isn't really safe and should be fixed if we want
> +	 * these statistics to be completely accurate.
>  	 */
>  
>  	/* total number of entries */
>  	atomic_t                 num_drc_entries;
>  
> +	/* Reference to below counters as array for init/destroy */
> +	struct percpu_counter    counters[0];

This feels slightly too clever for its own good, but....  OK, I see
there's a bunch of initializations to do in the nfsdstats case, and you
don't want to open code all that (and its error handling).  I guess I
don't have a better idea.  Is this a common pattern elsewhere?

Anyway, otherwise it all looks routine to me, thanks again.

--b.

>  	/* cache misses due only to checksum comparison failures */
> -	unsigned int             payload_misses;
> -
> +	struct percpu_counter    payload_misses;
>  	/* amount of memory (in bytes) currently consumed by the DRC */
> -	unsigned int             drc_mem_usage;
> +	struct percpu_counter    drc_mem_usage;
> +	/* End of counters array */
> +	struct percpu_counter    counters_end[0];
> +#define NFSD_NET_COUNTERS_NUM \
> +	((offsetof(struct nfsd_net, counters_end) - \
> +	  offsetof(struct nfsd_net, counters)) / sizeof(struct percpu_counter))
>  
>  	/* longest hash chain seen */
>  	unsigned int             longest_chain;
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index e83b21778816..0fa205d8ce49 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2173,7 +2173,7 @@ nfsd4_proc_null(struct svc_rqst *rqstp)
>  static inline void nfsd4_increment_op_stats(u32 opnum)
>  {
>  	if (opnum >= FIRST_NFS4_OP && opnum <= LAST_NFS4_OP)
> -		nfsdstats.nfs4_opcount[opnum]++;
> +		percpu_counter_inc(&nfsdstats.nfs4_opcount[opnum]);
>  }
>  
>  static const struct nfsd4_operation nfsd4_ops[];
> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> index 80c90fc231a5..4093ab25cc4d 100644
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -121,14 +121,14 @@ nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
>  				struct nfsd_net *nn)
>  {
>  	if (rp->c_type == RC_REPLBUFF && rp->c_replvec.iov_base) {
> -		nn->drc_mem_usage -= rp->c_replvec.iov_len;
> +		percpu_counter_sub(&nn->drc_mem_usage, rp->c_replvec.iov_len);
>  		kfree(rp->c_replvec.iov_base);
>  	}
>  	if (rp->c_state != RC_UNUSED) {
>  		rb_erase(&rp->c_node, &b->rb_head);
>  		list_del(&rp->c_lru);
>  		atomic_dec(&nn->num_drc_entries);
> -		nn->drc_mem_usage -= sizeof(*rp);
> +		percpu_counter_sub(&nn->drc_mem_usage, sizeof(*rp));
>  	}
>  	kmem_cache_free(drc_slab, rp);
>  }
> @@ -154,6 +154,16 @@ void nfsd_drc_slab_free(void)
>  	kmem_cache_destroy(drc_slab);
>  }
>  
> +static int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
> +{
> +	return nfsd_percpu_counters_init(nn->counters, NFSD_NET_COUNTERS_NUM);
> +}
> +
> +static void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
> +{
> +	nfsd_percpu_counters_destroy(nn->counters, NFSD_NET_COUNTERS_NUM);
> +}
> +
>  int nfsd_reply_cache_init(struct nfsd_net *nn)
>  {
>  	unsigned int hashsize;
> @@ -165,12 +175,16 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
>  	hashsize = nfsd_hashsize(nn->max_drc_entries);
>  	nn->maskbits = ilog2(hashsize);
>  
> +	status = nfsd_reply_cache_stats_init(nn);
> +	if (status)
> +		goto out_nomem;
> +
>  	nn->nfsd_reply_cache_shrinker.scan_objects = nfsd_reply_cache_scan;
>  	nn->nfsd_reply_cache_shrinker.count_objects = nfsd_reply_cache_count;
>  	nn->nfsd_reply_cache_shrinker.seeks = 1;
>  	status = register_shrinker(&nn->nfsd_reply_cache_shrinker);
>  	if (status)
> -		goto out_nomem;
> +		goto out_stats_destroy;
>  
>  	nn->drc_hashtbl = kvzalloc(array_size(hashsize,
>  				sizeof(*nn->drc_hashtbl)), GFP_KERNEL);
> @@ -186,6 +200,8 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
>  	return 0;
>  out_shrinker:
>  	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
> +out_stats_destroy:
> +	nfsd_reply_cache_stats_destroy(nn);
>  out_nomem:
>  	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
>  	return -ENOMEM;
> @@ -196,6 +212,7 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
>  	struct svc_cacherep	*rp;
>  	unsigned int i;
>  
> +	nfsd_reply_cache_stats_destroy(nn);
>  	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
>  
>  	for (i = 0; i < nn->drc_hashsize; i++) {
> @@ -324,7 +341,7 @@ nfsd_cache_key_cmp(const struct svc_cacherep *key,
>  {
>  	if (key->c_key.k_xid == rp->c_key.k_xid &&
>  	    key->c_key.k_csum != rp->c_key.k_csum) {
> -		++nn->payload_misses;
> +		percpu_counter_inc(&nn->payload_misses);
>  		trace_nfsd_drc_mismatch(nn, key, rp);
>  	}
>  
> @@ -407,7 +424,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
>  
>  	rqstp->rq_cacherep = NULL;
>  	if (type == RC_NOCACHE) {
> -		nfsdstats.rcnocache++;
> +		percpu_counter_inc(&nfsdstats.rcnocache);
>  		goto out;
>  	}
>  
> @@ -429,12 +446,12 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
>  		goto found_entry;
>  	}
>  
> -	nfsdstats.rcmisses++;
> +	percpu_counter_inc(&nfsdstats.rcmisses);
>  	rqstp->rq_cacherep = rp;
>  	rp->c_state = RC_INPROG;
>  
>  	atomic_inc(&nn->num_drc_entries);
> -	nn->drc_mem_usage += sizeof(*rp);
> +	percpu_counter_add(&nn->drc_mem_usage, sizeof(*rp));
>  
>  	/* go ahead and prune the cache */
>  	prune_bucket(b, nn);
> @@ -446,7 +463,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
>  
>  found_entry:
>  	/* We found a matching entry which is either in progress or done. */
> -	nfsdstats.rchits++;
> +	percpu_counter_inc(&nfsdstats.rchits);
>  	rtn = RC_DROPIT;
>  
>  	/* Request being processed */
> @@ -548,7 +565,7 @@ void nfsd_cache_update(struct svc_rqst *rqstp, int cachetype, __be32 *statp)
>  		return;
>  	}
>  	spin_lock(&b->cache_lock);
> -	nn->drc_mem_usage += bufsize;
> +	percpu_counter_add(&nn->drc_mem_usage, bufsize);
>  	lru_put_end(b, rp);
>  	rp->c_secure = test_bit(RQ_SECURE, &rqstp->rq_flags);
>  	rp->c_type = cachetype;
> @@ -588,13 +605,18 @@ static int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
>  
>  	seq_printf(m, "max entries:           %u\n", nn->max_drc_entries);
>  	seq_printf(m, "num entries:           %u\n",
> -			atomic_read(&nn->num_drc_entries));
> +		   atomic_read(&nn->num_drc_entries));
>  	seq_printf(m, "hash buckets:          %u\n", 1 << nn->maskbits);
> -	seq_printf(m, "mem usage:             %u\n", nn->drc_mem_usage);
> -	seq_printf(m, "cache hits:            %u\n", nfsdstats.rchits);
> -	seq_printf(m, "cache misses:          %u\n", nfsdstats.rcmisses);
> -	seq_printf(m, "not cached:            %u\n", nfsdstats.rcnocache);
> -	seq_printf(m, "payload misses:        %u\n", nn->payload_misses);
> +	seq_printf(m, "mem usage:             %lld\n",
> +		   percpu_counter_sum_positive(&nn->drc_mem_usage));
> +	seq_printf(m, "cache hits:            %lld\n",
> +		   percpu_counter_sum_positive(&nfsdstats.rchits));
> +	seq_printf(m, "cache misses:          %lld\n",
> +		   percpu_counter_sum_positive(&nfsdstats.rcmisses));
> +	seq_printf(m, "not cached:            %lld\n",
> +		   percpu_counter_sum_positive(&nfsdstats.rcnocache));
> +	seq_printf(m, "payload misses:        %lld\n",
> +		   percpu_counter_sum_positive(&nn->payload_misses));
>  	seq_printf(m, "longest chain len:     %u\n", nn->longest_chain);
>  	seq_printf(m, "cachesize at longest:  %u\n", nn->longest_chain_cachesize);
>  	return 0;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index f6d5d783f4a4..258605ee49b8 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1534,7 +1534,9 @@ static int __init init_nfsd(void)
>  	retval = nfsd4_init_pnfs();
>  	if (retval)
>  		goto out_free_slabs;
> -	nfsd_stat_init();	/* Statistics */
> +	retval = nfsd_stat_init();	/* Statistics */
> +	if (retval)
> +		goto out_free_pnfs;
>  	retval = nfsd_drc_slab_create();
>  	if (retval)
>  		goto out_free_stat;
> @@ -1554,6 +1556,7 @@ static int __init init_nfsd(void)
>  	nfsd_drc_slab_free();
>  out_free_stat:
>  	nfsd_stat_shutdown();
> +out_free_pnfs:
>  	nfsd4_exit_pnfs();
>  out_free_slabs:
>  	nfsd4_free_slabs();
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index c81dbbad8792..1879758bbaa5 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -400,7 +400,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
>  	}
>  out:
>  	if (error == nfserr_stale)
> -		nfsdstats.fh_stale++;
> +		percpu_counter_inc(&nfsdstats.fh_stale);
>  	return error;
>  }
>  
> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
> index b1bc582b0493..7bef1e7139d7 100644
> --- a/fs/nfsd/stats.c
> +++ b/fs/nfsd/stats.c
> @@ -38,17 +38,17 @@ static int nfsd_proc_show(struct seq_file *seq, void *v)
>  {
>  	int i;
>  
> -	seq_printf(seq, "rc %u %u %u\nfh %u %u %u %u %u\nio %u %u\n",
> -		      nfsdstats.rchits,
> -		      nfsdstats.rcmisses,
> -		      nfsdstats.rcnocache,
> -		      nfsdstats.fh_stale,
> -		      nfsdstats.fh_lookup,
> -		      nfsdstats.fh_anon,
> -		      nfsdstats.fh_nocache_dir,
> -		      nfsdstats.fh_nocache_nondir,
> -		      nfsdstats.io_read,
> -		      nfsdstats.io_write);
> +	seq_printf(seq, "rc %lld %lld %lld\nfh %lld %u %u %u %u\nio %lld %lld\n",
> +		   percpu_counter_sum_positive(&nfsdstats.rchits),
> +		   percpu_counter_sum_positive(&nfsdstats.rcmisses),
> +		   percpu_counter_sum_positive(&nfsdstats.rcnocache),
> +		   percpu_counter_sum_positive(&nfsdstats.fh_stale),
> +		   nfsdstats.fh_lookup,
> +		   nfsdstats.fh_anon,
> +		   nfsdstats.fh_nocache_dir,
> +		   nfsdstats.fh_nocache_nondir,
> +		   percpu_counter_sum_positive(&nfsdstats.io_read),
> +		   percpu_counter_sum_positive(&nfsdstats.io_write));
>  	/* thread usage: */
>  	seq_printf(seq, "th %u %u", nfsdstats.th_cnt, nfsdstats.th_fullcnt);
>  	for (i=0; i<10; i++) {
> @@ -62,7 +62,7 @@ static int nfsd_proc_show(struct seq_file *seq, void *v)
>  	for (i=0; i<11; i++)
>  		seq_printf(seq, " %u", nfsdstats.ra_depth[i]);
>  	seq_putc(seq, '\n');
> -	
> +
>  	/* show my rpc info */
>  	svc_seq_show(seq, &nfsd_svcstats);
>  
> @@ -70,8 +70,10 @@ static int nfsd_proc_show(struct seq_file *seq, void *v)
>  	/* Show count for individual nfsv4 operations */
>  	/* Writing operation numbers 0 1 2 also for maintaining uniformity */
>  	seq_printf(seq,"proc4ops %u", LAST_NFS4_OP + 1);
> -	for (i = 0; i <= LAST_NFS4_OP; i++)
> -		seq_printf(seq, " %u", nfsdstats.nfs4_opcount[i]);
> +	for (i = 0; i <= LAST_NFS4_OP; i++) {
> +		seq_printf(seq, " %lld",
> +			   percpu_counter_sum_positive(&nfsdstats.nfs4_opcount[i]));
> +	}
>  
>  	seq_putc(seq, '\n');
>  #endif
> @@ -91,14 +93,63 @@ static const struct proc_ops nfsd_proc_ops = {
>  	.proc_release	= single_release,
>  };
>  
> -void
> -nfsd_stat_init(void)
> +int nfsd_percpu_counters_init(struct percpu_counter counters[], int num)
>  {
> +	int i, err = 0;
> +
> +	for (i = 0; !err && i < num; i++)
> +		err = percpu_counter_init(&counters[i], 0, GFP_KERNEL);
> +
> +	if (!err)
> +		return 0;
> +
> +	for (; i > 0; i--)
> +		percpu_counter_destroy(&counters[i-1]);
> +
> +	return err;
> +}
> +
> +void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num)
> +{
> +	int i;
> +
> +	for (i = 0; i < num; i++)
> +		percpu_counter_set(&counters[i], 0);
> +}
> +
> +void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
> +{
> +	int i;
> +
> +	for (i = 0; i < num; i++)
> +		percpu_counter_destroy(&counters[i]);
> +}
> +
> +static int nfsd_stat_counters_init(void)
> +{
> +	return nfsd_percpu_counters_init(nfsdstats.counters, NFSD_STATS_COUNTERS_NUM);
> +}
> +
> +static void nfsd_stat_counters_destroy(void)
> +{
> +	nfsd_percpu_counters_destroy(nfsdstats.counters, NFSD_STATS_COUNTERS_NUM);
> +}
> +
> +int nfsd_stat_init(void)
> +{
> +	int err;
> +
> +	err = nfsd_stat_counters_init();
> +	if (err)
> +		return err;
> +
>  	svc_proc_register(&init_net, &nfsd_svcstats, &nfsd_proc_ops);
> +
> +	return 0;
>  }
>  
> -void
> -nfsd_stat_shutdown(void)
> +void nfsd_stat_shutdown(void)
>  {
> +	nfsd_stat_counters_destroy();
>  	svc_proc_unregister(&init_net, "nfsd");
>  }
> diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
> index b23fdac69820..ad52a916375e 100644
> --- a/fs/nfsd/stats.h
> +++ b/fs/nfsd/stats.h
> @@ -8,37 +8,53 @@
>  #define _NFSD_STATS_H
>  
>  #include <uapi/linux/nfsd/stats.h>
> +#include <linux/percpu_counter.h>
>  
>  
>  struct nfsd_stats {
> -	unsigned int	rchits;		/* repcache hits */
> -	unsigned int	rcmisses;	/* repcache hits */
> -	unsigned int	rcnocache;	/* uncached reqs */
> -	unsigned int	fh_stale;	/* FH stale error */
> +	/* Reference to below counters as array for init/destroy */
> +	struct percpu_counter	counters[0];
> +	struct percpu_counter   rchits;         /* repcache hits */
> +	struct percpu_counter   rcmisses;       /* repcache hits */
> +	struct percpu_counter   rcnocache;      /* uncached reqs */
> +	struct percpu_counter   fh_stale;       /* FH stale error */
> +	struct percpu_counter   io_read;        /* bytes returned to read requests */
> +	struct percpu_counter   io_write;       /* bytes passed in write requests */
> +#ifdef CONFIG_NFSD_V4
> +	/* Counters of individual nfsv4 operations */
> +	struct percpu_counter	nfs4_opcount[LAST_NFS4_OP + 1];
> +#endif
> +	/* End of array of couters */
> +	struct percpu_counter	counters_end[0];
> +#define NFSD_STATS_COUNTERS_NUM \
> +	((offsetof(struct nfsd_stats, counters_end) - \
> +	  offsetof(struct nfsd_stats, counters)) / sizeof(struct percpu_counter))
> +
> +	/* Protected by nfsd_mutex */
> +	unsigned int	th_cnt;		/* number of available threads */
> +
> +	/* Not updated at all?? */
>  	unsigned int	fh_lookup;	/* dentry cached */
>  	unsigned int	fh_anon;	/* anon file dentry returned */
>  	unsigned int	fh_nocache_dir;	/* filehandle not found in dcache */
>  	unsigned int	fh_nocache_nondir;	/* filehandle not found in dcache */
> -	unsigned int	io_read;	/* bytes returned to read requests */
> -	unsigned int	io_write;	/* bytes passed in write requests */
> -	unsigned int	th_cnt;		/* number of available threads */
>  	unsigned int	th_usage[10];	/* number of ticks during which n perdeciles
>  					 * of available threads were in use */
>  	unsigned int	th_fullcnt;	/* number of times last free thread was used */
>  	unsigned int	ra_size;	/* size of ra cache */
>  	unsigned int	ra_depth[11];	/* number of times ra entry was found that deep
>  					 * in the cache (10percentiles). [10] = not found */
> -#ifdef CONFIG_NFSD_V4
> -	unsigned int	nfs4_opcount[LAST_NFS4_OP + 1];	/* count of individual nfsv4 operations */
> -#endif
> -
>  };
>  
>  
>  extern struct nfsd_stats	nfsdstats;
> +
>  extern struct svc_stat		nfsd_svcstats;
>  
> -void	nfsd_stat_init(void);
> -void	nfsd_stat_shutdown(void);
> +int nfsd_percpu_counters_init(struct percpu_counter counters[], int num);
> +void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num);
> +void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num);
> +int nfsd_stat_init(void);
> +void nfsd_stat_shutdown(void);
>  
>  #endif /* _NFSD_STATS_H */
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 1ecaceebee13..6adb7aba2575 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -889,7 +889,7 @@ static __be32 nfsd_finish_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			       unsigned long *count, u32 *eof, ssize_t host_err)
>  {
>  	if (host_err >= 0) {
> -		nfsdstats.io_read += host_err;
> +		percpu_counter_add(&nfsdstats.io_read, host_err);
>  		*eof = nfsd_eof_on_read(file, offset, host_err, *count);
>  		*count = host_err;
>  		fsnotify_access(file);
> @@ -1031,7 +1031,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
>  		goto out_nfserr;
>  	}
>  	*cnt = host_err;
> -	nfsdstats.io_write += *cnt;
> +	percpu_counter_add(&nfsdstats.io_write, *cnt);
>  	fsnotify_modify(file);
>  
>  	if (stable && use_wgather) {
> -- 
> 2.17.1
