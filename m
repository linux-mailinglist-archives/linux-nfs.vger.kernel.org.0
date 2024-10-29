Return-Path: <linux-nfs+bounces-7562-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E529B5302
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 21:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7341F23827
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35D71DBB36;
	Tue, 29 Oct 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQWO6b3b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BD11940B3;
	Tue, 29 Oct 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730232035; cv=none; b=cPFk+nkv/JdIi0ty9mzFyTOQ4pkzvyOUfJxnLkPRV1vxvktWrO/pd216VeVDDz+uvn/6wqn8HF9+E3bvU0gnfL3ZfDs6hxl0HnY6TUvq8QM83yrjkBZotVjB58bEDoKlAV6yOLdNORro7Ece6JyWVbK9FzOjs48Bg0w8heSGQRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730232035; c=relaxed/simple;
	bh=Z5k6IE5EbAGovDlm8kn1eD8hO0NwIVUO7nt1+rBPFyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RqTyUGsVHtP10ky3Hp5yAIIdQwlkVfrmIzTEdGJMlDXiD03rIsJWxcRBCg4ABMQ76cYoItLRn8vnXWCOwAtXAh6Y/cghtYqn1J1sqRHZFIdrNnUyqEEz5z6Rwr6W7bFTW2EHg+MI3quMavRuWVzO3k15U0BH2+vT5f2oIUAnd88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQWO6b3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633B5C4CECD;
	Tue, 29 Oct 2024 20:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730232035;
	bh=Z5k6IE5EbAGovDlm8kn1eD8hO0NwIVUO7nt1+rBPFyM=;
	h=From:Date:Subject:To:Cc:From;
	b=EQWO6b3b23uFJ8yJz7kF6iDRTNE6NSAV4ffmgJXO1J7gNmVjt/Eu1gcH8hporzB1O
	 y5fElDNqOQjt3SeWdEbuOOcgE8T8SrzX5cy1KwaFkIjeACs9fy3sX2zsYD8DOuHPW4
	 saYK/r/+97QgVS8riMCfOxYWhJUxHLdTVmPV9GvPvnxgHwUXPave7/XY5VamkniE2W
	 bFDEKAvYW1vZNqwiUvZlNspiRTJxNK6q+Aat95gh+vrnZX3ZERS1bxZ3vY7FqKvefP
	 hkITA2DKJ5+lrVDHbRtmph9eck4tJL9TwSeM2XiDmuuWQTTP5qsc00kWyW4o/rgZd8
	 qw5Sf3EVFkTzA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 29 Oct 2024 16:00:23 -0400
Subject: [PATCH v2] nfsd: allow for up to 32 callback session slots
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-bcwide-v2-1-e9010b6ef55d@kernel.org>
X-B4-Tracking: v=1; b=H4sIANc+IWcC/2WMyw6CMBAAf4X0bM12KQ89+R+GA21X2GiAtAY1p
 P9uIR40HmcymUUE8kxBHLNFeJo58DgkwF0mbN8OHUl2iQUCagVYSGMf7EiWxlWkTZk7gyLFk6c
 LP7fRuUncc7iP/rV9Z7Xav8WsJEiHAHlFhYbWnq7kB7rtR9+ty09f//RAVdHWqA7OwnffxBjfI
 /NJOc0AAAA=
X-Change-ID: 20241025-bcwide-6bd7e4b63db2
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12941; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Z5k6IE5EbAGovDlm8kn1eD8hO0NwIVUO7nt1+rBPFyM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnIT7ciLNg2L6sd38JSfB3XmiIPIOrt8QRansL7
 vy5HUQXL9CJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZyE+3AAKCRAADmhBGVaC
 FTMcD/9ZW5J0t0fBipWWFUe/W2Hu3O6J1/IaA5BfFieSIHBJAySi1Ts75I0/dow80CJR2njcBzt
 8ZBaT/uNzvjt7uVz4yE8WXYHO9EbSavQzuUuOZ70TjnUPIv1ilt9WzcxRnh+Ud5SFIwOLxxQfaG
 Q161SYDqpznoiAOBh9ImdvhlSUvnJjs/tw7fUmbKFHlCSyQq8iDIJJ9aPLczig6IhOdCEsA6eBJ
 fD3LLDNmj1BZ+/f6sjjPDk/5pwfu5mhwUl69CSiySxxfTLXx66vdbx+N2ItijyPvP+FP2F2QzHX
 gWDz3RKGiHpR0wdHfZK4Ekv4zMUPK5ta7WdPLYn1AgXCAPAxFdWnTqEHyHE4ceqtSCqvXIJEp8L
 J29Fxmn+oSd1D4Pl0OiHPjXsBCp+W9pK8d9NKJgp9Lz0dYiHrtOTOTfNc+6oHIk0uy51XO+EcsS
 FN1iRcaelD8ahusYbNLPBfJTUgKIilgczQ0huxtzqIz+xPD7Mg15e/7S5EkdqPYaTqYqtduQsoJ
 OUaTTrE0pk5yDdWl1vWO9OczBealBRTwLcYg08o3SLUrWAdylIP08OY0s890o4Yfz++181jhEZV
 yH72w9FatAGZ2ksz2XUbCGXK4KKX4DEY7Ez4nxNGKCCvoQG2StcjAadJs18gs5HsGzLIfoUrP4I
 2f0PL8SWXcMWCVQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

