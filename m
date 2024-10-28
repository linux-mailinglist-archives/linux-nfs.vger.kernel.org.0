Return-Path: <linux-nfs+bounces-7533-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835629B3375
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 15:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13EE71F2517F
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2708E1DE2A8;
	Mon, 28 Oct 2024 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5OnrHyp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F951DDC3F;
	Mon, 28 Oct 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125598; cv=none; b=K+r/2WjVyIZAP5E0KcFa3Vl9uJq5DMukGT2HKO0sTAiGZOr/eD1nJI5EAtUIVSUrmIug4hCqkNk6y+sBOM25LLy0LX9eYeqiMVGbkseuJ0DUrW70N7iZXSDIew6nUQwJc6Ygag57o8KPJX9wyx+2Hg/gqsL6DsWrCZ4DPeFlpDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125598; c=relaxed/simple;
	bh=4T01MJC1R4biwK9P5GHFBAS6IjOVGH2oG2p6hUG0Q4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T5iMx7xUWOJfkGB5yb+PvwBibfx4OK4p6IWNqR0tL+Di+eGdfJODXNRJt6uAw+wPeMrPPhxMJWT1qmzHUC9SJlypOSSH77EdWTFBb/Fx9UwilWY8HJ7tP8J44fplimBTX7wKIip3K7I1QmE5YtR+r46h6gJjC2MH08tNoDEMZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5OnrHyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8659C4CEC3;
	Mon, 28 Oct 2024 14:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730125597;
	bh=4T01MJC1R4biwK9P5GHFBAS6IjOVGH2oG2p6hUG0Q4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V5OnrHypJo6ZEFBfyDaRK8DHLqdV0bATWOn6t3/P8FWVkBIk7OyCkzmZ5Dtc8RIuA
	 IVfsx0FMKDbGbJZBch8Vwlx/vnnyRi8cnRGySSVLINBofbb29CWssaFKD/QgvdIYj1
	 Kd87CZl+YivwSBxPbISi/WHtxaAhXBJ/csjbVBnTQbX8jGDFG01qrfdHajHA5cYwoG
	 auTKEaQrZprIS0iMnxT19vKzewpPJ3C6/dgeCt9Sk+/dxCku5eSckh34VFj2Ely8NA
	 qFElD7AhkUlaKuEUssLZMFdlBMHQF9nqAR9PLud9wv/6fGA98zWrdfDd3tJAooa06J
	 fRGIS7ro5xxRQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 28 Oct 2024 10:26:27 -0400
Subject: [PATCH 2/2] nfsd: allow for more callback session slots
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-bcwide-v1-2-0e75a8219dc0@kernel.org>
References: <20241028-bcwide-v1-0-0e75a8219dc0@kernel.org>
In-Reply-To: <20241028-bcwide-v1-0-0e75a8219dc0@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11100; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4T01MJC1R4biwK9P5GHFBAS6IjOVGH2oG2p6hUG0Q4Y=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnH58aM0YriuUyMPphXOrKMpjHe9/StWPP2YmVz
 Nb9pgSsUc6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZx+fGgAKCRAADmhBGVaC
 FSl1EACI6YYKDnKEct893GY2eyZOMExcRSE2HzuW46C8Y4/b3TOI0wGup84g7R8G0/FKNUyumWq
 xvw/9Nbg0KFVy70CW93WpKoMQYjPw2JJDVDNCCRX8uSvNY84b4EIXdkcG3DZk2neObWyN28AYP1
 WGfG2gMU+3Takej3mN/qG3hBRYIcAx8virkWvJ3a0qx4tUep3eZVnv78K5SuBuZOl8FrUmtdzMe
 eJXzrURzPw6UL008dlqb7jY9If7AsM1pzPibhgD0oOHsShdw+Njdn/jNS2L+qPcGk19esOofs8q
 1Qsilb6EFZGstOtGAJOc9wCm+JvMtjhXZVbnjvEZhI764Ng2fvpasvqb82s/bxqoiLCjZXVAAyf
 2Ev3ls2ZUij39KxEiEwzRAMLAazO2MugEJ5F6n4fCB0sqqrKrCA2DN90uQnCh/njpb2qo+uDpud
 igw8ewxac0gpXdbomlcHot2BmBK0PzqDCIwhghelHS2UAX0uUYJWVM8GbAnmSpvzIIMAnCrjVQZ
 MA+ZvvOubP/3gOukEvD5KUt0H7nuMl133ABlUa7uF25AcCNNfqAskIznmVehF4ptUyGzF4oA0Fx
 vsCTmjcTDTTt2gh40MHp/JpSdNpWhcSVPjb69N0yRw27JkPSGT/JmzWwRZa3qO/iAU2PIQjO6ji
 Ahiu52ajR/tZ//Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

