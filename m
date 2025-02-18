Return-Path: <linux-nfs+bounces-10175-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B94A3A18B
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 16:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE95D3AF615
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7638626E14C;
	Tue, 18 Feb 2025 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHdKgL41"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50082262811
	for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2025 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893187; cv=none; b=k/3mQGomoJhGkFW6G3WGxE9G6IHQeuX80UNbvqbEM3+wAtr7+pSfC5F+DRcDHm2tRcxay5ai3BYRdWF2a3jtR9im7u6OurgmWmdnuCucnKPmrQXJw0U+D2zHdvIsz0IXni/U0lrMz5rcQOSkB0i7jLJRykv8oXQQratmkwIjAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893187; c=relaxed/simple;
	bh=WCmHZN7hoYJGUWLVypvb4UKXeYsh5UC0n/+MvyCK65E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hd6UPukFJQEnLB+ya1OAPJRRaFSrnLTPZ0/GLfGt9Tze3zBnRic79B1LV9MiLuqH5YSV02whG7/p7NX7y4OSbe8K0qndDplvhctFJpR47IwMzExkYj1usc64DcdjsgRDxlIVvU8GaGFIkWW1I1cLza7b/Oi/PT8JQehcgL0BedQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHdKgL41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D76C4CEE7;
	Tue, 18 Feb 2025 15:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893187;
	bh=WCmHZN7hoYJGUWLVypvb4UKXeYsh5UC0n/+MvyCK65E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VHdKgL41CjaNGjqnpxd/gRtuMWlyzJ+xqr7o+qM4ayt8lP3uqTpi9+qmlZ6eKYkjc
	 /dIlV9W8YXR5EgS8jrohV5yVTBVgocD1WZlg9jPh9aqgZf6I8rKU+IMRFJovci9W3I
	 pF2soHucegoCGelkytnQrX5OsLtxBaRNr9DAg0dPQZ5NJhA34UjbJw2EYbeWcitRz9
	 qZtPTQcKEXZgM9igGVkidmlicf62MGy/6LAJDVF9goSGHDm4fli/JJ6+YPjc4iGVT2
	 hmpGN8VQ1wF8M2Q5p/qvgS9DhsipAUSsy2F8nQZ5NuFzdV1TBwV0AXNx+oNgZlExsU
	 lcByvzUTUIUtQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH v2 7/7] nfsd: filecache: drop the list_lru lock during lock gc scans
Date: Tue, 18 Feb 2025 10:39:37 -0500
Message-ID: <20250218153937.6125-8-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250218153937.6125-1-cel@kernel.org>
References: <20250218153937.6125-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

Under a high NFSv3 load with lots of different files being accessed,
the LRU list of garbage-collectable files can become quite long.

Asking list_lru_scan_node() to scan the whole list can result in a long
period during which a spinlock is held, blocking the addition of new LRU
items.

So ask list_lru_scan_node() to scan only a few entries at a time, and
repeat until the scan is complete.

If the shrinker runs between two consecutive calls of
list_lru_scan_node() it could invalidate the "remaining" counter which
could lead to premature freeing.  So add a spinlock to avoid that.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 27 ++++++++++++++++++++++++---
 fs/nfsd/filecache.h |  6 ++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 56935349f0e4..9a41ccfc2df6 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -544,6 +544,13 @@ nfsd_file_gc_cb(struct list_head *item, struct list_lru_one *lru,
 	return nfsd_file_lru_cb(item, lru, arg);
 }
 
+/* If the shrinker runs between calls to list_lru_walk_node() in
+ * nfsd_file_gc(), the "remaining" count will be wrong.  This could
+ * result in premature freeing of some files.  This may not matter much
+ * but is easy to fix with this spinlock which temporarily disables
+ * the shrinker.
+ */
+static DEFINE_SPINLOCK(nfsd_gc_lock);
 static void
 nfsd_file_gc(void)
 {
@@ -551,12 +558,22 @@ nfsd_file_gc(void)
 	LIST_HEAD(dispose);
 	int nid;
 
+	spin_lock(&nfsd_gc_lock);
 	for_each_node_state(nid, N_NORMAL_MEMORY) {
-		unsigned long nr = list_lru_count_node(&nfsd_file_lru, nid);
+		unsigned long remaining = list_lru_count_node(&nfsd_file_lru, nid);
 
-		ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_gc_cb,
-					  &dispose, &nr);
+		while (remaining > 0) {
+			unsigned long nr = min(remaining, NFSD_FILE_GC_BATCH);
+
+			remaining -= nr;
+			ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_gc_cb,
+						  &dispose, &nr);
+			if (nr)
+				/* walk aborted early */
+				remaining = 0;
+		}
 	}
+	spin_unlock(&nfsd_gc_lock);
 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
 	nfsd_file_dispose_list_delayed(&dispose);
 }
@@ -581,8 +598,12 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 	LIST_HEAD(dispose);
 	unsigned long ret;
 
+	if (!spin_trylock(&nfsd_gc_lock))
+		return SHRINK_STOP;
+
 	ret = list_lru_shrink_walk(&nfsd_file_lru, sc,
 				   nfsd_file_lru_cb, &dispose);
+	spin_unlock(&nfsd_gc_lock);
 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
 	nfsd_file_dispose_list_delayed(&dispose);
 	return ret;
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index de5b8aa7fcb0..5865f9c72712 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -3,6 +3,12 @@
 
 #include <linux/fsnotify_backend.h>
 
+/*
+ * Limit the time that the list_lru_one lock is held during
+ * an LRU scan.
+ */
+#define NFSD_FILE_GC_BATCH     (16UL)
+
 /*
  * This is the fsnotify_mark container that nfsd attaches to the files that it
  * is holding open. Note that we have a separate refcount here aside from the
-- 
2.47.0


