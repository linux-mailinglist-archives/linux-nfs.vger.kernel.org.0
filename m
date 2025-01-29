Return-Path: <linux-nfs+bounces-9772-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD348A226D9
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 00:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D412E3A6EFC
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 23:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9371E4929;
	Wed, 29 Jan 2025 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgPKWZZF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1615B1E47CA;
	Wed, 29 Jan 2025 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192857; cv=none; b=WzQ5miC/aSIa1Up55dCVW+kyircGq6mk2GLPxmIflqyxLK0+dw9ijwOiufaYjXfF/ag3KauW2jtRl6UOnfIV7GYEtaAIzfwH0U0baBw2QChe8nUDPBzUc4K7WxAD5WC/jmi+PQ9yGBovsniBtTXbw5hJCpu1WXeokwf2QsAE1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192857; c=relaxed/simple;
	bh=yQ+thEBAqsSgndfez3KwbQk4kYB4c0YOyYwqV2evsgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tS2whnru8fEydlXV1fkJtJTOhD0UiLLdilNr7KPH4LTheGuiXSK1OwqAPsHcpi5E3V0XWSF8GHYNInpTT8F8REp7wKBiZc2C1lrHkpQ7AF/XaNCdcIk7p07qy4j8L0aGRsxLXXO9b6UPnkEVGYkwgF06LjUYXkIR35Kv+3piqAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgPKWZZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36004C4CED1;
	Wed, 29 Jan 2025 23:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738192856;
	bh=yQ+thEBAqsSgndfez3KwbQk4kYB4c0YOyYwqV2evsgk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XgPKWZZFHCCf70nsoqKggpaiJSsB3KuG3svIVGrabB9CQUdRl9DQaiZVsx028qL1j
	 LMVInpqAJovk/Cd8C9GqlLQucALYDAcAdaNJYYJMk6HEyhS8DZ/+RhDRzO7j5o8YCX
	 hfcT2esakQKgcpspG+VangBxHKTwTtIIPHCWuVj7IVfKS8HPwQ/8iS/uqx3UTtcpWX
	 2gO8/wGyat65E8PW8QufaTQAc3lhcx8Oxf0W0envuprX30KHZnhcJTciiTSYiQIS1w
	 XYpuS6X2QuGaSYML/jsXWJfg8aiRlSc2JKO8x9qh8zCtvnRuGG7iUWvdufcrhfsIt9
	 lHK6BKsMuGS/A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 29 Jan 2025 18:20:43 -0500
Subject: [PATCH v3 3/6] nfsd: add a cb_ses pointer to nfsd4_callback and
 use it instead of clp->cb_cb_session
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-nfsd-6-14-v3-3-506e71e39e6b@kernel.org>
References: <20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org>
In-Reply-To: <20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7124; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yQ+thEBAqsSgndfez3KwbQk4kYB4c0YOyYwqV2evsgk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnmrfUhuAxs1o8Iou6bEixCslvz95wtP0VQ+ngC
 /pb4MkfNLCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5q31AAKCRAADmhBGVaC
 FaMyD/sHWNUs1UNFM+v57UebnsthnWP1ay5AEOHNriLUvNrWJO93B3wepZ8MLu4xt3KLzkb2358
 SyIHyL3ZJHqc81O+m2BnSILjW6Q1oUJRKH2dAFPOnMfJpEIhLmGO1ho0BoRaAC4OMYQ47oqknYz
 hmkJhx33TIvLqxiSFz8nA84kIKJOkIR4QJi3K0BF+0hy8MO4dp180bBp/bGKwZ5gq4ot1b288hK
 2xtRu96hhC7LuByIiR+kLWK3zW5OUDGn1pHHuxCatMQ4i1fJuQ6dwcviIQNTZ4BQnzu0NI5rELD
 HzokmweFEcs/mdswru6KzlGs8IxW5+nGqQj1abxivZ+dUel+KfGKMgMZxpzHsIfxhom8PnDhBXW
 dhWwcf5Wb5eqLWB5QMruODgK3jFX7gD6LmzeLj9+GPPbjIQYd5R6M0e3LxoA4FGQVPAwdZrOP/V
 zhmCVJhZ6wmU6UOJ3C5g8/w01rlP0Oz/8r6YMTW2TPA7BPfbqpbB0p3fp9hJzDkkPJv+Mdupy0D
 Y0liPZQkDCYm6mydjNunAjbKof4e78rap+bkbiYPuasl1mVzd6rKuyTY/KD8xKfNXOytf8TVABm
 YBxvO0150BJWXSfh/dsPj5VMlNx0QlWDCzs8C2qblisne3nTLEMQ1+pfxCfEtIQA8tPSVwl+dFh
 ewdzjRspGR4L0yw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Once a callback workqueue job has completed, the cl_cb_session could
