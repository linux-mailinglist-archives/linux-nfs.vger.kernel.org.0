Return-Path: <linux-nfs+bounces-23204-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vYICJB/vT2qOqgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23204-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 20:57:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0939734A29
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 20:57:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bbo9PN5E;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23204-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23204-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 375DC3146E00
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 18:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11D33B7751;
	Thu,  9 Jul 2026 18:47:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050BC4499B0;
	Thu,  9 Jul 2026 18:47:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622875; cv=none; b=S9B3GKsKzTlwHcZfcFzZTiCLeXQRSCbciwtnJIODV5VLL16YmprJWhwkXpsAUj/aZIz/G3GPnVaXb5HwaRq0i4XtbUZHxyMWjOuPBRsuXZW/iOtTt+QkH0n2fltbUzW0pfYraZStzglpyQvTQi0HlL//Z4mBJJTt1rZc/1Wt+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622875; c=relaxed/simple;
	bh=0+Dgs48ewBi79rul3VOhFHu7TwMd0dUcmPRUP9EN0v8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=feUYZ3FFOXu8bTyLqXq2/CNjIXNWdrPjy9Qlj2JR79r3Xux5qItCZtjw2+nV21bpeLiLKJHraY1ovEC3amz0qLR0Wh3DdaWqeyerK8uB3jv+7Y6jHdrj1wPrejtFlex3t3ZVwft8s957dGzzSxOtjTUQwBHt9hG7AFgaDHVKmhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbo9PN5E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46D81F00A3A;
	Thu,  9 Jul 2026 18:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622873;
	bh=rYXKcPecD/0GB1MMuu4am25vPS1cbhSbxCR1OUIma7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bbo9PN5EkjqKO8KZIH7AENdqqTcx2zvD3UVvLbQdaseZOaE/ePRqqenN9tsouwLDV
	 w3y27Z0fvpEbtmUzwcQ8YgUN5HWewWEgkIFIjj6QOCP1/HAP2wVcJKdAOBvSdrk5TR
	 lqJcG7sIfLaYsE/9Zl/U9uQQ/SqP1cXWu9LleGm7hrgUHd63FJlbsHNdW9UJ+/I44i
	 5axhz5A9Y94Y8d3bFnV3zOvxugGjN37v5/SZbgkOQis9THNmyXAgOwgESYZ/Th50yP
	 G7HoE+rlbNX24SShp2rzyR5nAETsSubBDiY0Hzal5YM67dwdhV1aJKHMHyoqrJGjRa
	 7w9gjbZ5XAmow==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 14:47:39 -0400
Subject: [PATCH v2 02/10] nfsd: fix UAF in async copy cancel and shutdown
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nfsd-testing-v2-2-0a1ba233bf87@kernel.org>
References: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
In-Reply-To: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Andy Adamson <andros@netapp.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14134; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0+Dgs48ewBi79rul3VOhFHu7TwMd0dUcmPRUP9EN0v8=;
 b=owEBbAKT/ZANAwAKAQAOaEEZVoIVAcsmYgBqT+zU4kfdSZ1BS45nRGoIl110ozayI0bzAqIIb
 5DEkuyEiSGJAjIEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/s1AAKCRAADmhBGVaC
 FUCFD/doMZmdTtrA/I8f+XVmIXbS/H9iC4TMMh/4TsGKzL/0Qyan4FsnZV32CL6lcEQfFWrEkHo
 fh6TfdZtSObrJhdi7vRLezGQAKFhOxdiVV0NAumUui2W5XUBU40/ZT33amAiwbLqOeYBF1C2Uo0
 V+YvgvPG1BQYpmICzJjbUbE/haamXh62YDUMKTBg9fAG4gUQPhDy+zFDw2e2EpFW6Zx/mTUcAyg
 xoUc2rEFM9z6KQz6AsGG3ZZYnkumigKA5yJd1NfFMV5oqKyfGtkwflCO6YSk5mBfVfxtiRaXtel
 m+KgJYG5dn30TKcRpeO/mL0w4y9JpSwAKcuIYW7DS/Gvw148Iyal6DtHqOn7XK/p6QEBHQ5saDq
 ua3TzYdmT3Cp1jq4IlGLRe3Wg2nWW4jc8grmD7Ns3qbYk/p3qESlbqisI/NWv7Tv+IkcOy7imwU
 dlEdUdyZh1aZ06eaS07i09yvuXskjNKP7KIkyh0U4rlbxmXhxI4bhsqchKhrr750jlAtEyIaUzw
 5o7JsopWPEPRDUamB6YP4cRceziItqtfhwFKrgLxZK252guFrH6qEthnzWZaiZgOZNBvVtrQMAi
 xl/ZkyiKuy8lcGWfg2NBEUGjZrWO5UwHyEgzrn4OG5vT/AzUxKozdtWQpLMz1i3v+bR2t9V8/PC
 rnBEUyRXnupfC
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23204-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:andros@netapp.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0939734A29

