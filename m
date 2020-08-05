Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F6B23D2FB
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Aug 2020 22:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHEU0l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Aug 2020 16:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgHEU0l (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Aug 2020 16:26:41 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A406622B42
        for <linux-nfs@vger.kernel.org>; Wed,  5 Aug 2020 20:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596659200;
        bh=+xdDK7UiSeg17vtYouNeo6HcNkdiq8oHOMNNJBmqyD0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hc4/CALOXoFuNxN08WyaTNoiAfA+QJst5LBsyVDcbBo/Z7XuO//VsM9TdhW6550Ub
         oQx/nq8+HXP7FLsNwOJA7xSSzOZR3s1JHwqeHeS+TGletpygGqNn0z4nhTahdg2y0F
         3cPjOxkWHY9PX4fqO4cfQ8A/qKv1/ZFyR1kx8Clc=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: Don't return layout segments that are in use
Date:   Wed,  5 Aug 2020 16:24:31 -0400
Message-Id: <20200805202431.627013-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805202431.627013-2-trondmy@kernel.org>
References: <20200805202431.627013-1-trondmy@kernel.org>
 <20200805202431.627013-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the NFS_LAYOUT_RETURN_REQUESTED flag is set, we want to return the
layout as soon as possible, meaning that the affected layout segments
should be marked as invalid, and should no longer be in use for I/O.

Fixes: f0b429819b5f ("pNFS: Ignore non-recalled layouts in pnfs_layout_need_return()")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 262ce01c7abe..b5baf36d4de5 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1226,31 +1226,27 @@ pnfs_send_layoutreturn(struct pnfs_layout_hdr *lo,
 	return status;
 }
 
+static bool
+pnfs_layout_segments_returnable(struct pnfs_layout_hdr *lo,
+				enum pnfs_iomode iomode,
+				u32 seq)
+{
+	struct pnfs_layout_range recall_range = {
+		.length = NFS4_MAX_UINT64,
+		.iomode = iomode,
+	};
+	return pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs,
+					       &recall_range, seq) != -EBUSY;
+}
+
 /* Return true if layoutreturn is needed */
 static bool
 pnfs_layout_need_return(struct pnfs_layout_hdr *lo)
 {
-	struct pnfs_layout_segment *s;
-	enum pnfs_iomode iomode;
-	u32 seq;
-
 	if (!test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags))
 		return false;
-
-	seq = lo->plh_return_seq;
-	iomode = lo->plh_return_iomode;
-
-	/* Defer layoutreturn until all recalled lsegs are done */
-	list_for_each_entry(s, &lo->plh_segs, pls_list) {
-		if (seq && pnfs_seqid_is_newer(s->pls_seq, seq))
-			continue;
-		if (iomode != IOMODE_ANY && s->pls_range.iomode != iomode)
-			continue;
-		if (test_bit(NFS_LSEG_LAYOUTRETURN, &s->pls_flags))
-			return false;
-	}
-
-	return true;
+	return pnfs_layout_segments_returnable(lo, lo->plh_return_iomode,
+					       lo->plh_return_seq);
 }
 
 static void pnfs_layoutreturn_before_put_layout_hdr(struct pnfs_layout_hdr *lo)
-- 
2.26.2

