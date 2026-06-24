Return-Path: <linux-nfs+bounces-22811-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4OBxCI4ZPGpmjwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22811-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:53:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCED6C0812
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:53:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CAK4g520;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22811-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22811-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2543C3051154
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF9A3DD85C;
	Wed, 24 Jun 2026 17:52:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D03DD85E;
	Wed, 24 Jun 2026 17:52:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323522; cv=none; b=DjebG5pfhNK7I+GRZcv3HqtR/eQ71F8rMwkfRCRIp4qSU3ePxhtaZWqM2ko0QgGBzHx1aN2/9M+jX2qvMXFHJ6ULnW4NR3KjmBQuXVb9jo6XbI66/TEgx5T9m7e+LWHIf/pFQhubBAT2r3zFlotuOC2SYOpIwKMSBNh7IQIOwLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323522; c=relaxed/simple;
	bh=lpK8jZ7K6IfeK+pOp8OkQ65eG+EeFPbRqGIYSP60nck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PoqBAPZuyoAdhtUVZCyaBdhknBu+Tbfm/7gLzGjBgyW8IyH7TE99xjmtNl3pACqHfFrbYCliTSDUsy5sKdMINHzf37ebxgwniUzhJxa2iY0SrrrrdjUWpD0+ymWSwQNYWybSN+XZiyfkEVsP3DP18V/3beWNsVl+dNC1mscuEZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAK4g520; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465E51F00A3A;
	Wed, 24 Jun 2026 17:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782323521;
	bh=5lAiCQYcwTt+KZlHHiXRjm2uyHRal9IjOJ9db+qjDhg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CAK4g520TDNwjmj/4rxOfbsK4QWa9wIfcuIAsU599Y6W/bsNwLuWOxJl76ifbq+95
	 AFZLClQaWugzgjYsuYM4w5+NLVqz5LNAbAionnzMbeYiaEr5XbNNKRgcCv2IM1KakF
	 bDTz8SfminbeGH7TaraG/Y7GVXvbAGZer9Sbbl3xsG1yRdOM4elrtim1382a/P406t
	 BcKrpiDIbD/JjAlYp5iSwjX1mCK+CpUSirJ+C04g62iA88wYCpb5jXjKS7x4EA8LCx
	 hSvR76jQSlJPZCzuO5pg/lhhreymlnW9/fFnt2gNWJjBbfVcSzxAZA2gMimQZb2XaY
	 Miyw7H270aj0w==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Jun 2026 13:51:45 -0400
Subject: [PATCH 3/3] nfsd: fix UAF in async copy cancel and shutdown
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-nfsd-testing-v1-3-b8853eb22e45@kernel.org>
References: <20260624-nfsd-testing-v1-0-b8853eb22e45@kernel.org>
In-Reply-To: <20260624-nfsd-testing-v1-0-b8853eb22e45@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Andy Adamson <andros@netapp.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10814; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lpK8jZ7K6IfeK+pOp8OkQ65eG+EeFPbRqGIYSP60nck=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqPBk8EJT2ONBzVTohAH0NyaWQfSAcsPVBLNS8r
 XeG4hG8K8GJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajwZPAAKCRAADmhBGVaC
 FWmgD/0VvorDeFSfzknDo3PJBPZZI8VVpEz3nNqesNsrvcnxcl4sZJucKI+uco2tWJYqePldY03
 XYm5wNBuTXnBI6+ke8PjhHI6nEHyJ4Q/8pafm8j7zeK26qdNZd0oWZXbXYJJ6bxGBfrfqhmABEp
 T0fPWJPa0G6vX7fZyAKYkLvohJN0vvxs/6OFbu0ftcTX2qnamRs9I5rVutSOUMDbuwO1vCojgC2
 HT9lcDHbTamjbelqYmoVbnnfuXL237dj2eEXibckdH/4OG78eOQlns+2RqS1KwikfmE4u9IZE3i
 AhLrKCRBxt3IMPaOiv250vogP1Vci5mu9RwmHnt5sRnXKPuX3hfBCisawkSdgo9FTiZFSDsl4gN
 4gP2kFOMXXsctR+qX5aPzSMCBOT6UPPRiToSG+k0wP2A0S2twLvw93dwWLOIijUGjc8G17QH2Vb
 xmQyH9dhyCNL8aenLKMtSwT1/mXBa2Ly2vQydPMreF6wJZ79bBqNnBvU+F/wZfMdd+Pr4AyJGHZ
 WmdDJ14zlLVS1jyG0xCBpW+zWFe6Y6Zhjb84KP7nIavC+531ulmiNmNJbe20I7Mb4ggtFpqvvJv
 C8JK6Cqoili+lg94M0qnDPi0hxZ6OvuRrgOTLixRypQE1i4rgL41aVXAkDJd7QThbkXr03Djre2
 7eRdclggKU47YFA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22811-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FCED6C0812

