Return-Path: <linux-nfs+bounces-22100-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AbNIgjkGmqS9ggAu9opvQ
	(envelope-from <linux-nfs+bounces-22100-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:20:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9642060CEE6
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D79453012858
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 13:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCD73C3C03;
	Sat, 30 May 2026 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHUnqbMJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204E3C345C;
	Sat, 30 May 2026 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780147177; cv=none; b=BEp/0xyqlKydbwugCFKL29JkbM+dkcSrZ28VO/Qp/CK8QcMcM8+SA6Cr5sWh1oHiJoXRn0fl+WmTD/sH3l83rcwJluhPnyo8JXClHT7tKz+4+EM8Kwb+1goXyB7IaPH5i+/qm7U09Ppsp9Y5hfLavB6u6M08GfnEiAOvwnrrQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780147177; c=relaxed/simple;
	bh=ok1w8ZTu0tkWmH62kK8ep31jnlBHpnPUqz9WmL5buLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F82vJUGncleOqLDMTLDpQ/45U6Ha/ENQfBRM2S/gbjGQ1uu4OiDpqqIFfcTrDhnsHQI2uWhnFgM0Dw4oSymQ0t9km3V3L/wg+/+vhO02GwY/ZbJ3uY1UI6xW3omlxmwrJLkMQ/2qvfMjLpu5uu7PZoGKuqt5uuUStBT8YhHHsrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHUnqbMJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D281F00893;
	Sat, 30 May 2026 13:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780147175;
	bh=Y/VxR1pWFM9uFscNT3GTwp//s18dYkhn16+UtFw+ppo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fHUnqbMJ4uLwWxQ1QgE4oaPTMnofbhcBnI/RXpHxMNTy1ALStveWir7kabpgP7YSX
	 gTij/z9CcSx1gSoHpCgvF77tZBYwu2/DtznZYJlbksBVYqZ+1zITlcJ/yMS6N6R0kU
	 ui8loKO20lTAhNz8D7osDJeJQm8SD72ZTKMx6n60mvXHPDSwPh5pgswMXcD/2np3JC
	 G9rb5NahOerz3c3Wc3bT4OJOD+9YLCNfsO9v+iFFwlIRuwiaiWfdNAe1wkflz0RLTG
	 kvjQtCtTPwn3OWgOQ5jfhOihqPHGVtAeDuJTrqwyAIO5S9A5lbKMMzat8hAGaSoznv
	 FUcu7HZeeG4og==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 30 May 2026 09:19:18 -0400
Subject: [PATCH v2 2/9] nfsd: RCU-protect cl_cb_session to fix
 use-after-free on session teardown
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260530-nfsd-fixes-v2-2-f27e8eb4d974@kernel.org>
References: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
In-Reply-To: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Scott Mayhew <smayhew@redhat.com>, 
 Trond Myklebust <Trond.Myklebust@netapp.com>, 
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>, 
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14826; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ok1w8ZTu0tkWmH62kK8ep31jnlBHpnPUqz9WmL5buLU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGuPh54Zi7bh3dN1/g0uwKVDMKDxuEKd+Pb96X
 pDZvw/rPXGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahrj4QAKCRAADmhBGVaC
 FRsxEADLGo9wg3Txo8Zs0UlfTK0uaZTn/UWClyoAdK2ETPNRwnoB8dt1XXuXlVBaRFg0SuRfxKP
 PowVj/QM+yQl/kuvhYGMfsMq57nK3b7qH+lhLYZohWZZkmfyMQOR2Aa5ND3QPFferrofNIbppzM
 q0AX3v5rqsM76Dj9kpU+U9NdYBThdJvA8P4LuYl6JQaQ73ViQSHsRVFodPDmV9ea3ymbAJ6aRxu
 cOb881BRYKyF9l+e5BgHd0Zdvc1Y/k96m4ttU8IAvr3xjqsyDOgmE8izLzSp+c9n0f4POamIl3P
 CBMzdCZeNm7kzsd34LcNIKg8dTLWRBEOEeip05EaRZ+ZbmSmks9/c/CUBksmubklKv4ZHfnnnvF
 xzIb57kF6KBZjBVuuWwGGI9hE/yTDe4ihTzU40U9mUuYKWEFZSvI39MNnNKJD8oruNPYEJZxaYR
 mab8awJ7EIl22dul0+oIYia7z7fmMqZAP/LKBPkgaZ0irU/xlGjDJrguAnnR6SJds7y/kYiRmYp
 tQlMnVqVHarDgHju+7U2WJYBjFu5yUdsDrTxsjKTdMpge2IuiG++LoxigGBCjqPwVDGVhUgL9p3
 nHrVP+fyIx/AVmyjJ66x1uplio01uuLwr2mxOkqxPXltGM3Xlw4bllnXtJ6U0fJohf/QGunRLum
 eacz4pjkMxELENw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22100-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9642060CEE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After a DESTROY_SESSION the per-session teardown path can free a
session while rpciod still holds an inflight callback rpc_task that
dereferences clp->cl_cb_session.  nfsd4_probe_callback_sync() flushes
cl_callback_wq, but once nfsd4_run_cb_work() has called
rpc_call_async() the rpc_task lives on rpciod; flushing the workqueue
does not wait for it.  rpc_shutdown_client() does drain rpciod tasks,
but uses a 1-second wait_event_timeout — tasks stuck in rpc_delay()
(e.g. 2-second NFS4ERR_DELAY retries) can outlive the drain.

    destroy path                       rpciod
    ------------                       ------
    unhash_session(ses)
    nfsd4_probe_callback_sync(clp)
      flush_workqueue(cl_callback_wq)
      /* returns; rpc_task still live */
    nfsd4_put_session_locked(ses)
    free_session(ses) -> kfree(ses)
                                       nfsd4_cb_sequence_done()
                                         reads cb_clp->cl_cb_session
                                         /* freed slab */

A second window exists in nfsd4_process_cb_update().  When
__nfsd4_find_backchannel() returns NULL because unhash_session() has
already removed the destroyed session from cl_sessions,
setup_callback_client() takes the v4.1 early return so
clp->cl_cb_session = ses never fires and the field retains a pointer
to the about-to-be-freed session.

Fix both by converting cl_cb_session to an RCU-protected pointer:

  - Move the cl_cb_session = ses assignment in setup_callback_client()
    to after rpc_create() succeeds, so it is only published when a
    working backchannel exists.  Clear cl_cb_session on the error
    return in nfsd4_process_cb_update().  Both stores use
    rcu_assign_pointer().

  - Annotate cl_cb_session with __rcu.  All rpciod-side readers use
    rcu_read_lock()/rcu_dereference() and check for NULL, bailing to
    the appropriate error or requeue path:
    encode_cb_sequence4args(), decode_cb_sequence4resok(),
    nfsd41_cb_get_slot(), nfsd41_cb_release_slot(),
    nfsd4_cb_prepare(), and nfsd4_cb_sequence_done().

  - Switch __free_session() from kfree() to kfree_rcu() so the
    session slab is not reclaimed until after an RCU grace period,
    guaranteeing that rpciod readers inside rcu_read_lock() never
    dereference freed memory.

  - Pass the session pointer to the nfsd_cb_seq_status and
    nfsd_cb_free_slot tracepoints instead of having them re-read
    cl_cb_session.

  - nfsd4_cb_prepare() calls rpc_exit() when the session is NULL,
    routing through the done/release path to requeue the callback.

Fixes: dcbeaa68dbbd ("nfsd4: allow backchannel recovery")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 109 ++++++++++++++++++++++++++++++++++++++++---------
 fs/nfsd/nfs4state.c    |   4 +-
 fs/nfsd/state.h        |   3 +-
 fs/nfsd/trace.h        |  14 +++----
 4 files changed, 100 insertions(+), 30 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 1964a213f80e..2eb2278dddd1 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -456,13 +456,20 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
 				    const struct nfsd4_callback *cb,
 				    struct nfs4_cb_compound_hdr *hdr)
 {
-	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
+	struct nfsd4_session *session;
 	struct nfsd4_referring_call_list *rcl;
 	__be32 *p;
 
 	if (hdr->minorversion == 0)
 		return;
 
+	rcu_read_lock();
+	session = rcu_dereference(cb->cb_clp->cl_cb_session);
+	if (!session) {
+		rcu_read_unlock();
+		return;
+	}
+
 	encode_nfs_cb_opnum4(xdr, OP_CB_SEQUENCE);
 	encode_sessionid4(xdr, session);
 
@@ -478,6 +485,7 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
 		encode_referring_call_list4(xdr, rcl);
 
 	hdr->nops++;
+	rcu_read_unlock();
 }
 
 static void update_cb_slot_table(struct nfsd4_session *ses, u32 target)
