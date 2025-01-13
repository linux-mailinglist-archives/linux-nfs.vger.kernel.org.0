Return-Path: <linux-nfs+bounces-9169-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BD1A0BC17
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 16:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710A318849AA
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C0E1FBBD4;
	Mon, 13 Jan 2025 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl3crLT9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A31C5D49
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782372; cv=none; b=RSSZDzzsQqwKSHtubHJhkczFTCwvjBn1XJ2X1o/4bL1iZKGNfkMLdZjYo+W8H/hEoGDKi3ie4Xuj+VKDykV6a18F1lOtiXAlPW42iPiI0BEZTLw4WfuIZW9y3zGxr/iuXxAsUa10AfuJWS3EiZKeTqA2pOZAtpsNaAVIGgGxQgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782372; c=relaxed/simple;
	bh=RsMld3utU85XCus2M6JodmzxzG40AESQ9SK1ML4uiQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDh6GgDOQHuIxBlYNuGAUORxwmepOXB7C31OwiP6FWBK53btxQUbTkdYrmnCmZZSQN6EB6xdDOeqtiFLeol2hcnBdjGDBI6lBpbWcm1XNpHq6RzGpEsj6BJge6KML2SU0EKQAAAc/t4FUNn062xeBU8zwT/U+hMngJMRJoajFkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl3crLT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E94C4CEE3;
	Mon, 13 Jan 2025 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736782371;
	bh=RsMld3utU85XCus2M6JodmzxzG40AESQ9SK1ML4uiQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sl3crLT9VMZU+Ym1YUGTM1PT+jx5AfeOCn9cwNA4jqN8Jdp8g2Ha+hXMazPRxCI+h
	 7XWgtMLKUjz33xKAW/Q/SxSyGdV+BjLtyd+opv/cYb2+I07yHbsXruktjzpV7kcTPF
	 p4gncnase5zapvzWkEGons1nZKb/sDHMtCpzadTGSlfhiBy1UNLsDyrJHz6RC2EjJK
	 qh3up4vD5jIK4BlflVeF+dVooFjaL6R++wP92Ufcmjct5l0/x+P0D7JOMIriMWiZP2
	 sU/IMgBYdeZpOerH8l1a8UZb3B1nQN+2ZHMd0FTZ/oQSpuxfH1Dl9zuEUCCp/gNYRJ
	 dxCTOQ2ebkk+g==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <kolga@netapp.com>
Subject: [PATCH v3 6/7] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
Date: Mon, 13 Jan 2025 10:32:41 -0500
Message-ID: <20250113153235.48706-15-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250113153235.48706-9-cel@kernel.org>
References: <20250113153235.48706-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5461; i=chuck.lever@oracle.com; h=from:subject; bh=i70vHbAFBDUE6UR4bx72VMirKZT3GeRjmXgzWJHNoo4=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnhTIbarAK7NmQPAoTwA0cP8mI4rndot9DkrrCm RL8/JggdQ2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ4UyGwAKCRAzarMzb2Z/ lzrZD/4psYs8qOvz1TTZWVQi1yCEJ6iz/ecyA7O07lyoACQVqvLQP7oll45GGbldZCPYxe2OscP OBTc2l7SGEEMVxq27thnVrykd7je4RPzaOjA5+iPGlIETBqomFkYPZIWI2ygCcPCxZyPbL/pSO5 yyZnHSCbXEvptfYOq6LbqBcHtDUuYwDVdsOvFgtyrwwvZvEU2GEt3eo9YtBQQLNo5JYeELY5XIi YDTPrzQNGq/QO5cKzt3T6SIyWtvzjNqByx5jrV+XQ2QHUqdN8xYuowZHMbdR3RGEfb8KbpG38rQ 8pMzrVlBDwrzEG7zRh+RYWNOIfe1eayS0p8OYDIY0OjDBqCj01ujr+z5gXq2qL/PvirthrIvtOM rzTYoz/5z4BXBStA0XKGfR4UgKlYT5nklJxd7rVuk1xCv325wwXhesZzlsysCydDSK3ct8hzLza AHlinwuWwjjB9PuYZmAztfuVXNXjCDdAOKMYKXiqdXvrMQmnyKTNIUhc/+o00NAlG61BUi9gM84 XPrLcNBg9bZH5NmkuRZ4KnHT8JsJABFASZE25xdJYXtMH1OtJnzxhaLpM2MpIKFnMoXzxVxlkeX sLJW6kAXrN/J8YhtOrKYChBhr9yJ6+bnBp1nCZVWlD28oM+XATTMFtOfkISQofXQFKwtrP+k+zn sIgfW6LFu26SFXg==
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c | 70 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 23508669d051..4baa66cd966a 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -175,6 +175,20 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
 	return err;
 }
 
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
@@ -184,9 +198,12 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 			     bool *restart)
 {
 	struct nfs4_copy_state *copy, *tmp_copy = NULL, *iter;
-	int status = NFS4_OK;
 	struct nfs_open_context *dst_ctx = nfs_file_open_context(dst);
 	struct nfs_open_context *src_ctx = nfs_file_open_context(src);
+	struct nfs_client *clp = dst_server->nfs_client;
+	unsigned long timeout = 3 * HZ;
+	int status = NFS4_OK;
+	u64 copied;
 
 	copy = kzalloc(sizeof(struct nfs4_copy_state), GFP_KERNEL);
 	if (!copy)
@@ -224,15 +241,12 @@ static int handle_async_copy(struct nfs42_copy_res *res,
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
+							   timeout);
+	if (!status)
+		goto timeout;
+	nfs4_copy_dequeue_callback(dst_server, src_server, copy);
 	if (status == -ERESTARTSYS) {
 		goto out_cancel;
 	} else if (copy->flags || copy->error == NFS4ERR_PARTNER_NO_AUTH) {
@@ -242,6 +256,7 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 	}
 out:
 	res->write_res.count = copy->count;
+	/* Copy out the updated write verifier provided by CB_OFFLOAD. */
 	memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy->verf));
 	status = -copy->error;
 
@@ -253,6 +268,39 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 	if (!nfs42_files_from_same_server(src, dst))
 		nfs42_do_offload_cancel_async(src, src_stateid);
 	goto out_free;
+timeout:
+	timeout <<= 1;
+	if (timeout > (clp->cl_lease_time >> 1))
+		timeout = clp->cl_lease_time >> 1;
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


