Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA02523D2FC
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Aug 2020 22:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgHEU0k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Aug 2020 16:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHEU0k (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Aug 2020 16:26:40 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EB7F22CA1
        for <linux-nfs@vger.kernel.org>; Wed,  5 Aug 2020 20:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596659200;
        bh=+/SEhvz3yfboCZvGfwMRulF3eCn6Xxd2xSdIpXJ3Oec=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QeVruGB6DH8Czm95N67wX1QPawfaZYySlqUgXVlB6hHNHMlB247pjn1yMfKRvlBhu
         ClhaI3rYGe8jQbsa70aXcPA06vZ+X3mTce5NG1o6cBIz7jiD8PeQj1X80tnBR1Uw2Q
         OrLcgKqsAY5lA5zC06+tU2L/E1cwwR0oSz6+PLGg=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: Don't move layouts to plh_return_segs list while in use
Date:   Wed,  5 Aug 2020 16:24:30 -0400
Message-Id: <20200805202431.627013-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805202431.627013-1-trondmy@kernel.org>
References: <20200805202431.627013-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the layout segment is still in use for a read or a write, we should
not move it to the layout plh_return_segs list. If we do, we can end
up returning the layout while I/O is still in progress.

Fixes: e0b7d420f72a ("pNFS: Don't discard layout segments that are marked for return")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index d8cdb94c6668..262ce01c7abe 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2392,16 +2392,6 @@ pnfs_layout_process(struct nfs4_layoutget *lgp)
 	return ERR_PTR(-EAGAIN);
 }
 
-static int
-mark_lseg_invalid_or_return(struct pnfs_layout_segment *lseg,
-		struct list_head *tmp_list)
-{
-	if (!mark_lseg_invalid(lseg, tmp_list))
-		return 0;
-	pnfs_cache_lseg_for_layoutreturn(lseg->pls_layout, lseg);
-	return 1;
-}
-
 /**
  * pnfs_mark_matching_lsegs_return - Free or return matching layout segments
  * @lo: pointer to layout header
@@ -2438,7 +2428,7 @@ pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
 				lseg, lseg->pls_range.iomode,
 				lseg->pls_range.offset,
 				lseg->pls_range.length);
-			if (mark_lseg_invalid_or_return(lseg, tmp_list))
+			if (mark_lseg_invalid(lseg, tmp_list))
 				continue;
 			remaining++;
 			set_bit(NFS_LSEG_LAYOUTRETURN, &lseg->pls_flags);
-- 
2.26.2

