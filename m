Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B826131677F
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Feb 2021 14:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhBJNIW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Feb 2021 08:08:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:53800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231781AbhBJNHu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 10 Feb 2021 08:07:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5445BAEB9;
        Wed, 10 Feb 2021 13:07:07 +0000 (UTC)
Date:   Wed, 10 Feb 2021 13:07:05 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: alloc_pages_bulk()
Message-ID: <20210210130705.GC3629@suse.de>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
 <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
 <20210209113108.1ca16cfa@carbon>
 <20210210084155.GA3697@techsingularity.net>
 <20210210124103.56ed1e95@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210210124103.56ed1e95@carbon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 6e479e9c48ce..d1b586e5b4b8 100644
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
index 519a60d5b6f7..f8353ea7b977 100644
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
@@ -5818,6 +5833,99 @@ static int find_next_best_node(int node, nodemask_t *used_node_mask)
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
+		page = __rmqueue_pcplist(zone, gfp_mask, migratetype,
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

-- 
Mel Gorman
SUSE Labs
