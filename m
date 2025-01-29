Return-Path: <linux-nfs+bounces-9773-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E135EA226DB
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 00:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E7607A29A5
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 23:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9A81E7C25;
	Wed, 29 Jan 2025 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkCZcX80"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF21E7640;
	Wed, 29 Jan 2025 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192858; cv=none; b=C99sWkMDO9AuCjHqzbAdhBg8bxAL9UflygYcMqC5HvTps/j/WRcnfuuAYO4/zei07I6eoPnjON52lv/PnLsbmq9e4G6Oah+USfxlzqlgdfuO/OYi2nrxBcvO5Rg/HEVyNBK9vizkssQB/i4F731c9axFjyg3k+SUpABBTjzIQv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192858; c=relaxed/simple;
	bh=QhwaF3Zpw2Ay8YmeGNGfXktwX3M8UrnOUWFD85Hkp/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BtRjswEWhQw66oQ4p+ot/BC4GAsk+dVrNjbGA59TMxI67O0GYTtUMW/uUqDBr3HPELZrjYHcAxZtDd+q9tiZuOvi75FFKel/hkhThTCPh6LNUCMiTb9uItpo8HU0JORAoQff5j0isJ41fI1XroZFU09w0C9EC9XiQhExi2kwpt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkCZcX80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB96C4CED3;
	Wed, 29 Jan 2025 23:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738192857;
	bh=QhwaF3Zpw2Ay8YmeGNGfXktwX3M8UrnOUWFD85Hkp/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZkCZcX80nuvAsTLretbvNn4+TDFmewSTb38E51fuVVpt0B3q9HGE3SG90RUmDP8jj
	 2RxHNoaDD7Rh86VGwdRv01XcgCOSXuU4G3lcHop/W2EcWvu4QRJ+MOsAu5Emg9LyRV
	 tihxmP50XtpVNM8aYfbmYd/t8ArwK1NaxZNbrDO/07APj9IknNHG3A2ty+6BUv2hfP
	 2pyC1yMzwof2A+yTylA9Y/ISjdOw4cQydLDBYGThKf74FvqDxquysiUgI1gh52+Dq+
	 cRjLELsPeS0i2+KyjNr/b1/PR7oNE4Hx7famQmZdrVjjIiRP8DeR91xhMNfMFLMQGw
	 Oa8RYMMmt4nAw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 29 Jan 2025 18:20:44 -0500
Subject: [PATCH v3 4/6] nfsd: overhaul CB_SEQUENCE error handling
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-nfsd-6-14-v3-4-506e71e39e6b@kernel.org>
References: <20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org>
In-Reply-To: <20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5263; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=QhwaF3Zpw2Ay8YmeGNGfXktwX3M8UrnOUWFD85Hkp/0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnmrfUO58CW3cQ0DoQ5miTyBByZVB35/TTJyuh0
 2Sge0l7Fg6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5q31AAKCRAADmhBGVaC
 FYP0D/9RI8DDcxgXCx8EGXbsAsFoO5pCo0tIDsuWBfbPwGo0gjfUGTSokvOwc+Ls3LHcwcJzsZ2
 alv0NZjQ9dYEZPHyhbb5PwuWSHjNDATGB3XJpvNhflX0aTr69ViPwC6rwlP5pAOrgT5ZCrOGEVv
 Ecbag9YkmWbYsUMBbbAhQEcfjNy91s+BijMwlke8i0LU2FNqjGrTgH1OmEGOFiE0Ft4JL3PSOR2
 SthsI+JIuzdNuWsAf2VrgoTBTFr0YpUqPESFrVHfIJYcluFWM9PeQzAAHcLglGgxpCgGIV8Hsl3
 SJJAu86xLMtG0Trovm03KJ+GdKpeIa2evCgbYOVz2U4Jd13Q2E0yUny/hfWk1Ij4qEjpMDVEXQ8
 IdWHk+37HB+aKAgO7B9kVPAZ1vySNvrDkXXjZMq1+9JvBmgyqjtoiU2iumQQLOIrpNRZDgnjPaj
 ollkoTuZAcfCtTc3x/V/RAWAX00n7KBzdSPib9twSROtn7igEEKQjMBoGOCNdlFpd8xmayIheQI
 FXFo+4S9WbxjuSl1L7Zuwzv39vSbkAWiDl34CfKs7AIiwm0AhcCXoIccWbv9dHKY4KlqeYD0LGu
 TsZiuNNV9oDBRt+vk9fmymVk74WZ10M7hHAEXEQQoYr7vTkdIsLTEU2MrWq/rk3uCzIia9B66b2
 ghwV6O0oBOh6TxQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Some of the existing error handling in nfsd4_cb_sequence_done is
incorrect. This patch first does some general cleanup and then reworks
some of the error handling cases.

There is only one case where we want to proceed with processing the rest
of the CB_COMPOUND, and that's when the cb_seq_status is 0. Make the
default return value be false, and only set it to true in that case.

