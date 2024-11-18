Return-Path: <linux-nfs+bounces-8064-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA169D1A5D
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AE6CB217F7
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AC81E7C0B;
	Mon, 18 Nov 2024 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkvLtHJy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6441E766A;
	Mon, 18 Nov 2024 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964840; cv=none; b=jleq4Szama1Vuq4nmU1eyimaQQe1QU1hapSUfYSMO7OXFsAWFSd45Q0WYx7lGjQ6ZpHv+SP/yhRfjrlW5MtQYuMTHZe64onjMFMhVu0EtM6QZuZ4XdtD2Q4ivEIet13V6qRV/MxGxnz3lqKcXP9nqLIos9V/ph+1J2I8BJ3bZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964840; c=relaxed/simple;
	bh=WlN6EyvwzLWfTLJxsOJCYPugmd+8BLbDPYS8E698i5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHj3xKuWrhuq/nF2gx6yjbHmO4mxyJV3z16r9LDpdbsMuLf8DQsDyJ9UaIbmhbWdPOM7ZIW+Cd8b/qddDjNwGAk/LjgOE9sy5vZoqhlHwf4zOd7XLkLsrl6vJTcWGKWqGli8ONKv2BCH9VmIwCuiFBnEvICcWZ5UI0oSE1mswEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkvLtHJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119EBC4CEDB;
	Mon, 18 Nov 2024 21:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964840;
	bh=WlN6EyvwzLWfTLJxsOJCYPugmd+8BLbDPYS8E698i5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkvLtHJyNpQ2oXPr6YYy60V/HDjX3nLHlUa8t9GAQcz5awzNsEaiepnoqs+qCvBH3
	 KC+1ShV9KI1yQjQa4TT2FQ0jLjnwYOjO1NhnyFWYRZu1OLGWJNDrZKHQxP816sRxa0
	 cA9czV0gtPN28u0sg/AIDf81tKhacgrsHGU7IMVroauznxMXaUkwCCWF+owIVl+YyV
	 KT14XJIcUP4E/USjZeGjrTOxDeMzL4IDo0rzkRNgR7t6TaYvrZklYUEB7noL9Dig3p
	 w3H7pebOF22YEK2E+DcpemkGSPHNDO3dhgQCDseyM9sr8uhwPWVeZ1TY5F9t62rflF
	 PX4ps0KPMKrtg==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 2/5] NFSD: Async COPY result needs to return a write verifier
Date: Mon, 18 Nov 2024 16:20:15 -0500
Message-ID: <20241118212035.3848-4-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212035.3848-1-cel@kernel.org>
References: <20241118212035.3848-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 9ed666eba4e0a2bb8ffaa3739d830b64d4f2aaad ]

Currently, when NFSD handles an asynchronous COPY, it returns a
zero write verifier, relying on the subsequent CB_OFFLOAD callback
to pass the write verifier and a stable_how4 value to the client.

However, if the CB_OFFLOAD never arrives at the client (for example,
if a network partition occurs just as the server sends the
CB_OFFLOAD operation), the client will never receive this verifier.
Thus, if the client sends a follow-up COMMIT, there is no way for
the client to assess the COMMIT result.

The usual recovery for a missing CB_OFFLOAD is for the client to
send an OFFLOAD_STATUS operation, but that operation does not carry
a write verifier in its result. Neither does it carry a stable_how4
value, so the client /must/ send a COMMIT in this case -- which will
always fail because currently there's still no write verifier in the
COPY result.

Thus the server needs to return a normal write verifier in its COPY
result even if the COPY operation is to be performed asynchronously.

If the server recognizes the callback stateid in subsequent
OFFLOAD_STATUS operations, then obviously it has not restarted, and
the write verifier the client received in the COPY result is still
valid and can be used to assess a COMMIT of the copied data, if one
is needed.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
[ cel: adjusted to apply to origin/linux-5.15.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2b1fcf5b6bf8..08d90e0e8fae 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -718,15 +718,6 @@ nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			   &access->ac_supported);
 }
 
-static void gen_boot_verifier(nfs4_verifier *verifier, struct net *net)
-{
-	__be32 *verf = (__be32 *)verifier->data;
-
-	BUILD_BUG_ON(2*sizeof(*verf) != sizeof(verifier->data));
-
-	nfsd_copy_write_verifier(verf, net_generic(net, nfsd_net_id));
-}
-
 static __be32
 nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
@@ -1594,7 +1585,6 @@ static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
 		test_bit(NFSD4_COPY_F_COMMITTED, &copy->cp_flags) ?
 			NFS_FILE_SYNC : NFS_UNSTABLE;
 	nfsd4_copy_set_sync(copy, sync);
-	gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
 }
 
 static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
@@ -1765,9 +1755,14 @@ static __be32
 nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
-	struct nfsd4_copy *copy = &u->copy;
-	__be32 status;
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct nfsd4_copy *async_copy = NULL;
+	struct nfsd4_copy *copy = &u->copy;
+	struct nfsd42_write_res *result;
+	__be32 status;
+
+	result = &copy->cp_res;
+	nfsd_copy_write_verifier((__be32 *)&result->wr_verifier.data, nn);
 
 	copy->cp_clp = cstate->clp;
 	if (nfsd4_ssc_is_inter(copy)) {
@@ -1787,8 +1782,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {
-		struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-
 		status = nfserrno(-ENOMEM);
 		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
 		if (!async_copy)
@@ -1800,8 +1793,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out_err;
 		if (!nfs4_init_copy_state(nn, copy))
 			goto out_err;
-		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.cs_stid,
-			sizeof(copy->cp_res.cb_stateid));
+		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
+			sizeof(result->cb_stateid));
 		dup_copy_fields(copy, async_copy);
 		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
 				async_copy, "%s", "copy thread");
-- 
2.47.0


