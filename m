Return-Path: <linux-nfs+bounces-1695-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B527845A30
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 15:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284411F29F70
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5106215A;
	Thu,  1 Feb 2024 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0YzZk43"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4840626B0;
	Thu,  1 Feb 2024 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797411; cv=none; b=hO6pMM+uMZnIQPlMaknvklPCSk/6eIHkCiyX2grOG8JjmtglmVf6adbYQwfGgwELdOTplo/9eVCHn4VAZkvTjh73VxRVxuNZlqY8/mtYj1XUSYJhTlYNe/a3PttMCf1WHZOwmv/G5cmr+IJbAvawBom6affVcslqmLq2M2NbuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797411; c=relaxed/simple;
	bh=NigfTYYIglHMMptlAyLmGzbjPM0kpXnaEBHbLajraDI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oV7H9ffkM+eJK11zp57ftiOS5p5pMQBaV+o+/+g7yi+erZjnPkjMK/1EttngQBSMcq9xSlNSRLx1ex1vyGd+Q1XdLcxxY89pLopWS/LGMe+Ze+5GcPqveX4ZTRqrfGp2EHbNYk6hf8E6+DDMhZDqzASkV3LdY66BZw7fqchwsJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0YzZk43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEBFC433C7;
	Thu,  1 Feb 2024 14:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706797410;
	bh=NigfTYYIglHMMptlAyLmGzbjPM0kpXnaEBHbLajraDI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=l0YzZk43THDvBn/r3TF0m4acSKc2c1XGXidIzcKvaHD2DbfjSEo3mzic6OfHz11Ov
	 NzsfMFJaB6LYS9MFXUILX4cF1sxD6gLPBhoasBiLTITVQGHgWRd7tWySjJ95jzUosS
	 U1gFjnh4zwPtb65GRv8sUi72E0mDHZ0wl1IBrg7hxweOtowegjGMeaXUAr+IT3/mVQ
	 p/+pCx37ww/rtV2pvTdFfDiG0XZQ6qdpQDzIJF9VxQM4ox47t/A4dg/gwtQvB+QfZN
	 reNpmbueh0O9hR4crucm+z8W7F2r4BkmaJze3VPt96s4y1/TL5TTbEjP+SJc6+wak5
	 S0Ovl/g7GwBzw==
Subject: [PATCH 1/3] NFSD: Modernize nfsd4_release_lockowner()
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Thu, 01 Feb 2024 09:23:29 -0500
Message-ID: 
 <170679740948.14195.177806651379038037.stgit@klimt.1015granger.net>
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
index d402ca0b535f..1b40b2197ce6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7113,16 +7113,13 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
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
@@ -7130,30 +7127,19 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	status = lookup_clientid(clid, cstate, nn, false);
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



