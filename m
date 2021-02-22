Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27013321B5B
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 16:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhBVPZ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 10:25:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231267AbhBVPX6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 22 Feb 2021 10:23:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6C5964EC3;
        Mon, 22 Feb 2021 15:23:14 +0000 (UTC)
Subject: [PATCH v2 2/4] mm: alloc_pages_bulk()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     mgorman@techsingularity.net
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org, kuba@kernel.org
Date:   Mon, 22 Feb 2021 10:23:13 -0500
Message-ID: <161400739391.195066.14757725055346872907.stgit@klimt.1015granger.net>
In-Reply-To: <161400722731.195066.9584156841718557193.stgit@klimt.1015granger.net>
References: <161400722731.195066.9584156841718557193.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Mel Gorman <mgorman@suse.de>

On Wed, Feb 10, 2021 at 12:41:03PM +0100, Jesper Dangaard Brouer wrote:
> On Wed, 10 Feb 2021 08:41:55 +0000
> Mel Gorman <mgorman@techsingularity.net> wrote:
>
> > On Tue, Feb 09, 2021 at 11:31:08AM +0100, Jesper Dangaard Brouer wrote:
> > > > > Neil Brown pointed me to this old thread:
> > > > >
> > > > > https://lore.kernel.org/lkml/20170109163518.6001-1-mgorman@techsingularity.net/
> > > > >
> > > > > We see that many of the prerequisites are in v5.11-rc, but
> > > > > alloc_page_bulk() is not. I tried forward-porting 4/4 in that
> > > > > series, but enough internal APIs have changed since 2017 that
> > > > > the patch does not come close to applying and compiling.
> > >
> > > I forgot that this was never merged.  It is sad as Mel showed huge
> > > improvement with his work.
> > >
> > > > > I'm wondering:
> > > > >
> > > > > a) is there a newer version of that work?
> > > > >
> > >
> > > Mel, why was this work never merged upstream?
> > >
> >
> > Lack of realistic consumers to drive it forward, finalise the API and
> > confirm it was working as expected. It eventually died as a result. If it
> > was reintroduced, it would need to be forward ported and then implement
> > at least one user on top.
>
> I guess I misunderstood you back in 2017. I though that I had presented
> a clear use-case/consumer in page_pool[1].

You did but it was never integrated and/or tested AFAIK. I see page_pool
accepts orders so even by the original prototype, it would only have seen
a benefit for order-0 pages. It would also have needed some supporting
data that it actually helped with drivers using the page_pool interface
which I was not in the position to properly test at the time.

> But you wanted the code as
> part of the patchset I guess.  I though, I could add it later via the
> net-next tree.
>

Yes, a consumer of the code should go in at the same time with supporting
data showing it actually helps because otherwise it's dead code.

> It seems that Chuck now have a NFS use-case, and Hellwig also have a
> use-case for DMA-iommu in __iommu_dma_alloc_pages.
>
> The performance improvement (in above link) were really impressive!
>
> Quote:
>  "It's roughly a 50-70% reduction of allocation costs and roughly a halving of the
>  overall cost of allocating/freeing batches of pages."
>
> Who have time to revive this patchset?
>

Not in the short term due to bug load and other obligations.

The original series had "mm, page_allocator: Only use per-cpu allocator
for irq-safe requests" but that was ultimately rejected because softirqs
were affected so it would have to be done without that patch.

The last patch can be rebased easily enough but it only batch allocates
order-0 pages. It's also only build tested and could be completely
miserable in practice and as I didn't even try boot test let, let alone
actually test it, it could be a giant pile of crap. To make high orders
work, it would need significant reworking but if the API showed even
partial benefit, it might motiviate someone to reimplement the bulk
interfaces to perform better.

Rebased diff, build tested only, might not even work

Signed-off-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/gfp.h |   24 +++++++++++
 mm/page_alloc.c     |  110 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 80544d5c08e7..4363627a0fe2 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -511,6 +511,29 @@ __alloc_pages(gfp_t gfp_mask, unsigned int order, int preferred_nid)
 	return __alloc_pages_nodemask(gfp_mask, order, preferred_nid, NULL);
 }
 
