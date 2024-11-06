Return-Path: <linux-nfs+bounces-7681-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0629BDA57
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 01:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7491F23F66
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 00:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD0143AAE;
	Wed,  6 Nov 2024 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkq8GE4E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A358E38396;
	Wed,  6 Nov 2024 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853080; cv=none; b=I9wP8+Jk5cnLwyzOoCCaJPMd15cVXqIRy9D0SB0Z8DHpktzhXgcx7bGRrPLorwSGranhoy+vfjzrYyHnAof1sn7V3Sjfw8QMsWLRhnZKs2BkuGkjxE+P37xLqntOqdBBycaOnMDMewNRzCxNFHVEipQIXq3/gUlv/hr+FtbTR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853080; c=relaxed/simple;
	bh=rt62tUQ2aV36JPPxoQGECZUKe3zl2CU1Mys8w+ZHQi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZPu4cus7TCoe5VwDRgwA902MJPvPntO5MzduEqdhoOhWmL7shiMOMq6Zw8uMi0ePtVmWf+xAU0uKBdpeQtBFXZJM82C66v7C3DOR0y1W31q+Vhbn875w26C3eHLzO+MgqFU4+AvLW3vhs2ZP677K/xoo1241VgDysMQ0VsBkOQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkq8GE4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6785CC4CECF;
	Wed,  6 Nov 2024 00:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730853080;
	bh=rt62tUQ2aV36JPPxoQGECZUKe3zl2CU1Mys8w+ZHQi4=;
	h=From:Date:Subject:To:Cc:From;
	b=gkq8GE4E/dmnYhex7L6Sd7I0XFTyeM1Q+PZIWRo69Mxqm48FLp7xaf4laj3F7gTAL
	 DZQPIScGyWhVdq05chgaa05yXr50BY0TELFE+H91iX4JrUzsMhW4LQJembx3nzpW39
	 U5w0y3uxCK94fNd04JYS8RkhlJusYw5++VXenHcr1Ixkpad9y4uWmcTjQN5Qb4BYO1
	 JWQeiniA2DMYEHt4ig86DURHE5FfrtU0cYvl5S9vHbEy1xKb26bd5W4ItT3bmQh10a
	 0iJtRwDK47zsiiTC089GKsGXdYWvoamCSAfkUwCvkTPc7OvyS9MJ+eObGSwXeQW8LC
	 O7CqP/Fth17gw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 05 Nov 2024 19:31:06 -0500
Subject: [PATCH v4] nfsd: allow for up to 32 callback session slots
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-bcwide-v4-1-48f52ee0fb0c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMm4KmcC/2WNyw6CMBREf8V0bc3tbcvDlf9hXND2Ao0GTDGoI
 fy7hRgCYTmTOWcG1lHw1LHzYWCBet/5tolBHQ/M1kVTEfcuZoaASgBqbuzbO+KJcSkpk0hnkMX
 xM1DpP7Poeou59t2rDd/Z24up3Sl6wYE7BJApaQWFvdwpNPQ4taGalP99ttkDpbrIUOTOwno/f
 fa4/skXDrnglIMAk1CptdtxcsVJWDgZ/yy6UuUFJlbpDTeO4w884aP9PQEAAA==
