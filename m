Return-Path: <linux-nfs+bounces-21491-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN4bEUO/AmoEwQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21491-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:48:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E266451A6A2
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C39713042E06
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 05:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A583CF68B;
	Tue, 12 May 2026 05:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QqOqi+Vu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2389406281;
	Tue, 12 May 2026 05:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564297; cv=none; b=nnvxSZ8iX0yOignk1k/54wIz9h6/Z5CkWkR1ByV/eh0mOB6GZmh4JjgxNIiZ3ERtmrgY+nzPsmxNmBMOG/vCz3xfZjYl2ulQpIcHyFWfbgLSJ5Ii7hvAHK5FDbQmJc8ZzY+49f2FaIAj9lA4Qh5q8YH4S1xOhKlnfwwguVtqLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564297; c=relaxed/simple;
	bh=a94w40NO4YD+3BaH+oMb3jw1FWM+Wd05w5McR5dHwOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7B8jgTLw8HAgQe9DG71EVlhzujKyDxCPKJ4r7i6dSk7Nx1R3u4UoDLIDh4jfXL3QM3XhQgGxf9DRLJchCQb2AVM7O2iUjKJxARG4k5BVAVyrB1H8Yvy7L2y3QJ9CcP8uNPShy/DoXpul368zE6rbJBczeeQMqpOa1ZOnnz2bpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QqOqi+Vu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jmg1/5AYnhQfPDVo7U8v9UEsn9gIbFRK+B6p/Lo/5oA=; b=QqOqi+Vu+e1lyd8X/LTzUvV1/s
	7nNzu+X/+UiipnmFD2UKvwRucWeks9YwyuibcySNp6WMvDeX4F1yrLmj6KlC1j/U0itxoREq7ty5j
	psvrVCvEVE+DGyltDxt2h7xbnHc2o21Dhshp4eRz7jXJmo5FP7/eNIyvbsR+we+lvpzS80HlOZuRL
	BtnTXIz7jT4ZN+GcEikcH8RCK3DW5D+Xs/Gyj3cUHsE6zHFR8tSGQ7eYtKmIGSQyp9kOpyNnIomyR
	LyJEvGDuooiyrdDlFLckwWnhjoGoOBRE7uRV1WGSBrGTTCxlFVT/UybEtrMcMglFTm5s3NOUdudR+
	Bvu6vXiw==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfoh-0000000FfXA-48rG;
	Tue, 12 May 2026 05:38:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong " <djwong@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 12/12] swap: move swap_info_struct to mm/swap.h
Date: Tue, 12 May 2026 07:35:28 +0200
Message-ID: <20260512053625.2950900-13-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512053625.2950900-1-hch@lst.de>
References: <20260512053625.2950900-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: E266451A6A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21491-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim,lst.de:email,lst.de:mid]
X-Rspamd-Action: no action

swap_info_struct is now internal to the MM subsystem, so remove it from
the public header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swap.h | 98 +-------------------------------------------
 mm/swap.h            | 92 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 96 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 95237ee065c2..31eef9b74949 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -16,9 +16,9 @@
 #include <uapi/linux/mempolicy.h>
 #include <asm/page.h>
 
-struct notifier_block;
-
 struct bio;
+struct notifier_block;
+struct swap_info_struct;
 
 #define SWAP_FLAG_PREFER	0x8000	/* set if swap priority specified */
 #define SWAP_FLAG_PRIO_MASK	0x7fff
@@ -178,29 +178,6 @@ struct sysinfo;
 struct writeback_control;
 struct zone;
 
-/*
- * Max bad pages in the new format..
- */
-#define MAX_SWAP_BADPAGES \
-	((offsetof(union swap_header, magic.magic) - \
-	  offsetof(union swap_header, info.badpages)) / sizeof(int))
-
-enum {
-	SWP_USED	= (1 << 0),	/* is slot in swap_info[] used? */
-	SWP_WRITEOK	= (1 << 1),	/* ok to write to this swap?	*/
-	SWP_DISCARDABLE = (1 << 2),	/* blkdev support discard */
-	SWP_DISCARDING	= (1 << 3),	/* now discarding a free cluster */
-	SWP_SOLIDSTATE	= (1 << 4),	/* blkdev seeks are cheap */
-	SWP_BLKDEV	= (1 << 6),	/* its a block device */
-	SWP_ACTIVATED	= (1 << 7),	/* set after swap_activate success */
-	SWP_FS_OPS	= (1 << 8),	/* swapfile operations go through fs */
-	SWP_AREA_DISCARD = (1 << 9),	/* single-time swap area discards */
-	SWP_PAGE_DISCARD = (1 << 10),	/* freed swap page-cluster discards */
-	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
-	SWP_SYNCHRONOUS_IO = (1 << 12),	/* synchronous IO is efficient */
-					/* add others here before... */
-};
-
 #define SWAP_CLUSTER_MAX 32UL
 #define SWAP_CLUSTER_MAX_SKIPPED (SWAP_CLUSTER_MAX << 10)
 #define COMPACT_CLUSTER_MAX SWAP_CLUSTER_MAX