nfsd currently only uses a single slot in the callback channel, which is
proving to be a bottleneck in some cases. Widen the callback channel to
a max of 32 slots (subject to the client's target_maxreqs value).

Change the cb_holds_slot boolean to an integer that tracks the current
slot number (with -1 meaning "unassigned").  Move the callback slot
tracking info into the session. Add a new u32 that acts as a bitmap to
track which slots are in use, and a u32 to track the latest callback
target_slotid that the client reports. While they are part of the
session, the fields are protected by the cl_lock.

Fix nfsd41_cb_get_slot to always search for the lowest slotid (using
ffs()), and change it to continually retry until there is a slot
available.

Finally, convert the session->se_cb_seq_nr field into an array of
counters and add the necessary handling to ensure that the seqids get
reset at the appropriate times.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 107 +++++++++++++++++++++++++++++++++++--------------
 fs/nfsd/nfs4state.c    |   7 +++-
 fs/nfsd/state.h        |  12 +++---
 fs/nfsd/trace.h        |   2 +-
 4 files changed, 89 insertions(+), 39 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index e38fa834b3d91333acf1425eb14c644e5d5f2601..64b85b164125b244494f9805840a0d8a1ccb4c1b 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -406,6 +406,16 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
 	hdr->nops++;
 }
 
+static u32 highest_unset_index(u32 word)
+{
+	int i;
+
+	for (i = sizeof(word) * 8 - 1; i > 0; --i)
+		if (!(word & BIT(i)))
+			return i;
+	return 0;
+}
+
 /*
  * CB_SEQUENCE4args
  *
@@ -432,15 +442,38 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
 	encode_sessionid4(xdr, session);
 
 	p = xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
-	*p++ = cpu_to_be32(session->se_cb_seq_nr);	/* csa_sequenceid */
-	*p++ = xdr_zero;			/* csa_slotid */
-	*p++ = xdr_zero;			/* csa_highest_slotid */
+	*p++ = cpu_to_be32(session->se_cb_seq_nr[cb->cb_held_slot]);	/* csa_sequenceid */
+	*p++ = cpu_to_be32(cb->cb_held_slot);		/* csa_slotid */
+	*p++ = cpu_to_be32(max(highest_unset_index(session->se_cb_slot_avail),
+			       session->se_cb_highest_slot)); /* csa_highest_slotid */
 	*p++ = xdr_zero;			/* csa_cachethis */
 	xdr_encode_empty_array(p);		/* csa_referring_call_lists */
 
 	hdr->nops++;
 }
 
+static void update_cb_slot_table(struct nfsd4_session *ses, u32 highest)
+{
+	/* No need to do anything if nothing changed */
+	if (likely(highest == READ_ONCE(ses->se_cb_highest_slot)))
+		return;
+
+	spin_lock(&ses->se_client->cl_lock);
+	/* If growing the slot table, reset any new sequences to 1 */
+	if (highest > ses->se_cb_highest_slot) {
+		int i;
+
+		for (i = ses->se_cb_highest_slot; i <= highest; ++i) {
+			/* beyond the end of the array? */
+			if (i >= NFSD_BC_SLOT_TABLE_MAX)
+				break;
+			ses->se_cb_seq_nr[i] = 1;
+		}
+	}
+	ses->se_cb_highest_slot = highest;
+	spin_unlock(&ses->se_client->cl_lock);
+}
+
 /*
  * CB_SEQUENCE4resok
  *
@@ -485,7 +518,7 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
 	p += XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
 
 	dummy = be32_to_cpup(p++);
-	if (dummy != session->se_cb_seq_nr) {
+	if (dummy != session->se_cb_seq_nr[cb->cb_held_slot]) {
 		dprintk("NFS: %s Invalid sequence number\n", __func__);
 		goto out;
 	}
@@ -496,9 +529,15 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
 		goto out;
 	}
 
-	/*
-	 * FIXME: process highest slotid and target highest slotid
-	 */
+	p++; // ignore current highest slot value
+
+	dummy = be32_to_cpup(p++);
+	if (dummy == 0) {
+		dprintk("NFS: %s Invalid target highest slotid\n", __func__);
+		goto out;
+	}
+
+	update_cb_slot_table(session, dummy);
 	status = 0;
 out:
 	cb->cb_seq_status = status;
@@ -1208,31 +1247,38 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
  * If the slot is available, then mark it busy.  Otherwise, set the
  * thread for sleeping on the callback RPC wait queue.
  */