X-Change-ID: 20241025-bcwide-6bd7e4b63db2
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13412; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rt62tUQ2aV36JPPxoQGECZUKe3zl2CU1Mys8w+ZHQi4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnKrjXwzwI5R73VknrWPoJSlOtISr4C3Q4BSMj/
 y8DC5kQK3mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZyq41wAKCRAADmhBGVaC
 FfQPEAChZ3h1h2socpBGSh/sVXr8i00Wh03c/R9LtkMholGWwnZA4Iiz6O/M5AlcJRkBVjKhw8i
 0lIDZO8U7utvufWE/LGYp/KKl3O9WXadqBiuvJvPaXz1rhqSO5cRBjJgXds9RRunXhJZVQjN6mj
 R6MiPU7hwfC9tqbtWz3IULDrsr9wD0gfkef+rMfMfxC6v6bVeVgo9eAUDm6nEfCdI1mDmlhtmvx
 VfTrJT3C9Yhhz2tCtMI9oB4Zp4dhx2ZVPDZ+wDg4TI/SPDjmfZlhsLJImRnY7RvfBqvbnSkewdb
 RChPOcJuW0cXddK2fd5zTiMSJmL/ozQ9lqwCUewm7khcuULNbVBruI4pp9SvHkZWIUUgasVYXG0
 NejaBbY32YjsbIWnPN+vyLZrNjBBWuNtHXxmNHL+vSBxUx/JPktiBQqOom0IExdx1Bji2Sso2MO
 A/IyDwkW5KE1A7MX7Zc5nlyqJ2eyeoqqEaoYXKF/u6bYIK4UlgfNRs1PxYmGMbskvOSi8Fk0dGn
 +ddQEXk9UtMbeCMvskFXkfICFtIJ0OTihm4/d6yHa0h+V6m2v9x3bbnzoA5RdTyeaLv8ABx17mt
 WJC+L7pBdFvcvmr/S1KvQ1bro8aZ95xNW7MU5f3BstKnj2HPy2fsrowTsglWvZtfKb8TEqXJOI5
 xuE1HOu4FkjKf7g==
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
a new per-session spinlock (the se_lock). Fix nfsd41_cb_get_slot to always
search for the lowest slotid (using ffs()).

Finally, convert the session->se_cb_seq_nr field into an array of
counters and add the necessary handling to ensure that the seqids get
reset at the appropriate times.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
v3 has a bug that Olga hit in testing. This version should fix the wait
when the slot table is full. Olga, if you're able to test this one, it
would be much appreciated.
---
Changes in v4:
- Fix the wait for a slot in nfsd41_cb_get_slot()
- Link to v3: https://lore.kernel.org/r/20241030-bcwide-v3-0-c2df49a26c45@kernel.org

Changes in v3:
- add patch to convert se_flags to single se_dead bool
- fix off-by-one bug in handling of NFSD_BC_SLOT_TABLE_MAX
- don't reject target highest slot value of 0
- Link to v2: https://lore.kernel.org/r/20241029-bcwide-v2-1-e9010b6ef55d@kernel.org

Changes in v2:
- take cl_lock when fetching fields from session to be encoded
- use fls() instead of bespoke highest_unset_index()
- rename variables in several functions with more descriptive names
- clamp limit of for loop in update_cb_slot_table()
- re-add missing rpc_wake_up_queued_task() call
- fix slotid check in decode_cb_sequence4resok()
- add new per-session spinlock
---
 fs/nfsd/nfs4callback.c | 113 ++++++++++++++++++++++++++++++++++++-------------
 fs/nfsd/nfs4state.c    |  11 +++--
 fs/nfsd/state.h        |  15 ++++---
 fs/nfsd/trace.h        |   2 +-
 4 files changed, 101 insertions(+), 40 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index e38fa834b3d91333acf1425eb14c644e5d5f2601..47a678333907eaa92db305dada503704c34c15b2 100644
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
@@ -484,21 +517,22 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
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
+	update_cb_slot_table(session, target);
 	status = 0;
 out:
 	cb->cb_seq_status = status;
@@ -1203,6 +1237,22 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
 	spin_unlock(&clp->cl_lock);
 }
 
+static int grab_slot(struct nfsd4_session *ses)
+{
+	int idx;
+
+	spin_lock(&ses->se_lock);
+	idx = ffs(ses->se_cb_slot_avail) - 1;
+	if (idx < 0 || idx > ses->se_cb_highest_slot) {
+		spin_unlock(&ses->se_lock);
+		return -1;
+	}
+	/* clear the bit for the slot */
+	ses->se_cb_slot_avail &= ~BIT(idx);
+	spin_unlock(&ses->se_lock);
+	return idx;
+}
+
 /*
  * There's currently a single callback channel slot.
  * If the slot is available, then mark it busy.  Otherwise, set the
@@ -1211,28 +1261,32 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
 static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
 {
 	struct nfs4_client *clp = cb->cb_clp;
+	struct nfsd4_session *ses = clp->cl_cb_session;
 
-	if (!cb->cb_holds_slot &&
-	    test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
+	if (cb->cb_held_slot >= 0)
+		return true;
+	cb->cb_held_slot = grab_slot(ses);
+	if (cb->cb_held_slot < 0) {
 		rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
 		/* Race breaker */
