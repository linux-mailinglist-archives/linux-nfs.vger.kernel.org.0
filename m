Return-Path: <linux-nfs+bounces-1388-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35283C7F3
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 17:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE59E1C21B4B
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546C57762A;
	Thu, 25 Jan 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAPt+91f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9673177
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200134; cv=none; b=mnO9I7gnL1AYMAYZt4+5yYYbU62cRJureddVefo44CzhXE4bspFAlwSjY5HJRwX4joI38EMqguw7MTPuS83iHAndTEcOZBGC9DKYOCFBbwE0U4g26XcrIwHlH2F5aqI2PrxrFe5csJZ/luay1n/VlRNB3MoxZmZEre8vKmIqqLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200134; c=relaxed/simple;
	bh=ZirEQrrH2B9FdI5tnbQePr1bsGZg3ZHsZpBpGBgGRbA=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XstthNJ89aS6vXfn7pdWMemgtAhznasvVWofSwxJY2R4Uo+7y1pyhYcqpxIATJRS1Y6rEw1tT+88i2EBqIR6sERrgI9Mg5jAOTLINrayJTHGiHLrSDJ3wjQf8Y+EeeW2K20+SDiBPMX9Dv3jCDwShFXu3PUbrvUR318H29hUuDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAPt+91f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86370C433C7
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200133;
	bh=ZirEQrrH2B9FdI5tnbQePr1bsGZg3ZHsZpBpGBgGRbA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=JAPt+91fi4pBOPlg9sM30YIdzdHn1D6m1HuOssoxG6sYFPZyCe7pw8UKq6nUSWj1/
	 mqqyYpky6G2mtDMYnYA5C/qZA/ZXXBaUYS+BbAWNcL66K2DaTI7rrIwZvjX0/584uy
	 eW7DcYGVG34zXLLfAilMGngacNk9dSiEmTXnx7xS8fgOj/HQlFFJw7LEyYujAeApS6
	 JLZWyTENagGW7dw/UhmikKDI+Y3HXFPirxxaI6diZsqVIZblGw8fpz4MZmg+BssaId
	 tBLyl01VK/n5U3BuIeF4VI4Tww7rFve/1z52G9wrT7x6bFq90TUUbBLBUjksZRgr/P
	 Le0qur6WE26dA==
Subject: [PATCH RFC 02/13] NFSD: Reschedule CB operations when backchannel
 rpc_clnt is shut down
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 25 Jan 2024 11:28:52 -0500
Message-ID: 
 <170620013252.2833.10156142379669175540.stgit@manet.1015granger.net>
In-Reply-To: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
References: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
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
 fs/nfsd/nfs4callback.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 43b0a34a5d5b..b2844abcb51f 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1375,20 +1375,22 @@ nfsd4_run_cb_work(struct work_struct *work)
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
+			 * XXX: Ideally, we would wait for the client to
+			 *	reconnect, but I haven't figured out how
+			 *	to do that yet.
+			 */
+			msleep(30);
+			nfsd4_queue_cb(cb);
+		}
 		return;
 	}
 
@@ -1401,6 +1403,12 @@ nfsd4_run_cb_work(struct work_struct *work)
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



