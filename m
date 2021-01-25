Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F07C302055
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jan 2021 03:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbhAYCXr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Jan 2021 21:23:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbhAYBzY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 24 Jan 2021 20:55:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14560207B6
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jan 2021 01:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611539678;
        bh=cBWvWPlPvNudHQcW0ZkEDfh/yrXqrX6wOhwUPt3k7wg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XgZlYRoQLAps3lfsCNDCpLSRhtgkOLVjctAi2pyoGjlrbJNQGcXKyY9KuuG4VDvnM
         juxKFjOcOR4TuaBbNG4v4sCyLh8Pih8mbgyLu3nonY+f4NOqw9sT8us5BHJ71K9B+t
         9P++xMLpYRWXIvEl8oUpVnewPLLvRry1eKEqpYEMxM5u+Bi3imkgIeATypa3v9bIwq
         uqznJUtrSqOzW0Iu2M8MmfhLjlFcpYbOsq/yOQIN0DDLREUgI76JPFKA4PychZ6XLD
         bAmC3jcuv/HRRcSB3D6gOrg+BeNewgtRdJusCCTuQZxrL6GdgNEk4+6aEfAXa9hV9C
         XTGNRd0J1FFMQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] pNFS/NFSv4: Try to return invalid layout in pnfs_layout_process()
Date:   Sun, 24 Jan 2021 20:54:33 -0500
Message-Id: <20210125015435.45979-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125015435.45979-1-trondmy@kernel.org>
References: <20210125015435.45979-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the server returns a new stateid that does not match the one in our
cache, then try to return the one we hold instead of just invalidating
it on the client side. This ensures that both client and server will
agree that the stateid is invalid.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index e68e6f8cb407..d6262289cf4a 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2398,7 +2398,13 @@ pnfs_layout_process(struct nfs4_layoutget *lgp)
 		 * We got an entirely new state ID.  Mark all segments for the
 		 * inode invalid, and retry the layoutget
 		 */
-		pnfs_mark_layout_stateid_invalid(lo, &free_me);
+		struct pnfs_layout_range range = {
+			.iomode = IOMODE_ANY,
+			.length = NFS4_MAX_UINT64,
+		};
+		pnfs_set_plh_return_info(lo, IOMODE_ANY, 0);
+		pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs,
+						&range, 0);
 		goto out_forget;
 	}
 
@@ -2417,7 +2423,6 @@ pnfs_layout_process(struct nfs4_layoutget *lgp)
 	spin_unlock(&ino->i_lock);
 	lseg->pls_layout = lo;
 	NFS_SERVER(ino)->pnfs_curr_ld->free_lseg(lseg);
-	pnfs_free_lseg_list(&free_me);
 	return ERR_PTR(-EAGAIN);
 }
 
-- 
2.29.2

