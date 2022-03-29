Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1538B4EB710
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 01:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241252AbiC2XxI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 19:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241192AbiC2XxG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 19:53:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F73020A97C;
        Tue, 29 Mar 2022 16:51:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BCB22210E4;
        Tue, 29 Mar 2022 23:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648597880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78FUAhyxyEonHm/FDM0yw+XAWXu8dlR0I1pop4ojBzY=;
        b=N3QeMRRw6Max+iDvM3u1NsZ8RJg7y1NPGTqJ9OreveC1uKBH9T+zS6fiBcWh+GYyJ211fZ
        7b3Y2dbebw+b+Mt6OKqhXWf87Ilr4LPIGKuYCQLX8N/r13XnJy3yV/Zs56n5EE0YkZbMVb
        Oeuvq+NB3spxQLZEA4sAXjf7faRVhz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648597880;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78FUAhyxyEonHm/FDM0yw+XAWXu8dlR0I1pop4ojBzY=;
        b=CjHR4+0jIzItpnvHsP10zCZbnFALAtinZTkFzYwH4Rto6TpgHLd4qhHPp30QY18zB8JZXa
        Myf3lbTfLT02ibCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CAF613A7E;
        Tue, 29 Mar 2022 23:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5X34CXabQ2IfLwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 29 Mar 2022 23:51:18 +0000
Subject: [PATCH 01/10] MM: create new mm/swap.h header file.
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 10:49:41 +1100
Message-ID: <164859778120.29473.11725907882296224053.stgit@noble.brown>
In-Reply-To: <164859751830.29473.5309689752169286816.stgit@noble.brown>
References: <164859751830.29473.5309689752169286816.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Many functions declared in include/linux/swap.h are only used within mm/

Create a new "mm/swap.h" and move some of these declarations there.
Remove the redundant 'extern' from the function declarations.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/swap.h |  121 ---------------------------------------------
 mm/huge_memory.c     |    1 
 mm/madvise.c         |    1 
 mm/memcontrol.c      |    1 
 mm/memory.c          |    1 
 mm/mincore.c         |    1 
 mm/page_alloc.c      |    1 
 mm/page_io.c         |    1 
 mm/shmem.c           |    1 
 mm/swap.h            |  133 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/swap_state.c      |    1 
 mm/swapfile.c        |    1 
 mm/util.c            |    1 
 mm/vmscan.c          |    1 
 mm/zswap.c           |    2 +
 15 files changed, 147 insertions(+), 121 deletions(-)
 create mode 100644 mm/swap.h

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 27093b477c5f..11390dde5a6c 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -420,62 +420,19 @@ extern void kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
 
-#include <linux/blk_types.h> /* for bio_end_io_t */
-
-/* linux/mm/page_io.c */
-extern int swap_readpage(struct page *page, bool do_poll);
-extern int swap_writepage(struct page *page, struct writeback_control *wbc);
-extern void end_swap_bio_write(struct bio *bio);
-extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
-	bio_end_io_t end_write_func);
 bool swap_dirty_folio(struct address_space *mapping, struct folio *folio);
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
@@ -528,12 +485,6 @@ static inline void put_swap_device(struct swap_info_struct *si)
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
@@ -548,11 +499,6 @@ static inline void put_swap_device(struct swap_info_struct *si)
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
@@ -567,14 +513,6 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
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
 
@@ -600,65 +538,6 @@ static inline void put_swap_page(struct page *page, swp_entry_t swp)
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
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2fe38212e07c..2b433920726d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -39,6 +39,7 @@
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
 #include "internal.h"
+#include "swap.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/thp.h>
diff --git a/mm/madvise.c b/mm/madvise.c
index b41858ee937b..4f48e48432e8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -35,6 +35,7 @@
 #include <asm/tlb.h>
 
 #include "internal.h"
+#include "swap.h"
 
 struct madvise_walk_private {
 	struct mmu_gather *tlb;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 725f76723220..4f4cb6a464fb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -67,6 +67,7 @@
 #include <net/sock.h>
 #include <net/ip.h>
 #include "slab.h"
+#include "swap.h"
 
 #include <linux/uaccess.h>
 
diff --git a/mm/memory.c b/mm/memory.c
index be44d0b36b18..92ea8ac374a4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -86,6 +86,7 @@
 
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
index bdc8f60ae462..82bfcd23d0eb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -81,6 +81,7 @@
 #include "internal.h"
 #include "shuffle.h"
 #include "page_reporting.h"
+#include "swap.h"
 
 /* Free Page Internal flags: for internal, non-pcp variants of free_pages(). */
 typedef int __bitwise fpi_t;
diff --git a/mm/page_io.c b/mm/page_io.c
index b417f000b49e..d01ab9d5410a 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -26,6 +26,7 @@
 #include <linux/uio.h>
 #include <linux/sched/task.h>
 #include <linux/delayacct.h>
+#include "swap.h"
 
 void end_swap_bio_write(struct bio *bio)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index 529c9ad3e926..31db146f15ec 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -38,6 +38,7 @@
 #include <linux/hugetlb.h>
 #include <linux/fs_parser.h>
 #include <linux/swapfile.h>
+#include "swap.h"
 
 static struct vfsmount *shm_mnt;
 
diff --git a/mm/swap.h b/mm/swap.h
new file mode 100644
index 000000000000..f8265bf0ce00
--- /dev/null
+++ b/mm/swap.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _MM_SWAP_H
+#define _MM_SWAP_H
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
+void delete_from_swap_cache(struct page *page);
+void clear_shadow_from_swap_cache(int type, unsigned long begin,
+				  unsigned long end);
+void free_swap_cache(struct page *page);
+struct page *lookup_swap_cache(swp_entry_t entry,
+			       struct vm_area_struct *vma,
+			       unsigned long addr);
+struct page *find_get_incore_page(struct address_space *mapping, pgoff_t index);
+
+struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
+				   struct vm_area_struct *vma,
+				   unsigned long addr,
+				   bool do_poll);
+struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
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
+#endif /* _MM_SWAP_H */
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 013856004825..5437dd317cf3 100644
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
index 63c61f8b2611..2650927a009b 100644
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
index 54e5e761a9a9..e8f59c0ef90f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -27,6 +27,7 @@
 #include <linux/uaccess.h>
 
 #include "internal.h"
+#include "swap.h"
 
 /**
  * kfree_const - conditionally free memory
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1678802e03e7..60378d36ec77 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -59,6 +59,7 @@
 #include <linux/sched/sysctl.h>
 
 #include "internal.h"
+#include "swap.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/vmscan.h>
diff --git a/mm/zswap.c b/mm/zswap.c
index 3efd8cae315e..2c5db4cbedea 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -36,6 +36,8 @@
 #include <linux/pagemap.h>
 #include <linux/workqueue.h>
 
+#include "swap.h"
+
 /*********************************
 * statistics
 **********************************/


