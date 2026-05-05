Return-Path: <linux-nfs+bounces-21397-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCRWOlI++mmjLAMAu9opvQ
	(envelope-from <linux-nfs+bounces-21397-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 21:00:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0A4D2F93
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 21:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4C893022051
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 19:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B173CEBB1;
	Tue,  5 May 2026 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw/HlPtL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A421F5847;
	Tue,  5 May 2026 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007620; cv=none; b=jPbMdNNThAsJUQbyFu56UKPQ8iQwJayW/OUoVVHX1fYVhstDrQqMUPIKadKli8KtB52/dJ6+/jvAIcthhxNEQaKBwxeKsqJGunBuc+JIh0KchzRR+nshu7u78MWdxe2ZQPnvbgDn5AJ1SLDZbZkEAvrbXG9fwVoIxZC25uVLs0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007620; c=relaxed/simple;
	bh=/OcYNCE/fDC5kwoNxmn93OOTbnEEIB7Un/u2ZoKZZmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MS9MDYoVIjIVP861RhZ+D8rxnu2A9elUYC7XC7YQFzr9NDkgU9i1zw4MnVrSYPeHTZK1hha2kBnuvOrsj8PCf7NPu4i7v5sWyTgTigbt0MR5BXiQQ7JES/wz2Xjln8wiyqSFXiaO6MWMk4XfOrb3MaMQIO06pgVPO62rPPNiihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pw/HlPtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E64C2BCB4;
	Tue,  5 May 2026 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778007620;
	bh=/OcYNCE/fDC5kwoNxmn93OOTbnEEIB7Un/u2ZoKZZmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pw/HlPtLi9QZuSy0R/GnGVx/M088vN+is++AsVyK+HkM65BpmXKrjG1+FtVEufNbF
	 1JTwPCDtTtFASeItu0D/qS/p7Hrmo5kPk8V12o7x+VtPlFlstl0AoU1oma0wToRPKE
	 qvaLSBSW7sZQltZopaacSX5nIxkIsQBYz1vltvTlMljHo4qJzJZK5ps13ccTFCnyWu
	 voQfWk/C0S4JQJRq0Vn56aWoQxcFPCikGxFRGRzIJojN3iKBreYa0PeZRgr3y9nngK
	 3YZcffK8BS+CHZ/ln1P9+7SFkSpmhTQdnT7HP6WwLXTuPzVlsPl8sbwh8BqXTmk2Mo
	 wYkZ3nLfCV/lw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 05 May 2026 20:59:49 +0200
Subject: [PATCH v6 2/2] mm: kick writeback flusher for IOCB_DONTCACHE with
 targeted dirty tracking
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-dontcache-v6-2-66463805dd6a@kernel.org>
References: <20260505-dontcache-v6-0-66463805dd6a@kernel.org>
In-Reply-To: <20260505-dontcache-v6-0-66463805dd6a@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9615; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/OcYNCE/fDC5kwoNxmn93OOTbnEEIB7Un/u2ZoKZZmM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp+j4zmzZ7nDbB+fjQU1X+H+KbEaew/Rb2QF6q/
 oHNf3dZOuWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafo+MwAKCRAADmhBGVaC
 FaZgEACq12/XKwbO+w71Vhf3mCc0WqNQSjceQThHmpkBQv9ZlF8uO/C7lf/v7idibv62hAJPRCC
 H3Uj4IauQdId4XWPj9SxBYQQASNuK+0qILP0XkR0YChV4RZvLPDPuT0ty4BKyyd3G76icATGdZB
 nKc0pdzr/YNo8RK5OI1iOpnlxM+l2jiiI182RtkmnatMQZZ5gfPqNwMSwayO16kMambplXFRMEp
 We13egbqmz7ayZO+RAnbdcpGbqU4doJq9GLZQCK8QNulUwxdmGsjgnB/TRwRA19/XBN1g3L4mSu
 ektu96BSyIIIJ1eWDHCfvNjO83FIlQ3Pal9oPTzrCm8aAUe3cLxiwlVX+YtIJE0smP5JO8x+auv
 iPd8j59q1eton3j/vUG/kuICFmTVHdYguxpBJ7BkbPwOMWPS9RQvj42+TzxwiJCQXqNPloimRKl
 JHWttx/Y0OjA4pypoGH5K8+n7MaFckzIv+S7T8rJXs85UMHci/TnuI6soZn4B7q7ypnxV164bXv
 ZEwwmjaXSgFoR3L/KZ9d/dQXbjr8weRraFl55IX+qcmQ4Anw1DuJqRSaYS8I57lor9WkA+u8yth
 TkogGYAY87faDji9bazKU3HLXprV5pSq9Agpn5Rtw5N+u/oQCY2cN9eM3X26fsP116+XoTxAF0x
 79lm31kEMtSuNcQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: E8D0A4D2F93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21397-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]

