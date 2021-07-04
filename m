Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1EE3BAADB
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jul 2021 04:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhGDCHr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Jul 2021 22:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhGDCHq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 3 Jul 2021 22:07:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDF27615A0
        for <linux-nfs@vger.kernel.org>; Sun,  4 Jul 2021 02:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625364312;
        bh=sI8IU2PYDhcRh+Oz/8+AP47sYfBngTBxJDelVCfFaks=;
        h=From:To:Subject:Date:From;
        b=B28UK+pBj9memlZXu/fSKAHcZtW80mGe2aPTTGtf3NWCvRyt5XYDJz0FLDjAD83n1
         0HKi4s2LuvrqPJ8AO8IArzOnwZZ70tJpI0pT5mvSvlfL+QMeNDw/egp69O8l4HEOBe
         eDawD2Tym6jxLixYsebuHCl7KzlJX5jIxTyNifGSyjPIU48VuHjbqfqZ9ueVdjqSe3
         c33pQxJURnYrQQ87czBRIvTg+5XMVkSwnugqMwKeNKLZz+UCSK5prP2q3/5cIeygxx
         CQZRls+wajHPxYry5bvgM2ETc3lRdIS2b3nISoBdH14FL01sarbfD9IGj+Nlqzzkxg
         tElaFCsvb/+8g==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/5] NFSv4/pnfs: Fix the layout barrier update
Date:   Sat,  3 Jul 2021 22:05:06 -0400
Message-Id: <20210704020510.4898-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we have multiple outstanding layoutget requests, the current code to
update the layout barrier assumes that the outstanding layout stateids
are updated in order. That's not necessarily the case.

Instead of using the value of lo->plh_outstanding as a guesstimate for
the window of values we need to accept, just wait to update the window
until we're processing the last one. The intention here is just to
ensure that we don't process 2^31 seqid updates without also updating
the barrier.

Fixes: 1bcf34fdac5f ("pNFS/NFSv4: Update the layout barrier when we schedule a layoutreturn")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 2c01ee805306..ffe02e43f8c0 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -966,10 +966,8 @@ void
 pnfs_set_layout_stateid(struct pnfs_layout_hdr *lo, const nfs4_stateid *new,
 			const struct cred *cred, bool update_barrier)
 {
-	u32 oldseq, newseq, new_barrier = 0;
-
-	oldseq = be32_to_cpu(lo->plh_stateid.seqid);
-	newseq = be32_to_cpu(new->seqid);
+	u32 oldseq = be32_to_cpu(lo->plh_stateid.seqid);
+	u32 newseq = be32_to_cpu(new->seqid);
 
 	if (!pnfs_layout_is_valid(lo)) {
 		pnfs_set_layout_cred(lo, cred);
@@ -979,19 +977,21 @@ pnfs_set_layout_stateid(struct pnfs_layout_hdr *lo, const nfs4_stateid *new,
 		clear_bit(NFS_LAYOUT_INVALID_STID, &lo->plh_flags);
 		return;
 	}
-	if (pnfs_seqid_is_newer(newseq, oldseq)) {
+
+	if (pnfs_seqid_is_newer(newseq, oldseq))
 		nfs4_stateid_copy(&lo->plh_stateid, new);
-		/*
-		 * Because of wraparound, we want to keep the barrier
-		 * "close" to the current seqids.
-		 */
-		new_barrier = newseq - atomic_read(&lo->plh_outstanding);
-	}
-	if (update_barrier)
-		new_barrier = be32_to_cpu(new->seqid);
-	else if (new_barrier == 0)
+
+	if (update_barrier) {
+		pnfs_barrier_update(lo, newseq);
 		return;
-	pnfs_barrier_update(lo, new_barrier);
+	}
+	/*
+	 * Because of wraparound, we want to keep the barrier
+	 * "close" to the current seqids. We really only want to
+	 * get here from a layoutget call.
+	 */
+	if (atomic_read(&lo->plh_outstanding) == 1)
+		 pnfs_barrier_update(lo, be32_to_cpu(lo->plh_stateid.seqid));
 }
 
 static bool
-- 
2.31.1

