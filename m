Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395FE2ECA2C
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jan 2021 06:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbhAGFcO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jan 2021 00:32:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbhAGFcN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 7 Jan 2021 00:32:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 322BD22E03
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jan 2021 05:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609997493;
        bh=/R1M0T6Kd3g2Y/TZcD2GM9uO8zV8lOJ1cWbQeRN6kMo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CLUUGsl2eOHix6rDjVkBmpMfrFL3sFWBD1+juq286DbXMh6EFY4rrgnUOvMKk2PkU
         +Kv7bFFXhpMlUdLn6NMoEFRD1h9CiggyhC9/tsDd/iz1he+MmBrlRlNjUi/6MM2qvX
         VynQPudD/cP1wlLCS/qGxWPgV3w3kOkU2YIhT2wSF9rc6Aud2Dg2Hgo7TG5olHaaJJ
         qXNNDdD59Mj2j9SauUYx6flZgHBw2BA6C2XgFwGq7Qk4OupttMhu0mZV6zC4COId9v
         LwGVXM4A8woBz8uv4w6eBxAT1wO9JNdLPQW2T9TdGXcHidiKHroYWEmKlnNXT6yXv7
         JHqODE9BXC2Tg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 5/7] NFS/pNFS: Don't call pnfs_free_bucket_lseg() before removing the request
Date:   Thu,  7 Jan 2021 00:31:28 -0500
Message-Id: <20210107053130.20341-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210107053130.20341-4-trondmy@kernel.org>
References: <20210107053130.20341-1-trondmy@kernel.org>
 <20210107053130.20341-2-trondmy@kernel.org>
 <20210107053130.20341-3-trondmy@kernel.org>
 <20210107053130.20341-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

In pnfs_generic_clear_request_commit(), we try calling
pnfs_free_bucket_lseg() before we remove the request from the DS bucket.
That will always fail, since the point is to test for whether or not
that bucket is empty.

Fixes: c84bea59449a ("NFS/pNFS: Simplify bucket layout segment reference counting")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 2efcfdd348a1..df20bbe8d15e 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -78,22 +78,18 @@ void
 pnfs_generic_clear_request_commit(struct nfs_page *req,
 				  struct nfs_commit_info *cinfo)
 {
-	struct pnfs_layout_segment *freeme = NULL;
+	struct pnfs_commit_bucket *bucket = NULL;
 
 	if (!test_and_clear_bit(PG_COMMIT_TO_DS, &req->wb_flags))
 		goto out;
 	cinfo->ds->nwritten--;
-	if (list_is_singular(&req->wb_list)) {
-		struct pnfs_commit_bucket *bucket;
-
+	if (list_is_singular(&req->wb_list))
 		bucket = list_first_entry(&req->wb_list,
-					  struct pnfs_commit_bucket,
-					  written);
-		freeme = pnfs_free_bucket_lseg(bucket);
-	}
+					  struct pnfs_commit_bucket, written);
 out:
 	nfs_request_remove_commit_list(req, cinfo);
-	pnfs_put_lseg(freeme);
+	if (bucket)
+		pnfs_put_lseg(pnfs_free_bucket_lseg(bucket));
 }
 EXPORT_SYMBOL_GPL(pnfs_generic_clear_request_commit);
 
-- 
2.29.2