The IOCB_DONTCACHE writeback path in generic_write_sync() calls
filemap_flush_range() on every write, submitting writeback inline in
the writer's context.  Perf lock contention profiling shows the
performance problem is not lock contention but the writeback submission
work itself — walking the page tree and submitting I/O blocks the writer
for milliseconds, inflating p99.9 latency from 23ms (buffered) to 93ms
(dontcache).

Replace the inline filemap_flush_range() call with a flusher kick that
drains dirty pages in the background.  This moves writeback submission
completely off the writer's hot path.

To avoid flushing unrelated buffered dirty data, add a dedicated
WB_start_dontcache bit and wb_check_start_dontcache() handler that uses
the per-wb WB_DONTCACHE_DIRTY counter to determine how many pages to
write back.  The flusher writes back that many pages from the oldest dirty
inodes (not restricted to dontcache-specific inodes). This helps
preserve I/O batching while limiting the scope of expedited writeback.

Like WB_start_all, the WB_start_dontcache bit coalesces multiple
DONTCACHE writes into a single flusher wakeup without per-write
allocations.  Use test_and_clear_bit to atomically consume the kick
request before reading the dirty counter and starting writeback, so that
concurrent DONTCACHE writes during writeback can re-set the bit and
schedule a follow-up flusher run.

Read the dirty counter with wb_stat_sum() (aggregating per-CPU batches)
rather than wb_stat() (which reads only the global counter) to ensure
small writes below the percpu batch threshold are visible to the flusher.

In filemap_dontcache_kick_writeback(), set the WB_start_dontcache bit
inside the unlocked_inode_to_wb_begin/end section for correct cgroup
writeback domain targeting, but defer the wb_wakeup() call until after
the section ends, since wb_wakeup() uses spin_unlock_irq() which would
unconditionally re-enable interrupts while the i_pages xa_lock may still
be held under irqsave during a cgroup writeback switch.

Also add WB_REASON_DONTCACHE as a new writeback reason for tracing
visibility.

dontcache-bench results (same host, T6F_SKL_1920GBF, 251 GiB RAM,
xfs on NVMe, fio io_uring):

Buffered and direct I/O paths are unaffected by this patchset. All
improvements are confined to the dontcache path:

Single-stream throughput (MB/s):
                        Before    After    Change
  seq-write/dontcache      298      897    +201%
  rand-write/dontcache     131      236     +80%

Tail latency improvements (seq-write/dontcache):
  p99:    135,266 us  ->  23,986 us   (-82%)
  p99.9: 8,925,479 us ->  28,443 us   (-99.7%)

Multi-writer (4 jobs, sequential write):
                                Before    After    Change
  dontcache aggregate (MB/s)     2,529    4,532     +79%
  dontcache p99 (us)             8,553    1,002     -88%
  dontcache p99.9 (us)         109,314    1,057     -99%

  Dontcache multi-writer throughput now matches buffered (4,532 vs
  4,616 MB/s).

32-file write (Axboe test):
                                Before    After    Change
  dontcache aggregate (MB/s)     1,548    3,499    +126%
  dontcache p99 (us)            10,170      602     -94%
  Peak dirty pages (MB)          1,837      213     -88%

  Dontcache now reaches 81% of buffered throughput (was 35%).

Competing writers (dontcache vs buffered, separate files):
                                Before    After
  buffered writer                  868      433 MB/s
  dontcache writer                 415      433 MB/s
  Aggregate                      1,284      866 MB/s

  Previously the buffered writer starved the dontcache writer 2:1.
  With per-bdi_writeback tracking, both writers now receive equal
  bandwidth. The aggregate matches the buffered-vs-buffered baseline
  (863 MB/s), indicating fair sharing regardless of I/O mode.

  The dontcache writer's p99.9 latency collapsed from 119 ms to
  33 ms (-73%), eliminating the severe periodic stalls seen in the
  baseline. Both writers now share identical latency profiles,
  matching the buffered-vs-buffered pattern.

The per-bdi_writeback dirty tracking dramatically reduces peak dirty
pages in dontcache workloads, with the 32-file test dropping from
1.8 GB to 213 MB. Dontcache sequential write throughput triples and
multi-writer throughput reaches parity with buffered I/O, with tail
latencies collapsing by 1-2 orders of magnitude.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fs-writeback.c                | 59 ++++++++++++++++++++++++++++++++++++++++
 include/linux/backing-dev-defs.h |  2 ++
 include/linux/fs.h               |  6 ++--
 include/trace/events/writeback.h |  3 +-
 4 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a65694cbfe68..faf15cf84c68 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2373,6 +2373,27 @@ static long wb_check_start_all(struct bdi_writeback *wb)
 	return nr_pages;
 }
 