@@ -529,21 +537,32 @@ static void update_cb_slot_table(struct nfsd4_session *ses, u32 target)
 static int decode_cb_sequence4resok(struct xdr_stream *xdr,
 				    struct nfsd4_callback *cb)
 {
-	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
+	struct nfsd4_session *session;
 	int status = -ESERVERFAULT;
 	__be32 *p;
 	u32 seqid, slotid, target;
 
+	rcu_read_lock();
+	session = rcu_dereference(cb->cb_clp->cl_cb_session);
+	if (!session) {
+		rcu_read_unlock();
+		cb->cb_seq_status = -NFS4ERR_BADSESSION;
+		return -NFS4ERR_BADSESSION;
+	}
+
 	/*
 	 * If the server returns different values for sessionID, slotID or
 	 * sequence number, the server is looney tunes.
 	 */
 	p = xdr_inline_decode(xdr, NFS4_MAX_SESSIONID_LEN + 4 + 4 + 4 + 4);
-	if (unlikely(p == NULL))
+	if (unlikely(p == NULL)) {
+		rcu_read_unlock();
 		goto out_overflow;
+	}
 
 	if (memcmp(p, session->se_sessionid.data, NFS4_MAX_SESSIONID_LEN)) {
 		dprintk("NFS: %s Invalid session id\n", __func__);
+		rcu_read_unlock();
 		goto out;
 	}
 	p += XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
@@ -551,12 +570,14 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
 	seqid = be32_to_cpup(p++);
 	if (seqid != session->se_cb_seq_nr[cb->cb_held_slot]) {
 		dprintk("NFS: %s Invalid sequence number\n", __func__);
+		rcu_read_unlock();
 		goto out;
 	}
 
 	slotid = be32_to_cpup(p++);
 	if (slotid != cb->cb_held_slot) {
 		dprintk("NFS: %s Invalid slotid\n", __func__);
+		rcu_read_unlock();
 		goto out;
 	}
 
@@ -564,6 +585,7 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
 
 	target = be32_to_cpup(p++);
 	update_cb_slot_table(session, target);
+	rcu_read_unlock();
 	status = 0;
 out:
 	cb->cb_seq_status = status;
@@ -1205,9 +1227,8 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 	} else {
 		if (!conn->cb_xprt || !ses)
 			return -EINVAL;
-		clp->cl_cb_session = ses;
 		args.bc_xprt = conn->cb_xprt;
-		args.prognumber = clp->cl_cb_session->se_cb_prog;
+		args.prognumber = ses->se_cb_prog;
 		args.protocol = conn->cb_xprt->xpt_class->xcl_ident |
 				XPRT_TRANSPORT_BC;
 		args.authflavor = ses->se_cb_sec.flavor;
@@ -1225,8 +1246,10 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 		return -ENOMEM;
 	}
 
