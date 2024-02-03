Return-Path: <linux-nfs+bounces-1729-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 278BF847FFC
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 04:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4EB1F266AE
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 03:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C33710A1C;
	Sat,  3 Feb 2024 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9bSUWnK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4725C10A1B
	for <linux-nfs@vger.kernel.org>; Sat,  3 Feb 2024 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706932529; cv=none; b=kKT4AEB479QoUvWNIYXPKhij7R/cnVv9lb0tN8KgK70yKXNb9EfldpiQqRQ9gG2ZLs3MxAJccBKTQVP/LyP2O9GNoNhEZO+5Il9cKBXr3+SPsWelIpoSIUDfw118GttPzYxOvodXqJH8kcnzvOqaJl8l361v6rnmfCPrE1nM/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706932529; c=relaxed/simple;
	bh=7IP1wejIpQxoKFELmEm0/EOBLJr7moTVVL6IAXruRI4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQG2tjNhYe3DPDPiOxR6K6Rb51vkA6xsUDa30qVV8yb10/ggy2YkMnXKD+IKsKJfc3iqk4k28QRAJLvNFZhHuV+GLfz3lXkUCCOziCjFAkfHlaR91q6HXHJwulgbon8XqjPFcEBnkfLOIKmXT4meQmv3tmOmgznz8ho2C2iJZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9bSUWnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF94C433C7;
	Sat,  3 Feb 2024 03:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706932528;
	bh=7IP1wejIpQxoKFELmEm0/EOBLJr7moTVVL6IAXruRI4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=i9bSUWnKA54+qrjN2cD21Rai8Dg6EOzXOUWic17VPGWYjMzAu4jbhJaCmaH3W9zRI
	 iS16K/N644fk02zYrX0ywSAkChfYmbA706hpvLkpvjPZ0lBZnscbfTvqLt3ECIfk5u
	 PYBP73JUkY1+5YckW7jLNGObfdoNyzvAB09uPYg060q+moySPTgGEVJi7jjg3eDhfj
	 YS0GwYxaULdG/qRPrvnCCL4J39FIBrCwfxY9Py4Lh+DppGtqJu37aMhxTRrGcYFwCy
	 5a/0d/Tc2juTN0Q5t2xaBy/a1zwzSgPJFQAvwTb7Ajp1dqbyOTh2RnYJB3zhxIqFD+
	 BdprCI6Nd2q+w==
Subject: [PATCH v2 2/4] NFSD: Modernize nfsd4_release_lockowner()
From: Chuck Lever <cel@kernel.org>
To: neilb@suse.de
Cc: linux-nfs@vger.kernel.org
Date: Fri, 02 Feb 2024 22:55:27 -0500
Message-ID: 
 <170693252764.20619.16152698344028608304.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170693220850.20619.2532987152854323295.stgit@klimt.1015granger.net>
References: 
 <170693220850.20619.2532987152854323295.stgit@klimt.1015granger.net>
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
index 74442ed47a66..af8665ad6af3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7309,16 +7309,13 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
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
@@ -7326,30 +7323,19 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
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



