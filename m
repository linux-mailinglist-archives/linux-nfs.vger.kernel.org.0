Return-Path: <linux-nfs+bounces-1699-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0557684609C
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 20:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE161F23FEC
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 19:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D56085264;
	Thu,  1 Feb 2024 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTT7Pnr2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3535984FC7;
	Thu,  1 Feb 2024 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814403; cv=none; b=vB8YGGJ00z+rs1xb5czf24GBD9NIiFBs5JHKHfqPesD8Hg4R+VeVAojViigfwf18GwQ9bFORm8cNkc4r2vxpwrvh3DSLOb8B91/m75JvfSiqkdYoZgFkNl2A6LN1a5r4kYm1QIfrO9D2ZBjJjj4jCTS6R2LOw2Sis2yPU0Sx2Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814403; c=relaxed/simple;
	bh=dCK+VAU2AQKDgMEEoSter8OFWkWUAXH351Qawc8AMYw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUTCHzz5+yIl+UfEg9+YQeM67zx4W0WVOBuSZHi99GPKkYR3JLSywxG5/+MBiOgzvIM+PCoe64xJrj0H2iCNsgm8qIFi7etnDbOEx3SEE7p6K5Iu8oZRnYbmOSVTeUPO3u1ILlaFhiOlJ13TedZj33MmCysY5J05Rb/9FpJe1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTT7Pnr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B47FC433C7;
	Thu,  1 Feb 2024 19:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706814402;
	bh=dCK+VAU2AQKDgMEEoSter8OFWkWUAXH351Qawc8AMYw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HTT7Pnr2hkN6QJyCxo/o24GbDxy+G8Ratkh4lip4ZWB3Dz+mpqjfCHCn8df5q5vTX
	 9vfZMFPuTgNqDMqCqi4MQ5lX54KEcu8hYcBjfC/GVB2WvvwpmzFQCrK4jT+/WsQMGY
	 onUBO1sNmMbGMqpBaLO6ypSOO2MrSeZA7Hu70E5ivFCCm9vDADdkfsQo9UFhvAA/kb
	 NasspqLtT+d80PwXfpGiCz4aUssr2jTigLJuQ8qMrI5Dh1ksryxW5xS7NrpYAz45oR
	 Vt2xl1eEeyKvAf6yPsz2cOinnZ37+V/ker3bWQSaHDRXEGOzQSzW2CSnaUHnI1R3oz
	 /FXHhR6cW0vxw==
Subject: [PATCH 1/3] NFSD: Modernize nfsd4_release_lockowner()
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Thu, 01 Feb 2024 14:06:41 -0500
Message-ID: 
 <170681440143.15250.6029809473642562886.stgit@klimt.1015granger.net>
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

[ Upstream commit bd8fdb6e545f950f4654a9a10d7e819ad48146e5 ]

Refactor: Use existing helpers that other lock operations use. This
change removes several automatic variables, so re-organize the
variable declarations for readability.

Stable-dep-of: edcf9725150e ("nfsd: fix RELEASE_LOCKOWNER")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a0aa7e63739d..9a77a3eac4ac 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6873,16 +6873,13 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 			union nfsd4_op_u *u)
 {
 	struct nfsd4_release_lockowner *rlockowner = &u->release_lockowner;
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	clientid_t *clid = &rlockowner->rl_clientid;
-	struct nfs4_stateowner *sop;
-	struct nfs4_lockowner *lo = NULL;
 	struct nfs4_ol_stateid *stp;
-	struct xdr_netobj *owner = &rlockowner->rl_owner;
-	unsigned int hashval = ownerstr_hashval(owner);
-	__be32 status;
-	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfs4_lockowner *lo;
 	struct nfs4_client *clp;
-	LIST_HEAD (reaplist);
+	LIST_HEAD(reaplist);
+	__be32 status;
 
 	dprintk("nfsd4_release_lockowner clientid: (%08x/%08x):\n",
 		clid->cl_boot, clid->cl_id);
@@ -6890,30 +6887,19 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	status = lookup_clientid(clid, cstate, nn);
 	if (status)
 		return status;
-
 	clp = cstate->clp;
-	/* Find the matching lock stateowner */
-	spin_lock(&clp->cl_lock);
-	list_for_each_entry(sop, &clp->cl_ownerstr_hashtbl[hashval],
-			    so_strhash) {
 
-		if (sop->so_is_open_owner || !same_owner_str(sop, owner))
-			continue;
-
-		if (atomic_read(&sop->so_count) != 1) {
-			spin_unlock(&clp->cl_lock);
-			return nfserr_locks_held;
-		}
-
-		lo = lockowner(sop);
-		nfs4_get_stateowner(sop);
-		break;
-	}
+	spin_lock(&clp->cl_lock);
+	lo = find_lockowner_str_locked(clp, &rlockowner->rl_owner);
 	if (!lo) {
 		spin_unlock(&clp->cl_lock);
 		return status;
 	}
-
+	if (atomic_read(&lo->lo_owner.so_count) != 2) {
+		spin_unlock(&clp->cl_lock);
+		nfs4_put_stateowner(&lo->lo_owner);
+		return nfserr_locks_held;
+	}
 	unhash_lockowner_locked(lo);
 	while (!list_empty(&lo->lo_owner.so_stateids)) {
 		stp = list_first_entry(&lo->lo_owner.so_stateids,