-		if (test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
-			dprintk("%s slot is busy\n", __func__);
+		cb->cb_held_slot = grab_slot(ses);
+		if (cb->cb_held_slot < 0)
 			return false;
-		}
 		rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
 	}
-	cb->cb_holds_slot = true;
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
@@ -1249,8 +1303,8 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
 }
 
 /*
- * TODO: cb_sequence should support referring call lists, cachethis, multiple
- * slots, and mark callback channel down on communication errors.
+ * TODO: cb_sequence should support referring call lists, cachethis,
+ * and mark callback channel down on communication errors.
  */
 static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 {
@@ -1292,7 +1346,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		return true;
 	}
 
-	if (!cb->cb_holds_slot)
+	if (cb->cb_held_slot < 0)
 		goto need_restart;
 
 	/* This is the operation status code for CB_SEQUENCE */
@@ -1306,10 +1360,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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
@@ -1335,17 +1389,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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
@@ -1565,7 +1618,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
 	cb->cb_status = 0;
 	cb->cb_need_restart = false;
-	cb->cb_holds_slot = false;
+	cb->cb_held_slot = -1;
 }
 
 /**
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index baf7994131fe1b0a4715174ba943fd2a9882aa12..75557e7cc9265517f51952563beaa4cfe8adcc3f 100644
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
@@ -2132,11 +2135,14 @@ static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, stru
 
 	INIT_LIST_HEAD(&new->se_conns);
 
-	new->se_cb_seq_nr = 1;
+	atomic_set(&new->se_ref, 0);
 	new->se_dead = false;
 	new->se_cb_prog = cses->callback_prog;
 	new->se_cb_sec = cses->cb_sec;
-	atomic_set(&new->se_ref, 0);
+
+	for (idx = 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx)
+		new->se_cb_seq_nr[idx] = 1;
+
 	idx = hash_sessionid(&new->se_sessionid);
 	list_add(&new->se_hash, &nn->sessionid_hashtbl[idx]);
 	spin_lock(&clp->cl_lock);
@@ -3159,7 +3165,6 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	kref_init(&clp->cl_nfsdfs.cl_ref);
 	nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB_NULL);
 	clp->cl_time = ktime_get_boottime_seconds();
-	clear_bit(0, &clp->cl_cb_slot_busy);
 	copy_verf(clp, verf);
 	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
 	clp->cl_cb_session = NULL;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index d22e4f2c9039324a0953a9e15a3c255fb8ee1a44..848d023cb308f0b69916c4ee34b09075708f0de3 100644
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
 
+/* Highest slot index that nfsd implements in NFSv4.1+ backchannel */
+#define NFSD_BC_SLOT_TABLE_MAX	(sizeof(u32) * 8 - 1)
+
 /*
  * Representation of a v4.1+ session. These are refcounted in a similar fashion
  * to the nfs4_client. References are only taken when the server is actively
@@ -314,6 +317,10 @@ struct nfsd4_conn {
  */
 struct nfsd4_session {
 	atomic_t		se_ref;
+	spinlock_t		se_lock;
+	u32			se_cb_slot_avail; /* bitmap of available slots */
+	u32			se_cb_highest_slot;	/* highest slot client wants */
+	u32			se_cb_prog;
 	bool			se_dead;
 	struct list_head	se_hash;	/* hash by sessionid */
 	struct list_head	se_perclnt;
@@ -322,8 +329,7 @@ struct nfsd4_session {
 	struct nfsd4_channel_attrs se_fchannel;
 	struct nfsd4_cb_sec	se_cb_sec;
 	struct list_head	se_conns;
-	u32			se_cb_prog;
-	u32			se_cb_seq_nr;
+	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_MAX + 1];
 	struct nfsd4_slot	*se_slots[];	/* forward channel slots */
 };
 
@@ -457,9 +463,6 @@ struct nfs4_client {
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
base-commit: 3c16aac09d20f9005fbb0e737b3ec520bbb5badd
change-id: 20241025-bcwide-6bd7e4b63db2

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