An async copy could be freed or used after free while a teardown caller
(OFFLOAD_CANCEL, nfsd4_shutdown_copy, nfsd4_cancel_copy_by_sb) raced the
copy kthread:

  - find_async_copy() bumped copy->refcount but left the copy on
    clp->async_copies, so the reaper's cleanup_async_copy() could run
    release_copy_files() concurrently with a cancel/shutdown caller. Both
    put and NULL nf_src/nf_dst without a common lock, double-putting the
    nfsd_file and freeing it early.

  - nfsd4_do_async_copy() set NFSD4_COPY_F_STOPPED before its final uses
    of the copy (nfsd_update_cmtime_attr() on copy->nf_dst,
    nfsd4_send_cb_offload()). nfsd4_stop_copy() treats a set STOPPED bit
    as "kthread done, skip kthread_stop()", so a teardown caller ran
    release_copy_files() -- which puts and NULLs nf_dst -- while the
    kthread still dereferenced it (NULL/UAF).

  - copy->copy_task was never pinned. The one-shot kthread self-reaps on
    return, so kthread_stop()'s get_task_struct() could touch a freed
    task_struct.

  - co_cb is embedded in the copy, but nfsd4_send_cb_offload() held a
    reference only on the client, so a concurrent teardown could free
    the copy while the CB_OFFLOAD callback was in flight.

Fix the teardown lifetime as a whole:

  - find_async_copy() unlinks the copy (clear cp_clp, list_del_init)
    under async_lock; the cancel, shutdown, and sb-cancel paths drop the
    list-membership reference via nfs4_put_copy() after nfsd4_stop_copy().
    Drop the now-redundant list_del fixup from cleanup_async_copy().

  - Give the kthread its own reference, taken in nfsd4_copy() before
    wake_up_process() and dropped at the end of nfsd4_do_async_copy();
    call wake_up_process() before list_add().

  - Pin the task_struct with get_task_struct() in nfsd4_copy(), released
    in nfs4_put_copy(), so kthread_stop() is safe whenever the kthread
    exits. Set NFSD4_COPY_F_STOPPED only in nfsd4_stop_copy(), which now
    always kthread_stop()s before release_copy_files(); completion is
    still reported via NFSD4_COPY_F_COMPLETED, so
    nfsd4_has_active_async_copies() is unaffected. Each teardown caller
    removes the copy from clp->async_copies first, so kthread_stop() runs
    exactly once.

  - Take a copy reference in nfsd4_send_cb_offload(), dropped in
    nfsd4_cb_offload_release(). The kthread still holds its own reference
    there, so the refcount_inc() cannot race the final free.

  - Read cp_clp with smp_load_acquire() to pair with the unordered
    set_bit()/clear_bit() writers (Documentation/atomic_bitops.rst).

Fixes: e0639dc5805a ("NFSD introduce async copy feature")
Fixes: ac0514f4d198 ("NFSD: Add a laundromat reaper for async copy state")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 163 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 128 insertions(+), 35 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 669896be08b6..fad01d67bf3f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1519,6 +1519,12 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
 		return;
