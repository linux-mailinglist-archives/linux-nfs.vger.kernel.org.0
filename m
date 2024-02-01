Return-Path: <linux-nfs+bounces-1700-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F7E84609D
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 20:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BCE1F25A5B
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 19:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B1485272;
	Thu,  1 Feb 2024 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQgT0ASm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6081E85274;
	Thu,  1 Feb 2024 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814409; cv=none; b=dmFTy7LmMEjFkJzOkYtco4oKojk4N0TYAQJXAfHsJCFyoUI43Oa9drjjB1+e/rOXFt1G51MLGaDrPmwcqWEAsNVf7O66DCnDOH+z3h8VibH/+Fi1mEfyZAxLgYrVFOoN2wzAwCVevA1kB0mX+XbvNAQBMOF0lLnUaCuZURgufmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814409; c=relaxed/simple;
	bh=iH85Pz0com4u+I8MDjLgoTQAwlaAU32vDG21kw8Y+hc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTGHnEzoGo25Tx83/nwAvsZRspU523v9MaVyxOr+1eLB8MkzcQ5TEPlr3//+9v0o3AKI1d05e7JOqJbqE7E1vndsm8aK2jiKnxxeVFNzVrZ0Elpk96pQ0geb9dA6oS3qYNKbTCZA/WQK8cQEmXu7R8Jz9NgLppfmu4sKqq+VxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQgT0ASm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1355C433C7;
	Thu,  1 Feb 2024 19:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706814409;
	bh=iH85Pz0com4u+I8MDjLgoTQAwlaAU32vDG21kw8Y+hc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nQgT0ASmfO4xnEVE/DNGC97Fuoz+VIA1gMLW/SmPnEYUg2CwQ4LbRGsJ+FU3uzrYy
	 2oHPgLGeLIBMZmlhu1OZMsOpKIiFiNzWe5TdxHthpVqWy2Kbksz0FxqRWLUO/+Jlxm
	 +GlFm9FIVvc+nvNYzdwf5u0ZK+WsX093kymBg8aAhsXQwN2vmKUFCeUIlmaOkPC+6f
	 2DBaIjbvaZBDnsj5Tx8/KcZoTe5g9VlNs5bWKxGhgmKmsDdowlO3crSyVOmB80jIYa
	 4UCX58RDxs7TX55cyK0Y4AzGqHWS4GY+IetmQ21qqz6iC01nohKR303tt5QgMRsUCq
	 3nRjRvqMbd20w==
Subject: [PATCH 2/3] NFSD: Add documenting comment for
 nfsd4_release_lockowner()
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Thu, 01 Feb 2024 14:06:47 -0500
Message-ID: 
 <170681440781.15250.14604698752530527458.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170681433624.15250.5881267576986350500.stgit@klimt.1015granger.net>
References: 
 <170681433624.15250.5881267576986350500.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 043862b09cc00273e35e6c3a6389957953a34207 ]

And return explicit nfserr values that match what is documented in the
new comment / API contract.

Stable-dep-of: edcf9725150e ("nfsd: fix RELEASE_LOCKOWNER")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9a77a3eac4ac..0dfc45d37658 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6867,6 +6867,23 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 	return status;
 }
 
+/**
+ * nfsd4_release_lockowner - process NFSv4.0 RELEASE_LOCKOWNER operations
+ * @rqstp: RPC transaction
+ * @cstate: NFSv4 COMPOUND state
+ * @u: RELEASE_LOCKOWNER arguments
+ *
+ * The lockowner's so_count is bumped when a lock record is added
+ * or when copying a conflicting lock. The latter case is brief,
+ * but can lead to fleeting false positives when looking for
+ * locks-in-use.
+ *
+ * Return values:
+ *   %nfs_ok: lockowner released or not found
+ *   %nfserr_locks_held: lockowner still in use
+ *   %nfserr_stale_clientid: clientid no longer active
+ *   %nfserr_expired: clientid not recognized
+ */
 __be32
 nfsd4_release_lockowner(struct svc_rqst *rqstp,
 			struct nfsd4_compound_state *cstate,
@@ -6893,7 +6910,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	lo = find_lockowner_str_locked(clp, &rlockowner->rl_owner);
 	if (!lo) {
 		spin_unlock(&clp->cl_lock);
-		return status;
+		return nfs_ok;
 	}
 	if (atomic_read(&lo->lo_owner.so_count) != 2) {
 		spin_unlock(&clp->cl_lock);
@@ -6909,11 +6926,11 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		put_ol_stateid_locked(stp, &reaplist);
 	}
 	spin_unlock(&clp->cl_lock);
+
 	free_ol_stateid_reaplist(&reaplist);
 	remove_blocked_locks(lo);
 	nfs4_put_stateowner(&lo->lo_owner);
-
-	return status;
+	return nfs_ok;
 }
 
 static inline struct nfs4_client_reclaim *



