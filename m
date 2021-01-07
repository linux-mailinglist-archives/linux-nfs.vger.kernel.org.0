Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EB32ECA2B
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jan 2021 06:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbhAGFcN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jan 2021 00:32:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbhAGFcM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 7 Jan 2021 00:32:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A89722DD3
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jan 2021 05:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609997492;
        bh=WCWFYJIzK+7gV1uOtwBlT+qX37HUdNpHq88GPcRrh5s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cCgUyVAT8XbZ8W6TIz0pwGQ1bP67OOVn/2iGk03qMWWv+tadoJZOb+a5Jlv7Ua7ez
         z/9JNECIpUcznvjakjaL7t351jzpz8BA9a5QM4asYkmjDCnRfOyS2shMyvBuxaYPvX
         AdhkGIdtJL9W0io/OAaTt0KF/qz6u+B687Ewkb8AeZCPLbcZWVrNCVoh0mq++CChg1
         vyYyK5goTvMWNEXuHejYnEPYNLhi1C+GZBkmlByC74jZcA+ibzHjOxhXEXKI+8+nwE
         pIkEPdPkkYYY+4MrSM2M9RLj/JW5uqc+7sqxtpO5ACNm++nQN3lkjH8ZKh3XTdYwq1
         ok0n6kkin1TEw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/7] pNFS: Clean up pnfs_layoutreturn_free_lsegs()
Date:   Thu,  7 Jan 2021 00:31:26 -0500
Message-Id: <20210107053130.20341-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210107053130.20341-2-trondmy@kernel.org>
References: <20210107053130.20341-1-trondmy@kernel.org>
 <20210107053130.20341-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Remove the check for whether or not the stateid is NULL, and fix up the
callers.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 30802d45c99a..16a37214aba9 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1152,7 +1152,7 @@ void pnfs_layoutreturn_free_lsegs(struct pnfs_layout_hdr *lo,
 	LIST_HEAD(freeme);
 
 	spin_lock(&inode->i_lock);
-	if (!pnfs_layout_is_valid(lo) || !arg_stateid ||
+	if (!pnfs_layout_is_valid(lo) ||
 	    !nfs4_stateid_match_other(&lo->plh_stateid, arg_stateid))
 		goto out_unlock;
 	if (stateid) {
@@ -1559,7 +1559,6 @@ void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
 {
 	struct pnfs_layout_hdr *lo = args->layout;
 	struct inode *inode = args->inode;
-	const nfs4_stateid *arg_stateid = NULL;
 	const nfs4_stateid *res_stateid = NULL;
 	struct nfs4_xdr_opaque_data *ld_private = args->ld_private;
 
@@ -1577,11 +1576,10 @@ void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
 			res_stateid = &res->stateid;
 		fallthrough;
 	default:
-		arg_stateid = &args->stateid;
+		pnfs_layoutreturn_free_lsegs(lo, &args->stateid, &args->range,
+					     res_stateid);
 	}
 	trace_nfs4_layoutreturn_on_close(args->inode, &args->stateid, ret);
-	pnfs_layoutreturn_free_lsegs(lo, arg_stateid, &args->range,
-			res_stateid);
 	if (ld_private && ld_private->ops && ld_private->ops->free)
 		ld_private->ops->free(ld_private);
 	pnfs_put_layout_hdr(lo);
-- 
2.29.2