-	if (clp->cl_minorversion != 0)
+	if (clp->cl_minorversion != 0) {
 		clp->cl_cb_conn.cb_xprt = conn->cb_xprt;
+		rcu_assign_pointer(clp->cl_cb_session, ses);
+	}
 	clp->cl_cb_client = client;
 	clp->cl_cb_cred = cred;
 	rcu_read_lock();
@@ -1333,18 +1356,33 @@ static int grab_slot(struct nfsd4_session *ses)
 static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
 {
 	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd4_session *ses = clp->cl_cb_session;
+	struct nfsd4_session *ses;
 
 	if (cb->cb_held_slot >= 0)
 		return true;
+
+	rcu_read_lock();
+	ses = rcu_dereference(clp->cl_cb_session);
+	if (!ses) {
+		rcu_read_unlock();
+		rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
+		return false;
+	}
 	cb->cb_held_slot = grab_slot(ses);
 	if (cb->cb_held_slot < 0) {
+		rcu_read_unlock();
 		rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
 		/* Race breaker */
-		cb->cb_held_slot = grab_slot(ses);
+		rcu_read_lock();
+		ses = rcu_dereference(clp->cl_cb_session);
+		if (ses)
+			cb->cb_held_slot = grab_slot(ses);
+		rcu_read_unlock();
 		if (cb->cb_held_slot < 0)
 			return false;
 		rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
+	} else {
+		rcu_read_unlock();
 	}
 	return true;
 }
