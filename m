Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEF8390580
	for <lists+linux-nfs@lfdr.de>; Tue, 25 May 2021 17:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhEYPeG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 11:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhEYPeC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 25 May 2021 11:34:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A93C860FDA
        for <linux-nfs@vger.kernel.org>; Tue, 25 May 2021 15:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621956752;
        bh=UhrHBKosMz1K30r/ZhYPKcQEvrPpBbiwevAFkmCXAgQ=;
        h=From:To:Subject:Date:From;
        b=sNhGEQmTrwA7NiZlP4p4w9qShX8zDyI/yC0cJZPTnfAcbxF/ROv2yqap3fv6zS4N4
         y+DgpQqTT36ntl6cvXQFR4wu/zrHkK9U9WOPsqIJTfX5wBwjQB8pfUXfRUOeBXXDyf
         bKZijW4rhT5kXyntkNnE5MxHitUnast6ORS70SOquNsUgIopJnv1KzL1d9uy7Vqljt
         fXuN7aG2FdGNBc7RMjoc/07puCvlAjlzIuIXg8kuDa0zNl8bEm7WdtGCBzhFbybffb
         UuO4PnYlmINAupABLy7NzUksxyWzIiD2xIuZOt04aPyoVURI5ogW7oVa50ABEEV4p1
         6FBB8srlJt5vA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS: Fix an Oopsable condition in __nfs_pageio_add_request()
Date:   Tue, 25 May 2021 11:32:29 -0400
Message-Id: <20210525153231.240329-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that nfs_pageio_error_cleanup() resets the mirror array contents,
so that the structure reflects the fact that it is now empty.
Also change the test in nfs_pageio_do_add_request() to be more robust by
checking whether or not the list is empty rather than relying on the
value of pg_count.

Fixes: fdbd1a2e4a71 ("nfs: Fix a missed page unlock after pg_doio()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 6c20b28d9d7c..76869728c44e 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1094,15 +1094,14 @@ nfs_pageio_do_add_request(struct nfs_pageio_descriptor *desc,
 	struct nfs_page *prev = NULL;
 	unsigned int size;
 
-	if (mirror->pg_count != 0) {
-		prev = nfs_list_entry(mirror->pg_list.prev);
-	} else {
+	if (list_empty(&mirror->pg_list)) {
 		if (desc->pg_ops->pg_init)
 			desc->pg_ops->pg_init(desc, req);
 		if (desc->pg_error < 0)
 			return 0;
 		mirror->pg_base = req->wb_pgbase;
-	}
+	} else
+		prev = nfs_list_entry(mirror->pg_list.prev);
 
 	if (desc->pg_maxretrans && req->wb_nio > desc->pg_maxretrans) {
 		if (NFS_SERVER(desc->pg_inode)->flags & NFS_MOUNT_SOFTERR)
@@ -1278,6 +1277,9 @@ static void nfs_pageio_error_cleanup(struct nfs_pageio_descriptor *desc)
 		mirror = nfs_pgio_get_mirror(desc, midx);
 		desc->pg_completion_ops->error_cleanup(&mirror->pg_list,
 				desc->pg_error);
+		mirror->pg_count = 0;
+		mirror->pg_base = 0;
+		mirror->pg_recoalesce = 0;
 	}
 }
 
-- 
2.31.1

