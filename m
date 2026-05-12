Return-Path: <linux-nfs+bounces-21537-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNBILwViA2oq5gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21537-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 19:23:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C983E525C26
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 19:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F32563074FC7
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE99F385D77;
	Tue, 12 May 2026 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwQyUKQ7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B9385D6B;
	Tue, 12 May 2026 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605829; cv=none; b=i1wpDAG1YU4yv/8aRb6zN3WnlsdA2yz4cgBcSodM+Bo/IjlkejggUzkZiBGwCWMQ9HNUY2FMyWoshHGssjGEqorLxY/5DP5WVlbowTPOL7OD1muH9hLxNHf60Aq5mV59/8LCMZJCKK2bbAtH8hoiOH1BlwGw1K2Shydd8q2Q4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605829; c=relaxed/simple;
	bh=UIMc6Epq1jKVpYoN8NQkrsbH35Z/rxkSt0+cjObPXEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vF2Rh4X0Meb/cIxqTxT8Dd9Bs+Y7KK5rNJkI5VbdgkYjg7f3MHRUe8iQ3sHnmh1y2+vYUcUBCjpyNC3Kz8BYRym8YdjUSjKvhOiYsjKBvCFVD4zAhrUnRJVxilOY5Q0e/FuK27y+4qxd+pwUduBgo0zznzSI3iflkOrJaoqL+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwQyUKQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEBEC2BCB0;
	Tue, 12 May 2026 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778605829;
	bh=UIMc6Epq1jKVpYoN8NQkrsbH35Z/rxkSt0+cjObPXEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cwQyUKQ7/ehswE6htqBY9YS5WZtrPNKyBqWQCvZt3MGoMAZl38WrdS4VCCUoTtce5
	 3HXiMl5gnt6E8BE0Wlgn1JAAx+a721k2CiMTFjCC1q/33PgDsydSqQVOEZ0c/aEcPh
	 qqMPItxUFu2pzF96J9wTatigpI1eNoG4appb93SUembefpNXfS+dQ3jx5Zjo7T9pg+
	 Mru+31A2ZvAy//NyZ0pamvIuUJ6MRZj/QrOw+oPtdc5YksLDWF2zrWsZK+3k4Y36/N
	 kUKgR6D21j3nHYHX3zYVq674GjpOqIAusFNnu8t7U2Rep60jDIv6s7wrNPKcxawCYO
	 7JJLf2m6C5FqQ==
Date: Tue, 12 May 2026 10:10:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: Re: [PATCH 12/12] swap: move swap_info_struct to mm/swap.h
Message-ID: <20260512171028.GM9555@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512053625.2950900-13-hch@lst.de>
X-Rspamd-Queue-Id: C983E525C26
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21537-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 07:35:28AM +0200, Christoph Hellwig wrote:
> swap_info_struct is now internal to the MM subsystem, so remove it from
> the public header.
> 