@@ -1352,12 +1390,17 @@ static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
 static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd4_session *ses = clp->cl_cb_session;
+	struct nfsd4_session *ses;
 
 	if (cb->cb_held_slot >= 0) {
-		spin_lock(&ses->se_lock);
-		ses->se_cb_slot_avail |= BIT(cb->cb_held_slot);
-		spin_unlock(&ses->se_lock);
+		rcu_read_lock();
+		ses = rcu_dereference(clp->cl_cb_session);
+		if (ses) {
+			spin_lock(&ses->se_lock);
+			ses->se_cb_slot_avail |= BIT(cb->cb_held_slot);
+			spin_unlock(&ses->se_lock);
+		}
+		rcu_read_unlock();
 		cb->cb_held_slot = -1;
 		rpc_wake_up_next(&clp->cl_cb_waitq);
 	}
@@ -1489,22 +1532,35 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 	trace_nfsd_cb_rpc_prepare(clp);
 	cb->cb_seq_status = 1;
 	cb->cb_status = 0;
-	if (minorversion && !nfsd41_cb_get_slot(cb, task))
-		return;
+	if (minorversion) {
+		if (!rcu_access_pointer(clp->cl_cb_session)) {
+			rpc_exit(task, -EIO);
+			return;
+		}
+		if (!nfsd41_cb_get_slot(cb, task))
+			return;
+	}
 	rpc_call_start(task);
 }
 
 /* Returns true if CB_COMPOUND processing should continue */
 static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
 {
-	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
+	struct nfsd4_session *session;
 	bool ret = false;
 
 	if (cb->cb_held_slot < 0)
 		goto requeue;
 
+	rcu_read_lock();
+	session = rcu_dereference(cb->cb_clp->cl_cb_session);
+	if (!session) {
+		rcu_read_unlock();
+		goto requeue;
+	}
+
 	/* This is the operation status code for CB_SEQUENCE */
-	trace_nfsd_cb_seq_status(task, cb);
+	trace_nfsd_cb_seq_status(task, cb, session);
 	switch (cb->cb_seq_status) {
 	case 0:
 		/*
@@ -1536,12 +1592,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		fallthrough;
 	case -NFS4ERR_BADSESSION:
 		nfsd4_mark_cb_fault(cb->cb_clp);
+		rcu_read_unlock();
 		goto requeue;
 	case -NFS4ERR_DELAY:
 		cb->cb_seq_status = 1;
-		if (RPC_SIGNALLED(task) || !rpc_restart_call(task))
+		if (RPC_SIGNALLED(task) || !rpc_restart_call(task)) {
+			rcu_read_unlock();
 			goto requeue;
+		}
 		rpc_delay(task, 2 * HZ);
+		rcu_read_unlock();
 		return false;
 	case -NFS4ERR_SEQ_MISORDERED:
 	case -NFS4ERR_BADSLOT:
@@ -1553,11 +1613,13 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 */
 		nfsd4_mark_cb_fault(cb->cb_clp);
 		cb->cb_held_slot = -1;
+		rcu_read_unlock();
 		goto retry_nowait;
 	default:
 		nfsd4_mark_cb_fault(cb->cb_clp);
 	}
-	trace_nfsd_cb_free_slot(task, cb);
+	trace_nfsd_cb_free_slot(task, cb, session);
+	rcu_read_unlock();
 	nfsd41_cb_release_slot(cb);
 	return ret;
 retry_nowait:
@@ -1679,7 +1741,15 @@ static struct nfsd4_conn * __nfsd4_find_backchannel(struct nfs4_client *clp)
  * Note there isn't a lot of locking in this code; instead we depend on
  * the fact that it is run from clp->cl_callback_wq, which won't run two
  * work items at once.  So, for example, clp->cl_callback_wq handles all
- * access of cl_cb_client and all calls to rpc_create or rpc_shutdown_client.
+ * access of cl_cb_client, and all calls to rpc_create or
+ * rpc_shutdown_client.
+ *
+ * cl_cb_session is written only from cl_callback_wq (via
+ * rcu_assign_pointer) and read from rpciod under rcu_read_lock (via
+ * rcu_dereference) by encode_cb_sequence4args(), decode_cb_sequence4resok(),
+ * nfsd4_cb_sequence_done(), and the cb-slot helpers.  Sessions are freed
+ * with kfree_rcu() so that rpciod readers in an RCU read-side critical
+ * section never dereference a freed session.
  */
 static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 {
@@ -1731,6 +1801,7 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 		nfsd4_mark_cb_down(clp);
 		if (c)
 			svc_xprt_put(c->cn_xprt);
+		rcu_assign_pointer(clp->cl_cb_session, NULL);
 		return;
 	}
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f4d12dbcf97b..9503859918ac 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2397,7 +2397,7 @@ static void __free_session(struct nfsd4_session *ses)
 {
 	free_session_slots(ses, 0);
 	xa_destroy(&ses->se_slots);
-	kfree(ses);
+	kfree_rcu(ses, rcu_head);
 }
 
 static void free_session(struct nfsd4_session *ses)
@@ -3689,7 +3689,7 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	clp->cl_time = ktime_get_boottime_seconds();
 	copy_verf(clp, verf);
 	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
-	clp->cl_cb_session = NULL;
+	RCU_INIT_POINTER(clp->cl_cb_session, NULL);
 	clp->net = net;
 	clp->cl_nfsd_dentry = nfsd_client_mkdir(
 		nn, &clp->cl_nfsdfs,
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 62a5fe3f6cc0..c26b2384d694 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -440,6 +440,7 @@ struct nfsd4_session {
 	u16			se_slot_gen;
 	bool			se_dead;
 	u32			se_target_maxslots;
+	struct rcu_head		rcu_head;
 };
 
 /* formatted contents of nfs4_sessionid */
@@ -552,7 +553,7 @@ struct nfs4_client {
 #define NFSD4_CB_FAULT		3
 	int			cl_cb_state;
 	struct nfsd4_callback	cl_cb_null;
-	struct nfsd4_session	*cl_cb_session;
+	struct nfsd4_session	__rcu *cl_cb_session;
 
 	/* for all client information that callback code might need: */
 	spinlock_t		cl_lock;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d01496aa3cf8..9917c0440522 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1751,9 +1751,10 @@ DEFINE_NFSD_CB_LIFETIME_EVENT(bc_shutdown);
 TRACE_EVENT(nfsd_cb_seq_status,
 	TP_PROTO(
 		const struct rpc_task *task,
-		const struct nfsd4_callback *cb
+		const struct nfsd4_callback *cb,
+		const struct nfsd4_session *session
 	),
-	TP_ARGS(task, cb),
+	TP_ARGS(task, cb, session),
 	TP_STRUCT__entry(
 		__field(unsigned int, task_id)
 		__field(unsigned int, client_id)
@@ -1765,8 +1766,6 @@ TRACE_EVENT(nfsd_cb_seq_status,
 		__field(int, seq_status)
 	),
 	TP_fast_assign(
-		const struct nfs4_client *clp = cb->cb_clp;
-		const struct nfsd4_session *session = clp->cl_cb_session;
 		const struct nfsd4_sessionid *sid =
 			(struct nfsd4_sessionid *)&session->se_sessionid;
 
@@ -1792,9 +1791,10 @@ TRACE_EVENT(nfsd_cb_seq_status,
 TRACE_EVENT(nfsd_cb_free_slot,
 	TP_PROTO(
 		const struct rpc_task *task,
-		const struct nfsd4_callback *cb
+		const struct nfsd4_callback *cb,
+		const struct nfsd4_session *session
 	),
-	TP_ARGS(task, cb),
+	TP_ARGS(task, cb, session),
 	TP_STRUCT__entry(
 		__field(unsigned int, task_id)
 		__field(unsigned int, client_id)
@@ -1805,8 +1805,6 @@ TRACE_EVENT(nfsd_cb_free_slot,
 		__field(u32, slot_seqno)
 	),
 	TP_fast_assign(
-		const struct nfs4_client *clp = cb->cb_clp;
-		const struct nfsd4_session *session = clp->cl_cb_session;
 		const struct nfsd4_sessionid *sid =
 			(struct nfsd4_sessionid *)&session->se_sessionid;
 

-- 
2.54.0


