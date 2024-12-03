Return-Path: <linux-nfs+bounces-8334-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA83C9E276C
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 17:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891A1165139
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACAC1F8ADF;
	Tue,  3 Dec 2024 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdozGFLS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07D1F8AD4
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243361; cv=none; b=JEx8nwrNJoH1839ZNjy+NaXD4tPFjMwR8+5MtS/VAwetEKmKbIK2j8DbLZebiaas0FEj0Toq5JPx5a/ZNSDfI7Mq+pSJct/SPSvI6qisB8c55mD7a2kGcXp2iWkDwSH2dkjwv6hsj5JDTz12+c4BBf5PgVc2RneBNLHwzigWUNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243361; c=relaxed/simple;
	bh=o4OPCvcvzGjpQ2jsC3ajssM6BwUC/ZQrtYpiBuMazYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/l5u0PPwS6d/PIhCh3bAWOpYtAAgvuvSChsRZ56KYTy856cEBOUjvYHMuH0sWdqxAwETgoWqwDwZM/Tl6aZ3sx+TOqvzQ65egoupdjryHA4pwg+GRrR71MhGPKY8TxXDA2A7MOIt51N6TDDOnBfBuCWTkysD4Ec69Pg6YKdymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdozGFLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEF7C4CED6;
	Tue,  3 Dec 2024 16:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733243360;
	bh=o4OPCvcvzGjpQ2jsC3ajssM6BwUC/ZQrtYpiBuMazYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fdozGFLS6VkmHbYVPmwpKOyRzZ060T5mFSuMYf5D5/lVOTlw4ihoXP25g+SfKE4bt
	 oe613Flc0a52d+vodvBt0UvAOYVn1EYU1XODLgfc/uNVKojyajVVLK+U7419L+Ojpd
	 wEHV40Hl5u3A+3r+gAyQcfbeqX/I0AozyQBK4WMkLtDw2v9hwPlQO3kvlsVfVGeWbf
	 2xhuOKonleVnSRVZzixgJwXNRUKb445C6cYxY9cy5Zrlyk5ctPfcPToXu2yJV29e6a
	 KgxnHB+jYpbLZdN9y3+zHXIM23KRWDx6Qe4nnK4udvm1IJaT9BUAfkZq7kI8Hg0Y5n
	 5B+Ntbpwf2TYw==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 3/7] NFS: Rename struct nfs4_offloadcancel_data
Date: Tue,  3 Dec 2024 11:29:12 -0500
Message-ID: <20241203162908.302354-12-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203162908.302354-9-cel@kernel.org>
References: <20241203162908.302354-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2778; i=chuck.lever@oracle.com; h=from:subject; bh=OjH+m397zWOGeAlWbq2+w1ipk8WludUbOjofUQ3hJn0=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnTzHaQUDdD5d36iI9/pYM8QCFMEyhnWZ4TGPJD HbLmfXMYZKJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ08x2gAKCRAzarMzb2Z/ l8hkD/9OEAJlQmawDJg4bhojNEuWEvasXvP9QD7a2RAlYpa4W/lrtyq+WWXMF+PvZ7XucoNDyyW qnmxWbBtToeK75mQHVMhh53ES/9R4SD3Gx/SBrWP1WOxvtpiWWF5mZngJBfNIpNvFwyFUNyigwC BBD6HwDbFiy2YY77f6TFBVIiNm6hbUrjnGnrAz5UAJlLV2QXTmIATcS3ZDUttL/ZDQR6x7aIVWC R1EBEFbLm09s+sHKlM4NwLk4xpnZKCKuOl28ONqeulBGKyKEZ53K2HdbJSznvndHr4IvcrOycmT hPDgf1umoXV16TptRtCtyNvKTxmHEuB3JllCpSb2d81zI9r4RSKV1h0gajoiX/DGg8PQiaf61H+ LeskHBP3aoJs867XsnkLKqJpNFp9tHocBtmv0eKnAjdZWTUDgprraCUrwcvEwLdMvs5PtSHrfrc byc8/9YNMYNi9A0IHOa4O7E6XkkmGevmVHP7fcDJRD1D2q9ST6zKhordu6TfyQIvP9UbzVVGAxn Oc3s0l03Wsz8LDJvYisWektUzPRZmkqrLdUnvfapoKlhsM0S4E08iMmM1MTxCcSLZg1CXhErF4y HBFVoEzEGbP2+0ehTx08aL9hl8M1rdmOhz0CR4e3ULal372yjxw3NJdm1lPmeP+yORcRHEiWoa7 27UIr1pPbcZMWdw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Refactor: This struct can be used unchanged for the new
OFFLOAD_STATUS implementation, so give it a more generic name.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 531c9c20ef1d..9d716907cf30 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -498,15 +498,15 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 	return err;
 }
 
-struct nfs42_offloadcancel_data {
+struct nfs42_offload_data {
 	struct nfs_server *seq_server;
 	struct nfs42_offload_status_args args;
 	struct nfs42_offload_status_res res;
 };
 
-static void nfs42_offload_cancel_prepare(struct rpc_task *task, void *calldata)
+static void nfs42_offload_prepare(struct rpc_task *task, void *calldata)
 {
-	struct nfs42_offloadcancel_data *data = calldata;
+	struct nfs42_offload_data *data = calldata;
 
 	nfs4_setup_sequence(data->seq_server->nfs_client,
 				&data->args.osa_seq_args,
@@ -515,7 +515,7 @@ static void nfs42_offload_cancel_prepare(struct rpc_task *task, void *calldata)
 
 static void nfs42_offload_cancel_done(struct rpc_task *task, void *calldata)
 {
-	struct nfs42_offloadcancel_data *data = calldata;
+	struct nfs42_offload_data *data = calldata;
 
 	trace_nfs4_offload_cancel(&data->args, task->tk_status);
 	nfs41_sequence_done(task, &data->res.osr_seq_res);
@@ -525,22 +525,22 @@ static void nfs42_offload_cancel_done(struct rpc_task *task, void *calldata)
 		rpc_restart_call_prepare(task);
 }
 
-static void nfs42_free_offloadcancel_data(void *data)
+static void nfs42_offload_release(void *data)
 {
 	kfree(data);
 }
 
 static const struct rpc_call_ops nfs42_offload_cancel_ops = {
-	.rpc_call_prepare = nfs42_offload_cancel_prepare,
+	.rpc_call_prepare = nfs42_offload_prepare,
 	.rpc_call_done = nfs42_offload_cancel_done,
-	.rpc_release = nfs42_free_offloadcancel_data,
+	.rpc_release = nfs42_offload_release,
 };
 
 static int nfs42_do_offload_cancel_async(struct file *dst,
 					 nfs4_stateid *stateid)
 {
 	struct nfs_server *dst_server = NFS_SERVER(file_inode(dst));
-	struct nfs42_offloadcancel_data *data = NULL;
+	struct nfs42_offload_data *data = NULL;
 	struct nfs_open_context *ctx = nfs_file_open_context(dst);
 	struct rpc_task *task;
 	struct rpc_message msg = {
@@ -559,7 +559,7 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
 	if (!(dst_server->caps & NFS_CAP_OFFLOAD_CANCEL))
 		return -EOPNOTSUPP;
 
-	data = kzalloc(sizeof(struct nfs42_offloadcancel_data), GFP_KERNEL);
+	data = kzalloc(sizeof(struct nfs42_offload_data), GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
 
-- 
2.47.0


