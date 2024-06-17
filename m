Return-Path: <linux-nfs+bounces-3861-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0683C90A1B2
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9410B28197A
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E6E8825;
	Mon, 17 Jun 2024 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRr6pddy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8A79F3
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587511; cv=none; b=FPC2YaeZgQF4aZg9oNU0/iuNrOoHss6eIPPXXaufd6ydlWWD5xnfFjfeJIAIpkzUMn98X7444a3I2jGc+/UYbiHoQf7uiRZiQVlUa67UtTz0wjfzUxoVyzkGj4eLPJGE4lM2RF0pN6iTqwvRDkrxJmiPenTDOHJlkyCfD3/t59U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587511; c=relaxed/simple;
	bh=AolsLQ07Le9ToPsFiX7P064ziAIl/0aGFCMVXUHKxbQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siCKLlcsiEmbCpV/OuCHzq9gkX8sFLb1ZfQTm8vjnhVXu6LPqPRbCz9HfRievgujH+EFKa0Wi2OxgW/TaukKfynKm6D3lw2gE4aeGkFp0IAChOU1NNZd5Oi5MgrapEXH5fyB+iznDa3Wuabenwa3QK0R0Ffiu0jsor4Kqkp6EFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRr6pddy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AF9C32786
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587510;
	bh=AolsLQ07Le9ToPsFiX7P064ziAIl/0aGFCMVXUHKxbQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZRr6pddyHoLh7NMNd4aGq3W0cBEZshSGTq1bs5ywxWusLWaF2i03yD5nJTz0GBbVf
	 4gkLuU5oGB9NG0f07UJGFXdWNHeZbNcvnnTielWd0OpCW0odqes6QhkflKs/R/oo1k
	 00JZ2JaNF2BEjbI9sQH4PXpMOVhXhfCqMxPhm1gSc4ks9iuspE+RdSP4du9G0KKBb2
	 qOZr7IJsvpYfRvHuIcrTDfAhkQfMzmBXAdpDgmtw9CnDSePk5XkLw7wAagzW4ct/T0
	 6NI6m037QbY41JIe3FvYOsNWbiRWA+uiVMro4pEFIG2MuvZ/tnNanFuHf5eImxi0X7
	 7aVhlXAVLOpQg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 02/19] NFSv4: Refactor nfs4_opendata_check_deleg()
Date: Sun, 16 Jun 2024 21:21:20 -0400
Message-ID: <20240617012137.674046-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-2-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Modify it to no longer depend directly on the struct opendata.
This will enable sharing with WANT_DELEGATION.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 66 +++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7a74dc1bcfbd..7f294085e887 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1954,51 +1954,39 @@ static struct nfs4_state *nfs4_try_open_cached(struct nfs4_opendata *opendata)
 }
 
 static void
-nfs4_opendata_check_deleg(struct nfs4_opendata *data, struct nfs4_state *state)
+nfs4_process_delegation(struct inode *inode, const struct cred *cred,
+			enum open_claim_type4 claim,
+			const struct nfs4_open_delegation *delegation)
 {
-	struct nfs_client *clp = NFS_SERVER(state->inode)->nfs_client;
-	struct nfs_delegation *delegation;
-	int delegation_flags = 0;
-
-	switch (data->o_res.delegation.open_delegation_type) {
+	switch (delegation->open_delegation_type) {
 	case NFS4_OPEN_DELEGATE_READ:
 	case NFS4_OPEN_DELEGATE_WRITE:
 		break;
 	default:
 		return;
-	};
-	rcu_read_lock();
-	delegation = rcu_dereference(NFS_I(state->inode)->delegation);
-	if (delegation)
-		delegation_flags = delegation->flags;
-	rcu_read_unlock();
-	switch (data->o_arg.claim) {
-	default:
-		break;
+	}
+	switch (claim) {
 	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
 	case NFS4_OPEN_CLAIM_DELEG_CUR_FH:
 		pr_err_ratelimited("NFS: Broken NFSv4 server %s is "
 				   "returning a delegation for "
 				   "OPEN(CLAIM_DELEGATE_CUR)\n",
-				   clp->cl_hostname);
-		return;
+				   NFS_SERVER(inode)->nfs_client->cl_hostname);
+		break;
+	case NFS4_OPEN_CLAIM_PREVIOUS:
+		nfs_inode_reclaim_delegation(inode, cred,
+				delegation->type,
+				&delegation->stateid,
+				delegation->pagemod_limit);
+		break;
+	default:
+		nfs_inode_set_delegation(inode, cred,
+				delegation->type,
+				&delegation->stateid,
+				delegation->pagemod_limit);
 	}
-	if ((delegation_flags & 1UL<<NFS_DELEGATION_NEED_RECLAIM) == 0)
-		nfs_inode_set_delegation(state->inode,
-				data->owner->so_cred,
-				data->o_res.delegation.type,
-				&data->o_res.delegation.stateid,
-				data->o_res.delegation.pagemod_limit);
-	else
-		nfs_inode_reclaim_delegation(state->inode,
-				data->owner->so_cred,
-				data->o_res.delegation.type,
-				&data->o_res.delegation.stateid,
-				data->o_res.delegation.pagemod_limit);
-
-	if (data->o_res.delegation.do_recall)
-		nfs_async_inode_return_delegation(state->inode,
-						  &data->o_res.delegation.stateid);
+	if (delegation->do_recall)
+		nfs_async_inode_return_delegation(inode, &delegation->stateid);
 }
 
 /*
@@ -2022,7 +2010,10 @@ _nfs4_opendata_reclaim_to_nfs4_state(struct nfs4_opendata *data)
 	if (ret)
 		return ERR_PTR(ret);
 
-	nfs4_opendata_check_deleg(data, state);
+	nfs4_process_delegation(state->inode,
+				data->owner->so_cred,
+				data->o_arg.claim,
+				&data->o_res.delegation);
 
 	if (!update_open_stateid(state, &data->o_res.stateid,
 				NULL, data->o_arg.fmode))
@@ -2089,8 +2080,11 @@ _nfs4_opendata_to_nfs4_state(struct nfs4_opendata *data)
 	if (IS_ERR(state))
 		goto out;
 
-	if (data->o_res.delegation.type != 0)
-		nfs4_opendata_check_deleg(data, state);
+	nfs4_process_delegation(state->inode,
+				data->owner->so_cred,
+				data->o_arg.claim,
+				&data->o_res.delegation);
+
 	if (!update_open_stateid(state, &data->o_res.stateid,
 				NULL, data->o_arg.fmode)) {
 		nfs4_put_open_state(state);
-- 
2.45.2