Now that there is a clear record of the session used to handle the
CB_COMPOUND, we can take changes to the cl_cb_session into account
when reattempting a call.

When restarting the RPC (but not the entire callback), test
RPC_SIGNALLED(). If it has been, then fall through to restart the
callback instead of just restarting the RPC.

Whenever restarting the entire callback, release the slot and session,
in case there have been changes in the interim.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 85 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 9f4838a6d9c668cdf66a77793f63c064586f2b22..109e8f872eaf2227ee30a1df3df86ab1ad88c384 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1381,11 +1381,16 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 	rpc_call_start(task);
 }
 
+static bool nfsd4_cb_session_changed(struct nfsd4_callback *cb)
+{
+	return cb->cb_ses != rcu_access_pointer(cb->cb_clp->cl_cb_session);
+}
+
 static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
 	struct nfsd4_session *session = cb->cb_ses;
-	bool ret = true;
+	bool ret = false;
 
 	if (!clp->cl_minorversion) {
 		/*
@@ -1398,13 +1403,13 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 * handle that case here.
 		 */
 		if (RPC_SIGNALLED(task))
-			goto need_restart;
+			goto requeue;
 
 		return true;
 	}
 
 	if (cb->cb_held_slot < 0)
-		goto need_restart;
+		goto requeue;
 
 	/* This is the operation status code for CB_SEQUENCE */
 	trace_nfsd_cb_seq_status(task, cb);
@@ -1418,11 +1423,15 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 * (sequence ID, cached reply) MUST NOT change.
 		 */
 		++session->se_cb_seq_nr[cb->cb_held_slot];
+		ret = true;
 		break;
 	case -ESERVERFAULT:
-		++session->se_cb_seq_nr[cb->cb_held_slot];
+		/*
+		 * Call succeeded, but CB_SEQUENCE reply failed sanity checks.
+		 * The client has gone insane. Mark the BC faulty, since there
+		 * isn't much else we can do.
+		 */
 		nfsd4_mark_cb_fault(cb->cb_clp);
-		ret = false;
 		break;
 	case 1:
 		/*
@@ -1433,39 +1442,67 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 */
 		fallthrough;
 	case -NFS4ERR_BADSESSION:
-		nfsd4_mark_cb_fault(cb->cb_clp);
-		ret = false;
-		goto need_restart;
+		/*
+		 * If the session hasn't changed, mark it faulty. Restart
+		 * the call.
+		 */
+		if (!nfsd4_cb_session_changed(cb))
+			nfsd4_mark_cb_fault(cb->cb_clp);
+		goto requeue;
 	case -NFS4ERR_DELAY:
+		/*
+		 * If the rpc_clnt is being torn down, then we must restart
+		 * the call from scratch.
+		 */
+		if (RPC_SIGNALLED(task))
+			goto requeue;
 		cb->cb_seq_status = 1;
-		if (!rpc_restart_call(task))
-			goto out;
-
+		rpc_restart_call(task);
 		rpc_delay(task, 2 * HZ);
 		return false;
-	case -NFS4ERR_BADSLOT:
-		goto retry_nowait;
 	case -NFS4ERR_SEQ_MISORDERED:
-		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
-			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
+		/*
+		 * Reattempt once with seq_nr 1. If that fails, treat this
+		 * like BADSLOT.
+		 */
+		if (!nfsd4_cb_session_changed(cb)) {
+			if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
+				session->se_cb_seq_nr[cb->cb_held_slot] = 1;
+				goto retry_nowait;
+			}
+		}
+		fallthrough;
+	case -NFS4ERR_BADSLOT:
+		/*
+		 * BADSLOT means that the client and server are out of sync
+		 * on the BC parameters. In this case, we want to mark the
+		 * backchannel faulty and then try it again, but _leak_ the
+		 * slot so no one uses it. If the callback session has
+		 * changed since then though, don't mark it.
+		 */
+		if (!nfsd4_cb_session_changed(cb)) {
+			nfsd4_mark_cb_fault(cb->cb_clp);
+			cb->cb_held_slot = -1;
 			goto retry_nowait;
 		}
-		break;
+		goto requeue;
 	default:
 		nfsd4_mark_cb_fault(cb->cb_clp);
 	}
 	trace_nfsd_cb_free_slot(task, cb);
 	nfsd41_cb_release_slot(cb);
-
-	if (RPC_SIGNALLED(task))
-		goto need_restart;
-out:
 	return ret;
 retry_nowait:
-	if (rpc_restart_call_prepare(task))
-		ret = false;
-	goto out;
-need_restart:
+	/*
+	 * RPC_SIGNALLED() means that the rpc_client is being torn down and
+	 * (possibly) recreated. Restart the call completely in that case.
+	 */
+	if (!RPC_SIGNALLED(task)) {
+		rpc_restart_call_prepare(task);
+		return false;
+	}
+requeue:
+	nfsd41_cb_release_slot(cb);
 	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
 		trace_nfsd_cb_restart(clp, cb);
 		task->tk_status = 0;

-- 
2.48.1


