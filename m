Return-Path: <linux-nfs+bounces-4533-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D2592423C
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 17:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A5F1F21485
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5DA1B47AC;
	Tue,  2 Jul 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2Dw+ULp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD31AD9E7
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933672; cv=none; b=mtbC207p51SzQdd0QzG+0ahEwMKFxh3pkIbCQz3ViA8i5XJOo7n7cDGuYVbQmyZ3tY2cn3Tmhf3tZpI5jexzoGXioIBctUewZYazWCG4R5vcHM4mvJJDjhJtLv+9bWWqnzMrYxkduLTuTxsWmkWT2JlcnkPhp50MpsfjNzLoPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933672; c=relaxed/simple;
	bh=vfqZ0xv+/IM20oUUxdM4iwZluQr6goFsE6boGZaic7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzdKu+ifSua1LevrWetAcBxvC13wB1WJH1x2YOQsGPWhb17bM1zMZAB6JCqqzDEScQFgJ8+veVG+QU0p0t0rOBm3Q/H5OUWEatTYttZMH4RiyIbtk4DPkbWRWzZbx2h0Kh0VesDhe1sOZ3lCPv3qP98sUcHiOWmZdERFXzQboH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2Dw+ULp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8367C116B1;
	Tue,  2 Jul 2024 15:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719933672;
	bh=vfqZ0xv+/IM20oUUxdM4iwZluQr6goFsE6boGZaic7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2Dw+ULpnsmFECBTn8BFQWcisk3lNUiViTOCjuDalsH8/Z6tsPiqc7NHpIrPb8sRn
	 W5m8LNdLXnwQ7ivQP8i4NchPb00NTXUDs9BvxN2eTRqqAf3YFjlXzJ/vqahppMUXom
	 87/b7/5kDqc/LPUu1CQUltXzPTNJ4P+cTNJlEOR7PhmwymxA0prv1bWy/+LT6rQMTU
	 mak1Eqjo/iTeuYhgmt/JUbq310sT+8BH8T4WLPDhRUPaLirrLOKIuJUsRBx/UEGQKX
	 as0DrawNHYTBpygd70Gz85+aQZeNN1FwQSVxX9hkmc7x6580Z2M1WZINAsAzW4RZMo
	 5YgfszfyrBFnA==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 5/6] NFS: Use  NFSv4.2's OFFLOAD_STATUS operation
Date: Tue,  2 Jul 2024 11:19:53 -0400
Message-ID: <20240702151947.549814-13-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702151947.549814-8-cel@kernel.org>
References: <20240702151947.549814-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3808; i=chuck.lever@oracle.com; h=from:subject; bh=DWbh404bj8qe6AC5OIsvBQmjKXvF2TOOOWVemzfvpZM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmhBqZG5wR6tFYGRTPhNo8K1/HIVc3XQezbLsuB c6Sze+jc/2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZoQamQAKCRAzarMzb2Z/ l0XHD/9Jn8QF7aWpwF9E2EokMuCtfm5iqfhPZkxVqtce59Q7gOyomrjOjzWpCJnQsAnf5IJK1MK ah93CLhr0yCPH/k6k9aU3dGHX9fjtIYtezOinZL0j1sxnAQLtXcO0/iABZ0ZMDxcjNUCdsrApwS eYW1an7Glpz/PxJk74bzwRQW8ziHJ8xL0grDK8UlmeG/z8U0267Qcywj/1ohjL2VXxuJSGskFRv g8y+lJpBA2ly3he3Y4UhUSln42Unsgd89MwLXRPSj3fSpQlQTNu8opco2I4nupbCt4P4bgSIsVs w3Dxj7etHzJ7DeEzmXtVbDKPAwrkj0cHcCUXyAokIAIZr8BsLhMp029x7MByUz1qdt4c/8KV1Jr NzrUkmc1ExNarCqYvEo3DHk4bEGly8SDmnhPNn44aZ+PtudnZOiXkbnNMTXikNhOCBxtdJqL3PX e7ki0TTM7EWuS2aDOdeDQ9JCTepd+p/oXJXlvKw55xRgYnetbznjEvTrotHJw3m7qR6RtyN/1+S Ur5ZSf2ciJ9xaREi6eODS5g1BwMTOhCwzNrMYvlb4huvt0JetsdSarLJ/WUqXB4tYpklkjDYF9w uFL4jMiD49zOaSFAXLaUkfHs7gR0xdCn6M43w3uygavvBXn96YZkVoTm+Vh/BrrW4U40hLZ7VaQ RijEmamDn0Oq06g==
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
 fs/nfs/nfs42proc.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index c55247da8e49..246534bfc946 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -175,6 +175,11 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
 	return err;
 }
 
+/* Wait this long before checking progress on a COPY operation */
+enum {
+	NFS42_COPY_TIMEOUT	= 5 * HZ,
+};
+
 static int handle_async_copy(struct nfs42_copy_res *res,
 			     struct nfs_server *dst_server,
 			     struct nfs_server *src_server,
@@ -184,9 +189,10 @@ static int handle_async_copy(struct nfs42_copy_res *res,
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
@@ -224,7 +230,9 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 		spin_unlock(&src_server->nfs_client->cl_lock);
 	}
 
-	status = wait_for_completion_interruptible(&copy->completion);
+wait:
+	status = wait_for_completion_interruptible_timeout(&copy->completion,
+							   NFS42_COPY_TIMEOUT);
 	spin_lock(&dst_server->nfs_client->cl_lock);
 	list_del_init(&copy->copies);
 	spin_unlock(&dst_server->nfs_client->cl_lock);
@@ -233,12 +241,17 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 		list_del_init(&copy->src_copies);
 		spin_unlock(&src_server->nfs_client->cl_lock);
 	}
-	if (status == -ERESTARTSYS) {
-		goto out_cancel;
-	} else if (copy->flags || copy->error == NFS4ERR_PARTNER_NO_AUTH) {
-		status = -EAGAIN;
-		*restart = true;
+	switch (status) {
+	case 0:
+		goto timeout;
+	case -ERESTARTSYS:
 		goto out_cancel;
+	default:
+		if (copy->flags || copy->error == NFS4ERR_PARTNER_NO_AUTH) {
+			status = -EAGAIN;
+			*restart = true;
+			goto out_cancel;
+		}
 	}
 out:
 	res->write_res.count = copy->count;
@@ -253,6 +266,19 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 	if (!nfs42_files_from_same_server(src, dst))
 		nfs42_do_offload_cancel_async(src, src_stateid);
 	goto out_free;
+timeout:
+	status = nfs42_proc_offload_status(src, src_stateid, &copied);
+	switch (status) {
+	case 0:
+	case -EREMOTEIO:
+		res->write_res.count = copied;
+		memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy->verf));
+		goto out_free;
+	case -EINPROGRESS:
+	case -EOPNOTSUPP:
+		goto wait;
+	}
+	goto out;
 }
 
 static int process_copy_commit(struct file *dst, loff_t pos_dst,
-- 
2.45.2


