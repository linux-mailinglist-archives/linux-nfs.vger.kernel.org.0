Return-Path: <linux-nfs+bounces-10343-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92497A44DA0
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 21:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AE73B84CB
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 20:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A929F21E0B2;
	Tue, 25 Feb 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tw9BiANA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C321D5B6
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515330; cv=none; b=BfTjBIhTs4Yb297uGmUShYw7nnfnnns5CHd02sC/kuyubSsuxbOFiL75+vr9DM3l1G/Q4KfH/mqCKNcIrRF9VFh2OFaZf8Rw7CC1Eog1Ifdy9GKbYL5iy+Eu9rmb4Vlg0pDXxW48bvUY5L5n7ChtL27bap6GlGf4AnjHeJqcGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515330; c=relaxed/simple;
	bh=kESsj05B+77mOqXZnlpDt7BIg72CLt6Liz1yn770qJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u60TCBwnO8o1mK9PNZKouYbVHUodcBei911/ZQGGAg8htWOBWpm0La9McValoJkSojME/sPs9NKTsg6IMy+zvBvLaX+fnhyI3jJNNDKVrg6GPccDxdrjQLum+bbfLWKgTFK4yaD5/4FxI4fzVt6ELRJuvPyDzdI5m5zZOANmyN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tw9BiANA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2ED3C4CEDD;
	Tue, 25 Feb 2025 20:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740515330;
	bh=kESsj05B+77mOqXZnlpDt7BIg72CLt6Liz1yn770qJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tw9BiANAUoVDxzUGhOxa1aNaR1ACvbFq3THuUHYLWA305uAukVunX+Cf/9K2mjnMD
	 u1fTPlSnDKRtFk9LrlAxuxO9AwMDHJzxebGgPOrqX06GnTJvzK3tFztCkiG1gH5Tf6
	 hbTKGy37wDSGkllcww4x7KJ+vft1gLMu5tnWIz0YDnc2m8lt8W4nEBgfvFnA+iQG97
	 w2Y5ZSemTuLBwMrYqFvPeDmJ6bYCw6ml8zCOlSuycB6K1OA4Oecc/+I9h1sQaiIy6Y
	 6hDckVXJdUXvhtXg2KLkAmk+oYsBaEpqy8pdy+NS1xRFzXmQynm3+gLCOwfWg+Cgp0
	 a62yQYaDnPs3w==
From: Mike Snitzer <snitzer@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 for-akpm for-6.14-rcX] NFS: fix nfs_release_folio() to not deadlock via kcompactd writeback
Date: Tue, 25 Feb 2025 15:28:48 -0500
Message-ID: <20250225202848.31721-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <Z733qhxzJyoIN41J@kernel.org>
References: <Z733qhxzJyoIN41J@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PF_KCOMPACTD flag and current_is_kcompactd() helper to check for
it so nfs_release_folio() can skip calling nfs_wb_folio() from
kcompactd.

Otherwise NFS can deadlock waiting for kcompactd enduced writeback
which recurses back to NFS (which triggers writeback to NFSD via
NFS loopback mount on the same host, NFSD blocks waiting for XFS's
call to __filemap_get_folio):

6070.550357] INFO: task kcompactd0:58 blocked for more than 4435 seconds.

{---
[58] "kcompactd0"
[<0>] folio_wait_bit+0xe8/0x200
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] nfs_wb_folio+0x80/0x1b0 [nfs]
[<0>] nfs_release_folio+0x68/0x130 [nfs]
[<0>] split_huge_page_to_list_to_order+0x362/0x840
[<0>] migrate_pages_batch+0x43d/0xb90
[<0>] migrate_pages_sync+0x9a/0x240
[<0>] migrate_pages+0x93c/0x9f0
[<0>] compact_zone+0x8e2/0x1030
[<0>] compact_node+0xdb/0x120
[<0>] kcompactd+0x121/0x2e0
[<0>] kthread+0xcf/0x100
[<0>] ret_from_fork+0x31/0x40
[<0>] ret_from_fork_asm+0x1a/0x30
---}

Fixes: 96780ca55e3cb ("NFS: fix up nfs_release_folio() to try to release the page")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/file.c              | 3 ++-
 include/linux/compaction.h | 5 +++++
 include/linux/sched.h      | 2 +-
 mm/compaction.c            | 3 +++
 4 files changed, 11 insertions(+), 2 deletions(-)

v3: rebase to latest Linus tree (commit cc8a0934d099).
v2: use |= to properly set PF_KCOMPACTD in kcompactd(). Also adjust
subject to reflect this patch fixes a deadlock.

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1bb646752e46..033feeab8c34 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -29,6 +29,7 @@
 #include <linux/pagemap.h>
 #include <linux/gfp.h>
 #include <linux/swap.h>
+#include <linux/compaction.h>
 
 #include <linux/uaccess.h>
 #include <linux/filelock.h>
@@ -457,7 +458,7 @@ static bool nfs_release_folio(struct folio *folio, gfp_t gfp)
 	/* If the private flag is set, then the folio is not freeable */
 	if (folio_test_private(folio)) {
 		if ((current_gfp_context(gfp) & GFP_KERNEL) != GFP_KERNEL ||
-		    current_is_kswapd())
+		    current_is_kswapd() || current_is_kcompactd())
 			return false;
 		if (nfs_wb_folio(folio->mapping->host, folio) < 0)
 			return false;
diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index e94776496049..7bf0c521db63 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -80,6 +80,11 @@ static inline unsigned long compact_gap(unsigned int order)
 	return 2UL << order;
 }
 
+static inline int current_is_kcompactd(void)
+{
+	return current->flags & PF_KCOMPACTD;
+}
+
 #ifdef CONFIG_COMPACTION
 
 extern unsigned int extfrag_for_order(struct zone *zone, unsigned int order);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d..9c15365a30c0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1701,7 +1701,7 @@ extern struct pid *cad_pid;
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 #define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
-#define PF__HOLE__00010000	0x00010000
+#define PF_KCOMPACTD		0x00010000	/* I am kcompactd */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocations inherit GFP_NOFS. See memalloc_nfs_save() */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocations inherit GFP_NOIO. See memalloc_noio_save() */
diff --git a/mm/compaction.c b/mm/compaction.c
index 12ed8425fa17..a3203d97123e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3181,6 +3181,7 @@ static int kcompactd(void *p)
 	long default_timeout = msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC);
 	long timeout = default_timeout;
 
+	current->flags |= PF_KCOMPACTD;
 	set_freezable();
 
 	pgdat->kcompactd_max_order = 0;
@@ -3237,6 +3238,8 @@ static int kcompactd(void *p)
 			pgdat->proactive_compact_trigger = false;
 	}
 
+	current->flags &= ~PF_KCOMPACTD;
+
 	return 0;
 }
 

