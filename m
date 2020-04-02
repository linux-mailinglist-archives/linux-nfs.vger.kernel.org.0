Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F1C19CD9F
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2020 01:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390216AbgDBXvr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Apr 2020 19:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390172AbgDBXvr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 Apr 2020 19:51:47 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BCF62072E
        for <linux-nfs@vger.kernel.org>; Thu,  2 Apr 2020 23:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585871506;
        bh=nqt8+cX6SQem6DZLzOlBmx3XAeGEX6R/w8yCNPG6izQ=;
        h=From:To:Subject:Date:From;
        b=crW1J/m6l5ne/tnGtsE+lFZqOrbSvYy5UQBsVH8tRUxB31j4rALvY2M3guHaINoot
         iJECAMKXz7mCUgUokjZZsyt0XxuMQASBh1SXc5Jfkgg75ENQuEU6cRN2BtmGgWPErv
         alet9XQtjTTTOaRxJn4dEwXGg1+hVFf8FWuBPbQ8=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS: Beware when dereferencing the delegation cred
Date:   Thu,  2 Apr 2020 19:49:15 -0400
Message-Id: <20200402234917.797185-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When we look up the delegation cred, we are usually doing so in
conjunction with a read of the stateid, and we want to ensure
that the look up is atomic with that read.

Fixes: 5f4adff16fa2 ("NFSv4: nfs_update_inplace_delegation() should update delegation cred")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 9 ++++++++-
 fs/nfs/nfs4proc.c   | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 01974f17afc9..816e1427f17e 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1243,8 +1243,10 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
 		inode = nfs_delegation_grab_inode(delegation);
 		if (inode == NULL)
 			goto restart_locked;
+		spin_lock(&delegation->lock);
 		cred = get_cred_rcu(delegation->cred);
 		nfs4_stateid_copy(&stateid, &delegation->stateid);
+		spin_unlock(&delegation->lock);
 		clear_bit(NFS_DELEGATION_TEST_EXPIRED, &delegation->flags);
 		rcu_read_unlock();
 		nfs_delegation_test_free_expired(inode, &stateid, cred);
@@ -1363,11 +1365,14 @@ bool nfs4_copy_delegation_stateid(struct inode *inode, fmode_t flags,
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_delegation *delegation;
-	bool ret;
+	bool ret = false;
 
 	flags &= FMODE_READ|FMODE_WRITE;
 	rcu_read_lock();
 	delegation = rcu_dereference(nfsi->delegation);
+	if (!delegation)
+		goto out;
+	spin_lock(&delegation->lock);
 	ret = nfs4_is_valid_delegation(delegation, flags);
 	if (ret) {
 		nfs4_stateid_copy(dst, &delegation->stateid);
@@ -1375,6 +1380,8 @@ bool nfs4_copy_delegation_stateid(struct inode *inode, fmode_t flags,
 		if (cred)
 			*cred = get_cred(delegation->cred);
 	}
+	spin_unlock(&delegation->lock);
+out:
 	rcu_read_unlock();
 	return ret;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 905c7d1bc277..e4f8311e506c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2790,16 +2790,19 @@ static int nfs41_check_delegation_stateid(struct nfs4_state *state)
 		return NFS_OK;
 	}
 
+	spin_lock(&delegation->lock);
 	nfs4_stateid_copy(&stateid, &delegation->stateid);
 
 	if (!test_and_clear_bit(NFS_DELEGATION_TEST_EXPIRED,
 				&delegation->flags)) {
+		spin_unlock(&delegation->lock);
 		rcu_read_unlock();
 		return NFS_OK;
 	}
 
 	if (delegation->cred)
 		cred = get_cred(delegation->cred);
+	spin_unlock(&delegation->lock);
 	rcu_read_unlock();
 	status = nfs41_test_and_free_expired_stateid(server, &stateid, cred);
 	trace_nfs4_test_delegation_stateid(state, NULL, status);
-- 
2.25.1

