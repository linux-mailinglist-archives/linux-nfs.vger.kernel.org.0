Return-Path: <linux-nfs+bounces-21102-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB21MPH97WnEpgAAu9opvQ
	(envelope-from <linux-nfs+bounces-21102-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 13:58:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC10469B0D
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 13:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF8543023E1C
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DA935F18E;
	Sun, 26 Apr 2026 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooZJKXZq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3B5318ED2;
	Sun, 26 Apr 2026 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777204608; cv=none; b=BqTZQLatXozPiX+3WVsO/hoUHEjW/g/O9WUg9uN0UJYqV3DOLgQbpWg0TiZM3i2ns7gduOPohNcl7z6xYlUeoKVTNQJlLdGZQrVxvvNSxOVC110UFk7EK7tIj1WoV+cOBVChqhlj9tpd9/7AQvRHXbkN0SihBa+B9YY56igQHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777204608; c=relaxed/simple;
	bh=5hBl0zioJo5bmMYBsa/ayjneMPX9D/E0U5nhPvmz3Ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LKSWdOQx8aEF6Yfu0iGn/EpY3Bb2SVtJPzbYnfuY4T33xUlNW8EBtyAjJbNobXjZIb7+rxCsaT47ng3WLeWjktnd3ifRDb0mwaq1bxo5vvm7CvH6ae+NZPpPlTa7fsKgqOlnDO9xTVXRm9tOPdQiuwySMEnrZTFegVSTe+S0Mtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooZJKXZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F856C2BCAF;
	Sun, 26 Apr 2026 11:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777204607;
	bh=5hBl0zioJo5bmMYBsa/ayjneMPX9D/E0U5nhPvmz3Ag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ooZJKXZqm0RN4As5t7yp7UYg1yu3tEkFQjZEmM8nPsoeCGMVy3rDmDeNBVajbkgLf
	 QIADhlIEZ6EfFzFvo6gMAPZHKezwp2U/rjmNbqqeJIIvhqo4H1V9CcK1oonXxlNv4P
	 JRsyGCXXyCOosabi8sWpWNGuwS2iXNsAEkvPeyyGFWC1QBGd1kBojbIu67BdtUKzAq
	 yesLLXGUVTgk6mi2deep1Kj3q84eWZPsY+Xo4ypp6ZRYB9zposMCp8muPo5r/PPWEX
	 1QdLj8DBu/7gBbGWedtD8wAUzcPuChtBD60r/1mChVCWdhJBIkjpellVjR2eQFRvWH
	 8OR/xmZVr/sLA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 26 Apr 2026 07:56:08 -0400
Subject: [PATCH v3 2/4] mm: kick writeback flusher for IOCB_DONTCACHE with
 targeted dirty tracking
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260426-dontcache-v3-2-79eb37da9547@kernel.org>
References: <20260426-dontcache-v3-0-79eb37da9547@kernel.org>
In-Reply-To: <20260426-dontcache-v3-0-79eb37da9547@kernel.org>
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
 Christoph Hellwig <hch@infradead.org>, Kairui Song <kasong@tencent.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9483; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5hBl0zioJo5bmMYBsa/ayjneMPX9D/E0U5nhPvmz3Ag=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp7f1zmVJGTA+Tu2f1JtkgZ4Wu4QF3JzIvd1NAx
 QeDTBATFNWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCae39cwAKCRAADmhBGVaC
 FeF3D/9yCQENYERa2fOF8sEnGIr+VfDwMDVMKgp6/vpNwbtri6dShe5ipAoG1nNJw2Ec8fYuiFg
 Imjx0pFCtOHJuShyO4+5vUueRxuIHyxkF7MIEO+nn0GapxZzXdLryLM28vxnSvFOP5UWUcrlRVT
 X1XJg64SsFTYWrf6TqLLZGJih2OjGZ/f8sQUYW6+piUA97X4h7ya4/FUr8MWv12fANionDuGBRQ
 l/zALxRhRgT+Xa9GJ/cjP4oVmx3ZXXIRbDUoW5qJX5cjxx0cEi/xg0fAh3Yb6qT7iOWKAuqXoN5
 4dm9IXRaDvssYpbwMUHfSVKcxoiIhSGRULtO0bazlUA6uAxK8HVyzEBXB/DQkHqL2uVMT4E+63z
 2Tlyh0wn6NUVzaxu6D39C1BO8EZCIefUUGMI2sZHZj/UzEkTAe6hpjph3RTTvsIn3HygosnhqQP
 eGSjsFc55/57rjQzR2EQwitPA+Bcl+P1uZnYKrUKKPlfKzqbXEbml4VfiQTynzJ95mmDSr09RVy
 942UbUjLOXIyjmqzjx3vNiSw138EfZYebQTmL/LKeXIRRheDBE3xi6tG1NnFIUm+gYE38ZvUAka
 aHK2QJipOHP63BECxbbGddNccTr1e1Hx7Nw75TaIYoHQjgoTm4k/S6I9EjhwjgyyB16UO6L0Bea
 wuMVICRdIU/Oh4g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 3AC10469B0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21102-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com,tencent.com,linux.dev,goodmis.org,efficios.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
the new NR_DONTCACHE_DIRTY counter to determine how many pages to write
back.  The flusher writes back that many pages from the oldest dirty
inodes (not restricted to dontcache-specific inodes). This helps
preserve I/O batching while limiting the scope of expedited writeback.

Like WB_start_all, the WB_start_dontcache bit coalesces multiple
DONTCACHE writes into a single flusher wakeup without per-write
allocations.

Also add WB_REASON_DONTCACHE as a new writeback reason for tracing
visibility, and target the correct cgroup writeback domain via
unlocked_inode_to_wb_begin().

dontcache-bench results on dual-socket Xeon Gold 6138 (80 CPUs, 256 GB
RAM, Samsung MZ1LB1T9HALS 1.7 TB NVMe, local XFS, io_uring, file size
~503 GB, compared to a v6.19-ish baseline):

  Single-client sequential write (MB/s):
                       baseline    patched     change
  buffered              1449.8     1440.1      -0.7%
  dontcache             1347.9     1461.5      +8.4%
  direct                1450.0     1440.1      -0.7%

  Single-client sequential write latency (us):
                       baseline    patched     change
  dontcache p50         3031.0    10551.3    +248.1%
  dontcache p99        74973.2    21626.9     -71.2%
  dontcache p99.9      85459.0    23199.7     -72.9%

  Single-client random write (MB/s):
                       baseline    patched     change
  dontcache              284.2      295.4      +3.9%

  Single-client random write p99.9 latency (us):
                       baseline    patched     change
  dontcache             2277.4      872.4     -61.7%

  Multi-writer aggregate throughput (MB/s):
                       baseline    patched     change
  buffered              1619.5     1611.2      -0.5%
  dontcache             1281.1     1629.4     +27.2%
  direct                1545.4     1609.4      +4.1%

  Mixed-mode noisy neighbor (dontcache writer + buffered readers):
                       baseline    patched     change
  writer (MB/s)         1297.6     1471.1     +13.4%
  readers avg (MB/s)     855.0      462.4     -45.9%

nfsd-io-bench results on same hardware (XFS on NVMe, NFSv3 via fio
NFS engine with libnfs, 1024 NFSD threads, pool_mode=pernode,
file size ~502 GB, compared to v6.19-ish baseline):

  Single-client sequential write (MB/s):
                       baseline    patched     change
  buffered              4844.2     4653.4      -3.9%
  dontcache             3028.3     3723.1     +22.9%
  direct                 957.6      987.8      +3.2%

  Single-client sequential write p99.9 latency (us):
                       baseline    patched     change
  dontcache            759169.0   175112.2     -76.9%

  Single-client random write (MB/s):
                       baseline    patched     change
  dontcache              590.0     1561.0    +164.6%

  Multi-writer aggregate throughput (MB/s):
                       baseline    patched     change
  buffered              9636.3     9422.9      -2.2%
  dontcache             1894.9     9442.6    +398.3%
  direct                 809.6      975.1     +20.4%

  Noisy neighbor (dontcache writer + random readers):
                       baseline    patched     change
  writer (MB/s)         1854.5     4063.6    +119.1%
  readers avg (MB/s)     131.2      101.6     -22.5%

The NFS results show even larger improvements than the local benchmarks.
Multi-writer dontcache throughput improves nearly 5x, matching buffered
I/O. Dirty page footprint drops 85-95% in sequential workloads vs.
buffered.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fs-writeback.c                | 60 ++++++++++++++++++++++++++++++++++++++++
 include/linux/backing-dev-defs.h |  2 ++
 include/linux/fs.h               |  6 ++--
 include/trace/events/writeback.h |  3 +-
 4 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a65694cbfe68..377767db48f7 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1334,6 +1334,18 @@ static void wb_start_writeback(struct bdi_writeback *wb, enum wb_reason reason)
 	wb_wakeup(wb);
 }
 
