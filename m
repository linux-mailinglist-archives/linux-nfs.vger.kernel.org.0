Return-Path: <linux-nfs+bounces-22052-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAEoK/G6GGrbmggAu9opvQ
	(envelope-from <linux-nfs+bounces-22052-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 00:00:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B68095FAB0F
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 00:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 237B731ADF19
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA84367297;
	Thu, 28 May 2026 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoVLVc4E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10AF3655C4;
	Thu, 28 May 2026 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005332; cv=none; b=YE0OOsd+SMGsEmiH38BndA6slEyj5F28qrZCkeeiPpETk7xOG+HbMoBbhSij7x51DE2jV9PLcqlGgCheeCIFCOWhIq+XQYtdzMBMr8n1cjrOY1ZAR/3TpT8r+/wO5UIjlGrNkQJG0MDUqtlZFgUbAXR7en1v8sMf/x8RxbjzsyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005332; c=relaxed/simple;
	bh=+1egxb1h4y2B2aNDpEQu+OZaOf0TQfGCXOYKnLxQ5lU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WV4b7YT8v207bVrT2XOLFG4dR5jaSmMgXdUpoewUWZSutYBAM0DSM61KulR5rWG9rP0veKxNPF/ZyAsRrow2YjNppXEAXwy6QlWqRPB/L29IemoP/+Ss7Hpp0n+vI3lpCV/AySNuhqVgRQXc9NoZkbr+6bpj3sYHWmry38bHXYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoVLVc4E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753AF1F00ACA;
	Thu, 28 May 2026 21:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780005328;
	bh=J/z8Oz1VKieRRTsML+iXe4muZfZGdxmLjJ0FZi/X4wc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DoVLVc4EnDRqTU1RJe7XrjR/aEiDbzy71BC/pJlAHzonK5B0+aBE/aokd4ccDsjR3
	 ZMkD/flx+5DmTy7obNt3kT0FGfjdZnzwzC7u1gvPv/+/KNWwYKb0MYebBXIS0husnR
	 hCfz+y0kvfLS9XKcDHFbNdrmyDLHtipQHC7cqdUcRzxwlRVT7XfBJ8U9hJXYbK8q9a
	 s1+0F5N+Ai4PAjoSJfUW/KDS9Wp79GETKAIhD74jcdPb6TMuGyyy9mnZMSbn0D+g1x
	 tL8oninox0aSwU9TIspSx+Mex1OZG5ZPeWdIy1+C+VvX4m72/z0D2x2KdLyq3boHQH
	 7mPry8Eq5KwMg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 28 May 2026 17:55:13 -0400
Subject: [PATCH 02/10] nfsd: drain callbacks and clear cl_cb_session
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-nfsd-fixes-v1-2-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
In-Reply-To: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5832; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9ZUym2wgilGmSwTI4ZQgv6cu3Cq2Hj2EPxdd/eLxtLQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGLnKm7OkdNAxVZlJQoYqRbptggne280lxckVQ
 sjczEGHsl+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahi5ygAKCRAADmhBGVaC
 FXkxD/wPTHJYpCfR4XF/8j6hpJkn/3FdisO3EkmMMn4twCXomfe5BIpj/PoHnOU4P7cCuxIeyca
 xiSKhzOE/QActMBcdqnVhaMXe9ENfOwoZAGaHSYO4QcPU8vVv7bTYf5jgY+Fs7WtkkL56mt4uKg
 3YtA/9gMNAgkZlVPsTDodrumqJgHjvDzW7Uzki0K0S2Jfp75FewJOc8oUzF6m+qjge7FNorLIEs
 5Eq/tQbNp1fSGUmus6lkt004VDBEbegKyiMsUGei4sD9EvLXiW6izOVYLa2oclcpJZU7vFPV7kP
 5u8G8YI5G1EfloWN4O0EEzjauwFSGnWTQJCM/TFAUmv02Wjy7wzcJvpDMSh8mdCBDXz2SJQa8UT
 g3RE+IPESc/KxLMULRIieCjogSDvETkZR5jQLjY5D+KSPaQrTXHV2PJsFwJpfsyGT2zbCQA5pjq
 HgqhuG/iZKR6Gt4rsF+ASYvwX1w8vVrXaakk0tPu1KaKFpMBKxzoOdiNYmPhuGj3zdP6yGE4Afd
 YZ7pYg2wy80UvUyktYhyjVUz6BW83wU/3F9+SobvpTmOW5uL5XObM397i/8rgD6140Yg1PAEhr6
 HCz9Symbbrd6ae2seDbticCh401uqA2+gi24is2rGITrphTZYnzRRs4sdiyYlZ3ASSygMMCrMjd
 TAQgpXy97MSKq9g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22052-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B68095FAB0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

After a DESTROY_SESSION the per-session teardown path can free a
session while rpciod still holds an inflight callback rpc_task that
dereferences clp->cl_cb_session.  nfsd4_probe_callback_sync() flushes
cl_callback_wq, but once nfsd4_run_cb_work() has called
rpc_call_async() the rpc_task lives on rpciod; flushing the workqueue
does not wait for it.  After the flush returns,
nfsd4_destroy_session() proceeds through nfsd4_put_session_locked()
and free_session() kfree()s the slab while rpciod's
nfsd4_cb_sequence_done(), grab_slot(), and nfsd41_cb_release_slot()
are still dereferencing cb->cb_clp->cl_cb_session.

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
setup_callback_client() takes the v4.1 early return

    if (!conn->cb_xprt || !ses)
            return -EINVAL;

so clp->cl_cb_session = ses never fires and the field retains a
pointer to the about-to-be-freed session.  Symmetrically, if a later
probe finds a different session's backchannel conn and that
setup_callback_client() call fails, the error tail must still scrub
any previously published cl_cb_session.

Fix by mirroring the two-stage drain that nfsd4_shutdown_callback()
already performs: call nfsd41_cb_inflight_wait_complete() in
nfsd4_probe_callback_sync() after flush_workqueue() so rpciod-side
nfsd41_cb_inflight_end() decrements are observed before the caller
releases the final session reference.  The two direct callers,
nfsd4_destroy_session() and nfsd4_init_conn() (itself invoked from
nfsd4_create_session() and nfsd4_bind_conn_to_session()), run in
sleepable process context and tolerate the wait_var_event() sleep:

    nfsd4_destroy_session() (fs/nfsd/nfs4state.c):
      unhash_session(ses);
      spin_unlock(&nn->client_lock);   /* spinlock dropped */
      nfsd4_probe_callback_sync(ses->se_client);

    nfsd4_init_conn() (fs/nfsd/nfs4state.c):
      acquires no locks in its body; calls nfsd4_hash_conn(),
      nfsd4_register_conn(), then nfsd4_probe_callback_sync() --
      entirely in sleepable process context.

Also clear clp->cl_cb_session unconditionally on the
nfsd4_process_cb_update() error return so every
setup_callback_client() failure -- whether c is NULL or points at a
different session whose probe failed -- leaves the field NULL rather
than pointing at a session that may subsequently be freed.

Fixes: dcbeaa68dbbd ("nfsd4: allow backchannel recovery")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/nfs4callback.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 1964a213f80e..1cf6b6100357 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1205,9 +1205,8 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
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
@@ -1225,8 +1224,10 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 		return -ENOMEM;
 	}
 
