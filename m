Return-Path: <linux-nfs+bounces-10093-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0296A349E2
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 17:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EB93A3188
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7382D2222C1;
	Thu, 13 Feb 2025 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baGePeGg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E2281369
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463359; cv=none; b=SqoTfRpgCDnnaYaqHDXCL/gScR3kN0kxBTCLnfkH90XBsSG7D968aOMFPNyaNrIeSDFFLDyTzwcvU5rfmixkeA+4X76UqXRDE0sZz6wkY98jDkBKCzfHvFGLusaiEsFls2avEIPOjodOlFlty2a+AZmysT17J7Tm4aZXP36A//U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463359; c=relaxed/simple;
	bh=OgnJXRaqvcd3XLEgYPxINRQ4JEw0MzyGJDcaj42Y+E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLKPzOf0sYvJyWEZCLjGz5VMH7BafMfxHe639JYfM/dLZqwPa9LYJLPDb38p4Hj1cdAKZPS5L2v1k4DEd+JY4tm1F25eAkMkZvUDxRFsvQoETy/BlUZ1XNWL22X9hDtiHHmyYNyjHZ0Uxhn/p2EnT3j7Ebog8ORZOb5mss1SAc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baGePeGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF97C4CEE5;
	Thu, 13 Feb 2025 16:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739463358;
	bh=OgnJXRaqvcd3XLEgYPxINRQ4JEw0MzyGJDcaj42Y+E4=;
	h=From:To:Cc:Subject:Date:From;
	b=baGePeGgvO+yaOESU/+/SY8LbV+Q+ZRGsCgqTBksRSk6cf+NRldY11Z9VBPAw5qDH
	 07Appb9dYffu1Fiy4jzbWYkFRIlRstuzkUPd+dEfCQTpD1MFmlnbLsOL7SPSsQqmdA
	 tXfElEpicMHszL8HnGWJKV9zhVfPhqUABUA9CEqAMFQGpauZiE5Zu8liAkpz/bEEqI
	 njIKB9hu0Wnw2p1EDfdih3Z7Qz0cMKB8C8HXQpZAkkU2nhWhMoiKWU40//r922DGw/
	 evJbuEtHsOuBIJP/VGOrpAXh+BVmKQrLxfLI9tk/D8Wo0m9DYOv7r3+5CZX59M4a4q
	 WJOjSR+bzPCWw==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [RFC PATCH] NFS: CB_OFFLOAD should return DELAY when no copy state ID matches
Date: Thu, 13 Feb 2025 11:15:55 -0500
Message-ID: <20250213161555.4914-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The NFSv4.2 protocol requires that a client match a CB_OFFLOAD
callback to a COPY reply containing the same copy state ID. However,
it's possible that the order of the callback and reply processing on
the client can cause the CB_OFFLOAD to be received and processed
/before/ the client has dealt with the COPY reply.

Currently, in this case, the Linux NFS client will queue a fresh
struct nfs4_copy_state in the CB_OFFLOAD handler.
handle_async_copy() then checks for a matching nfs4_copy_state
before settling down to wait for a CB_OFFLOAD reply.

But it would be simpler for the client's callback service to respond
to such a CB_OFFLOAD with "I'm not ready yet" and have the server
send the CB_OFFLOAD again later. This avoids the need for the
client's CB_OFFLOAD processing to allocate an extra struct
nfs4_copy_state -- in most cases that allocation will be tossed
immediately, and it's one less memory allocation that we have to
worry about accidentally leaking or accumulating over time.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback_proc.c | 14 ++------------
 fs/nfs/nfs42proc.c     | 21 +--------------------
 2 files changed, 3 insertions(+), 32 deletions(-)

Compile-tested only and pushed to my "fix-async-copy" branch...
File this in the "crazy ideas" bin, or maybe it makes sense ?


diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 8397c43358bd..cd2c3d196f22 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -712,14 +712,10 @@ __be32 nfs4_callback_offload(void *data, void *dummy,
 			     struct cb_process_state *cps)
 {
 	struct cb_offloadargs *args = data;
+	struct nfs4_copy_state *tmp_copy;
 	struct nfs_server *server;
-	struct nfs4_copy_state *copy, *tmp_copy;
 	bool found = false;
 
-	copy = kzalloc(sizeof(struct nfs4_copy_state), GFP_KERNEL);
-	if (!copy)
-		return cpu_to_be32(NFS4ERR_DELAY);
-
 	spin_lock(&cps->clp->cl_lock);
 	rcu_read_lock();
 	list_for_each_entry_rcu(server, &cps->clp->cl_superblocks,
@@ -737,17 +733,11 @@ __be32 nfs4_callback_offload(void *data, void *dummy,
 	}
 out:
 	rcu_read_unlock();
-	if (!found) {
-		memcpy(&copy->stateid, &args->coa_stateid, NFS4_STATEID_SIZE);
-		nfs4_copy_cb_args(copy, args);
-		list_add_tail(&copy->copies, &cps->clp->pending_cb_stateids);
-	} else
-		kfree(copy);
 	spin_unlock(&cps->clp->cl_lock);
 
 	trace_nfs4_cb_offload(&args->coa_fh, &args->coa_stateid,
 			args->wr_count, args->error,
 			args->wr_writeverf.committed);
-	return 0;
+	return found ? cpu_to_be32(NFS4_OK) : cpu_to_be32(NFS4ERR_DELAY);
 }
 #endif /* CONFIG_NFS_V4_2 */
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 6e00bef97915..b332eafac8a2 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -197,11 +197,11 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 			     nfs4_stateid *src_stateid,
 			     bool *restart)
 {
-	struct nfs4_copy_state *copy, *tmp_copy = NULL, *iter;
 	struct nfs_open_context *dst_ctx = nfs_file_open_context(dst);
 	struct nfs_open_context *src_ctx = nfs_file_open_context(src);
 	struct nfs_client *clp = dst_server->nfs_client;
 	unsigned long timeout = clp->cl_lease_time >> 1;
+	struct nfs4_copy_state *copy;
 	int status = NFS4_OK;
 	bool retry = false;
 	u64 copied;
@@ -211,28 +211,10 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 		return -ENOMEM;
 
 	spin_lock(&dst_server->nfs_client->cl_lock);
-	list_for_each_entry(iter,
-				&dst_server->nfs_client->pending_cb_stateids,
-				copies) {
-		if (memcmp(&res->write_res.stateid, &iter->stateid,
-				NFS4_STATEID_SIZE))
-			continue;
-		tmp_copy = iter;
-		list_del(&iter->copies);
-		break;
-	}
-	if (tmp_copy) {
-		spin_unlock(&dst_server->nfs_client->cl_lock);
-		kfree(copy);
-		copy = tmp_copy;
-		goto out;
-	}
-
 	memcpy(&copy->stateid, &res->write_res.stateid, NFS4_STATEID_SIZE);
 	init_completion(&copy->completion);
 	copy->parent_dst_state = dst_ctx->state;
 	copy->parent_src_state = src_ctx->state;
-
 	list_add_tail(&copy->copies, &dst_server->ss_copies);
 	spin_unlock(&dst_server->nfs_client->cl_lock);
 
@@ -255,7 +237,6 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 		*restart = true;
 		goto out_cancel;
 	}
-out:
 	res->write_res.count = copy->count;
 	/* Copy out the updated write verifier provided by CB_OFFLOAD. */
 	memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy->verf));
-- 
2.47.0


