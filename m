Return-Path: <linux-nfs+bounces-1492-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860D383E0CD
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 18:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257FD1F23A1A
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 17:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEFE208C5;
	Fri, 26 Jan 2024 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdR5bvtt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F29208BC
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291132; cv=none; b=U9FFeP9uAqznH4P9JnpolOxTwSnUF/w+TuBpOy5L4VP1HZYhgQFfGM/QMqVwPjb6aS6Xf8P9esv0bn+TWTi5mG+zkJOt1lErwjMWp507IdCe6ocjOfECHsi1VRMmRLpekMFHBfsDfDG7SktVdB05m33URotOjvQ1jB/gxlFRt+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291132; c=relaxed/simple;
	bh=mF7dux60dMpAU6FPXOAtOEcVq3Hty/2INAqzdyqD1KY=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTC15DEnI+43/hN4oTqr0Qjqejumeo+LSPQ/ZABdqpdS0XzMus+hk0+STI0fJgFKHZNVj/wohUojqsMtQ7Oye0+vWAY/87XtDPzr5ENyL6p4dFt+RYiS6cKnBeoz8dx5PKoe0tf9hopGSMr+BBuwICNpk6Yma2I8r7U344MHsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdR5bvtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD07DC43399
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291130;
	bh=mF7dux60dMpAU6FPXOAtOEcVq3Hty/2INAqzdyqD1KY=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=QdR5bvttXdOSh7PMZPNmjBejDYl1VJBHOTo0ov2M2EC7jt12qBCo9Wp1gRBaoQGKs
	 98kC3O/O/wYDUqGoCb6f8UMZ5rBT4h28V8BtTjQqRUfCjGDrKTP2WDYKnVwsM1KgyY
	 1xqhS18Jugb004qDaNedFYJe6qbzI/9TGuRUFYYZXrvKxl7QI+1imiyP4KoljR5zGl
	 BmSlGPG+6Xp9+KAkHjb0VMOGArkimF6pDQ4GEoSSCf4LWutD6YsNUKlf6IwEUZyz2H
	 b3dtxU4UmUmem2w9OnApGkz936NT9aJ8qoRoeAMQS+TT2iXGFCSvCtV1LOqRQbwjgP
	 ujRhv0dBuREUQ==
Subject: [PATCH 2 03/14] NFSD: Reschedule CB operations when backchannel
 rpc_clnt is shut down
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Fri, 26 Jan 2024 12:45:29 -0500
Message-ID: 
 <170629112969.20612.8526400738389878628.stgit@manet.1015granger.net>
In-Reply-To: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
References: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

As part of managing a client disconnect, NFSD closes down and
replaces the backchannel rpc_clnt.

If a callback operation is pending when the backchannel rpc_clnt is
shut down, currently nfsd4_run_cb_work() just discards that
callback. But there are multiple cases to deal with here:

 o The client's lease is getting destroyed. Throw the CB away.

 o The client disconnected. It might be forcing a retransmit of
   CB operations, or it could have disconnected for other reasons.
   Reschedule the CB so it is retransmitted when the client
   reconnects.

Since callback operations can now be rescheduled, ensure that
cb_ops->prepare can be called only once by moving the
cb_ops->prepare paragraph down to just before the rpc_call_async()
call.

Fixes: 2bbfed98a4d8 ("nfsd: Fix races between nfsd4_cb_release() and nfsd4_shutdown_callback()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |   32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 1ed2512b3648..389d05985c52 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -890,6 +890,13 @@ static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
 	return queue_delayed_work(callback_wq, &cb->cb_work, 0);
 }
 
+static void nfsd4_queue_cb_delayed(struct nfsd4_callback *cb,
+				   unsigned long msecs)
+{
+	queue_delayed_work(callback_wq, &cb->cb_work,
+			   msecs_to_jiffies(msecs));
+}
+
 static void nfsd41_cb_inflight_begin(struct nfs4_client *clp)
 {
 	atomic_inc(&clp->cl_cb_inflight);
@@ -1375,20 +1382,21 @@ nfsd4_run_cb_work(struct work_struct *work)
 	struct rpc_clnt *clnt;
 	int flags;
 
-	if (cb->cb_need_restart) {
-		cb->cb_need_restart = false;
-	} else {
-		if (cb->cb_ops && cb->cb_ops->prepare)
-			cb->cb_ops->prepare(cb);
-	}
-
 	if (clp->cl_flags & NFSD4_CLIENT_CB_FLAG_MASK)
 		nfsd4_process_cb_update(cb);
 
 	clnt = clp->cl_cb_client;
 	if (!clnt) {
-		/* Callback channel broken, or client killed; give up: */
-		nfsd41_destroy_cb(cb);
+		if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
+			nfsd41_destroy_cb(cb);
+		else {
+			/*
+			 * XXX: Ideally, we could wait for the client to
+			 *	reconnect, but I haven't figured out how
+			 *	to do that yet.
+			 */
+			nfsd4_queue_cb_delayed(cb, 25);
+		}
 		return;
 	}
 
@@ -1401,6 +1409,12 @@ nfsd4_run_cb_work(struct work_struct *work)
 		return;
 	}
 
+	if (cb->cb_need_restart) {
+		cb->cb_need_restart = false;
+	} else {
+		if (cb->cb_ops && cb->cb_ops->prepare)
+			cb->cb_ops->prepare(cb);
+	}
 	cb->cb_msg.rpc_cred = clp->cl_cb_cred;
 	flags = clp->cl_minorversion ? RPC_TASK_NOCONNECT : RPC_TASK_SOFTCONN;
 	rpc_call_async(clnt, &cb->cb_msg, RPC_TASK_SOFT | flags,