nfsd currently only uses a single slot in the callback channel, which is
proving to be a bottleneck in some cases. Widen the callback channel to
a max of 32 slots (subject to the client's target_maxreqs value).

Change the cb_holds_slot boolean to an integer that tracks the current
slot number (with -1 meaning "unassigned").  Move the callback slot
tracking info into the session. Add a new u32 that acts as a bitmap to
track which slots are in use, and a u32 to track the latest callback
target_slotid that the client reports. To protect the new fields, add
a new per-session spinlock (the se_lock).

Fix nfsd41_cb_get_slot to always search for the lowest slotid (using
ffs()), and change it to retry until there is a slot available or the
rpc_task is signalled.

Finally, convert the session->se_cb_seq_nr field into an array of
counters and add the necessary handling to ensure that the seqids get
reset at the appropriate times.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Minor update to the set I sent yesterday, mostly to address Chuck's
comments. This one also adds a new per-session spinlock to protect
these fields instead of using the cl_lock.

Olga, you had a workload that was seeing timeouts (probably?) due to
long callback queues. I'd be interested to know whether this patch
helps that workload at all.
---
Changes in v2:
- take cl_lock when fetching fields from session to be encoded
- use fls() instead of bespoke highest_unset_index()
- rename variables in several functions with more descriptive names
- clamp limit of for loop in update_cb_slot_table()
- re-add missing rpc_wake_up_queued_task() call
- fix slotid check in decode_cb_sequence4resok()
- add new per-session spinlock
---
 fs/nfsd/nfs4callback.c | 113 +++++++++++++++++++++++++++++++++++--------------
 fs/nfsd/nfs4state.c    |   8 +++-
 fs/nfsd/state.h        |  17 +++++---
 fs/nfsd/trace.h        |   2 +-
 4 files changed, 98 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index e38fa834b3d91333acf1425eb14c644e5d5f2601..4516ec5f68edcf702944dd2cc3071a24fd350f21 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -406,6 +406,19 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
 	hdr->nops++;
 }
 
+static u32 highest_slotid(struct nfsd4_session *ses)
+{
+	u32 idx;
+
+	spin_lock(&ses->se_lock);
+	idx = fls(~ses->se_cb_slot_avail);
+	if (idx > 0)
+		--idx;
+	idx = max(idx, ses->se_cb_highest_slot);
+	spin_unlock(&ses->se_lock);
+	return idx;
+}
+
 /*
  * CB_SEQUENCE4args
  *
@@ -432,15 +445,35 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
 	encode_sessionid4(xdr, session);
 
 	p = xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
-	*p++ = cpu_to_be32(session->se_cb_seq_nr);	/* csa_sequenceid */
-	*p++ = xdr_zero;			/* csa_slotid */
-	*p++ = xdr_zero;			/* csa_highest_slotid */
+	*p++ = cpu_to_be32(session->se_cb_seq_nr[cb->cb_held_slot]);	/* csa_sequenceid */
+	*p++ = cpu_to_be32(cb->cb_held_slot);		/* csa_slotid */
+	*p++ = cpu_to_be32(highest_slotid(session)); /* csa_highest_slotid */
 	*p++ = xdr_zero;			/* csa_cachethis */
 	xdr_encode_empty_array(p);		/* csa_referring_call_lists */
 
 	hdr->nops++;
 }
 
