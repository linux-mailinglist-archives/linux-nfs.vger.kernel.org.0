Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EB24780DA
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhLPXw2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:52:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47058 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhLPXw2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:52:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E2E8A2111A;
        Thu, 16 Dec 2021 23:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cY/eypVNNHD1cZaQ8vKdoi5Gyv0t4LUDjHUscRDhk30=;
        b=IgDmkb062+ktR5wPexm2UVfch18gGVZ11eht2BuUDkkBL+dhtRIv2TlMVbD+PFiNuApmHc
        DBNzc/PPZxmlcaJVWCQ63pfrReLguAwm6IjgWI7Jcda9tvgSdUdYIQgsJuPTLt7HoKpOGs
        l39rJ0Hyxb6+ZhXLa3IE46nbdMtt5fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698746;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cY/eypVNNHD1cZaQ8vKdoi5Gyv0t4LUDjHUscRDhk30=;
        b=VAsVCjzY8r3AO1a1zXPZMQ2VBuuAVHJe41M1BabTlKf+kOjd7EalIvtWnd1UzGtXHPKH5g
        C4/MHD2CajK+GMBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C74613EFD;
        Thu, 16 Dec 2021 23:52:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W5H4FTfRu2FIWwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:52:23 +0000
Subject: [PATCH 02/18] MM: create new mm/swap.h header file.
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Dec 2021 10:48:22 +1100
Message-ID: <163969850279.20885.7172996032577523902.stgit@noble.brown>
In-Reply-To: <163969801519.20885.3977673503103544412.stgit@noble.brown>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Many functions declared in include/linux/swap.h are only used within mm/

Create a new "mm/swap.h" and move some of these declarations there.
Remove the redundant 'extern' from the function declarations.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/swap.h |  121 -----------------------------------------------
 mm/madvise.c         |    1 
 mm/memory.c          |    1 
 mm/mincore.c         |    1 
 mm/page_alloc.c      |    1 
 mm/page_io.c         |    1 
 mm/shmem.c           |    1 
 mm/swap.h            |  129 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/swap_state.c      |    1 
 mm/swapfile.c        |    1 
 mm/util.c            |    1 
 mm/vmscan.c          |    1 
 12 files changed, 139 insertions(+), 121 deletions(-)
 create mode 100644 mm/swap.h

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 10b2a92c1aa1..6a0c25c0bb95 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -419,61 +419,18 @@ extern void kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
 
-#include <linux/blk_types.h> /* for bio_end_io_t */
-
-/* linux/mm/page_io.c */
-extern int swap_readpage(struct page *page, bool do_poll);
-extern int swap_writepage(struct page *page, struct writeback_control *wbc);
-extern void end_swap_bio_write(struct bio *bio);
-extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
-	bio_end_io_t end_write_func);
-
 int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
 		unsigned long nr_pages, sector_t start_block);
 int generic_swapfile_activate(struct swap_info_struct *, struct file *,
 		sector_t *);
 
-/* linux/mm/swap_state.c */
-/* One swap address space for each 64M swap space */
-#define SWAP_ADDRESS_SPACE_SHIFT	14
-#define SWAP_ADDRESS_SPACE_PAGES	(1 << SWAP_ADDRESS_SPACE_SHIFT)
-extern struct address_space *swapper_spaces[];
-#define swap_address_space(entry)			    \
-	(&swapper_spaces[swp_type(entry)][swp_offset(entry) \
-		>> SWAP_ADDRESS_SPACE_SHIFT])
 static inline unsigned long total_swapcache_pages(void)
 {
 	return global_node_page_state(NR_SWAPCACHE);
 }
 
-extern void show_swap_cache_info(void);
-extern int add_to_swap(struct page *page);
-extern void *get_shadow_from_swap_cache(swp_entry_t entry);
-extern int add_to_swap_cache(struct page *page, swp_entry_t entry,
-			gfp_t gfp, void **shadowp);
-extern void __delete_from_swap_cache(struct page *page,
-			swp_entry_t entry, void *shadow);
-extern void delete_from_swap_cache(struct page *);
-extern void clear_shadow_from_swap_cache(int type, unsigned long begin,
-				unsigned long end);
-extern void free_swap_cache(struct page *);
 extern void free_page_and_swap_cache(struct page *);
 extern void free_pages_and_swap_cache(struct page **, int);
-extern struct page *lookup_swap_cache(swp_entry_t entry,
-				      struct vm_area_struct *vma,
-				      unsigned long addr);
-struct page *find_get_incore_page(struct address_space *mapping, pgoff_t index);
-extern struct page *read_swap_cache_async(swp_entry_t, gfp_t,
-			struct vm_area_struct *vma, unsigned long addr,
-			bool do_poll);
-extern struct page *__read_swap_cache_async(swp_entry_t, gfp_t,
-			struct vm_area_struct *vma, unsigned long addr,
-			bool *new_page_allocated);
-extern struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
-				struct vm_fault *vmf);
-extern struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
-				struct vm_fault *vmf);
-
 /* linux/mm/swapfile.c */
 extern atomic_long_t nr_swap_pages;
 extern long total_swap_pages;
