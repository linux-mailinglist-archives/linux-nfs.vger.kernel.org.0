Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A6119B616
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2020 20:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgDAS7C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Apr 2020 14:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732148AbgDAS7C (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Apr 2020 14:59:02 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2BC820784
        for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2020 18:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585767541;
        bh=377he6UN6s3hghZdwMeYOuNO0ogsCGWOC/L/PVnnRqg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=z6J4PJg0OuBMpIm+Dd8f2QnOts2xqciDG5upmXiEy3UoX/Wc9VGJ4FO4hdkd1A7PQ
         AdG6tuTCMth2K8/8EGEj1u21TM5tB2WDIOR4sApZ8nLssKE3csnaNBBM+xKnZWWguK
         tth3QodQLmFaTVD5dYjsjf+AxtNXeT78mCpuUYbE=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 03/10] NFS: Fix use-after-free issues in nfs_pageio_add_request()
Date:   Wed,  1 Apr 2020 14:56:45 -0400
Message-Id: <20200401185652.1904777-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401185652.1904777-3-trondmy@kernel.org>
References: <20200401185652.1904777-1-trondmy@kernel.org>
 <20200401185652.1904777-2-trondmy@kernel.org>
 <20200401185652.1904777-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We need to ensure that we create the mirror requests before calling
nfs_pageio_add_request_mirror() on the request we are adding.
Otherwise, we can end up with a use-after-free if the call to
nfs_pageio_add_request_mirror() triggers I/O.

Fixes: c917cfaf9bbe ("NFS: Fix up NFS I/O subrequest creation")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c | 48 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 0e3f0f241d83..99eb839c5778 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1191,38 +1191,38 @@ int nfs_pageio_add_request(struct nfs_pageio_descriptor *desc,
 	if (desc->pg_error < 0)
 		goto out_failed;
 
-	for (midx = 0; midx < desc->pg_mirror_count; midx++) {
-		if (midx) {
-			nfs_page_group_lock(req);
-
-			/* find the last request */
-			for (lastreq = req->wb_head;
-			     lastreq->wb_this_page != req->wb_head;
-			     lastreq = lastreq->wb_this_page)
-				;
-
-			dupreq = nfs_create_subreq(req, lastreq,
-					pgbase, offset, bytes);
-
-			nfs_page_group_unlock(req);
-			if (IS_ERR(dupreq)) {
-				desc->pg_error = PTR_ERR(dupreq);
-				goto out_failed;
-			}
-		} else
-			dupreq = req;
+	/* Create the mirror instances first, and fire them off */
+	for (midx = 1; midx < desc->pg_mirror_count; midx++) {
+		nfs_page_group_lock(req);
+
+		/* find the last request */
+		for (lastreq = req->wb_head;
+		     lastreq->wb_this_page != req->wb_head;
+		     lastreq = lastreq->wb_this_page)
+			;
+
+		dupreq = nfs_create_subreq(req, lastreq,
+				pgbase, offset, bytes);
+
+		nfs_page_group_unlock(req);
+		if (IS_ERR(dupreq)) {
+			desc->pg_error = PTR_ERR(dupreq);
+			goto out_failed;
+		}
 
-		if (nfs_pgio_has_mirroring(desc))
-			desc->pg_mirror_idx = midx;
+		desc->pg_mirror_idx = midx;
 		if (!nfs_pageio_add_request_mirror(desc, dupreq))
 			goto out_cleanup_subreq;
 	}
 
+	desc->pg_mirror_idx = 0;
+	if (!nfs_pageio_add_request_mirror(desc, req))
+		goto out_failed;
+
 	return 1;
 
 out_cleanup_subreq:
-	if (req != dupreq)
-		nfs_pageio_cleanup_request(desc, dupreq);
+	nfs_pageio_cleanup_request(desc, dupreq);
 out_failed:
 	nfs_pageio_error_cleanup(desc);
 	return 0;
-- 
2.25.1

