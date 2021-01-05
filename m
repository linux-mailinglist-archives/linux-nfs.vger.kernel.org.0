Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0D92EAE37
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbhAEP1E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:27:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbhAEP1D (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 Jan 2021 10:27:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EA7222B4B
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609860383;
        bh=ZebdL5Lac/QocOqW9q6V5iyXRLtHDhEINPK5zKxu6eI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nfUD5Uv3TYn5A/dlR5LFld/ku6KIE6BW3rsybECuVhFaq+Xo3TtEGeIrrCvQ0GDH4
         ZSpF1Yq4bu0puItQAcYL/2Q7KKob/JGzm8C6IcH02LpflPwvqKMGP9hkdqAEicsejN
         19sjuGDNnMe62DC4JvK9nRdvRN2YYshXwstR/RvZt9MiMb/JvfMMjfoGxgKV1eNhzW
         uvgxXViguchXTAb36GE4vKURrQdS44Y/KREswNRJPG1TLaXJ4HJDxvDLxijlrnXzF5
         P4/vBuboo8ceaGrRZibN02sXBwdT3sp59exQfRhAUcLF20tZ1eK6+6ATxSx49SejCI
         UQM75sKXwvheA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] pNFS: Clean up pnfs_layoutreturn_free_lsegs()
Date:   Tue,  5 Jan 2021 10:26:19 -0500
Message-Id: <20210105152620.754453-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210105152620.754453-2-trondmy@kernel.org>
References: <20210105152620.754453-1-trondmy@kernel.org>
 <20210105152620.754453-2-trondmy@kernel.org>
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
index a18b1992b2fb..a0d8a67a4dd9 100644
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
 
@@ -1576,11 +1575,10 @@ void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
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

