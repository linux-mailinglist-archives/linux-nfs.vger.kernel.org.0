Return-Path: <linux-nfs+bounces-9958-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD17AA2D020
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 22:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC2516A5EF
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 21:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9D11DED77;
	Fri,  7 Feb 2025 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnR0K361"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9423D1DED6F;
	Fri,  7 Feb 2025 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965258; cv=none; b=sELe3x0HEve1YtDb3s9sauVZUFp8BhnNYfdGjQek0RTUHYdT2fAcLxqVheoVrQWZDoIBi31o1H1Xc7VKaayJWcJ51TgUXKob61kpbWpSKyxBrkuMGB9xbI9Bl3YDgdb08a9I+RYQTJ8sO4JAgITceVD+vs6c8Cr9hQf8wb4GPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965258; c=relaxed/simple;
	bh=sw3t4UEP7cS6Upg9M0jFnw3ef2OfnvBcdxBl8UpLg2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j734m3CWAC6xjVAEKvtyO69G8hc7LWJey1yNBwUzAvepVmZdE3JiB/ba0Yp+18DddfIL4zKKZP1x3grZaCOx9DFuFss+HpuV7GH1lFvW4rKQ6hCnyfVaKKp9kAzJqyzC/NmEhCbK4JHgCUYkWS2gD0dffWzNO4Y2Tdw/KnQ/k4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnR0K361; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7A7C4CEE2;
	Fri,  7 Feb 2025 21:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738965257;
	bh=sw3t4UEP7cS6Upg9M0jFnw3ef2OfnvBcdxBl8UpLg2c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NnR0K361Fpl1TJaDSbJGq4CrwKgS5t5a40pDaGnH+z3gczCjtbmVHcUYDJGH1F7zO
	 A937Cf6YHHj7EJvhbdy+jaTW24Trxdf9CkVFUA8Py0KtwDQ5W3k1d9HyPvy4q8QBK8
	 xqaTT4yQlqcLVwZR7dg4V46IaVGrbv89v6csEewmpoHdAEPIhowjqoDz4ryXTkwzBo
	 ZxUhh09m13RiaBu8rxt7fEpS7JMpSeWkmafoeJpuyFd6EQ+H/JHyMn0dbjId+WfMDB
	 EUqIHXqTz55TA1EWbOtk1Yf7EQLBs5cSxUBStWYObB1tJE4AMq1rYLKLyrrEIx55kp
	 oxNYBMTSFZuvA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 07 Feb 2025 16:53:54 -0500
Subject: [PATCH v5 7/7] nfsd: lift NFSv4.0 handling out of
 nfsd4_cb_sequence_done()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-nfsd-6-14-v5-7-f3b54fb60dc0@kernel.org>
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
In-Reply-To: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3143; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sw3t4UEP7cS6Upg9M0jFnw3ef2OfnvBcdxBl8UpLg2c=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnpoEAjCKIMrbArNfq0hu5S+vxyt8rkgIcUPuaW
 0K+BBXv3zuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6aBAAAKCRAADmhBGVaC
 FR0mD/wOdfIUVs6Eg7jAxtHDAXJAFKS6/DT+Uuz8DcwwE5xLW41YbqUkq29i3ahJufRcV6hI4QV
 LdAyoeVrBJZell/EEYNn26PaLzA0u2Dm6DIPSz5Q4WycxXwCjRRJt3RTThHBmBBdXO++9r7eut/
 UmX8pmjFEmVxmVRjTDre0KacvXaq1VeaeAzvb3P+N3h7+B4hk5pDHOhhgTx1IaK/e0bqb4LIUlr
 4GpPhaBHwVHv+gSd33vZIXPrxDfZtkl9dQ5ylGr4AeFYRq0HRrx8q9/dEcaEG3dTvCYWUUIXqx1
 C32bxJyEpwo/7i8BkFBIponsgP+BF0BSZI4t5nevbfU92fT42EaZjpBTDIgKHaaB3H+KCf/GWqr
 orKcYZglWBZMbyXM9Pc9/x73tut4aI2ADRDBWduK65W2SqvZ89yZevy4eUl1uQe20CauTZwPFXt
 pJwNb17kDoikx6HdCJgzkkdAk+kM4R7m1q2v+Ck0TODvWahjuRdXcmu5PoADO4uTc0sMMSGHUPE
 q1MykCG5Gngc2QJ4ZlNJbG5t0XmMxqsGUwieD16gXPsIbSjZsLcyW1AZrMmAC058bluQClLXZ9g
 A2rF6ZLaH/Fanr5Xs9FhqsC1JKgKuE1DwxCB6u2RYMQGVk3DmmZHZkuifcFQY2hgq1DFZ17R1DD
 bkuOPZan30BA83A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

It's a bit strange to call nfsd4_cb_sequence_done() on a callback with no
CB_SEQUENCE. Lift the handling of restarting a call into a new helper,
and move the handling of NFSv4.0 into nfsd4_cb_done().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 53 ++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index d6e3e8bb2efabadda9f922318880e12e1cb2c23f..a4427e2f6182415755b646dba1a1ef4acddc0709 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1328,28 +1328,23 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 	rpc_call_start(task);
 }
 
-/* Returns true if CB_COMPOUND processing should continue */
-static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
+static void requeue_callback(struct rpc_task *task, struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd4_session *session = clp->cl_cb_session;
-	bool ret = false;
-
-	if (!clp->cl_minorversion) {
-		/*
-		 * If the backchannel connection was shut down while this
-		 * task was queued, we need to resubmit it after setting up
-		 * a new backchannel connection.
-		 *
-		 * Note that if we lost our callback connection permanently
-		 * the submission code will error out, so we don't need to
-		 * handle that case here.
-		 */
-		if (RPC_SIGNALLED(task))
-			goto requeue;
 
-		return true;
+	nfsd41_cb_release_slot(cb);
+	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
+		trace_nfsd_cb_restart(clp, cb);
+		task->tk_status = 0;
+		cb->cb_need_restart = true;
 	}
+}
+
+/* Returns true if CB_COMPOUND processing should continue */
+static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
+{
+	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
+	bool ret = false;
 
 	if (cb->cb_held_slot < 0)
 		goto requeue;
@@ -1429,12 +1424,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 			return false;
 	}
 requeue:
-	nfsd41_cb_release_slot(cb);
-	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
-		trace_nfsd_cb_restart(clp, cb);
-		task->tk_status = 0;
-		cb->cb_need_restart = true;
-	}
+	requeue_callback(task, cb);
 	return false;
 }
 
@@ -1445,8 +1435,21 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 
 	trace_nfsd_cb_rpc_done(clp);
 
-	if (!nfsd4_cb_sequence_done(task, cb))
+	if (!clp->cl_minorversion) {
+		/*
+		 * If the backchannel connection was shut down while this
+		 * task was queued, we need to resubmit it after setting up
+		 * a new backchannel connection.
+		 *
+		 * Note that if we lost our callback connection permanently
+		 * the submission code will error out, so we don't need to
+		 * handle that case here.
+		 */
+		if (RPC_SIGNALLED(task))
+			requeue_callback(task, cb);
+	} else if (!nfsd4_cb_sequence_done(task, cb)) {
 		return;
+	}
 
 	if (cb->cb_status) {
 		WARN_ONCE(task->tk_status,

-- 
2.48.1


