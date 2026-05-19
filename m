Return-Path: <linux-nfs+bounces-21710-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Nd3FximDGq8jwUAu9opvQ
	(envelope-from <linux-nfs+bounces-21710-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 20:04:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B258366F
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 20:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3A9C308500E
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF518313E1D;
	Tue, 19 May 2026 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VdIwA+CR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536431FFC48;
	Tue, 19 May 2026 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213733; cv=none; b=FZSMUUDqH9h510ePCLPX73vp9g2nBjYtVuG4YUbdvrdByD7O2mHTHvFWeFyL+DcB4C+2E7gSEHlJ+jeVSTtap5ABrQHB2o6aZBx3G46lnyxUldE5aC4NavS//+Otz7pmIinRsbNg8jq4C7VBhdMeVKpxFE3XRY75Eqv4o9yG7hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213733; c=relaxed/simple;
	bh=hoRk7B7PLGBenK4M8QDRC35ahaVrj3bUrQLG9NX4u4U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZUyUSt0eEF7X5dNIy+B+EY8Agz19MVoJDT8qTGskkBpJec0PWgSVezPdtFxfPuawc4CUmMKg2e5q49euSVctJ8cx/vOR59vc05S9DaeAy02SbyjjF14B1W8Y9MSR3XE0GqK6vzjjhC/IgwiS9bAnGOFICRQUNW0a0Qnp+UGnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VdIwA+CR; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64JHeZ2n3322431;
	Tue, 19 May 2026 11:02:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=sl1HDM51VXPy60wPrewLZtWMpmGJvrEcHcbipQdsBGg=; b=VdIwA+CRlufm
	vZgEZPh1HP1TDU6UC/8fyWWJABzFYk07xNKZiTfgmqXyLormGThrgEAbpMS4h0AO
	8vJAOnmTWXKAGCgKCNLqdMXWHCU4XihsxGfM6MUtff98Zij91AS5JbuWTN3fFso7
	1cAy3+AukHJghcAsym7BLlQ5Hu8ouSuLjSIJiBT7ExwaXy/0nB3v+dBrUiniXZ3Y
	uTGUpzESpBK7i+/w1L7Xdp1VHPZmd9jXWLAowRqNhJN5iX7cCz+gqiy+N+YDRSX9
	Y+nqPTYSR6RXLAAel0BLn3ayobeF9WMMXxCa515SS7jth9HCSqk8iqv+Hr1gP8TM
	yWhS/i3YSw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4e8vfar50k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 19 May 2026 11:02:06 -0700 (PDT)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 18:01:38 +0000
From: Chris Mason <clm@meta.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust
	<trondmy@gmail.com>, <linux-nfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] nfsd: clear cl_cb_session on DESTROY_SESSION
Date: Tue, 19 May 2026 10:49:14 -0700
Message-ID: <20260519180032.1852793-3-clm@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519180032.1852793-2-clm@meta.com>
References: <20260519180032.1852793-2-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sR952mFmRxXUi5ZUbgBH1shOL1Ru0qPz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3OSBTYWx0ZWRfX9hyzjy9IIo4z
 e6A4UpaxeC/iGpYhcRK1A6+9ODv1bMnqtYTFMy/W13wszWJk38upS7AUOT1tzIa3GN+OahyOUr9
 1xy8t1rDkOij0O7+qdGETIr6qb+Z5w3nHJWfTXvhzJZ0VNLuoXGltyatDck/j7eZdvWCmwgEv8x
 mAjr2y6tXk1TaA3KVcSve+MhE0iwKbBmCubDKuAo7FS78FpaBjqYwxXk27g+w6yw7UNJT94NVkr
 3oNb/9oGH8OW9KH00nSaRJc8A9695fTtJpYo5yYsoqlKynITZCNEjq0O/HtxbFtTswvv4yWLxIB
 Gl3dwWyIypnTrVvAKqHGTx8kxstZlyAqgz3bWE2xFdrSPa/dz1S7t/mbZRsaRMCmnrm9cO/vj8t
 XNOMLv5ktEuvFsKx/OSUaFugysx51kAHKHf6Y1EmY2CVoxzMKbqrnIfDNn0r21emaxxSfL0L7MM
 eF5n1Z2reHV/pJ7WyKA==
