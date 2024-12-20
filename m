Return-Path: <linux-nfs+bounces-8692-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B38909F95B5
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 16:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C1616F6B3
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 15:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C99A21A42A;
	Fri, 20 Dec 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS+coAaG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1850021A428
	for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709364; cv=none; b=ScwVvG2a97vmc55sguCBcgo84tVkiKBV+F6buSfNEnTtidtnFM8FRMRHNmdKwyrqMDg0a4rWSDrGOLAFZSVf3rYjKLwSt5HVYFn9GMU6ecevzIDhG9Kuo8fVeicWidPbXtBK+RjI1uyuAONr9YBAjjWLN2n4AaH57W3Ls5weZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709364; c=relaxed/simple;
	bh=8a1Q+maZqFABNeSYL6UF65bkgRC63Q2S7h6CP2XI2zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=je8RwFY5mqZMiv9ObjLgzpYsLfF0DbFtEldyNjxPsO0iA4nlD8EEZYjG51o8zT9nNMUynqsQcbGXQhjR8HYCKUOXDMNBKp8t7TIlfK7etZP9tmJpoAURXTspOPFa2L1g41NGwGAqCPaHPLOV1rMLUZrACB6a0cCNQ8xMyBpwy6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS+coAaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDDAC4AF09;
	Fri, 20 Dec 2024 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734709364;
	bh=8a1Q+maZqFABNeSYL6UF65bkgRC63Q2S7h6CP2XI2zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MS+coAaGaz+3+Q7LDQrxjOnGnYJ+Qeps0FK45PRN0vl6kCezUA2EF8XAnjuZgoHCS
	 s3e9cPG+ENGIUwHbLV827Ib2swhi8kC6TDp/RDaJIzdIg9fO7ucbcwRHduYQUOY+Jq
	 E9KJjcnaVgVR2SJXSDjqqYzOQkDUw9rM9uqMUXSU/SrAXfdncZMDU5BlY7G3LEyImg
	 OhfYaS8eUU3sjc28r/QyCH8W3KxTA2lmwdgvEZ0SVNyY5kznNgobqbE5dbqv6b8+uv
	 PC7mNkrGZNybXjwXk++zc5nqdx6ohsF8KIxBaZ3BIr5na0rkTxjxOgnKiZftlK173A
	 koUV0D8X5gXfg==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <kolga@netapp.com>
Subject: [PATCH v2 6/7] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
Date: Fri, 20 Dec 2024 10:42:34 -0500
Message-ID: <20241220154227.16873-15-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220154227.16873-9-cel@kernel.org>
References: <20241220154227.16873-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5354; i=chuck.lever@oracle.com; h=from:subject; bh=e9sVK4hJFGQ+MgxLCyDcaat5hynBtznykV0ciFcJ+jc=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnZZBqx5s9J0Nh0OHc2I8joqeFFu7EPhWQ1//Os DqR0iGU/ymJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2WQagAKCRAzarMzb2Z/ lwI8D/0c5od6E3TxWUEJJTCJanIBELluHtwnQwjSNY4PzfXSxLlmxeK8VplbBP9ZD3CTqYxBQVq bFLR0Gx4T88bnCNZaaD1yY6Sh6xRxc7AfKjDR9S95gskyBfCuKg2/q0dDsPAjNcQhwtJheysciL qZFqZavQw33HGXtlsjMTKo4hVpChtcFaF3UrpZspUa5FMvTsnf6LOPOHU05Rf4Wut8wi5A2OLBO 7ASeso0CP+e9HKRPkLJYXRxRpCUpPsjMtEr5U7wAe+iHN786uC42DrEJXqlwLaRcit/RkZ3JIQl hsAEw7uS7CrFeuxlh+56c92bH5F6p5+t2MrpYc9P6S4qFZ2qsaLo76LO0pv7VfjuGjiHXKCOqfJ NbbjaGVvF9grUXhIAQbUVk6n0uTVUEN9EjHBrObnksaBLPxnPo/UEbaiM5wmivk63zAcc4I3TqW w2NLIBrX4L0ZGNuXqY8/IoAJmYaQO5KvuXReuOCZkRoFP588RwiuOWIFX12yHyauEDChw3sZ9P1 kFtHiwMF3akWXgS0/67c/PedPTjinIsBmDhRWNte8WcGlEFXBdMBM4VMX6edfWvOr6DZioTdahJ OIpt60njx5ZUkV+QW5vnpc5iGaKnwClnArwl55LWuwQ81KPdfqvjjwtqecl5j/5H1xbTBC2gIQh lKLLkRfGB9gFo8Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

We've found that there are cases where a transport disconnection
results in the loss of callback RPCs. NFS servers typically do not
retransmit callback operations after a disconnect.

This can be a problem for the Linux NFS client's current
implementation of asynchronous COPY, which waits indefinitely for a
CB_OFFLOAD callback. If a transport disconnect occurs while an async
COPY is running, there's a good chance the client will never get the
completing CB_OFFLOAD.

