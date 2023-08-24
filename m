Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D01787847
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 20:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjHXSxp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjHXSxO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 14:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004831BD2
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692903147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n5YIYGgOGXO5a1I/NLpBl4Lpc+zw4UO/MrgimT+sYFw=;
        b=dqp/cvB0OU1maZDWSgnkFfRi9YafJcTIjihEq87bA4IKZ3W6K0/1EITXayQ0DtCC3qNLfA
        4YPt783RFQ9MvLNA21BAbWECnxwt8ZfMw2sevqNyWJUTW+QzMi9LZpXAwODNBBuRaHvYnK
        6j7pjWZO/Xdn1HK5ecVCD0RJ3yYGbHA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-J84qSrZNOmaDkNzWk1KU_w-1; Thu, 24 Aug 2023 14:52:22 -0400
X-MC-Unique: J84qSrZNOmaDkNzWk1KU_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCCD58D40A4;
        Thu, 24 Aug 2023 18:52:20 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-2.rdu2.redhat.com [10.22.0.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60A39140E962;
        Thu, 24 Aug 2023 18:52:20 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSv4: fairly test all delegations on a SEQ4_ revocation
Date:   Thu, 24 Aug 2023 14:52:19 -0400
Message-Id: <6c85bc9cc6bd8d70fe0e74b096c72944f61874a7.1692903063.git.bcodding@redhat.com>
In-Reply-To: <426fa7ac71b4c9496039cc16169029a5abcb6dc5.1692902495.git.bcodding@redhat.com>
References: <426fa7ac71b4c9496039cc16169029a5abcb6dc5.1692902495.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