X-Authority-Analysis: v=2.4 cv=SORykuvH c=1 sm=1 tr=0 ts=6a0ca59e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VabnemYjAAAA:8 a=r6otxb-GsYeldv4tpOwA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: sR952mFmRxXUi5ZUbgBH1shOL1Ru0qPz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21710-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,fieldses.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,meta.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A07B258366F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The parent commit drains in-flight backchannel callbacks before
nfsd4_destroy_session() frees the session, which closes the primary
use-after-free.  clp->cl_cb_session still caches the freed pointer
though: no destroy, expire, or shutdown path clears it, so the
stale value survives until the next CREATE_SESSION overwrites it.

A backchannel dispatch that races in during that window dereferences
the freed session through one of three helpers:

    nfsd41_cb_get_slot()
      ses = clp->cl_cb_session;
      grab_slot(ses);             /* deref */

    nfsd41_cb_release_slot()
      ses = clp->cl_cb_session;
      spin_lock(&ses->se_lock);   /* deref */

    nfsd4_cb_sequence_done()
      session = cb->cb_clp->cl_cb_session;
      session->se_cb_seq_nr[...]; /* deref */

Fix by clearing the cached pointer in nfsd4_destroy_session() after
the inflight drain returns, under clp->cl_lock and only when the
session being destroyed is still the active backchannel session.
Pair the store with READ_ONCE() loads and NULL checks in the three
helpers so each takes its early-return / requeue path.