-static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
+static void nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
 {
 	struct nfs4_client *clp = cb->cb_clp;
+	struct nfsd4_session *ses = clp->cl_cb_session;
+	int idx;
 
-	if (!cb->cb_holds_slot &&
-	    test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
+	if (cb->cb_held_slot >= 0)
+		return;
+retry:
+	spin_lock(&clp->cl_lock);
+	idx = ffs(ses->se_cb_slot_avail) - 1;
+	if (idx < 0 || idx > ses->se_cb_highest_slot) {
+		spin_unlock(&clp->cl_lock);
 		rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
-		/* Race breaker */
-		if (test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
-			dprintk("%s slot is busy\n", __func__);
-			return false;
-		}
-		rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
+		goto retry;
 	}
-	cb->cb_holds_slot = true;
-	return true;
+	/* clear the bit for the slot */
+	ses->se_cb_slot_avail &= ~BIT(idx);
+	spin_unlock(&clp->cl_lock);
+	cb->cb_held_slot = idx;
 }
 
 static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
+	struct nfsd4_session *ses = clp->cl_cb_session;
 
-	if (cb->cb_holds_slot) {
-		cb->cb_holds_slot = false;
-		clear_bit(0, &clp->cl_cb_slot_busy);
+	if (cb->cb_held_slot >= 0) {
+		spin_lock(&clp->cl_lock);
+		ses->se_cb_slot_avail |= BIT(cb->cb_held_slot);
+		spin_unlock(&clp->cl_lock);
+		cb->cb_held_slot = -1;
 		rpc_wake_up_next(&clp->cl_cb_waitq);
 	}
 }
@@ -1265,8 +1311,8 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 	trace_nfsd_cb_rpc_prepare(clp);
 	cb->cb_seq_status = 1;
 	cb->cb_status = 0;
-	if (minorversion && !nfsd41_cb_get_slot(cb, task))
-		return;
+	if (minorversion)
+		nfsd41_cb_get_slot(cb, task);
 	rpc_call_start(task);
 }
 
@@ -1292,7 +1338,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		return true;
 	}
 
-	if (!cb->cb_holds_slot)
+	if (cb->cb_held_slot < 0)
 		goto need_restart;
 
 	/* This is the operation status code for CB_SEQUENCE */
@@ -1306,10 +1352,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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
@@ -1335,17 +1381,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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
@@ -1565,7 +1610,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
 	cb->cb_status = 0;
 	cb->cb_need_restart = false;
-	cb->cb_holds_slot = false;
+	cb->cb_held_slot = -1;
 }
 
 /**
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5b718b349396f1aecd0ad4c63b2f43342841bbd4..20a0d40202e40eed1c84d5d6c0a85b908804a6ba 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2002,6 +2002,8 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	}
 
 	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
+	new->se_cb_slot_avail = ~0U;
+	new->se_cb_highest_slot = battrs->maxreqs - 1;
 	return new;
 out_free:
 	while (i--)
@@ -2132,7 +2134,9 @@ static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, stru
 
 	INIT_LIST_HEAD(&new->se_conns);
 
-	new->se_cb_seq_nr = 1;
+	for (idx = 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx)
+		new->se_cb_seq_nr[idx] = 1;
+
 	new->se_flags = cses->flags;
 	new->se_cb_prog = cses->callback_prog;
 	new->se_cb_sec = cses->cb_sec;
@@ -3159,7 +3163,6 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	kref_init(&clp->cl_nfsdfs.cl_ref);
 	nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB_NULL);
 	clp->cl_time = ktime_get_boottime_seconds();
-	clear_bit(0, &clp->cl_cb_slot_busy);
 	copy_verf(clp, verf);
 	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
 	clp->cl_cb_session = NULL;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 41cda86fea1f6166a0fd0215d3d458c93ced3e6a..2987c362bdd56251e736879dc89302ada2259be8 100644
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
 
+/* Max number of slots that the server will use in the backchannel */
+#define NFSD_BC_SLOT_TABLE_MAX	32
+
 /*
  * Representation of a v4.1+ session. These are refcounted in a similar fashion
  * to the nfs4_client. References are only taken when the server is actively
@@ -325,7 +328,9 @@ struct nfsd4_session {
 	struct nfsd4_cb_sec	se_cb_sec;
 	struct list_head	se_conns;
 	u32			se_cb_prog;
-	u32			se_cb_seq_nr;
+	u32			se_cb_slot_avail; /* bitmap of available slots */
+	u32			se_cb_highest_slot;	/* highest slot client wants */
+	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_MAX];
 	struct nfsd4_slot	*se_slots[];	/* forward channel slots */
 };
 
@@ -459,9 +464,6 @@ struct nfs4_client {
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


