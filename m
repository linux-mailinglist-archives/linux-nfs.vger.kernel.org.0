Return-Path: <linux-nfs+bounces-9822-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2A7A245F7
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 01:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0EC218891BB
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 00:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEC335953;
	Sat,  1 Feb 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xlgqbn2L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1889335964
	for <linux-nfs@vger.kernel.org>; Sat,  1 Feb 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370096; cv=none; b=L+xZyK1CwsQ+ifCazGkzJGwRSBvtZUWCLj76EgsToMO0H+OLr4SfUmjXKWrRiPTKRQXJCkfglFYLqVaSLXsqUvTAQ4qa3mQNurF0YEMmL74PmXS3Gvvvalbp3zA8IE1XjxS4+ndXKi4V7nbfmUyvHEw+z5Y86uvwcHO8tCw0xQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370096; c=relaxed/simple;
	bh=t5NWF/sD9H5YoFVzqWylKFiG+MF1UKbZq35GsDK/08w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1eeBLbrwLZ3JPIk7P4nez7qMQRZ7WuoWTcQmk+MJwR1yqBG8WGyN0gF2qQp4TUZDWKq1iS/obsqjxruLrFg124jTmyEx1HYqMEiXxa2GWuccu978ouSUgIUEnD/odovpxV97f+UxjxUYktfFLl+RKNUAq2DlOW4d/uaRLVEj6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xlgqbn2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491E2C4CEE1;
	Sat,  1 Feb 2025 00:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738370096;
	bh=t5NWF/sD9H5YoFVzqWylKFiG+MF1UKbZq35GsDK/08w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xlgqbn2L/8CA922DP0MWF/Xzn/cbwRl3njxOCUo6LLTDl5ouxpl1DXl/iHL4azjID
	 6eRqXa9+xRCuGZlSbx4iNHF1D4+H3TRbFWeCsxyODEmC3+ClEmKgT6G1przFhrGkic
	 /YkAD9ls1U8ZIY8eWgRW2Vtb5A4h+5f6MRj3dmrUBrjfitf1z1/zBrInM9GSWTKZZZ
	 laCiVmy0xS9KuGRnf2q54F3wUTubgSsWrpPMWMFqLeKZ3VhvErJuPGBG1Gkbk49p5p
	 XYSWGWKWB2lIAdHKKCUqCsG1yEJcHcCr58rRhQnM/FiNv/Uc7FpnDDnkj1zQMYPMlf
	 yT37R7hsH3nIw==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH v4 6/7] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
Date: Fri, 31 Jan 2025 19:34:46 -0500
Message-ID: <20250201003447.54614-7-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250201003447.54614-1-cel@kernel.org>
References: <20250201003447.54614-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Suggested-by: Olga Kornievskaia <okorniev@redhat.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218735
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Olga Kornievskaia <okorniev@redhat.com>
Tested-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c | 73 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index c560801aae96..f56558c58fe9 100644
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
@@ -184,9 +198,13 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 			     bool *restart)
 {
 	struct nfs4_copy_state *copy, *tmp_copy = NULL, *iter;
-	int status = NFS4_OK;
 	struct nfs_open_context *dst_ctx = nfs_file_open_context(dst);
 	struct nfs_open_context *src_ctx = nfs_file_open_context(src);
+	struct nfs_client *clp = dst_server->nfs_client;
+	unsigned long timeout = clp->cl_lease_time >> 1;
+	int status = NFS4_OK;
+	bool retry = false;
+	u64 copied;
 
 	copy = kzalloc(sizeof(struct nfs4_copy_state), GFP_KERNEL);
 	if (!copy)
@@ -224,15 +242,12 @@ static int handle_async_copy(struct nfs42_copy_res *res,
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
@@ -242,6 +257,7 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 	}
 out:
 	res->write_res.count = copy->count;
+	/* Copy out the updated write verifier provided by CB_OFFLOAD. */
 	memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy->verf));
 	status = -copy->error;
 
@@ -253,6 +269,41 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 	if (!nfs42_files_from_same_server(src, dst))
 		nfs42_do_offload_cancel_async(src, src_stateid);
 	goto out_free;
+timeout:
+	if (retry) {
+		res->write_res.count = 0;
+		status = -EOPNOTSUPP;	/* Fall back to READ/WRITE copy. */
+		goto out_free;
+	}
+	status = nfs42_proc_offload_status(dst, &copy->stateid, &copied);
+	if (status == -EINPROGRESS)
+		goto wait;
+	nfs4_copy_dequeue_callback(dst_server, src_server, copy);
+	switch (status) {
+	case 0:
+		/* The server recognized the copy stateid. Don't overwrite
+		 * the verifier returned in the COPY result. */
+		res->write_res.count = copied;
+		break;
+	case -EREMOTEIO:
+		/* COPY operation failed on the server, though it could
+		 * have made some progress. */
+		res->write_res.count = copied;
+		status = -EOPNOTSUPP;	/* Fall back to READ/WRITE copy. */
+		break;
+	case -EBADF:
+		/* Server did not recognize the copy stateid, but the
+		 * CB_OFFLOAD request could have been received while the
+		 * client waited for OFFLOAD_STATUS reply. */
+		retry = true;
+		goto wait;
+	case -EOPNOTSUPP:
+		/* RFC 7862 REQUIREs server to support OFFLOAD_STATUS when
+		 * it has signed up for an async COPY, so server is not
+		 * spec-compliant. Fall back to READ/WRITE copy. */
+		res->write_res.count = 0;
+	}
+	goto out_free;
 }
 
 static int process_copy_commit(struct file *dst, loff_t pos_dst,
@@ -643,7 +694,7 @@ _nfs42_proc_offload_status(struct nfs_server *server, struct file *file,
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


