Return-Path: <linux-nfs+bounces-8337-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDDD9E276E
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 17:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2487A287AB1
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8C31F4283;
	Tue,  3 Dec 2024 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQsgNrFo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D691F8AE4
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243362; cv=none; b=SmTUhFw7iBIlnMTlDv9lQmuI4GL1gkTIVNTFIxrcAkD66lr4Di0QvAa6UlbMz95OTcSDQ5IjoQcCwUbaVV5jKotuLXCls2z/G1uDI7XgzRusHwYNKJRMhuIvs4WOHIWO24I6y7jk96iNsCuxPBO3RbY+SnEUxOtZrGIZM85YSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243362; c=relaxed/simple;
	bh=Np5ui7EbiMofzqRS40bS85XPIWkOO9rvA8sE0hFDSlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R48phJeb7iK+F0Xr4KQOidu0SDfJz3f4nXD9YOXQvUcfWvO8YAG4JlvNFH0rzzBYiRPUhcll7JPvG430qcGYI2/F4uPFe+VBP24nyFhy375cz1vrFXUvITiWK3WOc/fBG1WaiuUaTTVLxHUnZKuaWLQZ93LO2Z5DDhhTlYWmGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQsgNrFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A098C4CECF;
	Tue,  3 Dec 2024 16:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733243362;
	bh=Np5ui7EbiMofzqRS40bS85XPIWkOO9rvA8sE0hFDSlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQsgNrFob3/YrsUADiq+ot5J/7v2AxEzKDK+DXInrkg91yuhWOXKo0S6zFmln0vle
	 GjwcqbV+iM+g4Xd9yZWaGpDxvfrwzwBXZmXQk8lQkef8H5dVxYtjJ7u5BbIyt50vrh
	 ejc6bE3VlQvspTipYfkKDD+1YCDuZa05aUDV8Ik5M+HmXmKGl68ub2h3hIP4mg/to3
	 PBselLwMt6Y0EYuUPz1AjTjNYMSTAD+wIaXqbMy0OGRZ0aCW3pRDaW9wZyXVUamFpg
	 o0h1zorQHE/iky8tUo2+8bGiCE/fqLHzCPBC4vF92jb29MhaTspCFwAFJmxozdbXb6
	 ESQ4IKfFrESOw==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <kolga@netapp.com>
Subject: [PATCH v1 6/7] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
Date: Tue,  3 Dec 2024 11:29:15 -0500
Message-ID: <20241203162908.302354-15-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203162908.302354-9-cel@kernel.org>
References: <20241203162908.302354-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5001; i=chuck.lever@oracle.com; h=from:subject; bh=Q6g3DzWWmtlJTqfsXYKzi5mDgrK/81uOb/j2wsItDug=; b=kA0DAAgBM2qzM29mf5cByyZiAGdPMdvIWtQtJyuHX0DbyiE8uUR10Vuq62dvt6pUi5F1UjdrZ 4kCMwQAAQgAHRYhBCiy5bASht8kPPI+/jNqszNvZn+XBQJnTzHbAAoJEDNqszNvZn+XnlsP/je/ BeSmnqw//nBd8QAGhBxMeZijtJqdX0QxFjVBKvwd3SuXr1WZQxlJpBJpy7F8kG19PQOJ8TA2W7O zp0LIj0WkVjXjJoRCvSN08PI7zQa9PmlmK6BeGf66CRkJVp2Wxb75FKSaetxjSGR2r0PzTGyC4E 2UQgp792w1Wb/uhxV7WWW6tBuCrU1SVSOy+Ct4qZDxpQchYtsr5Ss2YEnlW7OueBno77PtMb7O9 jdylbu5UB78RPt6TPNAD+kaW+OE0AHOzwshfKvoWbr43qjfB6mlIqZPzdpkVALQpkT7zCqhI9OC n1O6A7Pj60VM3Ep7MX3sqGN8wDV1EqK7b/eCWr3yeywt90CJHDClh1S+VVNuCUTfY3oTIjH0LZG i4sVFxbdB5OGtU3zhZm+mfjAqZZ883xAEBfWF6zHFXxJmeaoCrnYP/AKeOV3GNWUYIBdahEgdjZ ZXWRvcfWnrXRshX7/NhDZy7VZggiaWn3Pf0ap3TmC4XbQ+rGT+k0mwp6kRlier0nYAJS/KUhCMZ ajeT9sLcusKSOAkyx18kGgUa21igiJdajh9svDzwj9Mnww8HWowrwTUsvsACSDjJso+qoIETT2V gZOKYd+zUOx35VkIAjhEoMdeabO1ZLNw8ou3ebnQjA2MSdAh2xCgVHp7siBerogguKiGyDbpblS DWU+v
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
 fs/nfs/nfs42proc.c | 68 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index fa180ce7c803..5f2bfca00416 100644
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
-- 
2.47.0


