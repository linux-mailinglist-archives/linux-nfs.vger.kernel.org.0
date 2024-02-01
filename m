Return-Path: <linux-nfs+bounces-1696-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3262845A36
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 15:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471A8B28615
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CCB6216D;
	Thu,  1 Feb 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArwpQ/9E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAE76216B;
	Thu,  1 Feb 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797417; cv=none; b=uKDFYsX77HXW6yOSo2JBm3/sQZtaE9vUKH6JaGxqQzjQwl89ePOwmFOmYnEVVDS/ajuscATNet6VDnXL1bmXXalXfNBWBz0IlM9C5bC3eJnyqHV2Yfgo+rBB4+FxxgkM2pNP7v/zG0o0qc2xxHJOyESO+Fpz3AJFscruOwppOPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797417; c=relaxed/simple;
	bh=f7Eh45JAeXWy9iDanVb6kHOf6Rg+hgzgsW8kfJ5Kxd4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prS+BnlcDHRZ8xtp2fGmy9a2+tpuVk7ART7gEZ6nDbrryMsWb3fWW+OmxFwkFLwUz6oNZvFkrvn3bI8xfTtWASVOqmDY/UoJthZVuvJYzCwCjaT1lvyVuTD0Kex9Q98o2q3ZcfaL1Szfkax85XQ6vGzyFdwA5TXTJxtkcrac92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArwpQ/9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA52DC433C7;
	Thu,  1 Feb 2024 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706797416;
	bh=f7Eh45JAeXWy9iDanVb6kHOf6Rg+hgzgsW8kfJ5Kxd4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ArwpQ/9E992EiauW0CeWTRTdRn0lnejcJIIbVAmZLiM0re3mhfWFD+j/Lof7X41kJ
	 6OwmSpShWhm9Nx66rIWgpI1ziNQ4fkuPQ3J6EGf+N5IO0U0F5eDHpbdXLnS0I1zXuN
	 6P9nK97Wp1/BYKAFIyZxxeWioE8aoUgKN3KwVI+bZwPOvS3BhSN3yRDSc9Fuj+kKPI
	 /vA6K3W1KRGgqUphmvJaev8QKlIr78rTLYPMhv1meRVU0pTRZqSYYyZJSclD5lBt7S
	 SUaSc+oFFPdrjJYPGmpxv9mdkeLeA0kB1SdCyPXUqTY5+nA+Dm/aP2pwSl0q0NqXNk
	 Rs8Zo7T3Ev0MA==
Subject: [PATCH 2/3] NFSD: Add documenting comment for
 nfsd4_release_lockowner()
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Thu, 01 Feb 2024 09:23:35 -0500
Message-ID: 
 <170679741583.14195.11379223326231647078.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170679738225.14195.77163641928598673.stgit@klimt.1015granger.net>
References: <170679738225.14195.77163641928598673.stgit@klimt.1015granger.net>
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
index 1b40b2197ce6..b6480be7b5e6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7107,6 +7107,23 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
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
@@ -7133,7 +7150,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	lo = find_lockowner_str_locked(clp, &rlockowner->rl_owner);
 	if (!lo) {
 		spin_unlock(&clp->cl_lock);
-		return status;
+		return nfs_ok;
 	}
 	if (atomic_read(&lo->lo_owner.so_count) != 2) {
 		spin_unlock(&clp->cl_lock);
@@ -7149,11 +7166,11 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
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