+static void update_cb_slot_table(struct nfsd4_session *ses, u32 target)
+{
+	/* No need to do anything if nothing changed */
+	if (likely(target == READ_ONCE(ses->se_cb_highest_slot)))
+		return;
+
+	spin_lock(&ses->se_lock);
+	if (target > ses->se_cb_highest_slot) {
+		int i;
+
+		target = min(target, NFSD_BC_SLOT_TABLE_MAX);
+
+		/* Growing the slot table. Reset any new sequences to 1 */
+		for (i = ses->se_cb_highest_slot + 1; i <= target; ++i)
+			ses->se_cb_seq_nr[i] = 1;
+	}
+	ses->se_cb_highest_slot = target;
+	spin_unlock(&ses->se_lock);
+}
+
 /*
  * CB_SEQUENCE4resok
  *
@@ -468,7 +501,7 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
 	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
 	int status = -ESERVERFAULT;
 	__be32 *p;
-	u32 dummy;
+	u32 seqid, slotid, target;
 
 	/*
 	 * If the server returns different values for sessionID, slotID or
@@ -484,21 +517,27 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
 	}
 	p += XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
 
-	dummy = be32_to_cpup(p++);
-	if (dummy != session->se_cb_seq_nr) {
+	seqid = be32_to_cpup(p++);
+	if (seqid != session->se_cb_seq_nr[cb->cb_held_slot]) {
 		dprintk("NFS: %s Invalid sequence number\n", __func__);
 		goto out;
 	}
 
-	dummy = be32_to_cpup(p++);
-	if (dummy != 0) {
+	slotid = be32_to_cpup(p++);
+	if (slotid != cb->cb_held_slot) {
 		dprintk("NFS: %s Invalid slotid\n", __func__);
 		goto out;
 	}
 
-	/*
-	 * FIXME: process highest slotid and target highest slotid
-	 */
+	p++; // ignore current highest slot value
+
+	target = be32_to_cpup(p++);
+	if (target == 0) {
+		dprintk("NFS: %s Invalid target highest slotid\n", __func__);
+		goto out;
+	}
+
+	update_cb_slot_table(session, target);
 	status = 0;
 out:
 	cb->cb_seq_status = status;
@@ -1211,28 +1250,39 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
 static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
 {
 	struct nfs4_client *clp = cb->cb_clp;
+	struct nfsd4_session *ses = clp->cl_cb_session;
+	int idx;
 
-	if (!cb->cb_holds_slot &&
-	    test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
-		rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
-		/* Race breaker */
-		if (test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
-			dprintk("%s slot is busy\n", __func__);
+	if (cb->cb_held_slot >= 0)
+		return true;
+retry:
+	spin_lock(&ses->se_lock);
+	idx = ffs(ses->se_cb_slot_avail) - 1;
+	if (idx < 0 || idx > ses->se_cb_highest_slot) {
+		spin_unlock(&ses->se_lock);
+		if (RPC_SIGNALLED(task))
 			return false;
-		}
+		rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
 		rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
+		goto retry;
 	}
-	cb->cb_holds_slot = true;
+	/* clear the bit for the slot */
+	ses->se_cb_slot_avail &= ~BIT(idx);
+	spin_unlock(&ses->se_lock);
+	cb->cb_held_slot = idx;
 	return true;
 }
 
 static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
+	struct nfsd4_session *ses = clp->cl_cb_session;
 
-	if (cb->cb_holds_slot) {
-		cb->cb_holds_slot = false;
-		clear_bit(0, &clp->cl_cb_slot_busy);
+	if (cb->cb_held_slot >= 0) {
+		spin_lock(&ses->se_lock);
+		ses->se_cb_slot_avail |= BIT(cb->cb_held_slot);
+		spin_unlock(&ses->se_lock);
+		cb->cb_held_slot = -1;
 		rpc_wake_up_next(&clp->cl_cb_waitq);
 	}
 }
@@ -1249,8 +1299,8 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
 }
 
 /*
- * TODO: cb_sequence should support referring call lists, cachethis, multiple
- * slots, and mark callback channel down on communication errors.
+ * TODO: cb_sequence should support referring call lists, cachethis,
+ * and mark callback channel down on communication errors.
  */
 static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 {
@@ -1292,7 +1342,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		return true;
 	}
 
-	if (!cb->cb_holds_slot)
+	if (cb->cb_held_slot < 0)
 		goto need_restart;
 
 	/* This is the operation status code for CB_SEQUENCE */
@@ -1306,10 +1356,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 * If CB_SEQUENCE returns an error, then the state of the slot
 		 * (sequence ID, cached reply) MUST NOT change.
 		 */
-		++session->se_cb_seq_nr;
+		++session->se_cb_seq_nr[cb->cb_held_slot];
 		break;
 	case -ESERVERFAULT:
-		++session->se_cb_seq_nr;
+		++session->se_cb_seq_nr[cb->cb_held_slot];
 		nfsd4_mark_cb_fault(cb->cb_clp);
 		ret = false;
 		break;
@@ -1335,17 +1385,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	case -NFS4ERR_BADSLOT:
 		goto retry_nowait;
 	case -NFS4ERR_SEQ_MISORDERED:
-		if (session->se_cb_seq_nr != 1) {
-			session->se_cb_seq_nr = 1;
+		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
+			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
 			goto retry_nowait;
 		}
 		break;
 	default:
 		nfsd4_mark_cb_fault(cb->cb_clp);
 	}
-	nfsd41_cb_release_slot(cb);
-
 	trace_nfsd_cb_free_slot(task, cb);
+	nfsd41_cb_release_slot(cb);
 
 	if (RPC_SIGNALLED(task))
 		goto need_restart;
