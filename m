Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259EB390868
	for <lists+linux-nfs@lfdr.de>; Tue, 25 May 2021 20:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhEYSEP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 14:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232250AbhEYSEN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 25 May 2021 14:04:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E1E661400
        for <linux-nfs@vger.kernel.org>; Tue, 25 May 2021 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621965763;
        bh=0na1AlFE4jd/lqYuo0yx4bg5RtgbvVJ+BoYv9SezeAY=;
        h=From:To:Subject:Date:From;
        b=RfispvswovGG3jW4J0HTUmChr+FKn3mnxjBBaMlLXD+gE8I2zOVcrX0m+8F+hAFpB
         L5XpaG0NN+g3jER5RhDG7obx1V3KNsCAGjLrvNMFxSMWZXCf9DSte3t65EH15HQG3l
         I6ViaE5nYT0wR9yM320atZfzD+zrQVSX7dC5e3crrcFZwdl0lGiI1pwCO2b9pr3MR/
         LQPH6iyO8l4WlS5A60HBsa6MgR84AzOd7msLb7q+UbSesb860kJcIRJG239J6QEPpE
         QpL7rzfCFOFoTxZTlW6xmiWhq2N2nF6wcIKlhHCl01qlaMx5cMlK3lEsbDNpp0TgDq
         3tEQFwMsIcuAw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/3] NFS: Fix an Oopsable condition in __nfs_pageio_add_request()
Date:   Tue, 25 May 2021 14:02:39 -0400
Message-Id: <20210525180241.261090-1-trondmy@kernel.org>
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

Fixes: a7d42ddb3099 ("nfs: add mirroring support to pgio layer")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 6c20b28d9d7c..d35c84af44e0 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1094,15 +1094,16 @@ nfs_pageio_do_add_request(struct nfs_pageio_descriptor *desc,
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
+		mirror->pg_count = 0;
+		mirror->pg_recoalesce = 0;
+	} else
+		prev = nfs_list_entry(mirror->pg_list.prev);
 
 	if (desc->pg_maxretrans && req->wb_nio > desc->pg_maxretrans) {
 		if (NFS_SERVER(desc->pg_inode)->flags & NFS_MOUNT_SOFTERR)
-- 
2.31.1