+unsigned long
+__alloc_pages_bulk_nodemask(gfp_t gfp_mask, unsigned int order,
+			struct zonelist *zonelist, nodemask_t *nodemask,
+			unsigned long nr_pages, struct list_head *alloc_list);
+
+static inline unsigned long
+__alloc_pages_bulk(gfp_t gfp_mask, unsigned int order,
+		struct zonelist *zonelist, unsigned long nr_pages,
+		struct list_head *list)
+{
+	return __alloc_pages_bulk_nodemask(gfp_mask, order, zonelist, NULL,
+						nr_pages, list);
+}
+
+static inline unsigned long
+alloc_pages_bulk(gfp_t gfp_mask, unsigned int order,
+		unsigned long nr_pages, struct list_head *list)
+{
+	int nid = numa_mem_id();
+	return __alloc_pages_bulk(gfp_mask, order,
+			node_zonelist(nid, gfp_mask), nr_pages, list);
+}
+
 /*
  * Allocate pages, preferring the node given as nid. The node must be valid and
  * online. For more general interface, see alloc_pages_node().
@@ -580,6 +603,7 @@ void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask);
 
 extern void __free_pages(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
+extern void free_pages_bulk(struct list_head *list);
 
 struct page_frag_cache;
 extern void __page_frag_cache_drain(struct page *page, unsigned int count);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ef5070fed76b..da6984094913 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3254,7 +3254,7 @@ void free_unref_page(struct page *page)
 }
 
 /*
- * Free a list of 0-order pages
+ * Free a list of 0-order pages whose reference count is already zero.
  */
 void free_unref_page_list(struct list_head *list)
 {
@@ -4435,6 +4435,21 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 	}
 }
 
+/* Drop reference counts and free pages from a list */
+void free_pages_bulk(struct list_head *list)
+{
+	struct page *page, *next;
+
+	list_for_each_entry_safe(page, next, list, lru) {
+		trace_mm_page_free_batched(page);
+		if (put_page_testzero(page)) {
+			list_del(&page->lru);
+			__free_pages_ok(page, 0, FPI_NONE);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(free_pages_bulk);
+
 static inline unsigned int
 gfp_to_alloc_flags(gfp_t gfp_mask)
 {
@@ -5820,6 +5835,99 @@ static int find_next_best_node(int node, nodemask_t *used_node_mask)
 }
 
 
+/*
+ * This is a batched version of the page allocator that attempts to
+ * allocate nr_pages quickly from the preferred zone and add them to list.
+ * Note that there is no guarantee that nr_pages will be allocated although
+ * every effort will be made to allocate at least one. Unlike the core
+ * allocator, no special effort is made to recover from transient
+ * failures caused by changes in cpusets. It should only be used from !IRQ
+ * context. An attempt to allocate a batch of patches from an interrupt
+ * will allocate a single page.
+ */
+unsigned long
+__alloc_pages_bulk_nodemask(gfp_t gfp_mask, unsigned int order,
+			struct zonelist *zonelist, nodemask_t *nodemask,
+			unsigned long nr_pages, struct list_head *alloc_list)
+{
+	struct page *page;
+	unsigned long alloced = 0;
+	unsigned int alloc_flags = ALLOC_WMARK_LOW;
+	unsigned long flags;
+	struct zone *zone;
+	struct per_cpu_pages *pcp;
+	struct list_head *pcp_list;
+	int migratetype;
+	gfp_t alloc_mask = gfp_mask; /* The gfp_t that was actually used for allocation */
+	struct alloc_context ac = { };
+
+	/* If there are already pages on the list, don't bother */
+	if (!list_empty(alloc_list))
+		return 0;
+
+	/* Order-0 cannot go through per-cpu lists */
+	if (order)
+		goto failed;
+
+	gfp_mask &= gfp_allowed_mask;
+
+	if (!prepare_alloc_pages(gfp_mask, order, numa_mem_id(), nodemask, &ac, &alloc_mask, &alloc_flags))
+		return 0;
+
+	if (!ac.preferred_zoneref)
+		return 0;
+
+	/*
+	 * Only attempt a batch allocation if watermarks on the preferred zone
+	 * are safe.
+	 */
+	zone = ac.preferred_zoneref->zone;
+	if (!zone_watermark_fast(zone, order, high_wmark_pages(zone) + nr_pages,
+				 zonelist_zone_idx(ac.preferred_zoneref), alloc_flags, gfp_mask))
+		goto failed;
+
+	/* Attempt the batch allocation */
+	migratetype = ac.migratetype;
+
+	local_irq_save(flags);
+	pcp = &this_cpu_ptr(zone->pageset)->pcp;
+	pcp_list = &pcp->lists[migratetype];
+
+	while (nr_pages) {
+		page = __rmqueue_pcplist(zone, migratetype, alloc_flags,
+								pcp, pcp_list);
+		if (!page)
+			break;
+
+		prep_new_page(page, order, gfp_mask, 0);
+		nr_pages--;
+		alloced++;
+		list_add(&page->lru, alloc_list);
+	}
+
+	if (!alloced) {
+		preempt_enable_no_resched();
+		goto failed;
+	}
+
+	__count_zid_vm_events(PGALLOC, zone_idx(zone), alloced);
+	zone_statistics(zone, zone);
+
+	local_irq_restore(flags);
+
+	return alloced;
+
+failed:
+	page = __alloc_pages_nodemask(gfp_mask, order, numa_node_id(), nodemask);
+	if (page) {
+		alloced++;
+		list_add(&page->lru, alloc_list);
+	}
+
+	return alloced;
+}
+EXPORT_SYMBOL(__alloc_pages_bulk_nodemask);
+
 /*
  * Build zonelists ordered by node and zones within node.
  * This results in maximum locality--normal zone overflows into local


