Return-Path: <linux-nfs+bounces-7578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E89B6673
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 15:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E9C1C20C3C
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5911F8938;
	Wed, 30 Oct 2024 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkjR/tl6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648C11F8932;
	Wed, 30 Oct 2024 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299736; cv=none; b=nxYTgxiwJ7HorjYqwvc37ruD+xt3w5wuLmNd8ItQKKkdDMbhAUf2aig9hBuj8ZVL9L0qUFXimQ0Svx4jJ0uOrNMvvCJaZyHJBS1VdB95B10LCs7pDHoMLtnkeDZv76VKVGisuGfalXi9RnHfm8y75DPhAke3PjldnjtQgJZvjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299736; c=relaxed/simple;
	bh=nckgiPLG+atCu4LICe7r7yxWKsI+u0PyRhMLEBHtspc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DGh718Mnk0kmK7fYeLhToBpnsKD3I5BkG5HEPecp0FNXTBTJOtebXgpX5Yic8byHLY3TvIAP8YaksixTSifHTAV3xeKFCTvbTc4AjmiYjGsM74eI9IrZaVbJVlKi8oZH92WPqtQuta/AQcJUnXIlpzjC3s93f1EwSAwnnWlX0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkjR/tl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA33C4CED0;
	Wed, 30 Oct 2024 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730299736;
	bh=nckgiPLG+atCu4LICe7r7yxWKsI+u0PyRhMLEBHtspc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TkjR/tl6x5m8+d8rk902Knv3sgxaCI205tj4oOzF/hffBere2oZvRV0jP5VLC6mhE
	 aIlW6IYnpiqYnqilZiCL8hV/FY+GlkaDRPHlwIKPLaOAFetV6JulzCd0X8UavyUnaV
	 7OL8kYnO1O7a4P3/8UvWaOMX0QLIxWUtAHtmOTdJcpbfIlq3720MYId4bBg3G9Endi
	 aNB659SQQPi8KNVM3UkQC9rvxzGRR0mOJVGIFOOK1icUx9g7lecFk1XPfxRDRNv1z5
	 5mpY8k0RpzqSddO6k01Lh+EanFCoybnN9m4Q4AHJuVoCAa8GKUHrOzpovQrMN6OMb2
	 Q55ef7JoJr4/Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Oct 2024 10:48:47 -0400
Subject: [PATCH v3 2/2] nfsd: allow for up to 32 callback session slots
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-bcwide-v3-2-c2df49a26c45@kernel.org>
References: <20241030-bcwide-v3-0-c2df49a26c45@kernel.org>
In-Reply-To: <20241030-bcwide-v3-0-c2df49a26c45@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11933; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=nckgiPLG+atCu4LICe7r7yxWKsI+u0PyRhMLEBHtspc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnIkdV/l0NC6Cnn7zI+SdECwaA02BcMOcWmwmjr
 tc7f50kTKOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZyJHVQAKCRAADmhBGVaC
 Fav9D/9eZk4dKz/6A5l0PD8sUXdXYSksKEhlSNaI033ZAVxdSUlRmJLZI6mG5ggrUQZGuaRrmjI
 vEW897Eq7O1zomVrHQmny7O6+n9pD3ggTWd9SFiYbUEaJLl5Z9bMQMXuLcWwIXFAPg5HxUyJpYH
 txnN/I0sXwBD0z5jdEn54LIP+GEHICb/j8Yaq78hRYGOArzhZAQ+r68E5XlZIS+O78BFS1xzZY9
 ltqWyPf0C4Zumh1mO9qOBgQlebQ8EONbHoMYGz28zeJ7TnZkMJFJq+H1HveCyLzZFi1edpQMKkk
 HRGHRzZVHHShjXsnhoHi85xkEQvfSkkr2CFoAdnRHciUOMe1zNtvgbGV/4/zdetccPsOUOy7Kdt
 TXkhQPLWpcP+PbMZ0uUx6vJupqVOCX1uRUT42IPailjPLaj1J6XVeUxCOAWqEUlSg5TiLPS0RkM
 /ziFn8j5bqDVM1EWVyU+nqNBW686sDyWp/iTgbqDNz4jlTDgyP8mThb2Xmt7VBj7/GDc04asHPG
 gekSsfoZntI57GtwAevT3aUTWvouikCjlJxdB0ur4DmnXJP1EsJuRFHAFSXLQ/VOY+6qIM3rCrF
 FT8aqSLteGiSY5fO8UhwjVBt42Cvwb2DvM+n6iO7Gp39rFRqFXjCFzbK2UunuecvfpHdyI5kvBV
 FhHtdLLRykiy4RQ==
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
 fs/nfsd/nfs4callback.c | 108 ++++++++++++++++++++++++++++++++++---------------
 fs/nfsd/nfs4state.c    |  11 +++--
 fs/nfsd/state.h        |  15 ++++---
 fs/nfsd/trace.h        |   2 +-
 4 files changed, 94 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index e38fa834b3d91333acf1425eb14c644e5d5f2601..04b52ae182fc55659662232712a2439fb9a3b95a 100644
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
@@ -1211,28 +1245,39 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
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
@@ -1249,8 +1294,8 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
 }
 
 /*
- * TODO: cb_sequence should support referring call lists, cachethis, multiple
- * slots, and mark callback channel down on communication errors.
+ * TODO: cb_sequence should support referring call lists, cachethis,
+ * and mark callback channel down on communication errors.
  */
 static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 {
@@ -1292,7 +1337,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		return true;
 	}
 
-	if (!cb->cb_holds_slot)
+	if (cb->cb_held_slot < 0)
 		goto need_restart;
 
 	/* This is the operation status code for CB_SEQUENCE */
@@ -1306,10 +1351,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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
@@ -1335,17 +1380,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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
@@ -1565,7 +1609,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
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

-- 
2.47.0