The encode and decode helpers also read cl_cb_session but only from
in-flight RPCs, which nfsd4_probe_callback_sync() has already
quiesced; the nfsd41_cb_get_slot() NULL check then blocks any new
RPC from acquiring a slot, so no fresh CB can reach encode/decode.
Without the WRITE_ONCE() store the NULL guards would be unreachable.

Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/nfs4callback.c | 24 ++++++++++++++++--------
 fs/nfsd/nfs4state.c    | 14 ++++++++++++++
 fs/nfsd/trace.h        | 35 ++++++++++++++++++++---------------
 3 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 50827405468d..8af2d0cc37c2 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1150,9 +1150,11 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 	} else {
 		if (!conn->cb_xprt || !ses)
 			return -EINVAL;
-		clp->cl_cb_session = ses;
+		spin_lock(&clp->cl_lock);
+		WRITE_ONCE(clp->cl_cb_session, ses);
+		spin_unlock(&clp->cl_lock);
 		args.bc_xprt = conn->cb_xprt;
-		args.prognumber = clp->cl_cb_session->se_cb_prog;
+		args.prognumber = ses->se_cb_prog;
 		args.protocol = conn->cb_xprt->xpt_class->xcl_ident |
 				XPRT_TRANSPORT_BC;
 		args.authflavor = ses->se_cb_sec.flavor;
@@ -1278,10 +1280,12 @@ static int grab_slot(struct nfsd4_session *ses)
 static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
 {
 	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd4_session *ses = clp->cl_cb_session;
+	struct nfsd4_session *ses = READ_ONCE(clp->cl_cb_session);
 
 	if (cb->cb_held_slot >= 0)
 		return true;
+	if (!ses)
+		return false;
 	cb->cb_held_slot = grab_slot(ses);
 	if (cb->cb_held_slot < 0) {
 		rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
@@ -1297,12 +1301,14 @@ static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
 static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd4_session *ses = clp->cl_cb_session;
+	struct nfsd4_session *ses = READ_ONCE(clp->cl_cb_session);
 
 	if (cb->cb_held_slot >= 0) {
-		spin_lock(&ses->se_lock);
-		ses->se_cb_slot_avail |= BIT(cb->cb_held_slot);
-		spin_unlock(&ses->se_lock);
+		if (ses) {
+			spin_lock(&ses->se_lock);
+			ses->se_cb_slot_avail |= BIT(cb->cb_held_slot);
+			spin_unlock(&ses->se_lock);
+		}
 		cb->cb_held_slot = -1;
 		rpc_wake_up_next(&clp->cl_cb_waitq);
 	}
@@ -1442,9 +1448,11 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 /* Returns true if CB_COMPOUND processing should continue */
 static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
 {
-	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
+	struct nfsd4_session *session = READ_ONCE(cb->cb_clp->cl_cb_session);
 	bool ret = false;
 
+	if (!session)
+		goto requeue;
 	if (cb->cb_held_slot < 0)
 		goto requeue;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6837b63d9864..563af61796e3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4281,6 +4281,20 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
 
 	nfsd4_probe_callback_sync(ses->se_client);
 
+	/*
+	 * The inflight drain inside nfsd4_probe_callback_sync() guarantees
+	 * that no backchannel RPC still references @ses.  Clear the client's
+	 * cached backchannel session pointer so any callback that races in
+	 * after this point (e.g. via a freshly re-established backchannel)
+	 * cannot dereference the about-to-be-freed session.  The matching
+	 * READ_ONCE() NULL checks live in nfsd41_cb_get_slot(),
+	 * nfsd41_cb_release_slot() and nfsd4_cb_sequence_done().
+	 */
+	spin_lock(&ses->se_client->cl_lock);
+	if (ses->se_client->cl_cb_session == ses)
+		WRITE_ONCE(ses->se_client->cl_cb_session, NULL);
+	spin_unlock(&ses->se_client->cl_lock);
+
 	spin_lock(&nn->client_lock);
 	status = nfs_ok;
 out_put_session:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 5ad38f50836d..db9b10978b2d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1742,17 +1742,19 @@ TRACE_EVENT(nfsd_cb_seq_status,
 	),
 	TP_fast_assign(
 		const struct nfs4_client *clp = cb->cb_clp;
-		const struct nfsd4_session *session = clp->cl_cb_session;
-		const struct nfsd4_sessionid *sid =
-			(struct nfsd4_sessionid *)&session->se_sessionid;
+		const struct nfsd4_session *session =
+			READ_ONCE(clp->cl_cb_session);
+		const struct nfsd4_sessionid *sid = session ?
+			(struct nfsd4_sessionid *)&session->se_sessionid :
+			NULL;
 
 		__entry->task_id = task->tk_pid;
 		__entry->client_id = task->tk_client ?
 				     task->tk_client->cl_clid : -1;
-		__entry->cl_boot = sid->clientid.cl_boot;
-		__entry->cl_id = sid->clientid.cl_id;
-		__entry->seqno = sid->sequence;
-		__entry->reserved = sid->reserved;
+		__entry->cl_boot = sid ? sid->clientid.cl_boot : 0;
+		__entry->cl_id = sid ? sid->clientid.cl_id : 0;
+		__entry->seqno = sid ? sid->sequence : 0;
+		__entry->reserved = sid ? sid->reserved : 0;
 		__entry->tk_status = task->tk_status;
 		__entry->seq_status = cb->cb_seq_status;
 	),
@@ -1782,18 +1784,21 @@ TRACE_EVENT(nfsd_cb_free_slot,
 	),
 	TP_fast_assign(
 		const struct nfs4_client *clp = cb->cb_clp;
-		const struct nfsd4_session *session = clp->cl_cb_session;
-		const struct nfsd4_sessionid *sid =
-			(struct nfsd4_sessionid *)&session->se_sessionid;
+		const struct nfsd4_session *session =
+			READ_ONCE(clp->cl_cb_session);
+		const struct nfsd4_sessionid *sid = session ?
+			(struct nfsd4_sessionid *)&session->se_sessionid :
+			NULL;
 
 		__entry->task_id = task->tk_pid;
 		__entry->client_id = task->tk_client ?
 				     task->tk_client->cl_clid : -1;
-		__entry->cl_boot = sid->clientid.cl_boot;
-		__entry->cl_id = sid->clientid.cl_id;
-		__entry->seqno = sid->sequence;
-		__entry->reserved = sid->reserved;
-		__entry->slot_seqno = session->se_cb_seq_nr[cb->cb_held_slot];
+		__entry->cl_boot = sid ? sid->clientid.cl_boot : 0;
+		__entry->cl_id = sid ? sid->clientid.cl_id : 0;
+		__entry->seqno = sid ? sid->sequence : 0;
+		__entry->reserved = sid ? sid->reserved : 0;
+		__entry->slot_seqno = session ?
+			session->se_cb_seq_nr[cb->cb_held_slot] : 0;
 	),
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
 		" sessionid=%08x:%08x:%08x:%08x new slot seqno=%u",
-- 
2.52.0


