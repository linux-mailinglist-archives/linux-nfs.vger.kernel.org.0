Return-Path: <linux-nfs+bounces-1692-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38B845A0E
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 15:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BBE1F21324
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E751F5D465;
	Thu,  1 Feb 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng62d+XW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD85337E;
	Thu,  1 Feb 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797315; cv=none; b=ecTqD0uK8fgxI7VcqM/w5v6PqSWnsuSvz+MbLpcyaW+KikxEYFI47kdOshfMoEtJEtDTyNZhXOkLLsklVud9Ke5ORWBSH6MS58gSHoGxmMzyGpWMloWo+TnSiYm7cSaBx+HL0FI1cL1JAbPe/0kCyoBkgWTv+ZM5+FpqptcoKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797315; c=relaxed/simple;
	bh=9iszL3bMHwAa7JyRz7Al1QK0A/KEcNMasKx4/EciM5g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LI+NPTuy1IDWOP49jD1nWQnBvPg8z23KqyN2pcK662QzvrhmaAzXruMRZPHlSRAQPr7ciql9MdEjX0vMUUNySOjeIjTpwgs2efIQmfjqmCsuk3qpw5iv2RnlkY+pcMpz80q9uYyqcnVJSzBxVHohPMr2Age1jAvhWVj2CCJ+QHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng62d+XW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41DAC433C7;
	Thu,  1 Feb 2024 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706797315;
	bh=9iszL3bMHwAa7JyRz7Al1QK0A/KEcNMasKx4/EciM5g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ng62d+XWuCDX4QLS4XMrWGxgy1O/70o4QN/9aiOMky+VreOOXiK8Qa2HIu00NUDHt
	 J71kAOnqCKrp5NrM5RUxwwS8Lz7j9Q9JZBIyhbigruloMNoVToQdeSapQIeUUymKHZ
	 lPJFaabu+/nqmBWGwARvUoayFgh6bqEtVZKR6/bCmCsAIMOAh42HhVcG200+YpNNJN
	 q3Bv0hk+H1aVG6Cr5yqgglAyGohXzOfQHDo6vDCENH9JcmyH56fuyYTWhpWZArm1fx
	 VKwU6TH/CJFD3GpWe3E6ZhSIeqzZ6rlIn+NjkJ/mVrKJ8ROeat1npKW3fnI6c4wlou
	 Wikf5HCSE90xQ==
Subject: [PATCH 2/3] NFSD: Add documenting comment for
 nfsd4_release_lockowner()
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Thu, 01 Feb 2024 09:21:53 -0500
Message-ID: 
 <170679731385.13994.10714724610995172976.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170679726132.13994.12738575104218499729.stgit@klimt.1015granger.net>
References: 
 <170679726132.13994.12738575104218499729.stgit@klimt.1015granger.net>
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
index 798063b9b96f..f8533299db1c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7284,6 +7284,23 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
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
@@ -7310,7 +7327,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	lo = find_lockowner_str_locked(clp, &rlockowner->rl_owner);
 	if (!lo) {
 		spin_unlock(&clp->cl_lock);
-		return status;
+		return nfs_ok;
 	}
 	if (atomic_read(&lo->lo_owner.so_count) != 2) {
 		spin_unlock(&clp->cl_lock);
@@ -7326,11 +7343,11 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
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



