Return-Path: <linux-nfs+bounces-9741-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7ECA21DFD
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A661665F0
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 13:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A011B4153;
	Wed, 29 Jan 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALUdfmC4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391B61B0F18;
	Wed, 29 Jan 2025 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158016; cv=none; b=oxWAHf9Gl9li756OUNbNc2Nyhl1jZ0aMYSgX229Ly/WLxlHBNWWE+1cZtDmlBxycpg6sZQFDX4ada2+226jQs4WgQV3BI76jZYGQRUvE6DwYOYRz1CzMqxT5JQ0fzXiB1ruBzwblhCtGh/dztHpLo+l0LSXBm2V+SgDH2XxBjnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158016; c=relaxed/simple;
	bh=yQ+thEBAqsSgndfez3KwbQk4kYB4c0YOyYwqV2evsgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JuAixqdRluMIYTtaKvtEIBfECHc8zsGRW1cWSdAYcae0aVOVLNUv6PupE3oURRKuskAWNAS56L0/E/q6r64m7zuz4tO9R9oPI4f1Rz2xgpp/y4J1fomGZNX4XGbeOcHNPfFu9UqO39Cq2+QztMTyMNsx/VCanGZDCfLEg6ES8wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALUdfmC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA54AC4CED3;
	Wed, 29 Jan 2025 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738158015;
	bh=yQ+thEBAqsSgndfez3KwbQk4kYB4c0YOyYwqV2evsgk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ALUdfmC4EBW2WaoKYevQYjagOd3H9BW788bewkwVwDmXK6PYsFwlu+a8RfSggJHTT
	 hoowTRauLC0FqmMo4VPhd9AR7R8uD9eqU+je7Udu/z95p4LX1heTG7Xy83R4cg5e1K
	 reGx66DJo+oMU8fzlfsE37i6CHC6kIrWStZ2nnLkQYgmXuNtGD+lEtCVzKGprMBh2d
	 d6MCTaZRLE/Kj2HckCtbIePd2gHkIg6rf+3/IyXeSEWyG5nGoPPFCcjCWA1nTy7/Y9
	 jf0pTQ4C7caL8yvAy9gZtSgFSO8UjUw6mDeDXt+trUiyjMOmiY0j7w9k/BCllWH6SO
	 RuK+k431YKsXw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 29 Jan 2025 08:39:56 -0500
Subject: [PATCH v2 3/7] nfsd: add a cb_ses pointer to nfsd4_callback and
 use it instead of clp->cb_cb_session
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-nfsd-6-14-v2-3-2700c92f3e44@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7124; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yQ+thEBAqsSgndfez3KwbQk4kYB4c0YOyYwqV2evsgk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnmi+5lvhs4/VYc7opP+c9t96xSx7MIrvtR9aDq
 2CEGsY0icWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5ovuQAKCRAADmhBGVaC
 FYkbD/wJEgfe/OhoFrFV7D/ZV+Ox85RKKEApf86k3ZWtnRrHF2SFva7tYUO4J8Vix1LMdpgKDzX
 47v/dLcuvxTivOJEf+OO9bggZoiWJReQmaMuYzD+4Wuh7e/4vrJLTzK3dzqaeg1q3V3GopRtIdT
 qqiHPJ7iplK1QU272fCqFwUJi9UzPM/BlcDfpGFPRzupgyHnkMbk1wxJOLHSafcCR9C3qo2skrx
 GrJw60Ze+V8UWZPyqxSn2j5FtJzu7CMLmMiN8q7b34NNOmkZxKXPgOMVXUiDHOzeTD0gD/m+k/2
 HmlLOoAe1wPWOV0/D0uCcB8VhfpX/aMFd1SF9+9QjJKZiknedHMLJJhnv+7qP5ul9FqvOmz2qUH
 Rpi45Mv5tOIn/TlsnwCW11d4WX4chebqlzcUaVozcOXJV9EUgysnBYxexdFznbEt4qPd97/w8kd
 bjHVQxGDTTDXRGrZ/lYUOM2m0hOjRg2BAfB9O0R9S9DdPhbfxmRaTCzRrmiMXBSWQw4rQ9pXFTn
 jiY98jX7BuvXOHcOvRrMyVXRceYazO7QA7IcockkCZ/A/CWy4X2DslDQ825o+AB7/PIT79RCunL
 VhclwoQNYCrT3Vf7l+F7+Dot/2LPXqI18Rn227tAg2gmoPsumTkH2ckQCR6P2gbYIbj8jDwzrNi
 nU0yOagdooKzI7w==
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


