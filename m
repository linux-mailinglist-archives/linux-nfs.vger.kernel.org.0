Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADF7447356
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Nov 2021 15:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhKGOmN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Nov 2021 09:42:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229520AbhKGOmN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 7 Nov 2021 09:42:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D5C561357;
        Sun,  7 Nov 2021 14:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636295970;
        bh=0nSploVJ1cezL7P1APkmvJ6I/eScWn2MDBWLQvktk7c=;
        h=From:To:Cc:Subject:Date:From;
        b=iqepzabM5HYpfpgbakSyA7nFFx2aXYaB6W1BfAmsHoN/JTk5zNOMbnnL746RcnSlr
         ap93MkTwwlp6rBrR76aak+jhb5OeWeuss4RpxS2igIZQJQSc25uD/GI4OtaUjogQf6
         VGBptodqiRxJTlCOS7Y6WVR2UIcFLl0DFWIKKIRg7zjk9onAWxkIGcL3tmUg8GJxWl
         7XMGLzQBS5ArfK4gew7fBdjUO52c2Enc3Xlt8fUAFCJVVsuz7C1zY8qknJXz/x8TCj
         lEyAve8jfNt8Nn+9qcc9pZ2bErc1AG/CCJldrrGjPUpKfphPPctF9OzCKdz09LldwM
         lKWaVIpd846Cg==
From:   trondmy@kernel.org
To:     rtm@csail.mit.edu
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Sanity check the parameters in nfs41_update_target_slotid()
Date:   Sun,  7 Nov 2021 09:32:43 -0500
Message-Id: <20211107143243.22653-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that the values supplied by the server do not exceed the size of
the largest allowed slot table.

Reported-by: <rtm@csail.mit.edu>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4session.c | 12 ++++++++----
 fs/nfs/nfs4session.h |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4session.c b/fs/nfs/nfs4session.c
index 4145a0138907..5db460476bf2 100644
--- a/fs/nfs/nfs4session.c
+++ b/fs/nfs/nfs4session.c
@@ -511,12 +511,16 @@ void nfs41_update_target_slotid(struct nfs4_slot_table *tbl,
 		struct nfs4_slot *slot,
 		struct nfs4_sequence_res *res)
 {
+	u32 target_highest_slotid = min(res->sr_target_highest_slotid,
+					NFS4_MAX_SLOTID);
+	u32 highest_slotid = min(res->sr_highest_slotid, NFS4_MAX_SLOTID);
+
 	spin_lock(&tbl->slot_tbl_lock);
-	if (!nfs41_is_outlier_target_slotid(tbl, res->sr_target_highest_slotid))
-		nfs41_set_target_slotid_locked(tbl, res->sr_target_highest_slotid);
+	if (!nfs41_is_outlier_target_slotid(tbl, target_highest_slotid))
+		nfs41_set_target_slotid_locked(tbl, target_highest_slotid);
 	if (tbl->generation == slot->generation)
-		nfs41_set_server_slotid_locked(tbl, res->sr_highest_slotid);
-	nfs41_set_max_slotid_locked(tbl, res->sr_target_highest_slotid);
+		nfs41_set_server_slotid_locked(tbl, highest_slotid);
+	nfs41_set_max_slotid_locked(tbl, target_highest_slotid);
 	spin_unlock(&tbl->slot_tbl_lock);
 }
 
diff --git a/fs/nfs/nfs4session.h b/fs/nfs/nfs4session.h
index 3de425f59b3a..351616c61df5 100644
--- a/fs/nfs/nfs4session.h
+++ b/fs/nfs/nfs4session.h
@@ -12,6 +12,7 @@
 #define NFS4_DEF_SLOT_TABLE_SIZE (64U)
 #define NFS4_DEF_CB_SLOT_TABLE_SIZE (16U)
 #define NFS4_MAX_SLOT_TABLE (1024U)
+#define NFS4_MAX_SLOTID (NFS4_MAX_SLOT_TABLE - 1U)
 #define NFS4_NO_SLOT ((u32)-1)
 
 #if IS_ENABLED(CONFIG_NFS_V4)
-- 
2.33.1