@@ -219,56 +196,6 @@ enum {
 #define SWAP_NR_ORDERS		1
 #endif
 
-/*
- * We keep using same cluster for rotational device so IO will be sequential.
- * The purpose is to optimize SWAP throughput on these device.
- */
-struct swap_sequential_cluster {
-	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
-};
-
-/*
- * The in-memory structure used to track swap areas.
- */
-struct swap_info_struct {
-	struct percpu_ref users;	/* indicate and keep swap device valid. */
-	unsigned long	flags;		/* SWP_USED etc: see above */
-	signed short	prio;		/* swap priority of this type */
-	struct plist_node list;		/* entry in swap_active_head */
-	signed char	type;		/* strange name for an index */
-	unsigned int	max;		/* size of this swap device */
-	unsigned long *zeromap;		/* kvmalloc'ed bitmap to track zero pages */
-	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
-	struct list_head free_clusters; /* free clusters list */
-	struct list_head full_clusters; /* full clusters list */
-	struct list_head nonfull_clusters[SWAP_NR_ORDERS];
-					/* list of cluster that contains at least one free slot */
-	struct list_head frag_clusters[SWAP_NR_ORDERS];
-					/* list of cluster that are fragmented or contented */
-	unsigned int pages;		/* total of usable pages of swap */
-	atomic_long_t inuse_pages;	/* number of those currently in use */
-	struct swap_sequential_cluster *global_cluster; /* Use one global cluster for rotating device */
-	spinlock_t global_cluster_lock;	/* Serialize usage of global cluster */
-	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
-	struct block_device *bdev;	/* swap device or bdev of swap file */
-	struct file *swap_file;		/* seldom referenced */
-	struct completion comp;		/* seldom referenced */
-	spinlock_t lock;		/*
-					 * protect map scan related fields like
-					 * inuse_pages and all cluster lists.
-					 * Other fields are only changed
-					 * at swapon/swapoff, so are protected
-					 * by swap_lock. changing flags need
-					 * hold this lock and swap_lock. If
-					 * both locks need hold, hold swap_lock
-					 * first.
-					 */
-	struct work_struct discard_work; /* discard worker */
-	struct work_struct reclaim_work; /* reclaim worker */
-	struct list_head discard_clusters; /* discard clusters list */
-	struct plist_node avail_list;   /* entry in swap_avail_head */
-};
-
 static inline swp_entry_t page_swap_entry(struct page *page)
 {
 	struct folio *folio = page_folio(page);
@@ -423,10 +350,7 @@ int find_first_swap(dev_t *device);
 extern unsigned int count_swap_pages(int, int);
 extern sector_t swapdev_block(int, pgoff_t);
 extern int __swap_count(swp_entry_t entry);
-extern bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
 extern int swp_swapcount(swp_entry_t entry);
-struct backing_dev_info;
-extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
 sector_t swap_folio_sector(struct folio *folio);
 
 /*
@@ -452,20 +376,7 @@ bool folio_free_swap(struct folio *folio);
 swp_entry_t swap_alloc_hibernation_slot(int type);
 void swap_free_hibernation_slot(swp_entry_t entry);
 
-static inline void put_swap_device(struct swap_info_struct *si)
-{
-	percpu_ref_put(&si->users);
-}
-
 #else /* CONFIG_SWAP */
-static inline struct swap_info_struct *get_swap_device(swp_entry_t entry)
-{
-	return NULL;
-}
-
-static inline void put_swap_device(struct swap_info_struct *si)
-{
-}
 
 #define get_nr_swap_pages()			0L
 #define total_swap_pages			0L
@@ -497,11 +408,6 @@ static inline int __swap_count(swp_entry_t entry)
 	return 0;
 }
 
-static inline bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry)
-{
-	return false;
-}
-
 static inline int swp_swapcount(swp_entry_t entry)
 {
 	return 0;
diff --git a/mm/swap.h b/mm/swap.h
index a77016f2423b..70974495bf15 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -8,6 +8,79 @@ struct swap_iocb;
 
 extern int page_cluster;
 
+/*
+ * We keep using same cluster for rotational device so IO will be sequential.
+ * The purpose is to optimize SWAP throughput on these device.
+ */
+struct swap_sequential_cluster {
+	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
+};
+
+/*
+ * The in-memory structure used to track swap areas.
+ */
+struct swap_info_struct {
+	struct percpu_ref users;	/* indicate and keep swap device valid. */
+	unsigned long	flags;		/* SWP_USED etc: see above */
+	signed short	prio;		/* swap priority of this type */
+	struct plist_node list;		/* entry in swap_active_head */
+	signed char	type;		/* strange name for an index */
+	unsigned int	max;		/* size of this swap device */
+	unsigned long *zeromap;		/* kvmalloc'ed bitmap to track zero pages */
+	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
+	struct list_head free_clusters; /* free clusters list */
+	struct list_head full_clusters; /* full clusters list */
+	struct list_head nonfull_clusters[SWAP_NR_ORDERS];
+					/* list of cluster that contains at least one free slot */
+	struct list_head frag_clusters[SWAP_NR_ORDERS];
+					/* list of cluster that are fragmented or contented */
+	unsigned int pages;		/* total of usable pages of swap */
+	atomic_long_t inuse_pages;	/* number of those currently in use */
+	struct swap_sequential_cluster *global_cluster; /* Use one global cluster for rotating device */
+	spinlock_t global_cluster_lock;	/* Serialize usage of global cluster */
+	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
+	struct block_device *bdev;	/* swap device or bdev of swap file */
+	struct file *swap_file;		/* seldom referenced */
+	struct completion comp;		/* seldom referenced */
+	spinlock_t lock;		/*
+					 * protect map scan related fields like
+					 * inuse_pages and all cluster lists.
+					 * Other fields are only changed
+					 * at swapon/swapoff, so are protected
+					 * by swap_lock. changing flags need
+					 * hold this lock and swap_lock. If
+					 * both locks need hold, hold swap_lock
+					 * first.
+					 */
+	struct work_struct discard_work; /* discard worker */
+	struct work_struct reclaim_work; /* reclaim worker */
+	struct list_head discard_clusters; /* discard clusters list */
+	struct plist_node avail_list;   /* entry in swap_avail_head */
+};
+
+/*
+ * Max bad pages in the new format..
+ */
+#define MAX_SWAP_BADPAGES \
+	((offsetof(union swap_header, magic.magic) - \
+	  offsetof(union swap_header, info.badpages)) / sizeof(int))
+
+enum {
+	SWP_USED	= (1 << 0),	/* is slot in swap_info[] used? */
+	SWP_WRITEOK	= (1 << 1),	/* ok to write to this swap?	*/
+	SWP_DISCARDABLE = (1 << 2),	/* blkdev support discard */
+	SWP_DISCARDING	= (1 << 3),	/* now discarding a free cluster */
+	SWP_SOLIDSTATE	= (1 << 4),	/* blkdev seeks are cheap */
+	SWP_BLKDEV	= (1 << 6),	/* its a block device */
+	SWP_ACTIVATED	= (1 << 7),	/* set after swap_activate success */
+	SWP_FS_OPS	= (1 << 8),	/* swapfile operations go through fs */
+	SWP_AREA_DISCARD = (1 << 9),	/* single-time swap area discards */
+	SWP_PAGE_DISCARD = (1 << 10),	/* freed swap page-cluster discards */
+	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
+	SWP_SYNCHRONOUS_IO = (1 << 12),	/* synchronous IO is efficient */
+					/* add others here before... */
+};
+
 #ifdef CONFIG_THP_SWAP
 #define SWAPFILE_CLUSTER	HPAGE_PMD_NR
 #define swap_entry_order(order)	(order)
@@ -352,6 +425,13 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 	return i;
 }
 
+bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
+struct swap_info_struct *get_swap_device(swp_entry_t entry);
+static inline void put_swap_device(struct swap_info_struct *si)
+{
+	percpu_ref_put(&si->users);
+}
+
 #else /* CONFIG_SWAP */
 struct swap_iocb;
 static inline struct swap_cluster_info *swap_cluster_lock(
@@ -498,5 +578,17 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 {
 	return 0;
 }
+static inline bool swap_entry_swapped(struct swap_info_struct *si,
+		swp_entry_t entry)
+{
+	return false;
+}
+static inline struct swap_info_struct *get_swap_device(swp_entry_t entry)
+{
+	return NULL;
+}
+static inline void put_swap_device(struct swap_info_struct *si)
+{
+}
 #endif /* CONFIG_SWAP */
 #endif /* _MM_SWAP_H */
-- 
2.53.0


