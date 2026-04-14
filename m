Return-Path: <linux-nfs+bounces-20833-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKh7INgG3mlRmQkAu9opvQ
	(envelope-from <linux-nfs+bounces-20833-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 11:20:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C123F7CFF
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 11:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D340301A538
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AFB35B631;
	Tue, 14 Apr 2026 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xKD7OtXc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4C3B9D90
	for <linux-nfs@vger.kernel.org>; Tue, 14 Apr 2026 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158176; cv=none; b=S3abyoijge+8dfgeuiKfF7fAsC1u/b3wZuzHKU8/wwhulD6C903dLih1e7FuK+zF+AOybcwOGTssIM4Ri87wSP0bKGB3wN1O7mzKhtvb33bCTs+BHkTfTJM1i3KJ3P98j+Qdgn9DZLcwWFgNnPWRknuex4+dGiZ+FOxcv22zxAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158176; c=relaxed/simple;
	bh=TZ7tyhV0Or+wnbgLUQgLKLLZWUO2JrR236fhabcxkeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7tK6t47ZsvoSyr/vEDjWGfCSdR+lyWczKVvf8a1bTqS+991GxUyJPBJslxIAG/4bWtrAg3BrUgBwqi7WD9dTKHuPzRcIA8kK6tFd1AfKxQMl/qS+k5ujIVPLgxPNrTSIwQfReypFwN08j9HXS+0e7YRZHitujGJ5RT2QuIfBTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xKD7OtXc; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776158172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubfySRhL7H2ALfoVfoAbTG+vWRfRjBu73p+puM1I0vE=;
	b=xKD7OtXcIsrwj1A0b0Itu601MKl/5NJ+Z0FGvgmv1pfr3euBdkog0LGDvJBe4hIkNDVTku
	mgSwNGLQjVUnIbnhuBdwF9V3qaKkp+SUraT5C3qywZ9fdaiGetCOGQPw5x4h6xn9mE+JFw
	1PF6B8WPGUWQtCNRt1t5U+XM/AdVoLM=
From: Ye Liu <ye.liu@linux.dev>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>
Cc: Ye Liu <liuye@kylinos.cn>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Youngjun Park <youngjun.park@lge.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] mm/vmstat: use node_stat_add_folio/sub_folio for folio_nr_pages operations
Date: Tue, 14 Apr 2026 17:15:18 +0800
Message-ID: <20260414091527.2970844-2-ye.liu@linux.dev>
In-Reply-To: <20260414091527.2970844-1-ye.liu@linux.dev>
References: <20260414091527.2970844-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kylinos.cn,google.com,suse.com,cmpxchg.org,nvidia.com,ziepe.ca,redhat.com,linux.alibaba.com,oracle.com,arm.com,kernel.org,linux.dev,intel.com,gmail.com,sk.com,gourry.net,huaweicloud.com,lge.com,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[40];
	TAGGED_FROM(0.00)[bounces-20833-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ye.liu@linux.dev,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.971];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9C123F7CFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ye Liu <liuye@kylinos.cn>

Replace node_stat_mod_folio() calls that pass folio_nr_pages(folio) or
-folio_nr_pages(folio) as the third argument with the more concise
node_stat_add_folio() and node_stat_sub_folio() functions respectively.

This makes the code more readable and reduces the number of arguments
passed to these functions.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 fs/nfs/internal.h   |  2 +-
 fs/nfs/write.c      |  2 +-
 mm/compaction.c     |  5 ++---
 mm/gup.c            |  5 ++---
 mm/khugepaged.c     | 10 ++++------
 mm/mempolicy.c      |  5 ++---
 mm/migrate.c        | 12 +++++-------
 mm/page-writeback.c |  4 ++--
 mm/swap_state.c     |  4 ++--
 9 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index fc5456377160..f5c52a2d2a1f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -858,7 +858,7 @@ static inline void nfs_folio_mark_unstable(struct folio *folio,
 		/* This page is really still in write-back - just that the
 		 * writeback is happening on the server now.
 		 */
-		node_stat_mod_folio(folio, NR_WRITEBACK, nr);
+		node_stat_add_folio(folio, NR_WRITEBACK);
 		bdi_wb_stat_mod(inode, WB_WRITEBACK, nr);
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 	}
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index cc02b57de3c7..a8700824a61b 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -871,7 +871,7 @@ static void nfs_folio_clear_commit(struct folio *folio)
 	if (folio) {
 		long nr = folio_nr_pages(folio);
 
-		node_stat_mod_folio(folio, NR_WRITEBACK, -nr);
+		node_stat_sub_folio(folio, NR_WRITEBACK);
 		bdi_wb_stat_mod(folio->mapping->host, WB_WRITEBACK, -nr);
 	}
 }
diff --git a/mm/compaction.c b/mm/compaction.c
index 3648ce22c807..d7ce622aeed1 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1215,9 +1215,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 		/* Successfully isolated */
 		lruvec_del_folio(lruvec, folio);
-		node_stat_mod_folio(folio,
-				NR_ISOLATED_ANON + folio_is_file_lru(folio),
-				folio_nr_pages(folio));
+		node_stat_add_folio(folio,
+				NR_ISOLATED_ANON + folio_is_file_lru(folio));
 
 isolate_success:
 		list_add(&folio->lru, &cc->migratepages);