@@ -527,12 +484,6 @@ static inline void put_swap_device(struct swap_info_struct *si)
 }
 
 #else /* CONFIG_SWAP */
-
-static inline int swap_readpage(struct page *page, bool do_poll)
-{
-	return 0;
-}
-
 static inline struct swap_info_struct *swp_swap_info(swp_entry_t entry)
 {
 	return NULL;
@@ -547,11 +498,6 @@ static inline void put_swap_device(struct swap_info_struct *si)
 {
 }
 
-static inline struct address_space *swap_address_space(swp_entry_t entry)
-{
-	return NULL;
-}
-
 #define get_nr_swap_pages()			0L
 #define total_swap_pages			0L
 #define total_swapcache_pages()			0UL
@@ -566,14 +512,6 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
 #define free_pages_and_swap_cache(pages, nr) \
 	release_pages((pages), (nr));
 
-static inline void free_swap_cache(struct page *page)
-{
-}
-
-static inline void show_swap_cache_info(void)
-{
-}
-
 /* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=0 */
 #define free_swap_and_cache(e) is_pfn_swap_entry(e)
 
@@ -599,65 +537,6 @@ static inline void put_swap_page(struct page *page, swp_entry_t swp)
 {
 }
 
-static inline struct page *swap_cluster_readahead(swp_entry_t entry,
-				gfp_t gfp_mask, struct vm_fault *vmf)
-{
-	return NULL;
-}
-
-static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
-			struct vm_fault *vmf)
-{
-	return NULL;
-}
-
-static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
-{
-	return 0;
-}
-
-static inline struct page *lookup_swap_cache(swp_entry_t swp,
-					     struct vm_area_struct *vma,
-					     unsigned long addr)
-{
-	return NULL;
-}
-
-static inline
-struct page *find_get_incore_page(struct address_space *mapping, pgoff_t index)
-{
-	return find_get_page(mapping, index);
-}
-
-static inline int add_to_swap(struct page *page)
-{
-	return 0;
-}
-
-static inline void *get_shadow_from_swap_cache(swp_entry_t entry)
-{
-	return NULL;
-}
-
-static inline int add_to_swap_cache(struct page *page, swp_entry_t entry,
-					gfp_t gfp_mask, void **shadowp)
-{
-	return -1;
-}
-
-static inline void __delete_from_swap_cache(struct page *page,
-					swp_entry_t entry, void *shadow)
-{
-}
-
-static inline void delete_from_swap_cache(struct page *page)
-{
-}
-
-static inline void clear_shadow_from_swap_cache(int type, unsigned long begin,
-				unsigned long end)
-{
-}
 
 static inline int page_swapcount(struct page *page)
 {
diff --git a/mm/madvise.c b/mm/madvise.c
index 8c927202bbe6..724470773582 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -33,6 +33,7 @@
 #include <asm/tlb.h>
 
 #include "internal.h"
+#include "swap.h"
 
 struct madvise_walk_private {
 	struct mmu_gather *tlb;
diff --git a/mm/memory.c b/mm/memory.c
index 8f1de811a1dc..80bbfd449b40 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -85,6 +85,7 @@
 
 #include "pgalloc-track.h"
 #include "internal.h"
+#include "swap.h"
 
 #if defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS) && !defined(CONFIG_COMPILE_TEST)
 #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
diff --git a/mm/mincore.c b/mm/mincore.c
index 9122676b54d6..f4f627325e12 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -20,6 +20,7 @@
 #include <linux/pgtable.h>
 
 #include <linux/uaccess.h>
+#include "swap.h"
 
 static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
 			unsigned long end, struct mm_walk *walk)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..c0b7a3878801 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -78,6 +78,7 @@
 #include "internal.h"
 #include "shuffle.h"
 #include "page_reporting.h"
+#include "swap.h"
 
 /* Free Page Internal flags: for internal, non-pcp variants of free_pages(). */
 typedef int __bitwise fpi_t;
diff --git a/mm/page_io.c b/mm/page_io.c
index cb617a4f59df..a9fe5de5dc32 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -25,6 +25,7 @@
 #include <linux/psi.h>
 #include <linux/uio.h>
 #include <linux/sched/task.h>
+#include "swap.h"
 
 void end_swap_bio_write(struct bio *bio)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index 18f93c2d68f1..993b6b3ca20f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -39,6 +39,7 @@
 #include <linux/frontswap.h>
 #include <linux/fs_parser.h>
 #include <linux/swapfile.h>
+#include "swap.h"
 
 static struct vfsmount *shm_mnt;
 
diff --git a/mm/swap.h b/mm/swap.h
new file mode 100644
index 000000000000..13e72a5023aa
--- /dev/null
+++ b/mm/swap.h
@@ -0,0 +1,129 @@
+
+#ifdef CONFIG_SWAP
+#include <linux/blk_types.h> /* for bio_end_io_t */
+
+/* linux/mm/page_io.c */
+int swap_readpage(struct page *page, bool do_poll);
+int swap_writepage(struct page *page, struct writeback_control *wbc);
+void end_swap_bio_write(struct bio *bio);
+int __swap_writepage(struct page *page, struct writeback_control *wbc,
+		     bio_end_io_t end_write_func);
+
+/* linux/mm/swap_state.c */
+/* One swap address space for each 64M swap space */
+#define SWAP_ADDRESS_SPACE_SHIFT	14
+#define SWAP_ADDRESS_SPACE_PAGES	(1 << SWAP_ADDRESS_SPACE_SHIFT)
+extern struct address_space *swapper_spaces[];
+#define swap_address_space(entry)			    \
+	(&swapper_spaces[swp_type(entry)][swp_offset(entry) \
+		>> SWAP_ADDRESS_SPACE_SHIFT])
+
+void show_swap_cache_info(void);
+int add_to_swap(struct page *page);
+void *get_shadow_from_swap_cache(swp_entry_t entry);
+int add_to_swap_cache(struct page *page, swp_entry_t entry,
+		      gfp_t gfp, void **shadowp);
+void __delete_from_swap_cache(struct page *page,
+			      swp_entry_t entry, void *shadow);
+void delete_from_swap_cache(struct page *);
+void clear_shadow_from_swap_cache(int type, unsigned long begin,
+				  unsigned long end);
+void free_swap_cache(struct page *);
+struct page *lookup_swap_cache(swp_entry_t entry,
+			       struct vm_area_struct *vma,
+			       unsigned long addr);
+struct page *find_get_incore_page(struct address_space *mapping, pgoff_t index);
+
+struct page *read_swap_cache_async(swp_entry_t, gfp_t,
+				   struct vm_area_struct *vma,
+				   unsigned long addr,
+				   bool do_poll);
+struct page *__read_swap_cache_async(swp_entry_t, gfp_t,
+				     struct vm_area_struct *vma,
+				     unsigned long addr,
+				     bool *new_page_allocated);
+struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
+				    struct vm_fault *vmf);
+struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
+			      struct vm_fault *vmf);
+
+#else /* CONFIG_SWAP */
+static inline int swap_readpage(struct page *page, bool do_poll)
+{
+	return 0;
+}
+
+static inline struct address_space *swap_address_space(swp_entry_t entry)
+{
+	return NULL;
+}
+
+static inline void free_swap_cache(struct page *page)
+{
+}
+
+static inline void show_swap_cache_info(void)
+{
+}
+
+static inline struct page *swap_cluster_readahead(swp_entry_t entry,
+				gfp_t gfp_mask, struct vm_fault *vmf)
+{
+	return NULL;
+}
+
+static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
+			struct vm_fault *vmf)
+{
+	return NULL;
+}
+
+static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
+{
+	return 0;
+}
+
+static inline struct page *lookup_swap_cache(swp_entry_t swp,
+					     struct vm_area_struct *vma,
+					     unsigned long addr)
+{
+	return NULL;
+}
+
+static inline
+struct page *find_get_incore_page(struct address_space *mapping, pgoff_t index)
+{
+	return find_get_page(mapping, index);
+}
+
+static inline int add_to_swap(struct page *page)
+{
+	return 0;
+}
+
+static inline void *get_shadow_from_swap_cache(swp_entry_t entry)
+{
+	return NULL;
+}
+
+static inline int add_to_swap_cache(struct page *page, swp_entry_t entry,
+					gfp_t gfp_mask, void **shadowp)
+{
+	return -1;
+}
+
+static inline void __delete_from_swap_cache(struct page *page,
+					swp_entry_t entry, void *shadow)
+{
+}
+
+static inline void delete_from_swap_cache(struct page *page)
+{
+}
+
+static inline void clear_shadow_from_swap_cache(int type, unsigned long begin,
+				unsigned long end)
+{
+}
+
+#endif /* CONFIG_SWAP */
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 616eb1d75b35..514b86b05488 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -23,6 +23,7 @@
 #include <linux/huge_mm.h>
 #include <linux/shmem_fs.h>
 #include "internal.h"
+#include "swap.h"
 
 /*
  * swapper_space is a fiction, retained to simplify the path through
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 419eacf474c5..f23d9ff21cf8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -44,6 +44,7 @@
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
 #include <linux/swap_cgroup.h>
+#include "swap.h"
 
 static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 				 unsigned char);
diff --git a/mm/util.c b/mm/util.c
index 741ba32a43ac..7e26387be090 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -27,6 +27,7 @@
 #include <linux/uaccess.h>
 
 #include "internal.h"
+#include "swap.h"
 
 /**
  * kfree_const - conditionally free memory
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641ac7..969bcdb4ca80 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -58,6 +58,7 @@
 #include <linux/balloon_compaction.h>
 
 #include "internal.h"
+#include "swap.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/vmscan.h>