@@ -1565,7 +1614,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
 	cb->cb_status = 0;
 	cb->cb_need_restart = false;
-	cb->cb_holds_slot = false;
+	cb->cb_held_slot = -1;
 }
 
 /**
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5b718b349396f1aecd0ad4c63b2f43342841bbd4..2e8d2a3425f8ae28608e9e6a81ecda49cf4b2089 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2002,6 +2002,9 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	}
 
 	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
+	new->se_cb_slot_avail = ~0U;
+	new->se_cb_highest_slot = battrs->maxreqs - 1;
+	spin_lock_init(&new->se_lock);
 	return new;
 out_free:
 	while (i--)
@@ -2132,7 +2135,9 @@ static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, stru
 
 	INIT_LIST_HEAD(&new->se_conns);
 
-	new->se_cb_seq_nr = 1;
+	for (idx = 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx)
+		new->se_cb_seq_nr[idx] = 1;
+
 	new->se_flags = cses->flags;
 	new->se_cb_prog = cses->callback_prog;
 	new->se_cb_sec = cses->cb_sec;
@@ -3159,7 +3164,6 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	kref_init(&clp->cl_nfsdfs.cl_ref);
 	nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB_NULL);
 	clp->cl_time = ktime_get_boottime_seconds();
-	clear_bit(0, &clp->cl_cb_slot_busy);
 	copy_verf(clp, verf);
 	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
 	clp->cl_cb_session = NULL;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 41cda86fea1f6166a0fd0215d3d458c93ced3e6a..665a672fe71e453809f432b8dd0b120e92f5a36a 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -71,8 +71,8 @@ struct nfsd4_callback {
 	struct work_struct cb_work;
 	int cb_seq_status;
 	int cb_status;
+	int cb_held_slot;
 	bool cb_need_restart;
-	bool cb_holds_slot;
 };
 
 struct nfsd4_callback_ops {
@@ -307,6 +307,9 @@ struct nfsd4_conn {
 	unsigned char cn_flags;
 };
 
+/* Max number of slots that nfsd implements for NFSv4.1+ backchannel */
+#define NFSD_BC_SLOT_TABLE_MAX	(sizeof(u32) * 8)
+
 /*
  * Representation of a v4.1+ session. These are refcounted in a similar fashion
  * to the nfs4_client. References are only taken when the server is actively
@@ -314,18 +317,21 @@ struct nfsd4_conn {
  */
 struct nfsd4_session {
 	atomic_t		se_ref;
-	struct list_head	se_hash;	/* hash by sessionid */
-	struct list_head	se_perclnt;
 /* See SESSION4_PERSIST, etc. for standard flags; this is internal-only: */
 #define NFS4_SESSION_DEAD	0x010
 	u32			se_flags;
+	spinlock_t		se_lock;
+	struct list_head	se_hash;	/* hash by sessionid */
+	struct list_head	se_perclnt;
 	struct nfs4_client	*se_client;
 	struct nfs4_sessionid	se_sessionid;
 	struct nfsd4_channel_attrs se_fchannel;
 	struct nfsd4_cb_sec	se_cb_sec;
 	struct list_head	se_conns;
 	u32			se_cb_prog;
-	u32			se_cb_seq_nr;
+	u32			se_cb_slot_avail; /* bitmap of available slots */
+	u32			se_cb_highest_slot;	/* highest slot client wants */
+	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_MAX];
 	struct nfsd4_slot	*se_slots[];	/* forward channel slots */
 };
 
@@ -459,9 +465,6 @@ struct nfs4_client {
 	 */
 	struct dentry		*cl_nfsd_info_dentry;
 
-	/* for nfs41 callbacks */
-	/* We currently support a single back channel with a single slot */
-	unsigned long		cl_cb_slot_busy;
 	struct rpc_wait_queue	cl_cb_waitq;	/* backchannel callers may */
 						/* wait here for slots */
 	struct net		*net;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index f318898cfc31614b5a84a4867e18c2b3a07122c9..a9c17186b6892f1df8d7f7b90e250c2913ab23fe 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1697,7 +1697,7 @@ TRACE_EVENT(nfsd_cb_free_slot,
 		__entry->cl_id = sid->clientid.cl_id;
 		__entry->seqno = sid->sequence;
 		__entry->reserved = sid->reserved;
-		__entry->slot_seqno = session->se_cb_seq_nr;
+		__entry->slot_seqno = session->se_cb_seq_nr[cb->cb_held_slot];
 	),
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
 		" sessionid=%08x:%08x:%08x:%08x new slot seqno=%u",

---
base-commit: 9c9cb4242c49bbadd010e8f0a9e7daf4b392ff6b
change-id: 20241025-bcwide-6bd7e4b63db2

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


