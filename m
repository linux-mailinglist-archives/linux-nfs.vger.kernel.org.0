Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C962EAE38
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbhAEP1E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:27:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbhAEP1E (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 Jan 2021 10:27:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D97722B51
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609860383;
        bh=D24Ib+4BY4IYY1PusSUnhNp3PP0Q13XBwl3Ko5G5194=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pKOJsiWFO2IaeDRfNSRcR51QeqWqf3WEp5nRADdSW68km7iJXMPNWVkyI2uwgr9+p
         vZxJWekdMWW6qrn0WMvSTfV39lblDQ7y6UOPt6CcOF9I+ni1iG5Tleer9gVFPcnzEz
         JhO7VJxL1XpUyGmmxOYXV1zMPXccic+a9E6RC0GDwp8i5qKZFkDgB+VJqbsjrTq2Ih
         18p6rh7Jv9WbnNZ5O2pdskimOI3GheUjIgRYnqWY9OqCnvrRnTY3O66CFpnrV1g9+F
         HqBfviaqiA4Z9YvWxqWzg+XH0/R0rvi1ZwFkArHgp0U3k3vhiYscFHSZVlH3ZSkUSQ
         PpJmD9pbjnhZg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] pNFS: Stricter ordering of layoutget and layoutreturn
Date:   Tue,  5 Jan 2021 10:26:20 -0500
Message-Id: <20210105152620.754453-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210105152620.754453-3-trondmy@kernel.org>
References: <20210105152620.754453-1-trondmy@kernel.org>
 <20210105152620.754453-2-trondmy@kernel.org>
 <20210105152620.754453-3-trondmy@kernel.org>
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
index a0d8a67a4dd9..e4a27afeee90 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2017,6 +2017,27 @@ pnfs_update_layout(struct inode *ino,
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
@@ -2069,28 +2090,6 @@ pnfs_update_layout(struct inode *ino,
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

