Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D0F2ECA2A
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jan 2021 06:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbhAGFcN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jan 2021 00:32:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbhAGFcN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 7 Jan 2021 00:32:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7C4C22E00
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jan 2021 05:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609997492;
        bh=FO1sweQYtHf3lMN7xew897cez/3jWH0MosD1i4t92To=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VQaCFjVVjlS1PNNqzcbGPWsMIGDVQFYqfRCw7MxVDFXUkTCOLJH0t/v4nmSua0M2V
         CBE1oWdizyVbRg8D85ZJNSLrbWuhFN4fPsUt+cce4pLng0+erFMl4nFpj9vhf6CoLW
         ZpN2sNmfPXzJeVXJUPIX/b1acPXf75sYz6PUilNRWkI2kq/cmWhZlcejLplxUzGiGu
         UL4dlMk8rCJs/bEgiNBpYzbzRhbbJpuAq1Ch3rDRVYTJPZ/u8vNjpffNq/GHVdmSQ1
         RFW2Pfg+7UB4sgDb1UDyn8LAbGoqUOFC+clkSSHxihs9vNd7Xt4l8qI9iPXAjQXDzp
         2U7WM/UMaovkw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/7] pNFS: Stricter ordering of layoutget and layoutreturn
Date:   Thu,  7 Jan 2021 00:31:27 -0500
Message-Id: <20210107053130.20341-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210107053130.20341-3-trondmy@kernel.org>
References: <20210107053130.20341-1-trondmy@kernel.org>
 <20210107053130.20341-2-trondmy@kernel.org>
 <20210107053130.20341-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If a layout return is in progress, we should wait for it to complete,
in case the layout segment we are picking up gets returned too.

Fixes: 30cb3ee299cb ("pNFS: Handle NFS4ERR_OLD_STATEID on layoutreturn by bumping the state seqid")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 16a37214aba9..fc13a3c8bc48 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2018,6 +2018,27 @@ pnfs_update_layout(struct inode *ino,
 		goto lookup_again;
 	}
 
+	/*
+	 * Because we free lsegs when sending LAYOUTRETURN, we need to wait
+	 * for LAYOUTRETURN.
+	 */
+	if (test_bit(NFS_LAYOUT_RETURN, &lo->plh_flags)) {
+		spin_unlock(&ino->i_lock);
+		dprintk("%s wait for layoutreturn\n", __func__);
+		lseg = ERR_PTR(pnfs_prepare_to_retry_layoutget(lo));
+		if (!IS_ERR(lseg)) {
+			pnfs_put_layout_hdr(lo);
+			dprintk("%s retrying\n", __func__);
+			trace_pnfs_update_layout(ino, pos, count, iomode, lo,
+						 lseg,
+						 PNFS_UPDATE_LAYOUT_RETRY);
+			goto lookup_again;
+		}
+		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
+					 PNFS_UPDATE_LAYOUT_RETURN);
+		goto out_put_layout_hdr;
+	}
+
 	lseg = pnfs_find_lseg(lo, &arg, strict_iomode);
 	if (lseg) {
 		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
@@ -2070,28 +2091,6 @@ pnfs_update_layout(struct inode *ino,
 		nfs4_stateid_copy(&stateid, &lo->plh_stateid);
 	}
 
-	/*
-	 * Because we free lsegs before sending LAYOUTRETURN, we need to wait
-	 * for LAYOUTRETURN even if first is true.
-	 */
-	if (test_bit(NFS_LAYOUT_RETURN, &lo->plh_flags)) {
-		spin_unlock(&ino->i_lock);
-		dprintk("%s wait for layoutreturn\n", __func__);
-		lseg = ERR_PTR(pnfs_prepare_to_retry_layoutget(lo));
-		if (!IS_ERR(lseg)) {
-			if (first)
-				pnfs_clear_first_layoutget(lo);
-			pnfs_put_layout_hdr(lo);
-			dprintk("%s retrying\n", __func__);
-			trace_pnfs_update_layout(ino, pos, count, iomode, lo,
-					lseg, PNFS_UPDATE_LAYOUT_RETRY);
-			goto lookup_again;
-		}
-		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
-				PNFS_UPDATE_LAYOUT_RETURN);
-		goto out_put_layout_hdr;
-	}
-
 	if (pnfs_layoutgets_blocked(lo)) {
 		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
 				PNFS_UPDATE_LAYOUT_BLOCKED);
-- 
2.29.2

