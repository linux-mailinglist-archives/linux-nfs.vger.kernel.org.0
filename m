Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7890A3BAADD
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jul 2021 04:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhGDCHr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Jul 2021 22:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhGDCHr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 3 Jul 2021 22:07:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65ACF615FF
        for <linux-nfs@vger.kernel.org>; Sun,  4 Jul 2021 02:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625364312;
        bh=fB3JX7US2ey2k16pSBrtYiDV8JZI0rWkuvlqDiHk3z0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Kj+hodEUimrIqHq9Ln3AkzPq1hN36MW0zniDlnJEud3x2j4J5OAxKYKE1ymYxnTTN
         /2O80k67gk1o5erTuj2KwWdh4GmrpEYwVtoLDuSrga+php2HdLlaG3VUQNvTDihGzB
         jIjcWLU613dMJbYtQddbjsvc0LT6bORtbhzPOwxzPFfSXK2lwwNqHFhJfugGuHBM5P
         EKbTCIkrTIZxHpUPHvghn8SHUAmYUlZ2COU0POJcVerMQ7v+BFCv9YqTeNF3tsYys7
         oM0ZtkOBXOo2xfD0e+qF0mFy5v65Fr+SZc3Q7/CiKxuIdvU6Qsm/ZMFYA8kQgODJE5
         jGX4F0luuPrDw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/5] NFSv4/pnfs: Fix layoutget behaviour after invalidation
Date:   Sat,  3 Jul 2021 22:05:07 -0400
Message-Id: <20210704020510.4898-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210704020510.4898-1-trondmy@kernel.org>
References: <20210704020510.4898-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the layout gets invalidated, we should wait for any outstanding
layoutget requests for that layout to complete, and we should resend
them only after re-establishing the layout stateid.

Fixes: d29b468da4f9 ("pNFS/NFSv4: Improve rejection of out-of-order layouts")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index ffe02e43f8c0..be960e47d7f6 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2014,7 +2014,7 @@ pnfs_update_layout(struct inode *ino,
 	 * If the layout segment list is empty, but there are outstanding
 	 * layoutget calls, then they might be subject to a layoutrecall.
 	 */
-	if (list_empty(&lo->plh_segs) &&
+	if ((list_empty(&lo->plh_segs) || !pnfs_layout_is_valid(lo)) &&
 	    atomic_read(&lo->plh_outstanding) != 0) {
 		spin_unlock(&ino->i_lock);
 		lseg = ERR_PTR(wait_var_event_killable(&lo->plh_outstanding,
@@ -2390,11 +2390,13 @@ pnfs_layout_process(struct nfs4_layoutget *lgp)
 		goto out_forget;
 	}
 
+	if (!pnfs_layout_is_valid(lo) && !pnfs_is_first_layoutget(lo))
+		goto out_forget;
+
 	if (nfs4_stateid_match_other(&lo->plh_stateid, &res->stateid)) {
 		/* existing state ID, make sure the sequence number matches. */
 		if (pnfs_layout_stateid_blocked(lo, &res->stateid)) {
-			if (!pnfs_layout_is_valid(lo) &&
-			    pnfs_is_first_layoutget(lo))
+			if (!pnfs_layout_is_valid(lo))
 				lo->plh_barrier = 0;
 			dprintk("%s forget reply due to sequence\n", __func__);
 			goto out_forget;
@@ -2413,8 +2415,6 @@ pnfs_layout_process(struct nfs4_layoutget *lgp)
 		goto out_forget;
 	} else {
 		/* We have a completely new layout */
-		if (!pnfs_is_first_layoutget(lo))
-			goto out_forget;
 		pnfs_set_layout_stateid(lo, &res->stateid, lgp->cred, true);
 	}
 
-- 
2.31.1