+static void wb_start_dontcache_writeback(struct bdi_writeback *wb)
+{
+	if (!wb_has_dirty_io(wb))
+		return;
+
+	if (test_bit(WB_start_dontcache, &wb->state) ||
+	    test_and_set_bit(WB_start_dontcache, &wb->state))
+		return;
+
+	wb_wakeup(wb);
+}
+
 /**
  * wb_start_background_writeback - start background writeback
  * @wb: bdi_writback to write from
@@ -2373,6 +2385,28 @@ static long wb_check_start_all(struct bdi_writeback *wb)
 	return nr_pages;
 }
 
+static long wb_check_start_dontcache(struct bdi_writeback *wb)
+{
+	long nr_pages;
+
+	if (!test_bit(WB_start_dontcache, &wb->state))
+		return 0;
+
+	nr_pages = global_node_page_state(NR_DONTCACHE_DIRTY);
+	if (nr_pages) {
+		struct wb_writeback_work work = {
+			.nr_pages	= wb_split_bdi_pages(wb, nr_pages),
+			.sync_mode	= WB_SYNC_NONE,
+			.range_cyclic	= 1,
+			.reason		= WB_REASON_DONTCACHE,
+		};
+
+		nr_pages = wb_writeback(wb, &work);
+	}
+
+	clear_bit(WB_start_dontcache, &wb->state);
+	return nr_pages;
+}
 
 /*
  * Retrieve work items and do the writeback they describe
@@ -2394,6 +2428,11 @@ static long wb_do_writeback(struct bdi_writeback *wb)
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
@@ -2468,6 +2507,27 @@ void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
 	rcu_read_unlock();
 }
 
+/**
+ * filemap_dontcache_kick_writeback - kick flusher for IOCB_DONTCACHE writes
+ * @mapping:	address_space that was just written to
+ *
+ * Kick the writeback flusher thread to expedite writeback of dontcache
+ * dirty pages.  Uses a dedicated WB_start_dontcache bit so that only
+ * pages tracked by NR_DONTCACHE_DIRTY are written back, rather than
+ * flushing the entire BDI's dirty pages.
+ */
+void filemap_dontcache_kick_writeback(struct address_space *mapping)
+{
+	struct inode *inode = mapping->host;
+	struct bdi_writeback *wb;
+	struct wb_lock_cookie cookie = {};
+
+	wb = unlocked_inode_to_wb_begin(inode, &cookie);
+	wb_start_dontcache_writeback(wb);
+	unlocked_inode_to_wb_end(inode, &cookie);
+}
+EXPORT_SYMBOL_GPL(filemap_dontcache_kick_writeback);
+
 /*
  * Wakeup the flusher threads to start writeback of all currently dirty pages
  */
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index a06b93446d10..74f8a9977f5d 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -26,6 +26,7 @@ enum wb_state {
 	WB_writeback_running,	/* Writeback is in progress */
 	WB_has_dirty_io,	/* Dirty inodes on ->b_{dirty|io|more_io} */
 	WB_start_all,		/* nr_pages == 0 (all) work pending */
+	WB_start_dontcache,	/* dontcache writeback pending */
 };
 
 enum wb_stat_item {
@@ -55,6 +56,7 @@ enum wb_reason {
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
2.53.0


