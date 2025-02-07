Return-Path: <linux-nfs+bounces-9937-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C0FA2C40C
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 14:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A2F167F70
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 13:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF71F8690;
	Fri,  7 Feb 2025 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBnq71BS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8301F7916;
	Fri,  7 Feb 2025 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935918; cv=none; b=kJRFzNEOQ0iw1OQ1Vjmw/uhZfTZBWx6SZKefaIUupF6vTJnlb9dUbKZx83Hyl7Ju5PZUqocSxepl1hS2TlEjiZW3BAcnhnF6pkGgsEW00+6uQg7ehX2yJbP80RdpnK7MJmxEGWd8+FLzuMNrCnbzH0Xc1k7qbk20pxoaKNvCvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935918; c=relaxed/simple;
	bh=DuwKaH3YjKZMxKG65W1fEFU23EHCiVuzIenYqSc8+F8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hqCeGd5pFALJ/R083A9Di5m2D+eZzLHd/PhDgQ7rtv6aAwnaGI+EhryOXIhUtpvRo+9IrEF64LiqDo2mmAHfMlrIIJKWoNsa5g2lRW9vHBwMeEoKg3tnTwLVyeyCyfUEfEJvGSWnaV54xqVc2BwfDhZnzFwuvTlfc0m4EW3UA7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBnq71BS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783DBC4CEE8;
	Fri,  7 Feb 2025 13:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738935918;
	bh=DuwKaH3YjKZMxKG65W1fEFU23EHCiVuzIenYqSc8+F8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oBnq71BSX09apoFsHYSuNjDAuqexoV41HBqR53U9f9Nb1y7iMgFLyr/suJ3kH5vGA
	 VZKD8r33bFX8nSQlSofUvGXesN3arBG4lIVEBb12UwsCpMehLyHuR+UfGwcE6O5kz+
	 aVkPVuT4ZatkZeMzbbssb96K5bz8q1kgnSf/NPdoOk5ay7Jz3GuqQaxxq0kedWFBjv
	 reOUmH7V1V4mC/fEmNhBr1mmu5Y+AL9FZgUixEC6W//OjA17mrDpWBFXz7kYz8Uia2
	 QlRhxS42psKS8VZ0qMnVEcFzctDI7d/5q6Nx96dbJyq25refetJS7kmjqgll4Fzszw
	 koNRJYQngUokg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 07 Feb 2025 08:45:04 -0500
Subject: [PATCH v4 2/2] nfsd: lift NFSv4.0 handling out of
 nfsd4_cb_sequence_done()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-nfsd-6-14-v4-2-1aa42c407265@kernel.org>
References: <20250207-nfsd-6-14-v4-0-1aa42c407265@kernel.org>
In-Reply-To: <20250207-nfsd-6-14-v4-0-1aa42c407265@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3323; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DuwKaH3YjKZMxKG65W1fEFU23EHCiVuzIenYqSc8+F8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnpg5riqjm/sjDV1X7n6mW4LrLroQQy0ZT6kMpG
 lEJRkKG6V6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6YOawAKCRAADmhBGVaC
 FQaaD/40UEXK1+ZdDZW3YjHHysSY4SO3AIBzCchQ1A79c5iY6YDOfHpSzt033c8tumzi6053N5o
 cUlVtL3iY5yVs5lQyhxMQVkXJPzkbNHOUIU/IdyX3wm65veHfSudjx2uvMPApZFfdOWRzd+hxxl
 YojgWUqu7In6+yznjiRQh8yKrIzF7r1xSqlRbBjc/+QfTHeBBPn0vM3rCXnGqEnuuQK2+Yy4Dr2
 RNLvUe4EblAEAP+ep63D3+79VvgT1hmSkGR9SUandQgIzTzARJ+Zb8/gQBPwMH3NRL7fFtGujgJ
 CWsPTB1qvf6Zc4qd5QaX7u/cOzgI7k94QdiPsH18vHBgSe3GsORAeG1QTv/R7cf+vulKAZdRlkP
 5niheqGc8luHH8/ykyLzBF6n5NZ0BxmiszPhwTCt9p4vMw4IcLvChYqCZq1dbrWkHMmCuEK6ceN
 voNyI192lQ64NuujPwFPI3YHa0OQR7robPThnXoQVavhd+h334oJnio7FsxR9HFdUB+AoQACad7
 cQuDtONFpASnpVDRJQXk0BAXTpPtdGkBAeI6ZpoQ0SXC4w3EOa74xwzybIcU+cQG6KAPDkuQhaQ
 pEgvSx7KckgpM+gWCoPLDZo3DB+AnfD7ICDXDsF4ZKmVh4DGGhRzc4r+UTud5DAxYJRwdPjiy0i
 //uCi2EIPuaL8rQ==
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
index a8603c3cdcdafbf9ccc6296425112f1730419b7b..570762d992c553987923669d57b4ab8f529655d3 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1328,27 +1328,22 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 	rpc_call_start(task);
 }
 
-static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
+static void requeue_callback(struct rpc_task *task, struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd4_session *session = clp->cl_cb_session;
-	bool ret = false;
 
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
-
-		return true;
+	nfsd41_cb_release_slot(cb);
+	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
+		trace_nfsd_cb_restart(clp, cb);
+		task->tk_status = 0;
+		cb->cb_need_restart = true;
 	}
+}
+
+static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
+{
+	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
+	bool ret = false;
 
 	if (cb->cb_held_slot < 0)
 		goto requeue;
@@ -1427,19 +1422,14 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 retry_nowait:
 	/*
 	 * RPC_SIGNALLED() means that the rpc_client is being torn down and
-	 * (possibly) recreated. Restart the call completely in that case.
+	 * (possibly) recreated. Restart the whole callback in that case.
 	 */
 	if (!RPC_SIGNALLED(task)) {
 		rpc_restart_call_prepare(task);
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
 
@@ -1450,8 +1440,21 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 
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


