Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2023D58F6
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 13:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhGZLSX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 07:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233606AbhGZLSX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:18:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5C2B60F22
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jul 2021 11:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627300731;
        bh=MMfyyZxqw5O4APMcwE3iA/CIXTgyGAHHU/8qhpzkU54=;
        h=From:To:Subject:Date:From;
        b=ZMUdc0VFMWXpCjZO6v/PnjWcreilpC8a+hONc/6ldUaM98crYoYBlzNL9sGda9CEN
         QuiuoIwys3wxPpT1yosZSc9pYsR+g5LaKWJ01cxNuQ+LTlAfH/ZwwbLqaGVMSM7oXr
         IjxZalqgsCsAZGz9mUv5WcQMCnzm8egh+WlW/AigiME9lvcBBkr8VNRSnBnWZCaHJn
         ySXG7/vC9Nst/ZFCZVfKkS0gTYL60y/sVPbfxfXpZffsWeRBAs1Qc/uyOfeedxusub
         ffLEtJrC/TD2mOPC6jHp0O+WY49Cd6cS4YkXeUZE3En2RS6zTOGhv2gQ8Kw/LKe6Z6
         aRFTBIXaUDSTw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4/pNFS: Fix a layoutget livelock loop
Date:   Mon, 26 Jul 2021 07:58:49 -0400
Message-Id: <20210726115850.8429-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If NFS_LAYOUT_RETURN_REQUESTED is set, but there is no value set for
the layout plh_return_seq, we can end up in a livelock loop in which
every layout segment retrieved by a new call to layoutget is immediately
invalidated by pnfs_layout_need_return().
To get around this, we should just set plh_return_seq to the current
value of the layout stateid's seqid.

Fixes: d474f96104bd ("NFS: Don't return layout segments that are in use")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 4ed4586bc1a2..51049499e98f 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -347,11 +347,15 @@ pnfs_set_plh_return_info(struct pnfs_layout_hdr *lo, enum pnfs_iomode iomode,
 		iomode = IOMODE_ANY;
 	lo->plh_return_iomode = iomode;
 	set_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags);
-	if (seq != 0) {
-		WARN_ON_ONCE(lo->plh_return_seq != 0 && lo->plh_return_seq != seq);
+	/*
+	 * We must set lo->plh_return_seq to avoid livelocks with
+	 * pnfs_layout_need_return()
+	 */
+	if (seq == 0)
+		seq = be32_to_cpu(lo->plh_stateid.seqid);
+	if (!lo->plh_return_seq || pnfs_seqid_is_newer(seq, lo->plh_return_seq))
 		lo->plh_return_seq = seq;
-		pnfs_barrier_update(lo, seq);
-	}
+	pnfs_barrier_update(lo, seq);
 }
 
 static void
-- 
2.31.1