+	/*
+	 * Drop the task_struct reference taken in nfsd4_copy(). Only async
+	 * copies have a copy_task; it is left NULL on every other path.
+	 */
+	if (copy->copy_task)
+		put_task_struct(copy->copy_task);
 	kfree(copy->cp_src);
 	kfree(copy);
 }
@@ -1528,20 +1534,23 @@ static void release_copy_files(struct nfsd4_copy *copy);
 static void nfsd4_stop_copy(struct nfsd4_copy *copy)
 {
 	trace_nfsd_copy_async_cancel(copy);
-	if (!test_and_set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags)) {
-		kthread_stop(copy->copy_task);
-		if (!test_bit(NFSD4_COPY_F_CB_ERROR, &copy->cp_flags))
-			copy->nfserr = nfs_ok;
-		set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
-	}
-
 	/*
-	 * The copy was removed from async_copies before this function
-	 * was called, so the reaper cannot clean it up. Release files
-	 * here regardless of who won the STOPPED race. If the thread
-	 * set STOPPED, it has finished using the files. If STOPPED
-	 * was set here, kthread_stop() waited for the thread to exit.
+	 * Always join the copy kthread before touching its resources. The
+	 * task_struct is pinned by get_task_struct() in nfsd4_copy(), so
+	 * kthread_stop() is safe even if this one-shot kthread has already
+	 * returned. Joining guarantees the kthread is no longer using
+	 * copy->nf_dst or the client by the time release_copy_files() runs.
+	 *
+	 * The caller has already removed the copy from clp->async_copies and
+	 * is the sole owner of this teardown, so kthread_stop() runs exactly
+	 * once per copy.
 	 */
+	set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags);
+	kthread_stop(copy->copy_task);
+	if (!test_bit(NFSD4_COPY_F_CB_ERROR, &copy->cp_flags))
+		copy->nfserr = nfs_ok;
+	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
+
 	release_copy_files(copy);
 	nfs4_put_copy(copy);
 }
@@ -1555,7 +1564,11 @@ static struct nfsd4_copy *nfsd4_unhash_copy(struct nfs4_client *clp)
 		copy = list_first_entry(&clp->async_copies, struct nfsd4_copy,
 					copies);
 		refcount_inc(&copy->refcount);
-		copy->cp_clp = NULL;
+		/*
+		 * Pairs with smp_load_acquire in nfsd4_send_cb_offload();
+		 * see find_async_copy() for rationale.
+		 */
+		smp_store_release(&copy->cp_clp, NULL);
 		if (!list_empty(&copy->copies))
 			list_del_init(&copy->copies);
 	}
@@ -1567,8 +1580,16 @@ void nfsd4_shutdown_copy(struct nfs4_client *clp)
 {
 	struct nfsd4_copy *copy;
 
-	while ((copy = nfsd4_unhash_copy(clp)) != NULL)
+	while ((copy = nfsd4_unhash_copy(clp)) != NULL) {
 		nfsd4_stop_copy(copy);
+		/*
+		 * nfsd4_unhash_copy() removed the copy from
+		 * clp->async_copies and cleared cp_clp, so the reaper
+		 * can no longer reach it and drop the list-membership
+		 * reference via cleanup_async_copy(). Drop it here.
+		 */
+		nfs4_put_copy(copy);
+	}
 }
 
 static bool nfsd4_copy_on_sb(const struct nfsd4_copy *copy,
@@ -1637,6 +1658,14 @@ void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
 
 		list_del_init(&copy->copies);
 		nfsd4_stop_copy(copy);
+		/*
+		 * The copy was moved off clp->async_copies under
+		 * async_lock above, so the reaper can no longer reach
+		 * it and drop the list-membership reference via
+		 * cleanup_async_copy(). Drop it here, mirroring
+		 * nfsd4_offload_cancel() and nfsd4_shutdown_copy().
+		 */
+		nfs4_put_copy(copy);
 		nfsd4_put_client(clp);
 	}
 }
@@ -1931,6 +1960,8 @@ static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
 
 	set_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags);
 	nfsd4_put_client(cb->cb_clp);