find_async_copy() bumps copy->refcount under clp->async_lock but
leaves the copy on clp->async_copies, violating the precondition of
nfsd4_stop_copy(). The async copy reaper walks clp->async_copies,
moves OFFLOAD_DONE copies to a private reaplist, then calls
cleanup_async_copy() outside the lock, racing the cancel path:

    CPU 0 (OFFLOAD_CANCEL)         CPU 1 (reaper)
    -----                          -----
    find_async_copy()
      refcount_inc(&copy->refcount)
      /* copy still on async_copies */
                                   spin_lock(&clp->async_lock)
                                   move copy to reaplist
                                   spin_unlock(&clp->async_lock)
    nfsd4_stop_copy(copy)
      release_copy_files(copy)
        nfsd_file_put(nf_src)
                                   cleanup_async_copy(copy)
                                     release_copy_files(copy)
                                       nfsd_file_put(nf_src)
                                       /* double put -> UAF */

release_copy_files() reads, puts, then NULLs nf_src/nf_dst, but the
two callers hold no common lock, so both can observe a non-NULL
pointer and each call nfsd_file_put() on the same struct nfsd_file.
That decrements nf_ref twice; nfsd_file_slab is created with
KMEM_CACHE(nfsd_file, 0) (no SLAB_TYPESAFE_BY_RCU), so the premature
free leads to a use-after-free of the filecache object.

Unlinking the copy in find_async_copy() exposes a second hazard.
nfsd4_stop_copy() only joins via kthread_stop() when the teardown
caller wins test_and_set_bit(NFSD4_COPY_F_STOPPED). If the kthread
sets the bit first, kthread_stop() is skipped and the teardown
caller's nfs4_put_copy() can free copy while the kthread runs on:

    CPU 0 (teardown)               CPU 1 (copy kthread)
    -----                          -----
                                   set_bit(STOPPED, &cp_flags)
                                   set_bit(COMPLETED, &cp_flags)
    nfsd4_stop_copy(copy)
      test_and_set_bit(STOPPED)
        /* returns 1, skip stop */
      release_copy_files(copy)
      nfs4_put_copy(copy) /* 1->0 */
      kfree(copy)
                                   nfsd4_send_cb_offload(copy)
                                   /* UAF */

In find_async_copy(), after refcount_inc() under async_lock, clear
copy->cp_clp and list_del_init(&copy->copies), mirroring
nfsd4_unhash_copy() so the reaper can no longer observe the copy.
nfsd4_offload_cancel(), nfsd4_shutdown_copy(), and
nfsd4_cancel_copy_by_sb() then call nfs4_put_copy() after
nfsd4_stop_copy() to release the list-membership reference the
reaper previously dropped via cleanup_async_copy(). Because the copy
is always unlinked before cleanup_async_copy() now runs, drop the
list_del fixup (and the cp_clp deref) from cleanup_async_copy().

Give the kthread its own reference: refcount_inc() in nfsd4_copy()
before wake_up_process(), paired with nfs4_put_copy() as the final
act of nfsd4_do_async_copy(). Call wake_up_process() before
list_add() so the publisher has no use of async_copy after
spin_unlock; a concurrent find_async_copy() + nfsd4_stop_copy() can
then drain all references safely.

Pair the cp_clp writers (find_async_copy(), nfsd4_unhash_copy())
with smp_load_acquire() in nfsd4_send_cb_offload(). set_bit() and
clear_bit() are unordered atomics per
Documentation/atomic_bitops.rst and provide no ordering fence, so
a plain load of cp_clp could be reordered past the subsequent clp
dereference on weakly-ordered hardware. smp_load_acquire() supplies
the required barrier.

Fixes: ac0514f4d198 ("NFSD: Add a laundromat reaper for async copy state")
Assisted-by: kres:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 100 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 669896be08b6..a16a33d0ed00 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1536,11 +1536,10 @@ static void nfsd4_stop_copy(struct nfsd4_copy *copy)
 	}
 
 	/*
-	 * The copy was removed from async_copies before this function
-	 * was called, so the reaper cannot clean it up. Release files
-	 * here regardless of who won the STOPPED race. If the thread
-	 * set STOPPED, it has finished using the files. If STOPPED
-	 * was set here, kthread_stop() waited for the thread to exit.
+	 * Caller has already removed the copy from clp->async_copies, so
+	 * the reaper cannot reach it. Release files regardless of who won
+	 * STOPPED; if STOPPED was set here, kthread_stop() joined the
+	 * kthread.
 	 */
 	release_copy_files(copy);
 	nfs4_put_copy(copy);
@@ -1555,7 +1554,11 @@ static struct nfsd4_copy *nfsd4_unhash_copy(struct nfs4_client *clp)
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
@@ -1567,8 +1570,16 @@ void nfsd4_shutdown_copy(struct nfs4_client *clp)
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
@@ -1637,6 +1648,14 @@ void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
 
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
@@ -2062,28 +2081,38 @@ static void release_copy_files(struct nfsd4_copy *copy)
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
@@ -2160,6 +2189,13 @@ static int nfsd4_do_async_copy(void *data)
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
 
@@ -2229,11 +2265,18 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				async_copy, "%s", "copy thread");
 		if (IS_ERR(async_copy->copy_task))
 			goto out_dec_async_copy_err;
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
@@ -2287,8 +2330,19 @@ find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
 
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
@@ -2307,8 +2361,16 @@ nfsd4_offload_cancel(struct svc_rqst *rqstp,
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
2.54.0


