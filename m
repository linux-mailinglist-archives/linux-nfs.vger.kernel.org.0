Return-Path: <linux-nfs+bounces-10430-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C1EA4CA10
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 18:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96A9A7ABEF5
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FF422CBE9;
	Mon,  3 Mar 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb6xYd7V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336822B5AB
	for <linux-nfs@vger.kernel.org>; Mon,  3 Mar 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023332; cv=none; b=EkvKXDxy0m4Eurelxj2jBBWyEPPh5uPueOYUbl+tTttTQ20dQ7hYCc/1uW1n5yRMlXiDDTV907lSH8cma6tVM4uCBuK9s5D0g2Xs3xbH+yV0Bk6rCD+4CQE5GTIb9KeKiSo9mDzsiQ9u/n2jc7mXOLKDHvDz9ojZpV+BV7EXbvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023332; c=relaxed/simple;
	bh=viZH39/Hz7SX5oqB1O1obicG4xEf1225wzArudsgz+U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QK0XOoz2BkMuvt2GVcNLAIqRRg5YyfwsCTMNKKivGTaR0krtVjs3I22ZCWfeJDRO3W/S9SVg6GDxAfWlwhIIA41W5lKsIIjb7/twiZElRbh6q/GMcbWDTwqjSYY9c1kAZi4Vv3fL/y2ROxeRsoRQ6sMsC4+l5TcJA0Pqbo++jDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb6xYd7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2284DC4CEE5
	for <linux-nfs@vger.kernel.org>; Mon,  3 Mar 2025 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741023332;
	bh=viZH39/Hz7SX5oqB1O1obicG4xEf1225wzArudsgz+U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fb6xYd7VLxDl4p6he8h2BfXhW2Vjeh2MZOXFx/rQqknyEptoccwDg+uE2BPo+7TvJ
	 34sp5QVXscWt0u2Cmu820qVuYEgreTnf+IxzRHwNwUwTL8bErIXoDLc0ncnmGL7nR5
	 fg+BbwiMgPoAiGxbqaYtSikk+Ih96Hgda+oUlgIAW0kNh1Jmr1No5ZNst61aymx1eN
	 1Ab7aHSGHrRqLL6VxPmCEPxoSd38242kgjewPj4QXVBiq3nXJRxuoCV8I9VPKcB0KY
	 VhHx9QwQSjzWOiN4DZnhWhUp/2+WVgKdXXWzTuk+kKSi6GfClIhPbwlw2LT4g7tHqy
	 r4RVd50MQ9+gA==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] NFSv4: Avoid unnecessary scans of filesystems for returning delegations
Date: Mon,  3 Mar 2025 12:35:27 -0500
Message-ID: <caf3b686044859b05606f2bc64e1f45b5ccbb57a.1741023037.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741023037.git.trond.myklebust@hammerspace.com>
References: <cover.1741023037.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The amount of looping through the list of delegations is occasionally
leading to soft lockups. If the state manager was asked to return
delegations asynchronously, it should only scan those filesystems that
hold delegations that need to be returned.

Fixes: af3b61bf6131 ("NFSv4: Clean up nfs_client_return_marked_delegations()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c       | 5 +++++
 include/linux/nfs_fs_sb.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index df77d68d9ff9..d1f5e497729c 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -79,6 +79,7 @@ static void nfs_mark_return_delegation(struct nfs_server *server,
 				       struct nfs_delegation *delegation)
 {
 	set_bit(NFS_DELEGATION_RETURN, &delegation->flags);
+	set_bit(NFS4SERV_DELEGRETURN, &server->delegation_flags);
 	set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
 }
 
@@ -608,6 +609,9 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 	struct nfs_delegation *place_holder_deleg = NULL;
 	int err = 0;
 
+	if (!test_and_clear_bit(NFS4SERV_DELEGRETURN,
+				&server->delegation_flags))
+		return 0;
 restart:
 	/*
 	 * To avoid quadratic looping we hold a reference
@@ -659,6 +663,7 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 		cond_resched();
 		if (!err)
 			goto restart;
+		set_bit(NFS4SERV_DELEGRETURN, &server->delegation_flags);
 		set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
 		goto out;
 	}
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index f00bfcee7120..4e9ad6f6e907 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -250,6 +250,8 @@ struct nfs_server {
 	struct list_head	ss_copies;
 	struct list_head	ss_src_copies;
 
+	unsigned long		delegation_flags;
+#define NFS4SERV_DELEGRETURN		(1)
 	unsigned long		delegation_gen;
 	unsigned long		mig_gen;
 	unsigned long		mig_status;
-- 
2.48.1


