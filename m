Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750087CFEEC
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Oct 2023 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346475AbjJSQAU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Oct 2023 12:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345737AbjJSQAT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Oct 2023 12:00:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07388112
        for <linux-nfs@vger.kernel.org>; Thu, 19 Oct 2023 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697731171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=n5YIYGgOGXO5a1I/NLpBl4Lpc+zw4UO/MrgimT+sYFw=;
        b=DeYEdOy3enn2rH9IpNKzU4B0AS76fYuAMl1osXW8HynW9UnyCleVFVOgHJ2nANbZNdCB2K
        f1KFoxM9sFnpvujCBddovzU6MndDzOi3Gi8D8wIuoJPxfLUtlsKesoKIG0SK6SFbRdUzea
        GyIPekJo49i3Rlxb8/kQItg+xsv8r3w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-UYGzGbVMPQ6uQLs_i33Yww-1; Thu, 19 Oct 2023 11:59:23 -0400
X-MC-Unique: UYGzGbVMPQ6uQLs_i33Yww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B015891767;
        Thu, 19 Oct 2023 15:59:23 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCFBFC15BB8;
        Thu, 19 Oct 2023 15:59:22 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [RESEND PATCH v2] NFSv4: fairly test all delegations on a SEQ4_ revocation
Date:   Thu, 19 Oct 2023 11:59:22 -0400
Message-ID: <20231019155922.6549-1-bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When the client is required to use TEST_STATEID to discover which
delegation(s) have been revoked, it may continually test delegations at the
head of the list if the server continues to be unsatisfied and send
SEQ4_STATUS_RECALLABLE_STATE_REVOKED.  For a large number of delegations
this behavior is prone to live-lock because the client may never be able to
test and free revoked state at the end of the list since the
SEQ4_STATUS_RECALLABLE_STATE_REVOKED will cause us to flag delegations at
the head of the list to be tested.  This problem is further exacerbated by
the state manager's willingness to be scheduled out on a busy system while
testing the list of delegations.

Keep a generation counter for each attempt to test all delegations, and
skip delegations that have already been tested in the current pass.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/delegation.c       | 7 ++++++-
 fs/nfs/delegation.h       | 1 +
 include/linux/nfs_fs_sb.h | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

--

Changed on v2: remove extra brackets that had my debug statements

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index cf7365581031..fa1a14def45c 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -448,6 +448,7 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	delegation->cred = get_cred(cred);
 	delegation->inode = inode;
 	delegation->flags = 1<<NFS_DELEGATION_REFERENCED;
+	delegation->test_gen = 0;
 	spin_lock_init(&delegation->lock);
 
 	spin_lock(&clp->cl_lock);
@@ -1294,6 +1295,8 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
 	struct inode *inode;
 	const struct cred *cred;
 	nfs4_stateid stateid;
+	unsigned long gen = ++server->delegation_gen;
+
 restart:
 	rcu_read_lock();
 restart_locked:
@@ -1303,7 +1306,8 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
 		    test_bit(NFS_DELEGATION_RETURNING,
 					&delegation->flags) ||
 		    test_bit(NFS_DELEGATION_TEST_EXPIRED,
-					&delegation->flags) == 0)
+					&delegation->flags) == 0 ||
+			delegation->test_gen == gen)
 			continue;
 		inode = nfs_delegation_grab_inode(delegation);
 		if (inode == NULL)
@@ -1312,6 +1316,7 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
 		cred = get_cred_rcu(delegation->cred);
 		nfs4_stateid_copy(&stateid, &delegation->stateid);
 		spin_unlock(&delegation->lock);
+		delegation->test_gen = gen;
 		clear_bit(NFS_DELEGATION_TEST_EXPIRED, &delegation->flags);
 		rcu_read_unlock();
 		nfs_delegation_test_free_expired(inode, &stateid, cred);
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 1c378992b7c0..a6f495d012cf 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -21,6 +21,7 @@ struct nfs_delegation {
 	fmode_t type;
 	unsigned long pagemod_limit;
 	__u64 change_attr;
+	unsigned long test_gen;
 	unsigned long flags;
 	refcount_t refcount;
 	spinlock_t lock;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 20eeba8b009d..2f9d380b3439 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -238,6 +238,7 @@ struct nfs_server {
 	struct list_head	delegations;
 	struct list_head	ss_copies;
 
+	unsigned long		delegation_gen;
 	unsigned long		mig_gen;
 	unsigned long		mig_status;
 #define NFS_MIG_IN_TRANSITION		(1)
-- 
2.40.1

