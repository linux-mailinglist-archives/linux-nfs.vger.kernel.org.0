Return-Path: <linux-nfs+bounces-11251-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE24A9975A
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 20:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C581B802F2
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F141928CF6B;
	Wed, 23 Apr 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5P8ZcKn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E0310957
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431192; cv=none; b=aD7eOvsgzJHFnMgLC2aTbQty9XqUpZO5zrcYqk/hbi6lxjOfv0HUxJqT7Gs7bZYLeJhdD6cmjkckWmjnS/alhZHYnuJ5YXbnaXpcSxOXA4Z9XsmAZKViv6hJKL0tS54ABrkOaixdGltcU6aAQsqH5CGJrJkf9IZF+AmHfudVdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431192; c=relaxed/simple;
	bh=e0ucbDPiYLor2QaUD2RKwEfiSusvvCQeYEf7++VzmQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPEKpxqKTrB93lkc2WKe4OJE8bFaZupKr+oLzYXLqCKyfs+sski3sFB7kd5H8RwbM6Pv+MgO+sxmCELZ0SiiCrlaQsdwfUCHQBruQwTPJ1222HQZUG1EbE2CosPukCIkaITrf/LrMNPULSrepPESzjEKiQ+/RJF/akyGfnUSQnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5P8ZcKn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745431190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EyCoc/6b0j2mRvWmKDYzq2xwzQQblxK2O7gmil0gpLI=;
	b=D5P8ZcKnxaKV0VRQkEf2y3NLNvCzQ+CS9H4ceB7CumZNwFAr+uDdZuhPTnmjyzeEHEoh1s
	GI28eG3KHvTz7CWvI3zUh34HDgGs8ig3bS9SBrR8RbZz0JttvcwTXmibuVa/mmg5eaWAij
	3s5eEcgI+l+fvKyEZm7d6bDsiEj7c2w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-nkL1jS9hN0GHMPC7pZkVRg-1; Wed,
 23 Apr 2025 13:59:46 -0400
X-MC-Unique: nkL1jS9hN0GHMPC7pZkVRg-1
X-Mimecast-MFC-AGG-ID: nkL1jS9hN0GHMPC7pZkVRg_1745431185
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63660180034E;
	Wed, 23 Apr 2025 17:59:45 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.16])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B26B180045C;
	Wed, 23 Apr 2025 17:59:44 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4: Allow FREE_STATEID to clean up delegations
Date: Wed, 23 Apr 2025 13:59:41 -0400
Message-ID: <e8c113d33be1bf52016b6b747330eec5c17dc948.1745430006.git.bcodding@redhat.com>
In-Reply-To: <cover.1745430006.git.bcodding@redhat.com>
References: <cover.1745430006.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The NFS client's list of delegations can grow quite large (well beyond the
delegation watermark) if the server is revoking or there are repeated
events that expire state.  Once this happens, the revoked delegations can
cause a performance problem for subsequent walks of the
servers->delegations list when the client tries to test and free state.

If we can determine that the FREE_STATEID operation has completed without
error, we can prune the delegation from the list.

Since the NFS client combines TEST_STATEID with FREE_STATEID in its minor
version operations, there isn't an easy way to communicate success of
FREE_STATEID.  Rather than re-arrange quite a number of calling paths to
break out the separate procedures, let's signal the success of FREE_STATEID
by setting the stateid's type.

Set NFS4_FREED_STATEID_TYPE for stateids that have been successfully
discarded from the server, and use that type to signal that the delegation
can be cleaned up.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/delegation.c  | 25 ++++++++++++++++++-------
 fs/nfs/nfs4_fs.h     |  3 +--
 fs/nfs/nfs4proc.c    | 11 +++++------
 include/linux/nfs4.h |  1 +
 4 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 4db912f56230..b746793cf730 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1006,13 +1006,6 @@ static void nfs_revoke_delegation(struct inode *inode,
 		nfs_inode_find_state_and_recover(inode, stateid);
 }
 