change to a completely different session, if there is more than one
callback in flight at a time.

Have the callback hold its own cb reference to the session, and fix the
slot acquisition routines to get/put a session reference. This ensures
that the call and reply handling are working with the same session.

In the event that rpc_prepare can't get a session reference, allow the
rpc_task to sleep until the session reference changes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 67 +++++++++++++++++++++++++++++++++++++++++---------
 fs/nfsd/state.h        |  1 +
 fs/nfsd/trace.h        |  6 ++---
 3 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index e55bf66a33d6efb56d2f75f0a49a60307e3807ac..9f4838a6d9c668cdf66a77793f63c064586f2b22 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -435,7 +435,7 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
 				    const struct nfsd4_callback *cb,
 				    struct nfs4_cb_compound_hdr *hdr)
 {
-	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
+	struct nfsd4_session *session = cb->cb_ses;
 	__be32 *p;
 
 	if (hdr->minorversion == 0)
@@ -503,7 +503,7 @@ static void update_cb_slot_table(struct nfsd4_session *ses, u32 target)
 static int decode_cb_sequence4resok(struct xdr_stream *xdr,
 				    struct nfsd4_callback *cb)
 {
-	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
+	struct nfsd4_session *session = cb->cb_ses;
 	int status = -ESERVERFAULT;
 	__be32 *p;
 	u32 seqid, slotid, target;
@@ -1142,7 +1142,7 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 			return -EINVAL;
 		rcu_assign_pointer(clp->cl_cb_session, ses);
 		args.bc_xprt = conn->cb_xprt;
-		args.prognumber = clp->cl_cb_session->se_cb_prog;
+		args.prognumber = ses->se_cb_prog;
 		args.protocol = conn->cb_xprt->xpt_class->xcl_ident |
 				XPRT_TRANSPORT_BC;
 		args.authflavor = ses->se_cb_sec.flavor;
@@ -1161,9 +1161,10 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 		ret = -ENOMEM;
 		goto out_put_ses;
 	}
-
-	if (clp->cl_minorversion != 0)
+	if (clp->cl_minorversion != 0) {
 		clp->cl_cb_conn.cb_xprt = conn->cb_xprt;
+		rpc_wake_up(&clp->cl_cb_waitq);
+	}
 	clp->cl_cb_client = client;
 	clp->cl_cb_cred = cred;
 	rcu_read_lock();
@@ -1252,6 +1253,34 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
 	spin_unlock(&clp->cl_lock);
 }
 
