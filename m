Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2F2302052
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jan 2021 03:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbhAYCWv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Jan 2021 21:22:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbhAYBzZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 24 Jan 2021 20:55:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E53B229EF
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jan 2021 01:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611539680;
        bh=cssEzPA45nM1tOBRahmnYgwGo+srnNnOi9EIslPzwps=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZM44+ZY7KMoAdkD8k0/7iuZmHFmoF0TyqcmnMjVWseSkeOwP8rYbFTLUfQcudsJI0
         MRHktDkwnjO7tDUYX4GlzRbGhSRGcb+vWd1ravqhxFY40I0wgxSnb8t06zG55tuUc2
         1RSU9jOORrdC3c5WMizkgHaAROIaZfB4+JFUcXJcr1CV17nTl3NuR7nupkeiICVlmK
         +nLpEZmELLTSDTqw8uAqBAMWUhedvYicUqSDwvXJT4seY1p5Nf6gFTqnL0PXst/ehY
         FRqbHK+SGH4bU5/+a/GbA4B9e+UMNizg0sCwrxTeQ5acZIDCPla65u3MrzIBt1hzpJ
         2vaxiqw2RpxCg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] pNFS/NFSv4: Improve rejection of out-of-order layouts
Date:   Sun, 24 Jan 2021 20:54:35 -0500
Message-Id: <20210125015435.45979-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125015435.45979-3-trondmy@kernel.org>
References: <20210125015435.45979-1-trondmy@kernel.org>
 <20210125015435.45979-2-trondmy@kernel.org>
 <20210125015435.45979-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If a layoutget ends up being reordered w.r.t. a layoutreturn, e.g. due
to a layoutget-on-open not knowing a priori which file to lock, then we
must assume the layout is no longer being considered valid state by the
server.
Incrementally improve our ability to reject such states by using the
cached old stateid in conjunction with the plh_barrier to try to
identify them.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index acb63ec00053..af64b4e6fd1f 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1000,7 +1000,7 @@ pnfs_layout_stateid_blocked(const struct pnfs_layout_hdr *lo,
 {
 	u32 seqid = be32_to_cpu(stateid->seqid);
 
-	return !pnfs_seqid_is_newer(seqid, lo->plh_barrier);
+	return !pnfs_seqid_is_newer(seqid, lo->plh_barrier) && lo->plh_barrier;
 }
 
 /* lget is set to 1 if called from inside send_layoutget call chain */
@@ -1912,6 +1912,11 @@ static void nfs_layoutget_end(struct pnfs_layout_hdr *lo)
 		wake_up_var(&lo->plh_outstanding);
 }
 
+static bool pnfs_is_first_layoutget(struct pnfs_layout_hdr *lo)
+{
+	return test_bit(NFS_LAYOUT_FIRST_LAYOUTGET, &lo->plh_flags);
+}
+
 static void pnfs_clear_first_layoutget(struct pnfs_layout_hdr *lo)
 {
 	unsigned long *bitlock = &lo->plh_flags;
@@ -2386,17 +2391,17 @@ pnfs_layout_process(struct nfs4_layoutget *lgp)
 		goto out_forget;
 	}
 
-	if (!pnfs_layout_is_valid(lo)) {
-		/* We have a completely new layout */
-		pnfs_set_layout_stateid(lo, &res->stateid, lgp->cred, true);
-	} else if (nfs4_stateid_match_other(&lo->plh_stateid, &res->stateid)) {
+	if (nfs4_stateid_match_other(&lo->plh_stateid, &res->stateid)) {
 		/* existing state ID, make sure the sequence number matches. */
 		if (pnfs_layout_stateid_blocked(lo, &res->stateid)) {
+			if (!pnfs_layout_is_valid(lo) &&
+			    pnfs_is_first_layoutget(lo))
+				lo->plh_barrier = 0;
 			dprintk("%s forget reply due to sequence\n", __func__);
 			goto out_forget;
 		}
 		pnfs_set_layout_stateid(lo, &res->stateid, lgp->cred, false);
-	} else {
+	} else if (pnfs_layout_is_valid(lo)) {
 		/*
 		 * We got an entirely new state ID.  Mark all segments for the
 		 * inode invalid, and retry the layoutget
@@ -2409,6 +2414,11 @@ pnfs_layout_process(struct nfs4_layoutget *lgp)
 		pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs,
 						&range, 0);
 		goto out_forget;
+	} else {
+		/* We have a completely new layout */
+		if (!pnfs_is_first_layoutget(lo))
+			goto out_forget;
+		pnfs_set_layout_stateid(lo, &res->stateid, lgp->cred, true);
 	}
 
 	pnfs_get_lseg(lseg);
-- 
2.29.2

