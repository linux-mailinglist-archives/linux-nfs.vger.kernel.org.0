Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2457078782C
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 20:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjHXSnW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 14:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243033AbjHXSnO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 14:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB36AE50
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 11:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692902549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pkv/PfMxqFvZkU5OYBQSY4PHeW0b7SXY3/jo72jZU7E=;
        b=PEigP+X/27f4JXm3tV3/CawyxgL12s/Pg3Mg74Ni4n7h5DeW6cDQPfvtLa7eruVjr6V6iy
        IiR/JWBVEFspchpMsHy6ZBrYKhX5zklVCWpgImVr9b/9F1zftx4ag4xDRJ/BV1EhhfIUs2
        Tm36C8I9eKljneLLmria7ik+DG8T+l4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-XVI9qYNhOwKQ2R9dRMZIyw-1; Thu, 24 Aug 2023 14:42:28 -0400
X-MC-Unique: XVI9qYNhOwKQ2R9dRMZIyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9C42800270;
        Thu, 24 Aug 2023 18:42:27 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-2.rdu2.redhat.com [10.22.0.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FC2FC1602B;
        Thu, 24 Aug 2023 18:42:27 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: fairly test all delegations on a SEQ4_ revocation
Date:   Thu, 24 Aug 2023 14:42:26 -0400
Message-Id: <426fa7ac71b4c9496039cc16169029a5abcb6dc5.1692902495.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 fs/nfs/delegation.c       | 8 +++++++-
 fs/nfs/delegation.h       | 1 +
 include/linux/nfs_fs_sb.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index cf7365581031..34a16bf2ee91 100644
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
@@ -1303,8 +1306,10 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
 		    test_bit(NFS_DELEGATION_RETURNING,
 					&delegation->flags) ||
 		    test_bit(NFS_DELEGATION_TEST_EXPIRED,
-					&delegation->flags) == 0)
+					&delegation->flags) == 0 ||
+			delegation->test_gen == gen) {
 			continue;
+		}
 		inode = nfs_delegation_grab_inode(delegation);
 		if (inode == NULL)
 			goto restart_locked;
@@ -1312,6 +1317,7 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
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