+	/* Drop the copy reference taken in nfsd4_send_cb_offload(). */
+	nfs4_put_copy(copy);
 }
 
 static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
@@ -2062,28 +2093,38 @@ static void release_copy_files(struct nfsd4_copy *copy)
 	}
 }
 
+/*
+ * Called from the async copy reaper (after unlinking from async_copies
+ * under async_lock) and from nfsd4_copy()'s out_err path (where the copy
+ * was never list_add'd). In both cases the copy is unreachable from
+ * clp->async_copies.
+ */
 static void cleanup_async_copy(struct nfsd4_copy *copy)
 {
 	nfs4_free_copy_state(copy);
 	release_copy_files(copy);
-	if (copy->cp_clp) {
-		spin_lock(&copy->cp_clp->async_lock);
-		if (!list_empty(&copy->copies))
-			list_del_init(&copy->copies);
-		spin_unlock(&copy->cp_clp->async_lock);
-	}
 	nfs4_put_copy(copy);
 }
 
 static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 {
 	struct nfsd4_cb_offload *cbo = &copy->cp_cb_offload;
-	struct nfs4_client *clp = copy->cp_clp;
+	struct nfs4_client *clp;
 
 	/*
-	 * cp_clp is NULL when called via nfsd4_shutdown_copy() during
-	 * client destruction. Skip the callback; the client is gone.
+	 * Pairs with smp_store_release(&copy->cp_clp) in find_async_copy()
+	 * and nfsd4_unhash_copy(). set_bit/clear_bit are unordered atomics
+	 * (Documentation/atomic_bitops.rst), so the acquire is needed to
+	 * prevent the cp_clp load being reordered past the clp dereference
+	 * below on weakly-ordered hardware. The kthread holds its own
+	 * reference across this call (taken before wake_up_process in
+	 * nfsd4_copy()); see commit log for per-path client lifetime.
+	 *
+	 * cp_clp is NULL when the copy was canceled (find_async_copy,
+	 * nfsd4_unhash_copy) before the kthread reached this point. Skip
+	 * the callback; the canceling path owns the notification.
 	 */
+	clp = smp_load_acquire(&copy->cp_clp);
 	if (!clp) {
 		set_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags);
 		return;
@@ -2095,10 +2136,16 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 	cbo->co_retries = 5;
 
 	/*
-	 * Hold a reference on the client while the callback is in flight.
-	 * Released in nfsd4_cb_offload_release().
+	 * Hold a reference on the client and on the copy while the callback
+	 * is in flight. co_cb is embedded in the copy, so the copy must
+	 * outlive the callback; a concurrent OFFLOAD_CANCEL or shutdown can
+	 * otherwise drop the last copy reference and free it while the RPC
+	 * layer still references co_cb. Both are released in
+	 * nfsd4_cb_offload_release(). The kthread still holds its own copy
+	 * reference here, so this refcount_inc() cannot race the final free.
 	 */
 	kref_get(&clp->cl_nfsdfs.cl_ref);
+	refcount_inc(&copy->refcount);
 
 	nfsd4_init_cb(&cbo->co_cb, clp, &nfsd4_cb_offload_ops,
 		      NFSPROC4_CLNT_CB_OFFLOAD);
@@ -2150,16 +2197,27 @@ static int nfsd4_do_async_copy(void *data)
 do_callback:
 	if (!test_bit(NFSD4_COPY_F_CB_ERROR, &copy->cp_flags))
 		copy->nfserr = nfserr;
-	/* The kthread exits forthwith. Ensure that a subsequent
-	 * OFFLOAD_CANCEL won't try to kill it again. */
-	set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags);
-
+	/*
+	 * Do not set NFSD4_COPY_F_STOPPED here. That bit tells a teardown
+	 * caller it may skip kthread_stop(); setting it before the kthread
+	 * is done using copy->nf_dst and the client lets a concurrent
+	 * nfsd4_stop_copy() release those resources out from under us.
+	 * STOPPED is now set only by nfsd4_stop_copy(), which always joins
+	 * via kthread_stop().
+	 */
 	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
 	trace_nfsd_copy_async_done(copy);
 	atomic_dec(&copy->cp_nn->pending_async_copies);
 	if (copy->cp_res.wr_bytes_written > 0 && copy->attr_update)
 		nfsd_update_cmtime_attr(copy->nf_dst->nf_file, 0);
 	nfsd4_send_cb_offload(copy);