diff --git a/mm/gup.c b/mm/gup.c
index ad9ded39609c..2cb2efa20bff 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2304,9 +2304,8 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 
 		list_add_tail(&folio->lru, movable_folio_list);
-		node_stat_mod_folio(folio,
-				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
-				    folio_nr_pages(folio));
+		node_stat_add_folio(folio,
+				    NR_ISOLATED_ANON + folio_is_file_lru(folio));
 	}
 
 	return collected;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b8452dbdb043..f662de753305 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -502,9 +502,8 @@ void __khugepaged_exit(struct mm_struct *mm)
 
 static void release_pte_folio(struct folio *folio)
 {
-	node_stat_mod_folio(folio,
-			NR_ISOLATED_ANON + folio_is_file_lru(folio),
-			-folio_nr_pages(folio));
+	node_stat_sub_folio(folio,
+			NR_ISOLATED_ANON + folio_is_file_lru(folio));
 	folio_unlock(folio);
 	folio_putback_lru(folio);
 }
@@ -650,9 +649,8 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			result = SCAN_DEL_PAGE_LRU;
 			goto out;
 		}
-		node_stat_mod_folio(folio,
-				NR_ISOLATED_ANON + folio_is_file_lru(folio),
-				folio_nr_pages(folio));
+		node_stat_add_folio(folio,
+				NR_ISOLATED_ANON + folio_is_file_lru(folio));
 		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 		VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4e4421b22b59..1c413f66b35f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1259,9 +1259,8 @@ static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 	if ((flags & MPOL_MF_MOVE_ALL) || !folio_maybe_mapped_shared(folio)) {
 		if (folio_isolate_lru(folio)) {
 			list_add_tail(&folio->lru, foliolist);
-			node_stat_mod_folio(folio,
-				NR_ISOLATED_ANON + folio_is_file_lru(folio),
-				folio_nr_pages(folio));
+			node_stat_add_folio(folio,
+				NR_ISOLATED_ANON + folio_is_file_lru(folio));
 		} else {
 			/*
 			 * Non-movable folio may reach here.  And, there may be
diff --git a/mm/migrate.c b/mm/migrate.c
index 8a64291ab5b4..dc8cfee37a70 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -268,8 +268,8 @@ void putback_movable_pages(struct list_head *l)
 		if (unlikely(page_has_movable_ops(&folio->page))) {
 			putback_movable_ops_page(&folio->page);
 		} else {
-			node_stat_mod_folio(folio, NR_ISOLATED_ANON +
-					folio_is_file_lru(folio), -folio_nr_pages(folio));
+			node_stat_sub_folio(folio, NR_ISOLATED_ANON +
+					folio_is_file_lru(folio));
 			folio_putback_lru(folio);
 		}
 	}
@@ -2272,9 +2272,8 @@ static int __add_folio_for_migration(struct folio *folio, int node,
 			return 1;
 	} else if (folio_isolate_lru(folio)) {
 		list_add_tail(&folio->lru, pagelist);
-		node_stat_mod_folio(folio,
-			NR_ISOLATED_ANON + folio_is_file_lru(folio),
-			folio_nr_pages(folio));
+		node_stat_add_folio(folio,
+			NR_ISOLATED_ANON + folio_is_file_lru(folio));
 		return 1;
 	}
 	return -EBUSY;
@@ -2726,8 +2725,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 	if (!folio_isolate_lru(folio))
 		return -EAGAIN;
 
-	node_stat_mod_folio(folio, NR_ISOLATED_ANON + folio_is_file_lru(folio),
-			    nr_pages);
+	node_stat_add_folio(folio, NR_ISOLATED_ANON + folio_is_file_lru(folio));
 	return 0;
 }
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 833f743f309f..87e9ea41313a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2750,7 +2750,7 @@ bool folio_redirty_for_writepage(struct writeback_control *wbc,
 
 		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 		current->nr_dirtied -= nr;
-		node_stat_mod_folio(folio, NR_DIRTIED, -nr);
+		node_stat_sub_folio(folio, NR_DIRTIED);
 		wb_stat_mod(wb, WB_DIRTIED, -nr);
 		unlocked_inode_to_wb_end(inode, &cookie);
 	}
@@ -2981,7 +2981,7 @@ bool __folio_end_writeback(struct folio *folio)
 
 	lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr);
 	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
-	node_stat_mod_folio(folio, NR_WRITTEN, nr);
+	node_stat_add_folio(folio, NR_WRITTEN);
 
 	return ret;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 1415a5c54a43..d08e923c9979 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -160,7 +160,7 @@ void __swap_cache_add_folio(struct swap_cluster_info *ci,
 	folio_set_swapcache(folio);
 	folio->swap = entry;
 
-	node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
+	node_stat_add_folio(folio, NR_FILE_PAGES);
 	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
 }
 
@@ -265,7 +265,7 @@ void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
 
 	folio->swap.val = 0;
 	folio_clear_swapcache(folio);
-	node_stat_mod_folio(folio, NR_FILE_PAGES, -nr_pages);
+	node_stat_sub_folio(folio, NR_FILE_PAGES);
 	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr_pages);
 
 	if (!folio_swapped) {
-- 
2.43.0


