Return-Path: <linux-nfs+bounces-9742-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A663A21E01
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BACDF7A33E9
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9929F1BEF74;
	Wed, 29 Jan 2025 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXKR+3DT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721BA1B87EE;
	Wed, 29 Jan 2025 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158017; cv=none; b=PcfldRMyc/gED03VC9fF4fBHLAicO/Zsx/8FD4SAaK/93O/IebW9mTOdvkpKIdcxqhgHvJgjlWviBtZppkv0ulr7Yh/EEZ6toFPkJ0yGmW7XvSo3qpKCXKew0ZpkxUa7grFL9BjbawCh6hhTb0laVnNNqzpQFdunt8xb/6l3WoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158017; c=relaxed/simple;
	bh=NbJxpKAEYs/HAN2fTpo7awYOhoPSyHXKWtM0VOeNu7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f7feIDFs3fh7gFXWJdpASniS58LKOoSugzHSo6fqWoF2bFsumk2Wgc1XezgSvrWSJ1vTeV4ocBFCoxnoToTl06V9E+UGxwSMbQ+C5VC9Tsnvtp12ZJ5U5SBaWwwo7c9NPuHiihBOGV7e+nAQUcMnLL+bMVdDoHesyTYL7C7rr2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXKR+3DT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E353CC4CEE6;
	Wed, 29 Jan 2025 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738158016;
	bh=NbJxpKAEYs/HAN2fTpo7awYOhoPSyHXKWtM0VOeNu7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fXKR+3DTmOg8nuPtE3hhUAvf5c07NkL9NnmfT4RoWl6dEYNuZkYhpKJve+PDAnVJq
	 Iq18AVU+8gbo0hnMIHcph7BHqwucHWEsfVuVgfI5o2m+FPrsiCnJzZHqJg0JuHwtzs
	 y/9tNyKRI0X0Dll9rjfrqibpIpxr5jHAlG6OoWLqjj1MoAjoFteWmRx4DDQpZvIXoL
	 aX2AJeyvg+rL6SF/V/IDoibvLBZcTgTgItBYglYklo/5RZriCZBRk92Ip6ISIEZwxU
	 /zSi9D47tP6IPhOzj1ABsZiWs4sp4KiFn28rLt0rfqOM9T3fB6WL8IiWT1dRf+zxJO
	 Ce8j2ROIgVtDw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 29 Jan 2025 08:39:57 -0500
Subject: [PATCH v2 4/7] nfsd: overhaul CB_SEQUENCE error handling
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-nfsd-6-14-v2-4-2700c92f3e44@kernel.org>
References: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
In-Reply-To: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4840; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NbJxpKAEYs/HAN2fTpo7awYOhoPSyHXKWtM0VOeNu7s=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnmi+65z4cMIUssnxsrHOSeprTUHhdasqrzUY+n
 Ad4S0Go8OGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5ovugAKCRAADmhBGVaC
 FQh7EACXW0Lwz4npWxwgr/66sDBkBQ+zaYBh9tLi1aLJG4MSzpIwX/pI41mcMWqLyhnDVZrDlKh
 Y40akHp0xL5AwTHtD4kN/pgWwPVB3/bxJaYEdOc5yqnxcukXY+blyQtXqlSSnRx5tVucq25N2jJ
 dKyFarP1jQKBgWocViqPQ5TlaBnUdr7pZHsfuNB/UKzEdL5MuDAHDjdOirV4UPbixZTLvKA/YNG
 zECz0Qvv+6Leg/EdSZciqlAEsgAuZCukLY1i8lIij+REPC2t+Dv/J7BcbS6eFa0+3lcMn4xnMIE
 lFCbbIXcw8lPBVk0881EVL8nTILixpnpo5WKKW6XIfQNF7+5s58TZ0S2Hhq96Ybtd8oJ+GVDgbE
 J9oxmSBQr1v8LCNRuV8vntzLWrOnA1K5wcNRebIpOi1+bAwdeqzfzn4P1TfMLaE+WVjs24F8dh5
 7w0NP4Btc1BdzrrQwTfKInF38MFCuuShDdPBp25tC7kbpK3Xi+OUhuf8cn786PQW+2nqZJtGzZ1
 gJYdEcawliJSccJAlU+H+bFLsDJyhl2eP/lf0yhE1iXShvNISjGKjBY7LLiFDKjZceO52HdbfPQ
 xgfqVWLXNJvRMMt8T56jp/8cNyIMUo1vXXt3MwUWUiYMHvb5B94BnlFnYapnGwTmX4b1D+B2wpC
 KrMdwhJexQO+uzw==
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
 fs/nfsd/nfs4callback.c | 78 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 9f4838a6d9c668cdf66a77793f63c064586f2b22..e70a7a03933b1f8a48d31b0ef226c3f157d14ed1 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1381,11 +1381,16 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 	rpc_call_start(task);
 }
 
+static bool cb_session_changed(struct nfsd4_callback *cb)
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
@@ -1418,11 +1423,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 * (sequence ID, cached reply) MUST NOT change.
 		 */
 		++session->se_cb_seq_nr[cb->cb_held_slot];
+		ret = true;
 		break;
 	case -ESERVERFAULT:
+		/*
+		 * Call succeeded, but CB_SEQUENCE reply failed sanity checks.
+		 * The client has gone insane. Mark the BC faulty, since there
+		 * isn't much else we can do.
+		 */
 		++session->se_cb_seq_nr[cb->cb_held_slot];
 		nfsd4_mark_cb_fault(cb->cb_clp);
-		ret = false;
 		break;
 	case 1:
 		/*
@@ -1433,39 +1443,67 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 */
 		fallthrough;
 	case -NFS4ERR_BADSESSION:
-		nfsd4_mark_cb_fault(cb->cb_clp);
-		ret = false;
+		/*
+		 * If the session hasn't changed, mark it faulty. Restart
+		 * the call.
+		 */
+		if (!cb_session_changed(cb))
+			nfsd4_mark_cb_fault(cb->cb_clp);
 		goto need_restart;
 	case -NFS4ERR_DELAY:
+		/*
+		 * If the rpc_clnt is being torn down, then we must restart
+		 * the call from scratch.
+		 */
+		if (RPC_SIGNALLED(task))
+			goto need_restart;
 		cb->cb_seq_status = 1;
-		if (!rpc_restart_call(task))
-			goto out;
-
-		rpc_delay(task, 2 * HZ);
+		if (rpc_restart_call(task))
+			rpc_delay(task, 2 * HZ);
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
+		if (!cb_session_changed(cb)) {
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
+		if (!cb_session_changed(cb)) {
+			nfsd4_mark_cb_fault(cb->cb_clp);
+			cb->cb_held_slot = -1;
 			goto retry_nowait;
 		}
-		break;
+		goto need_restart;
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
+	/*
+	 * RPC_SIGNALLED() means that the rpc_client is being torn down and
+	 * (possibly) recreated. Restart the call completely in that case.
+	 */
+	if (!RPC_SIGNALLED(task)) {
+		rpc_restart_call_prepare(task);
+		return false;
+	}
 need_restart:
+	nfsd41_cb_release_slot(cb);
 	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
 		trace_nfsd_cb_restart(clp, cb);
 		task->tk_status = 0;

-- 
2.48.1