Even more cleaning out of swap.h is nice, so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/swap.h | 98 +-------------------------------------------
>  mm/swap.h            | 92 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+), 96 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 95237ee065c2..31eef9b74949 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -16,9 +16,9 @@
>  #include <uapi/linux/mempolicy.h>
>  #include <asm/page.h>
>  
> -struct notifier_block;
> -
>  struct bio;
> +struct notifier_block;
> +struct swap_info_struct;
>  
>  #define SWAP_FLAG_PREFER	0x8000	/* set if swap priority specified */
>  #define SWAP_FLAG_PRIO_MASK	0x7fff
> @@ -178,29 +178,6 @@ struct sysinfo;
>  struct writeback_control;
>  struct zone;
>  
> -/*
> - * Max bad pages in the new format..
> - */
> -#define MAX_SWAP_BADPAGES \
> -	((offsetof(union swap_header, magic.magic) - \
> -	  offsetof(union swap_header, info.badpages)) / sizeof(int))
> -
> -enum {
> -	SWP_USED	= (1 << 0),	/* is slot in swap_info[] used? */
> -	SWP_WRITEOK	= (1 << 1),	/* ok to write to this swap?	*/
> -	SWP_DISCARDABLE = (1 << 2),	/* blkdev support discard */
> -	SWP_DISCARDING	= (1 << 3),	/* now discarding a free cluster */
> -	SWP_SOLIDSTATE	= (1 << 4),	/* blkdev seeks are cheap */
> -	SWP_BLKDEV	= (1 << 6),	/* its a block device */
> -	SWP_ACTIVATED	= (1 << 7),	/* set after swap_activate success */
> -	SWP_FS_OPS	= (1 << 8),	/* swapfile operations go through fs */
> -	SWP_AREA_DISCARD = (1 << 9),	/* single-time swap area discards */
> -	SWP_PAGE_DISCARD = (1 << 10),	/* freed swap page-cluster discards */
> -	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
> -	SWP_SYNCHRONOUS_IO = (1 << 12),	/* synchronous IO is efficient */
> -					/* add others here before... */
> -};
> -
>  #define SWAP_CLUSTER_MAX 32UL
>  #define SWAP_CLUSTER_MAX_SKIPPED (SWAP_CLUSTER_MAX << 10)
>  #define COMPACT_CLUSTER_MAX SWAP_CLUSTER_MAX
> @@ -219,56 +196,6 @@ enum {
>  #define SWAP_NR_ORDERS		1
>  #endif
>  
> -/*
> - * We keep using same cluster for rotational device so IO will be sequential.
> - * The purpose is to optimize SWAP throughput on these device.
> - */
> -struct swap_sequential_cluster {
> -	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
> -};
> -
> -/*
> - * The in-memory structure used to track swap areas.
> - */
> -struct swap_info_struct {
> -	struct percpu_ref users;	/* indicate and keep swap device valid. */
> -	unsigned long	flags;		/* SWP_USED etc: see above */
> -	signed short	prio;		/* swap priority of this type */
> -	struct plist_node list;		/* entry in swap_active_head */
> -	signed char	type;		/* strange name for an index */
> -	unsigned int	max;		/* size of this swap device */
> -	unsigned long *zeromap;		/* kvmalloc'ed bitmap to track zero pages */
> -	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
> -	struct list_head free_clusters; /* free clusters list */
> -	struct list_head full_clusters; /* full clusters list */
> -	struct list_head nonfull_clusters[SWAP_NR_ORDERS];
> -					/* list of cluster that contains at least one free slot */
> -	struct list_head frag_clusters[SWAP_NR_ORDERS];
> -					/* list of cluster that are fragmented or contented */
> -	unsigned int pages;		/* total of usable pages of swap */
> -	atomic_long_t inuse_pages;	/* number of those currently in use */
> -	struct swap_sequential_cluster *global_cluster; /* Use one global cluster for rotating device */
> -	spinlock_t global_cluster_lock;	/* Serialize usage of global cluster */
> -	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
> -	struct block_device *bdev;	/* swap device or bdev of swap file */
> -	struct file *swap_file;		/* seldom referenced */
> -	struct completion comp;		/* seldom referenced */
> -	spinlock_t lock;		/*
> -					 * protect map scan related fields like
> -					 * inuse_pages and all cluster lists.
> -					 * Other fields are only changed
> -					 * at swapon/swapoff, so are protected
> -					 * by swap_lock. changing flags need
> -					 * hold this lock and swap_lock. If
> -					 * both locks need hold, hold swap_lock
> -					 * first.
> -					 */
> -	struct work_struct discard_work; /* discard worker */
> -	struct work_struct reclaim_work; /* reclaim worker */
> -	struct list_head discard_clusters; /* discard clusters list */
> -	struct plist_node avail_list;   /* entry in swap_avail_head */
> -};
> -
>  static inline swp_entry_t page_swap_entry(struct page *page)
>  {
>  	struct folio *folio = page_folio(page);
> @@ -423,10 +350,7 @@ int find_first_swap(dev_t *device);
>  extern unsigned int count_swap_pages(int, int);
>  extern sector_t swapdev_block(int, pgoff_t);
>  extern int __swap_count(swp_entry_t entry);
> -extern bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
>  extern int swp_swapcount(swp_entry_t entry);
> -struct backing_dev_info;
> -extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
>  sector_t swap_folio_sector(struct folio *folio);
>  
>  /*
> @@ -452,20 +376,7 @@ bool folio_free_swap(struct folio *folio);
>  swp_entry_t swap_alloc_hibernation_slot(int type);
>  void swap_free_hibernation_slot(swp_entry_t entry);
>  
> -static inline void put_swap_device(struct swap_info_struct *si)
> -{
> -	percpu_ref_put(&si->users);
> -}
> -
>  #else /* CONFIG_SWAP */
> -static inline struct swap_info_struct *get_swap_device(swp_entry_t entry)
> -{
> -	return NULL;
> -}
> -
> -static inline void put_swap_device(struct swap_info_struct *si)
> -{
> -}
>  
>  #define get_nr_swap_pages()			0L
>  #define total_swap_pages			0L
> @@ -497,11 +408,6 @@ static inline int __swap_count(swp_entry_t entry)
>  	return 0;
>  }
>  
> -static inline bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry)
> -{
> -	return false;
> -}
> -
>  static inline int swp_swapcount(swp_entry_t entry)
>  {
>  	return 0;
> diff --git a/mm/swap.h b/mm/swap.h
> index a77016f2423b..70974495bf15 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -8,6 +8,79 @@ struct swap_iocb;
>  
>  extern int page_cluster;
>  
> +/*
> + * We keep using same cluster for rotational device so IO will be sequential.
> + * The purpose is to optimize SWAP throughput on these device.
> + */
> +struct swap_sequential_cluster {
> +	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
> +};
> +
> +/*
> + * The in-memory structure used to track swap areas.
> + */
> +struct swap_info_struct {
> +	struct percpu_ref users;	/* indicate and keep swap device valid. */
> +	unsigned long	flags;		/* SWP_USED etc: see above */
> +	signed short	prio;		/* swap priority of this type */
> +	struct plist_node list;		/* entry in swap_active_head */
> +	signed char	type;		/* strange name for an index */
> +	unsigned int	max;		/* size of this swap device */
> +	unsigned long *zeromap;		/* kvmalloc'ed bitmap to track zero pages */
> +	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
> +	struct list_head free_clusters; /* free clusters list */
> +	struct list_head full_clusters; /* full clusters list */
> +	struct list_head nonfull_clusters[SWAP_NR_ORDERS];
> +					/* list of cluster that contains at least one free slot */
> +	struct list_head frag_clusters[SWAP_NR_ORDERS];
> +					/* list of cluster that are fragmented or contented */
> +	unsigned int pages;		/* total of usable pages of swap */
> +	atomic_long_t inuse_pages;	/* number of those currently in use */
> +	struct swap_sequential_cluster *global_cluster; /* Use one global cluster for rotating device */
> +	spinlock_t global_cluster_lock;	/* Serialize usage of global cluster */
> +	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
> +	struct block_device *bdev;	/* swap device or bdev of swap file */
> +	struct file *swap_file;		/* seldom referenced */
> +	struct completion comp;		/* seldom referenced */
> +	spinlock_t lock;		/*
> +					 * protect map scan related fields like
> +					 * inuse_pages and all cluster lists.
> +					 * Other fields are only changed
> +					 * at swapon/swapoff, so are protected
> +					 * by swap_lock. changing flags need
> +					 * hold this lock and swap_lock. If
> +					 * both locks need hold, hold swap_lock
> +					 * first.
> +					 */
> +	struct work_struct discard_work; /* discard worker */
> +	struct work_struct reclaim_work; /* reclaim worker */
> +	struct list_head discard_clusters; /* discard clusters list */
> +	struct plist_node avail_list;   /* entry in swap_avail_head */
> +};
> +
> +/*
> + * Max bad pages in the new format..
> + */
> +#define MAX_SWAP_BADPAGES \
> +	((offsetof(union swap_header, magic.magic) - \
> +	  offsetof(union swap_header, info.badpages)) / sizeof(int))
> +
> +enum {
> +	SWP_USED	= (1 << 0),	/* is slot in swap_info[] used? */
> +	SWP_WRITEOK	= (1 << 1),	/* ok to write to this swap?	*/
> +	SWP_DISCARDABLE = (1 << 2),	/* blkdev support discard */
> +	SWP_DISCARDING	= (1 << 3),	/* now discarding a free cluster */
> +	SWP_SOLIDSTATE	= (1 << 4),	/* blkdev seeks are cheap */
> +	SWP_BLKDEV	= (1 << 6),	/* its a block device */
> +	SWP_ACTIVATED	= (1 << 7),	/* set after swap_activate success */
> +	SWP_FS_OPS	= (1 << 8),	/* swapfile operations go through fs */
> +	SWP_AREA_DISCARD = (1 << 9),	/* single-time swap area discards */
> +	SWP_PAGE_DISCARD = (1 << 10),	/* freed swap page-cluster discards */
> +	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
> +	SWP_SYNCHRONOUS_IO = (1 << 12),	/* synchronous IO is efficient */
> +					/* add others here before... */
> +};
> +
>  #ifdef CONFIG_THP_SWAP
>  #define SWAPFILE_CLUSTER	HPAGE_PMD_NR
>  #define swap_entry_order(order)	(order)
> @@ -352,6 +425,13 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
>  	return i;
>  }
>  
> +bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
> +struct swap_info_struct *get_swap_device(swp_entry_t entry);
> +static inline void put_swap_device(struct swap_info_struct *si)
> +{
> +	percpu_ref_put(&si->users);
> +}
> +
>  #else /* CONFIG_SWAP */
>  struct swap_iocb;
>  static inline struct swap_cluster_info *swap_cluster_lock(
> @@ -498,5 +578,17 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
>  {
>  	return 0;
>  }
> +static inline bool swap_entry_swapped(struct swap_info_struct *si,
> +		swp_entry_t entry)
> +{
> +	return false;
> +}
> +static inline struct swap_info_struct *get_swap_device(swp_entry_t entry)
> +{
> +	return NULL;
> +}
> +static inline void put_swap_device(struct swap_info_struct *si)
> +{
> +}
>  #endif /* CONFIG_SWAP */
>  #endif /* _MM_SWAP_H */
> -- 
> 2.53.0
> 
> 

