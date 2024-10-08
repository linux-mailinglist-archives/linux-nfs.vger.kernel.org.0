Return-Path: <linux-nfs+bounces-6936-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A440995098
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 15:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9671F222E8
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 13:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002621DEFCE;
	Tue,  8 Oct 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czXddXHx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D012713959D
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395264; cv=none; b=d2Pdy+8pk2a4UOHl2e0zBdVQU4AMBXnYz5TXl2z6oIdmGGhlSj/GQ7gG+MIsRyY4dr3vdBZBNWhNsYXk/VSIYTNbZa5gDbZiNv7nGQfkVHKvDF+OunL5uWHmIWHRAB4HnPdC6AEblwKS7QCoFqcBhlxqeUl0vu7RZI/SzRqIYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395264; c=relaxed/simple;
	bh=q0RETyiCP/d0baSmOVxrwtvB8fHv4FHoJ2JK18jFLBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1qrrwzz5eDbVlln90GM69pT8GYUnw5jQYqKNt/HoUFfgi2ZGyItefClzUGr5qZ3xQlYa7lIPz1R7xKDuAsNSPu8cK1pC7xczxhDH2l6afxBa9LtLPSPDP5pkliG7z/KLLKMmIAXLt4am3NawroUtb7nN9/WLgYNVWtAfzy23wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czXddXHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0628C4CECC;
	Tue,  8 Oct 2024 13:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395264;
	bh=q0RETyiCP/d0baSmOVxrwtvB8fHv4FHoJ2JK18jFLBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=czXddXHxlLu461+p+kKRuB41YuFLHF/cLNpmhpTvnQtcKIFfGT4rtZR4uV2u9TQAd
	 n8Fdz+R8rYnVlO8ua0QjA5HWCNQCFpGKVVfyM40+6SrAdr0qhrt8CKHzHd+FRYj8LD
	 n+vDTryV47+RTudxg4i0T91aozxjPwZgO3TxCOcGBDoa34RS3OIT9voGiB60F+dM+r
	 UHuh8Kfy4+f/zetmNiBg8c6PJ66fy923tmqVXROXaCLsKE2WCL8FreazllyPVa/Rxp
	 11RRzaZq7bxL/lrihS8TF20SFbsMzmSjYQP03CdeoFGn+BzNu/ca6TNlIjXIVupB4f
	 khHCJfQpGq57g==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <kolga@netapp.com>
Subject: [RFC PATCH 8/9] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
Date: Tue,  8 Oct 2024 09:47:27 -0400
Message-ID: <20241008134719.116825-19-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008134719.116825-11-cel@kernel.org>
References: <20241008134719.116825-11-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4536; i=chuck.lever@oracle.com; h=from:subject; bh=v+/LHBuN8ciCwAoUTfr98DwrUyGBgKIMqQuGP0oqoMY=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnBTfzaLEw1zH1dt7+vSFzECU/hM8iJjAehRnMH d6V3gntT9iJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwU38wAKCRAzarMzb2Z/ l0IpEACDWBMgDC1zKZemc/F2OJ2typRA5EY0Yo5rgDcvnpDo6Wnuw6izC1TDJFwXV/RMCBBlnnN fYneHpgggchmzdAtkqm7Z78aNUIpqaQlPw8Si6Zv783rh/xMJPsKMtcFi3TeBLhCvtMU7GSjtn8 /kox/IlEcklixTiJCa/pA4U9B++G5eHFHd8Xo4GlCV0J0F3Ial9b9/IgHxWZ3DxaKRK/8cpQhBF yx+Xp97IMND4RSZasUt+b185unA6tZsMzATe3CwX3lZoFnYVUnYznEGLqHv1tq00z929QQPeGh8 DzZWn+t0pTRF6QSX8G0ZVtk4Ze9iF8xe3zL8c2kPz0yAtqBgKGhjciaEVcPRcQx4+kZhSWWlq3f ck8kzVpmxNxVFTpQkt+x2J1isD3CtQrV20QJeK9im4FCIgXPHZ0HkPEbk/5N/9w1XxEjnAHHAYf cew385w8tk2qCbPjT43zfDiCrOXwWbbEFCNuZtQ0Yyq2iw9izrPwvdQWX361mbGe4+8/C3mG7OT ydCBeg/jLL3/fGEh93C5KDj4VO2sxozHvREzVbZu9SdSFEBNb7oq84oDSg2mlEpxpHJyA7DvC4s 3O2R2/bmgRPmB62TvwfnVwAUDSeL14hoGUAB7kM8HcgA4HijJdWm9XnixMq7n5wT/SFCVQrXIPZ 2JEgIdZvSQnX5gg==
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
 fs/nfs/nfs42proc.c | 56 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 175330843558..fc4f64750dc5 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -175,6 +175,11 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
 	return err;
 }
 
+/* Wait this long before checking progress on a COPY operation */
+enum {
+	NFS42_COPY_TIMEOUT	= 3 * HZ,
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
@@ -233,15 +241,21 @@ static int handle_async_copy(struct nfs42_copy_res *res,
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
+	/* Copy out the updated write verifier provided by CB_OFFLOAD. */
 	memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy->verf));
 	status = -copy->error;
 
@@ -253,6 +267,34 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 	if (!nfs42_files_from_same_server(src, dst))
 		nfs42_do_offload_cancel_async(src, src_stateid);
 	goto out_free;
+timeout:
+	status = nfs42_proc_offload_status(src, &copy->stateid, &copied);
+	switch (status) {
+	case 0:
+	case -EREMOTEIO:
+		/* The server recognized the copy stateid, so it hasn't
+		 * rebooted. Don't overwrite the verifier returned in the
+		 * COPY result. */
+		res->write_res.count = copied;
+		goto out_free;
+	case -EINPROGRESS:
+		goto wait;
+	case -EBADF:
+		/* Server did not recognize the copy stateid. It has
+		 * probably restarted and lost the plot. State recovery
+		 * might redrive the COPY from the beginning, in this
+		 * case? */
+		res->write_res.count = 0;
+		status = -EREMOTEIO;
+		break;
+	case -EOPNOTSUPP:
+		/* RFC 7862 REQUIREs server to support OFFLOAD_STATUS when
+		 * it has signed up for an async COPY, so server is not
+		 * spec-compliant. */
+		res->write_res.count = 0;
+		status = -EREMOTEIO;
+	}
+	goto out;
 }
 
 static int process_copy_commit(struct file *dst, loff_t pos_dst,
-- 
2.46.2


