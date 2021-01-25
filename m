Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A17A302057
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jan 2021 03:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbhAYCYI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Jan 2021 21:24:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbhAYBzY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 24 Jan 2021 20:55:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2F25224DF
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jan 2021 01:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611539679;
        bh=pq9n19jsRZma9AVdKeOBUawVw72V5gU/vukPoUEihXM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PCH+rQs3ARfSu2QUDwCpbwJCFdlAKQsBarn5mhSH55Rt9BuZLjFKwo9qLiEyVLujS
         l0sIXSSgWekpBheYI0t2yP00sRw93prgxuboYiqHYBZUnkaG5LC8YLKL82hvgJoT+x
         BMfMy0qMsQAiBp1tHQQkAcyJlfRtvpij/uIa6aeTmepfZsM8BxFem5Nwe1X1AUFsrt
         +ljjhfhXuLpr7HLNHQMlqO4NqeNQ62ngAWZ/3i3zKso3OS8ym9WpudFuXepdwav8xg
         7Xjl0q1LBuxUIQli0FosuwA/2Bv9FsNN5AnUhx/mwaEZgrc8y0brNp04ka+HKGhCtR
         eQxuQl4uBp6Mw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] pNFS/NFSv4: Update the layout barrier when we schedule a layoutreturn
Date:   Sun, 24 Jan 2021 20:54:34 -0500
Message-Id: <20210125015435.45979-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125015435.45979-2-trondmy@kernel.org>
References: <20210125015435.45979-1-trondmy@kernel.org>
 <20210125015435.45979-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When we're scheduling a layoutreturn, we need to ignore any further
incoming layouts with sequence ids that are going to be affected by the
layout return.

Fixes: 44ea8dfce021 ("NFS/pnfs: Reference the layout cred in pnfs_prepare_layoutreturn()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index d6262289cf4a..acb63ec00053 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -324,6 +324,21 @@ pnfs_grab_inode_layout_hdr(struct pnfs_layout_hdr *lo)
 	return NULL;
 }
 
+/*
+ * Compare 2 layout stateid sequence ids, to see which is newer,
+ * taking into account wraparound issues.
+ */
+static bool pnfs_seqid_is_newer(u32 s1, u32 s2)
+{
+	return (s32)(s1 - s2) > 0;
+}
+
+static void pnfs_barrier_update(struct pnfs_layout_hdr *lo, u32 newseq)
+{
+	if (pnfs_seqid_is_newer(newseq, lo->plh_barrier))
+		lo->plh_barrier = newseq;
+}
+
 static void
 pnfs_set_plh_return_info(struct pnfs_layout_hdr *lo, enum pnfs_iomode iomode,
 			 u32 seq)
@@ -335,6 +350,7 @@ pnfs_set_plh_return_info(struct pnfs_layout_hdr *lo, enum pnfs_iomode iomode,
 	if (seq != 0) {
 		WARN_ON_ONCE(lo->plh_return_seq != 0 && lo->plh_return_seq != seq);
 		lo->plh_return_seq = seq;
+		pnfs_barrier_update(lo, seq);
 	}
 }
 
@@ -639,15 +655,6 @@ static int mark_lseg_invalid(struct pnfs_layout_segment *lseg,
 	return rv;
 }
 
-/*
- * Compare 2 layout stateid sequence ids, to see which is newer,
- * taking into account wraparound issues.
- */
-static bool pnfs_seqid_is_newer(u32 s1, u32 s2)
-{
-	return (s32)(s1 - s2) > 0;
-}
-
 static bool
 pnfs_should_free_range(const struct pnfs_layout_range *lseg_range,
 		 const struct pnfs_layout_range *recall_range)
@@ -984,8 +991,7 @@ pnfs_set_layout_stateid(struct pnfs_layout_hdr *lo, const nfs4_stateid *new,
 		new_barrier = be32_to_cpu(new->seqid);
 	else if (new_barrier == 0)
 		return;
-	if (pnfs_seqid_is_newer(new_barrier, lo->plh_barrier))
-		lo->plh_barrier = new_barrier;
+	pnfs_barrier_update(lo, new_barrier);
 }
 
 static bool
@@ -1183,20 +1189,17 @@ pnfs_prepare_layoutreturn(struct pnfs_layout_hdr *lo,
 		return false;
 	set_bit(NFS_LAYOUT_RETURN, &lo->plh_flags);
 	pnfs_get_layout_hdr(lo);
+	nfs4_stateid_copy(stateid, &lo->plh_stateid);
+	*cred = get_cred(lo->plh_lc_cred);
 	if (test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags)) {
-		nfs4_stateid_copy(stateid, &lo->plh_stateid);
-		*cred = get_cred(lo->plh_lc_cred);
 		if (lo->plh_return_seq != 0)
 			stateid->seqid = cpu_to_be32(lo->plh_return_seq);
 		if (iomode != NULL)
 			*iomode = lo->plh_return_iomode;
 		pnfs_clear_layoutreturn_info(lo);
-		return true;
-	}
-	nfs4_stateid_copy(stateid, &lo->plh_stateid);
-	*cred = get_cred(lo->plh_lc_cred);
-	if (iomode != NULL)
+	} else if (iomode != NULL)
 		*iomode = IOMODE_ANY;
+	pnfs_barrier_update(lo, be32_to_cpu(stateid->seqid));
 	return true;
 }
 
-- 
2.29.2

