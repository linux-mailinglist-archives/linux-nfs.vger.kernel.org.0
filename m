Return-Path: <linux-nfs+bounces-7600-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E099B7BDF
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 14:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8D8B2112E
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 13:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4094319D091;
	Thu, 31 Oct 2024 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzazMqlw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5C113D886
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382016; cv=none; b=CDTb1KtaVw7zWK6ER1v6DSLedVLi+3EX6Uo7qNys+oRkySTD4Ki5W1zHsgNd3Km4et6e7CarsDZ6JwcxiYa0p7fzFhY9C+eZfhnWX0liXjQq9h/AFpp6WtXsRNC1LNLng9NYUfpak9kKaNStqhjDanXWTvUFBfUzPPt+JkrYR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382016; c=relaxed/simple;
	bh=Rw6lt8gVnbtsze7NI6sN17Je7YcVfKpkJqOxuQIDkZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oE0R5bk8QQ3lFeiUucL5rPzbq75wVMLY85yoXoMuVXQxdTXP7FmdJ24k9qN0BVQeqTipeefYQhCUmIoth+XwpGASjr+mp92q+xrE09LpUzz4Y73zNVlm4GIuj6vDhJvtoG1gF6VJYJUhxu+NbxDH3guwy0OJmj3yS4Lgo1yVfyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzazMqlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADABC4DDED;
	Thu, 31 Oct 2024 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730382015;
	bh=Rw6lt8gVnbtsze7NI6sN17Je7YcVfKpkJqOxuQIDkZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzazMqlwv11ldGyI2qD8htwEZs0CEdQPK8pzW5ZBhKmXnlADfdue7Y2S/kOXKOBLk
	 1Gbbv1oLsznpyFw5gItPfCvECLkfO3CTHQXIdrz0qIQ/GdmpiqYqkRQctkHCx4s1/l
	 KmXLkzolRks3/I4llgIDpFtTcHe1Fdk48gIZ1tG/P63ZYzPdyYRwdMzuLBfzZayBbD
	 q+XxzCdFIGX4ODqhVluK01xFF0a98wVf8gev9yMHjXv3CD9FOJihvnGzb0WXlSGhbf
	 SQiC4YgfnkA9IZvibtQUatwVV0J1TR1YTSeytOtsrChmrxmknxFQJfDIv/WA6S9f0I
	 y0xttB8X/OxGw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 5/8] NFSD: Block DESTROY_CLIENTID only when there are ongoing async COPY operations
Date: Thu, 31 Oct 2024 09:40:06 -0400
Message-ID: <20241031134000.53396-15-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031134000.53396-10-cel@kernel.org>
References: <20241031134000.53396-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3168; i=chuck.lever@oracle.com; h=from:subject; bh=YOTZEvbpL09QAoMAsaifVC3ocwxxfIpaEoV+F8nsVGQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnI4i3QOa0vQAa0FwHWnKbhBK5GHaYkTDhtl9hO QJAN9GHRy2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZyOItwAKCRAzarMzb2Z/ l2ppEADBHv6ibGdW3RdNyY8dPt/3NNwQ+R2txnZrjbX4agKi/1i0rBfxtkGz6aZcvt50MsrZ2qd EEQTGiSqSO4cvelA+ml4uHUlx2TPYQ1qAWK75A8+L0R3EcSvNafa/YbZekySkwjP2Psw+5EAGcE Uv6Ez+ETCW2qkNqLDL1mdXqR3VXCwUqcAwt8J6cGm2lNeDtDuuA4EdOfZZLIBh7KkclVaZr18a1 VtBBXr9dUnFjirMaDMGpLGt60K+kCFEf8yOt469q8vf02xRefM4E6ZcyDAwHhlEd9iLssBxebAx DT2zwpMQ61uT+ywWGe/jGYXSkm/fD92Qv8yKtTLmMxu9uVMePdgSe13G522XqmAXjK+cYimoLC4 dmKfklySIFJ/ucHUbG91HXWQlHd605U7LZOJzM6FNiAmpyE1IzAD+/p2Ci/J5JUpbCDAgJGQdYo fdjwnp23b7VgwwoJd/nJehggieXp/7YTR97tPrur/idvcZq+YzWDwGtJORLYve3ExLy+n7garYY NW5QRDZsiC/o60XStHeOkb7/pRYp+VxwOuUknQ+r9RJdMieK64P255Wp1PpFXz2Ny1TZhk5770t LFkCv7sf5yXhP6nYey7ZkzR7KkbG1ChbBLep1MRI1xhvHnfqM9ha+6aj4bl2C3I9+HJ3o5ac0dT rVTOKKZPyjcvnlw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Currently __destroy_client() consults the nfs4_client's async_copies
list to determine whether there are ongoing async COPY operations.
However, NFSD now keeps copy state in that list even when the
async copy has completed, to enable OFFLOAD_STATUS to find the
COPY results for a while after the COPY has completed.

DESTROY_CLIENTID should not be blocked if the client's async_copies
list contains state for only completed copy operations.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c  | 30 ++++++++++++++++++++++++++++++
 fs/nfsd/nfs4state.c |  2 +-
 fs/nfsd/state.h     |  1 +
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0918d05c54a1..4d44b785a580 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1278,6 +1278,36 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status;
 }
 
+/**
+ * nfsd4_has_active_async_copies - Check for ongoing copy operations
+ * @clp: Client to be checked
+ *
+ * NFSD maintains state for async COPY operations after they complete,
+ * and this state remains in the nfs4_client's async_copies list.
+ * Ongoing copies should block the destruction of the nfs4_client, but
+ * completed copies should not.
+ *
+ * Return values:
+ *   %true: At least one active async COPY is ongoing
+ *   %false: No active async COPY operations were found
+ */
+bool nfsd4_has_active_async_copies(struct nfs4_client *clp)
+{
+	struct nfsd4_copy *copy;
+	bool result = false;
+
+	spin_lock(&clp->async_lock);
+	list_for_each_entry(copy, &clp->async_copies, copies) {
+		if (!test_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags) &&
+		    !test_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags)) {
+			result = true;
+			break;
+		}
+	}
+	spin_unlock(&clp->async_lock);
+	return result;
+}
+
 static void nfs4_put_copy(struct nfsd4_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 551d2958ec29..cde5ba69d7a5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3487,7 +3487,7 @@ static bool client_has_state(struct nfs4_client *clp)
 #endif
 		|| !list_empty(&clp->cl_delegations)
 		|| !list_empty(&clp->cl_sessions)
-		|| !list_empty(&clp->async_copies);
+		|| nfsd4_has_active_async_copies(clp);
 }
 
 static __be32 copy_impl_id(struct nfs4_client *clp,
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 35b3564c065f..6c84c0900ec4 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -742,6 +742,7 @@ extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
 extern void nfsd4_shutdown_callback(struct nfs4_client *);
 extern void nfsd4_shutdown_copy(struct nfs4_client *clp);
+bool nfsd4_has_active_async_copies(struct nfs4_client *clp);
 extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name,
 				struct xdr_netobj princhash, struct nfsd_net *nn);
 extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn);
-- 
2.47.0


