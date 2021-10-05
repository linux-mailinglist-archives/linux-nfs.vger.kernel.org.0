Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B2B422D84
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 18:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbhJEQMg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 12:12:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236227AbhJEQMg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 Oct 2021 12:12:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13FF561354
        for <linux-nfs@vger.kernel.org>; Tue,  5 Oct 2021 16:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633450245;
        bh=zKwFiq2DF0F7CKkpZ3b8H7IyiJMIJZ3jWAMENIfe1z8=;
        h=From:To:Subject:Date:From;
        b=owi1PDiEgTykKhXK6mcprcy6CS6ulL/dwTmzYigWglZEhwPCPkf75GInmNKTtO8IN
         xIRVY/ortArZQYFNoH6lMXd8eAS8mHAeuftgHY+XS7gQ6DA6jVy4lfa/dnPbvyJHRV
         rItIzHyYI076/YenjVkmJaUiXRjoDkuj1U6iWwmgD4B+1sJw8BuIJ835i7byVx8QIK
         Rd7cEVoEqonQ9vZ0bvK9oMhxdS1QRAsxRv99Ukwgq7vio6aMrOwoH0bxQIyKwvKqA5
         wOT+P6AhduU6KRcxtM8FjVrgMYTTqHnhD56yKCNlK8/cj3iOkKb43w8q8hU8+XlwG5
         V6vF4kOgR1ynA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: Fix deadlocks in nfs_scan_commit_list()
Date:   Tue,  5 Oct 2021 12:10:35 -0400
Message-Id: <20211005161036.1054428-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Partially revert commit 2ce209c42c01 ("NFS: Wait for requests that are
locked on the commit list"), since it can lead to deadlocks between
commit requests and nfs_join_page_group().
For now we should assume that any locked requests on the commit list are
either about to be removed and committed by another task, or the writes
they describe are about to be retransmitted. In either case, we should
not need to worry.

Fixes: 2ce209c42c01 ("NFS: Wait for requests that are locked on the commit list")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index b89d5ef3af0e..38f181e1343a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1039,25 +1039,11 @@ nfs_scan_commit_list(struct list_head *src, struct list_head *dst,
 	struct nfs_page *req, *tmp;
 	int ret = 0;
 
-restart:
 	list_for_each_entry_safe(req, tmp, src, wb_list) {
 		kref_get(&req->wb_kref);
 		if (!nfs_lock_request(req)) {
-			int status;
-
-			/* Prevent deadlock with nfs_lock_and_join_requests */
-			if (!list_empty(dst)) {
-				nfs_release_request(req);
-				continue;
-			}
-			/* Ensure we make progress to prevent livelock */
-			mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
-			status = nfs_wait_on_request(req);
 			nfs_release_request(req);
-			mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
-			if (status < 0)
-				break;
-			goto restart;
+			continue;
 		}
 		nfs_request_remove_commit_list(req, cinfo);
 		clear_bit(PG_COMMIT_TO_DS, &req->wb_flags);
@@ -1952,6 +1938,7 @@ static int __nfs_commit_inode(struct inode *inode, int how,
 	int may_wait = how & FLUSH_SYNC;
 	int ret, nscan;
 
+	how &= ~FLUSH_SYNC;
 	nfs_init_cinfo_from_inode(&cinfo, inode);
 	nfs_commit_begin(cinfo.mds);
 	for (;;) {
-- 
2.31.1