+	/*
+	 * Drop the kthread's own reference (taken before
+	 * wake_up_process() in nfsd4_copy()). After this point, copy
+	 * may be freed by a concurrent teardown caller's pending
+	 * nfs4_put_copy().
+	 */
+	nfs4_put_copy(copy);
 	return 0;
 }
 
@@ -2198,6 +2256,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {
+		struct task_struct *task;
+
 		async_copy = kzalloc_obj(struct nfsd4_copy);
 		if (!async_copy)
 			goto out_err;
@@ -2225,15 +2285,29 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		       NFS4_MAX_SESSIONID_LEN);
 		async_copy->cp_cb_offload.co_referring_slotid = cstate->slot->sl_index;
 		async_copy->cp_cb_offload.co_referring_seqno = cstate->slot->sl_seqid;
-		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
-				async_copy, "%s", "copy thread");
-		if (IS_ERR(async_copy->copy_task))
+		task = kthread_create(nfsd4_do_async_copy, async_copy,
+				      "%s", "copy thread");
+		if (IS_ERR(task))
 			goto out_dec_async_copy_err;
+		/*
+		 * Pin the task_struct so a later nfsd4_stop_copy() can call
+		 * kthread_stop() safely even after this one-shot kthread has
+		 * exited and been reaped. Released by nfs4_put_copy().
+		 */
+		get_task_struct(task);
+		async_copy->copy_task = task;
+		/*
+		 * Take the kthread's reference and wake it before publishing
+		 * on async_copies, so the publisher does not touch async_copy
+		 * after spin_unlock and a concurrent teardown caller can drain
+		 * all remaining references safely. See commit log for details.
+		 */
+		refcount_inc(&async_copy->refcount);
+		wake_up_process(async_copy->copy_task);
 		spin_lock(&async_copy->cp_clp->async_lock);
 		list_add(&async_copy->copies,
 				&async_copy->cp_clp->async_copies);
 		spin_unlock(&async_copy->cp_clp->async_lock);
-		wake_up_process(async_copy->copy_task);
 		status = nfs_ok;
 	} else {
 		status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
@@ -2287,8 +2361,19 @@ find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
 
 	spin_lock(&clp->async_lock);
 	copy = find_async_copy_locked(clp, stateid);
-	if (copy)
+	if (copy) {
 		refcount_inc(&copy->refcount);
+		/*
+		 * Mirror nfsd4_unhash_copy(): unlink and clear cp_clp under
+		 * async_lock so the reaper cannot reach the copy. Caller drops
+		 * the list-membership reference via nfs4_put_copy() after
+		 * nfsd4_stop_copy(). smp_store_release() pairs with
+		 * smp_load_acquire() in nfsd4_send_cb_offload().
+		 */
+		smp_store_release(&copy->cp_clp, NULL);
+		if (!list_empty(&copy->copies))
+			list_del_init(&copy->copies);
+	}
 	spin_unlock(&clp->async_lock);
 	return copy;
 }
@@ -2307,8 +2392,16 @@ nfsd4_offload_cancel(struct svc_rqst *rqstp,
 		struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
 		return manage_cpntf_state(nn, &os->stateid, clp, NULL);
-	} else
+	} else {
 		nfsd4_stop_copy(copy);
+		/*
+		 * find_async_copy() removed the copy from
+		 * clp->async_copies, so the reaper can no longer
+		 * reach it and drop the list-membership reference
+		 * via cleanup_async_copy(). Drop it here.
+		 */
+		nfs4_put_copy(copy);
+	}
 
 	return nfs_ok;
 }

-- 
2.55.0