-	if (clp->cl_minorversion != 0)
+	if (clp->cl_minorversion != 0) {
 		clp->cl_cb_conn.cb_xprt = conn->cb_xprt;
+		clp->cl_cb_session = ses;
+	}
 	clp->cl_cb_client = client;
 	clp->cl_cb_cred = cred;
 	rcu_read_lock();
@@ -1299,6 +1300,7 @@ void nfsd4_probe_callback_sync(struct nfs4_client *clp)
 {
 	nfsd4_probe_callback(clp);
 	flush_workqueue(clp->cl_callback_wq);
+	nfsd41_cb_inflight_wait_complete(clp);
 }
 
 void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
@@ -1679,7 +1681,17 @@ static struct nfsd4_conn * __nfsd4_find_backchannel(struct nfs4_client *clp)
  * Note there isn't a lot of locking in this code; instead we depend on
  * the fact that it is run from clp->cl_callback_wq, which won't run two
  * work items at once.  So, for example, clp->cl_callback_wq handles all
- * access of cl_cb_client and all calls to rpc_create or rpc_shutdown_client.
+ * access of cl_cb_client and cl_cb_session, and all calls to rpc_create
+ * or rpc_shutdown_client.
+ *
+ * rpciod-side readers of cl_cb_session (encode_cb_sequence4args(),
+ * nfsd4_cb_sequence_done(), the cb-slot helpers, and the cb_sequence
+ * tracepoints) run outside cl_callback_wq.  The
+ * nfsd41_cb_inflight_wait_complete() drain in nfsd4_probe_callback_sync()
+ * waits until cl_cb_inflight reaches zero before the caller proceeds with
+ * session teardown; any rpc_task that reads cl_cb_session must hold an
+ * inflight pin (via nfsd41_cb_inflight_begin) for this fence to be
+ * effective.
  */
 static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 {
@@ -1731,6 +1743,7 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 		nfsd4_mark_cb_down(clp);
 		if (c)
 			svc_xprt_put(c->cn_xprt);
+		clp->cl_cb_session = NULL;
 		return;
 	}
 }

-- 
2.54.0


