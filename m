Return-Path: <linux-nfs+bounces-1691-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30311845A0B
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 15:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB2128E099
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D3D5D473;
	Thu,  1 Feb 2024 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlLaY/V2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7B5CDF5;
	Thu,  1 Feb 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797309; cv=none; b=jzLHnT3EO3O9D5ubMho61ncc6KrbbkDWwPfeCauXynHfw6RIFbeonXBkz5XGtpz0RjY2CkIiU0UWESKcJ3JodBshaA9d0gozZdwALCptQMreOF2jXmf7c5FPywt4Q91JiY39EXuvQx8DpgEeccjoQlySHJITA7plDM4Vo6ttR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797309; c=relaxed/simple;
	bh=AEyv3M+kfEWiba1eoSuhyqcxF1T4Cjs0XpZLhQXVJ2M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6QvqEFkJggJpPdpBOahzJ5JN10073jdzh3OY4P+I5AhXok1e77BrZ/fG+N/M41r9VSYbnu4mQzAteYOgbhbmTd9PIQTx00Ua2klwYLm2B0rke2YjqZBlxik4bYv3nZOWoIUp6iaOFDeS0eH/AbXFGePtcYwsOSCjAEtWI7qhpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlLaY/V2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73095C433F1;
	Thu,  1 Feb 2024 14:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706797308;
	bh=AEyv3M+kfEWiba1eoSuhyqcxF1T4Cjs0XpZLhQXVJ2M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=DlLaY/V2bPBWFu6L/lyyVQ6BA/B+Up6lQW0TyiPn3NmqNIF644hdgXPwn5fQKu60b
	 ipoWq0NcaoKF/BXPmNFqLu89rEpqs7mXT5OqIvAOu7+6+Oac62fj1fvvxxQ2rJNfVa
	 aNQkGjnUFqE9jgL0pz5nfZnrrEB825rVmmdVoKW3RLopaKE/9RxAUvTfQzHvXVIiIF
	 lp7a09gfsDCRqOH4SA0mie97ce3o1U7MCpNSrNOASuYKknWYs0mAEX7CmPgEqPO+v0
	 ybJJcoLt+m9KiIsan1KvoOK20SDhGW9xOz6TEdNfXIV3C/rlYDmH04icWQFXSogo/C
	 xh+vUywXnUAvw==
Subject: [PATCH 1/3] NFSD: Modernize nfsd4_release_lockowner()
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Thu, 01 Feb 2024 09:21:47 -0500
Message-ID: 
 <170679730745.13994.4441368316879617198.stgit@klimt.1015granger.net>
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
index 9b660491f393..798063b9b96f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7290,16 +7290,13 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
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
@@ -7307,30 +7304,19 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	status = set_client(clid, cstate, nn);
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



