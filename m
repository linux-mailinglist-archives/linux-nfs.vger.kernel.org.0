Return-Path: <linux-nfs+bounces-10325-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC84A432EB
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 03:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D853B8419
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 02:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F6154F8C;
	Tue, 25 Feb 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UitmN2Ho"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F04242A99
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450004; cv=none; b=t6AmP5FPNOgWU0FNfWen21Qav8oifye82kFgAefZ8oCUd+r4+swB7Yn44tOgN2JPaY0cOLLt42QalMnYpJCpg6yP1RO6Rq3WrHIwHxCUwqtGkO8R3AWbwjpSrTEHA4woNw6Rd+ONnRkfGLllQk8Ycpu0kbLqld5odQpkvVZdgCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450004; c=relaxed/simple;
	bh=5+413m+ngSS6dw6yaidAoXFdiyOOFj4mHmmkj+at7rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtNF1TcbhzmOema0wJiUfZGlF7Z8N44OdAjOS4sLIEtdEzq9lKh3HTHnCjM1IpQ7GIbiM3YxKQAii9J0JHCWNZZXifne4M02spJEQGjIEdzUcmyPUFzeLgR3qNEWfFHDskPTKwemsnDjsEnb3Y4V5bsfYrToMjb2zjdWhnxnIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UitmN2Ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB261C4CEE6;
	Tue, 25 Feb 2025 02:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740450004;
	bh=5+413m+ngSS6dw6yaidAoXFdiyOOFj4mHmmkj+at7rE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UitmN2Hor8LnbDfvmHV0O2BzM2TBJ0GRd+3hTjBEBzWCuCpJZeFYiAA29ieRZ64H9
	 hsHycVYwS1H6f84IBE6JqbAgB8MllAdcPoy8HIpx0lDi8pdg3CsOUEocOjV002k/Ih
	 fwIhlgT0bmSGblcJ36wJ2rCxYJf7PhLqg1THLup5JeuKQ7qOUC7EPzht+waTexudEa
	 oEIvJUD9G3VJEYvIeYJKjfsAa5labKH49YO6EnsiaKo6fErX95aqQA/BXaQBZXA6gy
	 oYZ766eJa8fhD+t7/M5dMJvCKbN60JwL0Y9d00ULqcdJV+7lsO+GksjBmAQ5LItevB
	 GEJAu9MQZQFDA==
From: Mike Snitzer <snitzer@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 for-akpm for-6.14-rcX] NFS: fix nfs_release_folio() to not deadlock via kcompactd writeback
Date: Mon, 24 Feb 2025 21:20:02 -0500
Message-ID: <20250225022002.26141-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250225003301.25693-1-snitzer@kernel.org>
References: <20250225003301.25693-1-snitzer@kernel.org>
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

v2: use |= to properly set PF_KCOMPACTD in kcompactd(). Also adjust
subject to reflect this patch fixes a deadlock.

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1bb646752e466..033feeab8c346 100644
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
index e947764960496..7bf0c521db634 100644
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
index 8982820dae213..0d1d70aded38f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1682,7 +1682,7 @@ extern struct pid *cad_pid;
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 #define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
-#define PF__HOLE__00010000	0x00010000
+#define PF_KCOMPACTD		0x00010000	/* I am kcompactd */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocations inherit GFP_NOFS. See memalloc_nfs_save() */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocations inherit GFP_NOIO. See memalloc_noio_save() */
diff --git a/mm/compaction.c b/mm/compaction.c
index 384e4672998e5..836c36f9b2f00 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3164,6 +3164,7 @@ static int kcompactd(void *p)
 	if (!cpumask_empty(cpumask))
 		set_cpus_allowed_ptr(tsk, cpumask);
 
+	tsk->flags |= PF_KCOMPACTD;
 	set_freezable();
 
 	pgdat->kcompactd_max_order = 0;
@@ -3220,6 +3221,8 @@ static int kcompactd(void *p)
 			pgdat->proactive_compact_trigger = false;
 	}
 
+	tsk->flags &= ~PF_KCOMPACTD;
+
 	return 0;
 }
 
-- 
2.44.0


