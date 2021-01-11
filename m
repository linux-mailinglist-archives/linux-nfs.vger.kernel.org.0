Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AFA2F0AC4
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 02:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbhAKBZx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 10 Jan 2021 20:25:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbhAKBZx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 10 Jan 2021 20:25:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40F44223E0
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 01:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610328312;
        bh=3OyD6HDc7FH59fsQImIIEBIlU7rW5C9F20OhinDLDiE=;
        h=From:To:Subject:Date:From;
        b=mS0lwA6jbDQ0N+T8p4qXyrkEwr3BiMd9/R1GkMQG8GZIfTN/gSRuAWUniv9oATGKN
         aIb5jo0s2hxAXVVhB0XMLZC9ytjYoqQVp5bMBE1ME+8tzy3xeC/kqxi59v8/8uR5qy
         645ykiop9UhdVOZl2QadMtTb+I58g3B4anQ3V6etCFrwf9eilLY5kpgiGUjp45ecWI
         uQWdn+xPZyzcCArqXcEw8I3wbAVDkVkzrjmUo4LQNTNticU55wY99w1PacefS14O6N
         MFbJJ+63QwafoNmZsx3HyQZ+XDwXgWKg50F1n70oEtoXV6HxqMWJ0ln/IUU9W0PxgG
         bjVRnCwEgKMtg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: nfs_delegation_find_inode_server must first reference the superblock
Date:   Sun, 10 Jan 2021 20:25:10 -0500
Message-Id: <20210111012511.481829-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Before referencing the inode, we must ensure that the superblock can be
referenced. Otherwise, we can end up with iput() calling superblock
operations that are no longer valid or accessible.

Fixes: e39d8a186ed0 ("NFSv4: Fix an Oops during delegation callbacks")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 816e1427f17e..04bf8066980c 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1011,22 +1011,24 @@ nfs_delegation_find_inode_server(struct nfs_server *server,
 				 const struct nfs_fh *fhandle)
 {
 	struct nfs_delegation *delegation;
-	struct inode *freeme, *res = NULL;
+	struct super_block *freeme = NULL;
+	struct inode *res = NULL;
 
 	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
 		spin_lock(&delegation->lock);
 		if (delegation->inode != NULL &&
 		    !test_bit(NFS_DELEGATION_REVOKED, &delegation->flags) &&
 		    nfs_compare_fh(fhandle, &NFS_I(delegation->inode)->fh) == 0) {
-			freeme = igrab(delegation->inode);
-			if (freeme && nfs_sb_active(freeme->i_sb))
-				res = freeme;
+			if (nfs_sb_active(server->super)) {
+				freeme = server->super;
+				res = igrab(delegation->inode);
+			}
 			spin_unlock(&delegation->lock);
 			if (res != NULL)
 				return res;
 			if (freeme) {
 				rcu_read_unlock();
-				iput(freeme);
+				nfs_sb_deactive(freeme);
 				rcu_read_lock();
 			}
 			return ERR_PTR(-EAGAIN);
-- 
2.29.2