+static bool grab_cb_ses(struct nfsd4_callback *cb)
+{
+	struct nfs4_client *clp = cb->cb_clp;
+	struct nfsd4_session *ses;
+	bool ret = false;
+
+	if (cb->cb_ses)
+		return true;
+
+	rcu_read_lock();
+	ses = rcu_dereference(clp->cl_cb_session);
+	if (ses && nfsd4_cb_get_session(ses)) {
+		cb->cb_ses = ses;
+		ret = true;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static void put_cb_ses(struct nfsd4_callback *cb)
+{
+	if (cb->cb_ses) {
+		nfsd4_cb_put_session(cb->cb_ses);
+		cb->cb_ses = NULL;
+	}
+}
+
 static int grab_slot(struct nfsd4_session *ses)
 {
 	int idx;
@@ -1269,24 +1298,33 @@ static int grab_slot(struct nfsd4_session *ses)
 }
 
 /*
- * There's currently a single callback channel slot.
- * If the slot is available, then mark it busy.  Otherwise, set the
- * thread for sleeping on the callback RPC wait queue.
+ * Get both a session reference and a slot.
  */
 static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
 {
 	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd4_session *ses = clp->cl_cb_session;
+	struct nfsd4_session *ses;
+
+	if (!grab_cb_ses(cb)) {
+		rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
+		if (!grab_cb_ses(cb))
+			return false;
+		rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
+	}
 
 	if (cb->cb_held_slot >= 0)
 		return true;
+
+	ses = cb->cb_ses;
 	cb->cb_held_slot = grab_slot(ses);
 	if (cb->cb_held_slot < 0) {
 		rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
 		/* Race breaker */
 		cb->cb_held_slot = grab_slot(ses);
-		if (cb->cb_held_slot < 0)
+		if (cb->cb_held_slot < 0) {
+			put_cb_ses(cb);
 			return false;
+		}
 		rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
 	}
 	return true;
@@ -1295,7 +1333,10 @@ static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
 static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd4_session *ses = clp->cl_cb_session;
+	struct nfsd4_session *ses = cb->cb_ses;
+
+	if (!ses)
+		return;
 
 	if (cb->cb_held_slot >= 0) {
 		spin_lock(&ses->se_lock);
@@ -1304,6 +1345,7 @@ static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
 		cb->cb_held_slot = -1;
 		rpc_wake_up_next(&clp->cl_cb_waitq);
 	}
+	put_cb_ses(cb);
 }
 
 static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
@@ -1342,7 +1384,7 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd4_session *session = clp->cl_cb_session;
+	struct nfsd4_session *session = cb->cb_ses;
 	bool ret = true;
 
 	if (!clp->cl_minorversion) {
@@ -1629,6 +1671,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op)
 {
 	cb->cb_clp = clp;
+	cb->cb_ses = NULL;
 	cb->cb_msg.rpc_proc = &nfs4_cb_procedures[op];
 	cb->cb_msg.rpc_argp = cb;
 	cb->cb_msg.rpc_resp = cb;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 0faa367c9fa3280fa4a8a982f974804bb89f2035..56fe34d8dd90344404512114113c00a027aeb6a4 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -66,6 +66,7 @@ typedef struct {
 
 struct nfsd4_callback {
 	struct nfs4_client *cb_clp;
+	struct nfsd4_session *cb_ses;
 	struct rpc_message cb_msg;
 	const struct nfsd4_callback_ops *cb_ops;
 	struct work_struct cb_work;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index ad2c0c432d08705bcebf00f7309f19267afcae03..fff665bac3b252387f92139b5f868cf1b034d1c9 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1644,8 +1644,7 @@ TRACE_EVENT(nfsd_cb_seq_status,
 		__field(int, seq_status)
 	),
 	TP_fast_assign(
-		const struct nfs4_client *clp = cb->cb_clp;
-		const struct nfsd4_session *session = clp->cl_cb_session;
+		const struct nfsd4_session *session = cb->cb_ses;
 		const struct nfsd4_sessionid *sid =
 			(struct nfsd4_sessionid *)&session->se_sessionid;
 
@@ -1684,8 +1683,7 @@ TRACE_EVENT(nfsd_cb_free_slot,
 		__field(u32, slot_seqno)
 	),
 	TP_fast_assign(
-		const struct nfs4_client *clp = cb->cb_clp;
-		const struct nfsd4_session *session = clp->cl_cb_session;
+		const struct nfsd4_session *session = cb->cb_ses;
 		const struct nfsd4_sessionid *sid =
 			(struct nfsd4_sessionid *)&session->se_sessionid;
 

-- 
2.48.1