-void nfs_remove_bad_delegation(struct inode *inode,
-		const nfs4_stateid *stateid)
-{
-	nfs_revoke_delegation(inode, stateid);
-}
-EXPORT_SYMBOL_GPL(nfs_remove_bad_delegation);
-
 void nfs_delegation_mark_returned(struct inode *inode,
 		const nfs4_stateid *stateid)
 {
@@ -1054,6 +1047,24 @@ void nfs_delegation_mark_returned(struct inode *inode,
 	nfs_inode_find_state_and_recover(inode, stateid);
 }
 
+/**
+ * nfs_remove_bad_delegation - handle delegations that are unusable
+ * @inode: inode to process
+ * @stateid: the delegation's stateid
+ *
+ * If the server ACK-ed our FREE_STATEID then clean
+ * up the delegation, else mark and keep the revoked state.
+ */
+void nfs_remove_bad_delegation(struct inode *inode,
+		const nfs4_stateid *stateid)
+{
+	if (stateid && stateid->type == NFS4_FREED_STATEID_TYPE)
+		nfs_delegation_mark_returned(inode, stateid);
+	else
+		nfs_revoke_delegation(inode, stateid);
+}
+EXPORT_SYMBOL_GPL(nfs_remove_bad_delegation);
+
 /**
  * nfs_expire_unused_delegation_types
  * @clp: client to process
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 7d383d29a995..d3ca91f60fc1 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -67,8 +67,7 @@ struct nfs4_minor_version_ops {
 	void	(*free_lock_state)(struct nfs_server *,
 			struct nfs4_lock_state *);
 	int	(*test_and_free_expired)(struct nfs_server *,
-					 const nfs4_stateid *,
-					 const struct cred *);
+					 nfs4_stateid *, const struct cred *);
 	struct nfs_seqid *
 		(*alloc_seqid)(struct nfs_seqid_counter *, gfp_t);
 	void	(*session_trunk)(struct rpc_clnt *clnt,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bfb9e980d662..143cb191b0b8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -105,7 +105,7 @@ static struct rpc_task *_nfs41_proc_sequence(struct nfs_client *clp,
 		bool is_privileged);
 static int nfs41_test_stateid(struct nfs_server *, const nfs4_stateid *,
 			      const struct cred *);
-static int nfs41_free_stateid(struct nfs_server *, const nfs4_stateid *,
+static int nfs41_free_stateid(struct nfs_server *, nfs4_stateid *,
 			      const struct cred *, bool);
 #endif
 
@@ -2886,16 +2886,14 @@ static int nfs40_open_expired(struct nfs4_state_owner *sp, struct nfs4_state *st
 }
 
 static int nfs40_test_and_free_expired_stateid(struct nfs_server *server,
-					       const nfs4_stateid *stateid,
-					       const struct cred *cred)
+					       nfs4_stateid *stateid, const struct cred *cred)
 {
 	return -NFS4ERR_BAD_STATEID;
 }
 
 #if defined(CONFIG_NFS_V4_1)
 static int nfs41_test_and_free_expired_stateid(struct nfs_server *server,
-					       const nfs4_stateid *stateid,
-					       const struct cred *cred)
+					       nfs4_stateid *stateid, const struct cred *cred)
 {
 	int status;
 
@@ -10572,7 +10570,7 @@ static const struct rpc_call_ops nfs41_free_stateid_ops = {
  * Note: this function is always asynchronous.
  */
 static int nfs41_free_stateid(struct nfs_server *server,
-		const nfs4_stateid *stateid,
+		nfs4_stateid *stateid,
 		const struct cred *cred,
 		bool privileged)
 {
@@ -10612,6 +10610,7 @@ static int nfs41_free_stateid(struct nfs_server *server,
 	if (IS_ERR(task))
 		return PTR_ERR(task);
 	rpc_put_task(task);
+	stateid->type = NFS4_FREED_STATEID_TYPE;
 	return 0;
 }
 
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 9ac83ca88326..8ec5766cb22f 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -72,6 +72,7 @@ struct nfs4_stateid_struct {
 		NFS4_LAYOUT_STATEID_TYPE,
 		NFS4_PNFS_DS_STATEID_TYPE,
 		NFS4_REVOKED_STATEID_TYPE,
+		NFS4_FREED_STATEID_TYPE,
 	} type;
 };
 
-- 
2.47.0