+static long wb_check_start_dontcache(struct bdi_writeback *wb)
+{
+	long nr_pages;
+
+	if (!test_and_clear_bit(WB_start_dontcache, &wb->state))
+		return 0;
+
+	nr_pages = wb_stat_sum(wb, WB_DONTCACHE_DIRTY);
+	if (nr_pages) {
+		struct wb_writeback_work work = {
+			.nr_pages	= nr_pages,
+			.sync_mode	= WB_SYNC_NONE,
+			.range_cyclic	= 1,
+			.reason		= WB_REASON_DONTCACHE,
+		};
+
+		nr_pages = wb_writeback(wb, &work);
+	}
+
+	return nr_pages;
+}
 
 /*
  * Retrieve work items and do the writeback they describe
@@ -2394,6 +2415,11 @@ static long wb_do_writeback(struct bdi_writeback *wb)
 	 */
 	wrote += wb_check_start_all(wb);
 
+	/*
+	 * Check for dontcache writeback request
+	 */
+	wrote += wb_check_start_dontcache(wb);
+
 	/*
 	 * Check for periodic writeback, kupdated() style
 	 */
@@ -2468,6 +2494,39 @@ void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
 	rcu_read_unlock();
 }
 
+/**
+ * filemap_dontcache_kick_writeback - kick flusher for IOCB_DONTCACHE writes
+ * @mapping:	address_space that was just written to
+ *
+ * Kick the writeback flusher thread to expedite writeback of dontcache dirty
+ * pages. Queue writeback for the inode's wb for as many pages as there are
+ * dontcache pages, but don't restrict writeback to dontcache pages only.
+ *
+ * This significantly improves performance over either writing all wb's pages
+ * or writing only dontcache pages.  Although it doesn't guarantee quick
+ * writeback and reclaim of dontcache pages, it keeps the amount of dirty pages
+ * in check. Over longer term dontcache pages get written and reclaimed by
+ * background writeback even with this rough heuristic.
+ */
+void filemap_dontcache_kick_writeback(struct address_space *mapping)
+{
+	struct inode *inode = mapping->host;
+	struct bdi_writeback *wb;
+	struct wb_lock_cookie cookie = {};
+	bool need_wakeup = false;
+
+	wb = unlocked_inode_to_wb_begin(inode, &cookie);
+	if (wb_has_dirty_io(wb) &&
+	    !test_bit(WB_start_dontcache, &wb->state) &&
+	    !test_and_set_bit(WB_start_dontcache, &wb->state))
+		need_wakeup = true;
+	unlocked_inode_to_wb_end(inode, &cookie);
+
+	if (need_wakeup)
+		wb_wakeup(wb);
+}
+EXPORT_SYMBOL_GPL(filemap_dontcache_kick_writeback);
+
 /*
  * Wakeup the flusher threads to start writeback of all currently dirty pages
  */
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index cb660dd37286..4f1084937315 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -26,6 +26,7 @@ enum wb_state {
 	WB_writeback_running,	/* Writeback is in progress */
 	WB_has_dirty_io,	/* Dirty inodes on ->b_{dirty|io|more_io} */
 	WB_start_all,		/* nr_pages == 0 (all) work pending */
+	WB_start_dontcache,	/* dontcache writeback pending */
 };
 
 enum wb_stat_item {
@@ -56,6 +57,7 @@ enum wb_reason {
 	 */
 	WB_REASON_FORKER_THREAD,
 	WB_REASON_FOREIGN_FLUSH,
+	WB_REASON_DONTCACHE,
 
 	WB_REASON_MAX,
 };
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 11559c513dfb..df72b42a9e9b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2624,6 +2624,7 @@ extern int __must_check file_write_and_wait_range(struct file *file,
 						loff_t start, loff_t end);
 int filemap_flush_range(struct address_space *mapping, loff_t start,
 		loff_t end);
+void filemap_dontcache_kick_writeback(struct address_space *mapping);
 
 static inline int file_write_and_wait(struct file *file)
 {
@@ -2657,10 +2658,7 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
 		if (ret)
 			return ret;
 	} else if (iocb->ki_flags & IOCB_DONTCACHE) {
-		struct address_space *mapping = iocb->ki_filp->f_mapping;
-
-		filemap_flush_range(mapping, iocb->ki_pos - count,
-				iocb->ki_pos - 1);
+		filemap_dontcache_kick_writeback(iocb->ki_filp->f_mapping);
 	}
 
 	return count;
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index bdac0d685a98..13ee076ccd16 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -44,7 +44,8 @@
 	EM( WB_REASON_PERIODIC,			"periodic")		\
 	EM( WB_REASON_FS_FREE_SPACE,		"fs_free_space")	\
 	EM( WB_REASON_FORKER_THREAD,		"forker_thread")	\
-	EMe(WB_REASON_FOREIGN_FLUSH,		"foreign_flush")
+	EM( WB_REASON_FOREIGN_FLUSH,		"foreign_flush")	\
+	EMe(WB_REASON_DONTCACHE,		"dontcache")
 
 WB_WORK_REASON
 

-- 
2.54.0