Fix this by implementing the OFFLOAD_STATUS operation so that the
Linux NFS client can probe the NFS server if it doesn't see a
CB_OFFLOAD in a reasonable amount of time.

This patch implements a simplistic check. As future work, the client
might also be able to detect whether there is no forward progress on
the request asynchronous COPY operation, and CANCEL it.

Suggested-by: Olga Kornievskaia <kolga@netapp.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218735
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c | 70 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 7fd0f2aa42d4..65cfdb5c7b02 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -175,6 +175,25 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
 	return err;
 }
 
+/* Wait this long before checking progress on a COPY operation */
+enum {
+	NFS42_COPY_TIMEOUT	= 3 * HZ,
+};
+
+static void nfs4_copy_dequeue_callback(struct nfs_server *dst_server,
+				       struct nfs_server *src_server,
+				       struct nfs4_copy_state *copy)
+{
+	spin_lock(&dst_server->nfs_client->cl_lock);
+	list_del_init(&copy->copies);
+	spin_unlock(&dst_server->nfs_client->cl_lock);
+	if (dst_server != src_server) {
+		spin_lock(&src_server->nfs_client->cl_lock);
+		list_del_init(&copy->src_copies);
+		spin_unlock(&src_server->nfs_client->cl_lock);
+	}
+}
+
 static int handle_async_copy(struct nfs42_copy_res *res,
 			     struct nfs_server *dst_server,
 			     struct nfs_server *src_server,
@@ -184,9 +203,10 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 			     bool *restart)
 {
 	struct nfs4_copy_state *copy, *tmp_copy = NULL, *iter;
-	int status = NFS4_OK;
 	struct nfs_open_context *dst_ctx = nfs_file_open_context(dst);
 	struct nfs_open_context *src_ctx = nfs_file_open_context(src);
+	int status = NFS4_OK;
+	u64 copied;
 
 	copy = kzalloc(sizeof(struct nfs4_copy_state), GFP_KERNEL);
 	if (!copy)
@@ -224,15 +244,12 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 		spin_unlock(&src_server->nfs_client->cl_lock);
 	}
 
-	status = wait_for_completion_interruptible(&copy->completion);
-	spin_lock(&dst_server->nfs_client->cl_lock);
-	list_del_init(&copy->copies);
-	spin_unlock(&dst_server->nfs_client->cl_lock);
-	if (dst_server != src_server) {
-		spin_lock(&src_server->nfs_client->cl_lock);
-		list_del_init(&copy->src_copies);
-		spin_unlock(&src_server->nfs_client->cl_lock);
-	}
+wait:
+	status = wait_for_completion_interruptible_timeout(&copy->completion,
+							   NFS42_COPY_TIMEOUT);
+	if (!status)
+		goto timeout;
+	nfs4_copy_dequeue_callback(dst_server, src_server, copy);
 	if (status == -ERESTARTSYS) {
 		goto out_cancel;
 	} else if (copy->flags || copy->error == NFS4ERR_PARTNER_NO_AUTH) {
@@ -242,6 +259,7 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 	}
 out:
 	res->write_res.count = copy->count;
+	/* Copy out the updated write verifier provided by CB_OFFLOAD. */
 	memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy->verf));
 	status = -copy->error;
 
@@ -253,6 +271,36 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 	if (!nfs42_files_from_same_server(src, dst))
 		nfs42_do_offload_cancel_async(src, src_stateid);
 	goto out_free;
+timeout:
+	status = nfs42_proc_offload_status(dst, &copy->stateid, &copied);
+	if (status == -EINPROGRESS)
+		goto wait;
+	nfs4_copy_dequeue_callback(dst_server, src_server, copy);
+	switch (status) {
+	case 0:
+		/* The server recognized the copy stateid, so it hasn't
+		 * rebooted. Don't overwrite the verifier returned in the
+		 * COPY result. */
+		res->write_res.count = copied;
+		goto out_free;
+	case -EREMOTEIO:
+		/* COPY operation failed on the server. */
+		status = -EOPNOTSUPP;
+		res->write_res.count = copied;
+		goto out_free;
+	case -EBADF:
+		/* Server did not recognize the copy stateid. It has
+		 * probably restarted and lost the plot. */
+		res->write_res.count = 0;
+		status = -EOPNOTSUPP;
+		break;
+	case -EOPNOTSUPP:
+		/* RFC 7862 REQUIREs server to support OFFLOAD_STATUS when
+		 * it has signed up for an async COPY, so server is not
+		 * spec-compliant. */
+		res->write_res.count = 0;
+	}
+	goto out_free;
 }
 
 static int process_copy_commit(struct file *dst, loff_t pos_dst,
@@ -643,7 +691,7 @@ _nfs42_proc_offload_status(struct nfs_server *server, struct file *file,
  * Other negative errnos indicate the client could not complete the
  * request.
  */
-static int __maybe_unused
+static int
 nfs42_proc_offload_status(struct file *dst, nfs4_stateid *stateid, u64 *copied)
 {
 	struct inode *inode = file_inode(dst);
-- 
2.47.0


