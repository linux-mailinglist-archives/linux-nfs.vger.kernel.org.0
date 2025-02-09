Return-Path: <linux-nfs+bounces-9978-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F24A2DDBB
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 13:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F9D188745B
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 12:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE811DE3A4;
	Sun,  9 Feb 2025 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD+y160q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41261DDC3F;
	Sun,  9 Feb 2025 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104295; cv=none; b=U+I/wEnmcAw/jCuvdVXbsystpWN1Vd4PcPRbCaQGSPCZJE0rdRl7hfH8jy60B6Tf2z3hFcoiXQY35UX6zkq6zEkC98PaDFsNnMuPh2tbNqVsj2qDQQBRR4xiPESvCT0NIREJYmTKQ3WkwCsA4f47UZxb/DB8FCPqJbtJ346P4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104295; c=relaxed/simple;
	bh=ztGrtU9UoYB+Y9k8TfSDh9WfS45ofxCmIJlfkVPZp+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R89UesUhiiRquaOOguAQ7CF+DT5zV/wbBaLB/4+8p15COFtZ74godl8bKTPIr9ONqDvpYyxHoabayqJkA4TYfSv5rOqpHSxp5soKkVbcdp0n9HJK4GGbDHkHMqCYgHP0XQc1n0AihkDe12Oe4C5uQ9wpmZC1PlsXvgiRtO8Dhk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD+y160q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1E7C4CEEB;
	Sun,  9 Feb 2025 12:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739104295;
	bh=ztGrtU9UoYB+Y9k8TfSDh9WfS45ofxCmIJlfkVPZp+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CD+y160qlDtP/YwPyV94G/nWVg+5bzMazqN9Jo3nPv8goRiTZR6cYc9T+MeTiHrdV
	 QmhHdvC3JXbpmjIIswrTsEv5NcuUZU3FlzFCTEz878ARwDSbZ0Wzpmit+IMD0CfEbk
	 fEX42lY6E2n8DBgrx3MmRyZimvWF/KcFqddaeJ37dE1k9ovPwq8+bLs+2XElDuP6AE
	 NtsDEmdXJ9/9vofXIIwHgyOg/QdIPeWXUQjUnrkLgWJqDRmI8Rf+0/K+YdHI86lr11
	 iM8gCSyylzyOqrkKzbw5nBWYQjVf8I9Pt5w20Z5TxoaycjRZuKVH4NS2nGsnnqaqb4
	 J9i6SuzUzczIg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 09 Feb 2025 07:31:23 -0500
Subject: [PATCH v6 2/7] nfsd: lift NFSv4.0 handling out of
 nfsd4_cb_sequence_done()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-nfsd-6-14-v6-2-396dd1bed647@kernel.org>
References: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
In-Reply-To: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3105; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ztGrtU9UoYB+Y9k8TfSDh9WfS45ofxCmIJlfkVPZp+s=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnqKAjhNK/tk8wBKnxbBy5WR6/7g/dfrgecvWmV
 MpKqsbkSweJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6igIwAKCRAADmhBGVaC
 FZLaEACKxyh24VRVvAI0Nx3sH3HY4t4QIjJ+h62XnhG6j0SMm9nwiDNrpVU3JtscJlkeXRs0S2y
 mQCwVuX22z1Ad85ZrK2i1eSQkrBZi6LqWHYBi17oJkArX29G12J9+BLCeilMaAe6mWdnWugVFbs
 oNvNsoGVvjhUKIs6IjQjXRNPuypfSxXYL2uO7DMIv4+1FdpVW2pV/jtz1pfh1zamoqBtmFbgdtI
 96yAmnHlNCrlmZPRqqm4/jHw7357fH8npjT9zVvlpC+jrmV2hFMcR18/+l+txM8f2a6bIBmtIXG
 Do9LQxjEp8/1lkcoz1MIPFJ/6fT/9Kz6FXZ+w1ey3aQ5Ck488mQJf6/d/vp+QH4z1jhPAOVeDGM
 YOGfCMUARrdSMoLsG4t8hzs1LwaIH2RZnRBgejx1orhxkaXDM0rzDdMlpHww7omr3MuINRB5weg
 gt05APpo51ynkqYtACa4d10Apnm6DQH/tcR3comFpCb4lPXO5dgBLxa5eXphGZ509suRFQfJqqA
 ZDMMwRjocxkEmXYA52ZoyiIJG2+RGetk7YVyOXs0Y7H/D/JWfz+JDfEWZp0Blkh4m3Yo95hoZf7
 Re3UN1719t/P1DrdYA7+XSRkaDVkdmHy50JMGPcUbP25bWbk/wmnMPsW1LhWxAjK426xEthyQEY
 cE0A53mwF/5Csbg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

It's a bit strange to call nfsd4_cb_sequence_done() on a callback with no
CB_SEQUENCE. Lift the handling of restarting a call into a new helper,
and move the handling of NFSv4.0 into nfsd4_cb_done().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 51 ++++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 79abc981e6416a88d9a81497e03e12faa3ce6d0e..f983d2879bd3fe4c5aa2b0381f968fac753d79dc 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1328,28 +1328,22 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 	rpc_call_start(task);
 }
 
-/* Returns true if CB_COMPOUND processing should continue */
-static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
+static void nfsd4_requeue_cb(struct rpc_task *task, struct nfsd4_callback *cb)
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
@@ -1411,11 +1405,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	rpc_restart_call_prepare(task);
 	goto out;
 requeue:
-	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
-		trace_nfsd_cb_restart(clp, cb);
-		task->tk_status = 0;
-		cb->cb_need_restart = true;
-	}
+	nfsd4_requeue_cb(task, cb);
 	return false;
 }
 
@@ -1426,8 +1416,21 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 
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
+			nfsd4_requeue_cb(task, cb);
+	} else if (!nfsd4_cb_sequence_done(task, cb)) {
 		return;
+	}
 
 	if (cb->cb_status) {
 		WARN_ONCE(task->tk_status,

-- 
2.48.1


