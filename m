Return-Path: <linux-nfs+bounces-21400-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAJLJrdn+mkEOwMAu9opvQ
	(envelope-from <linux-nfs+bounces-21400-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 23:57:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 225C14D4225
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 23:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F0C830A4B55
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA67E4963A5;
	Tue,  5 May 2026 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="YffJzxuW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA352F616A
	for <linux-nfs@vger.kernel.org>; Tue,  5 May 2026 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018141; cv=none; b=SR27VaEUxQwNvrMFHEO35syprLKiVAOTFr+k+X8sYTW62HlurwBr201jBaGdjjQZmy4u95ay3rhSZ3gHT1ZfMth4x3Z3pEUrSu6gCusiTDpMTAqChZxsX0UH8N1aCHRIhaJzCXu/6NQKhC8sVrn9r5dREW8KdS2r9CQYMhD644s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018141; c=relaxed/simple;
	bh=7ezNlw0YOz+kZ9/49qwXTcH8YKLvOOwxUpwSz0erZFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkuCa5eEgifZY/meAKQD4N9NfBQR8x9Wg+lF1U71aMAXSuZHgR7mhoM1BIdyAnyha30g1j3k4ahaTzACIX8hKn/rCPu9EthL+3YZewxxgKjh+nm00E+nC1lm+9kgGaMfuV76pVhVJ5jvanOxhtOI5Y66QdV58UhRGHZLOeWqITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=YffJzxuW; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8e8c0c2d2bcso825359485a.1
        for <linux-nfs@vger.kernel.org>; Tue, 05 May 2026 14:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1778018138; x=1778622938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rypnrMHl2RyrnLOhfMVjvQ5uZ1QQC+jtTdscustbdnY=;
        b=YffJzxuWrUTv+qAwVsd0nEVG6odb0RWmjWN3OJwCS3gytjN1L4z7kF1a7A1OhStqaD
         cni1xrmeCB5QjuaYcpUQ2f7ze1hlvl7cbNGTFWkhFtMQa/N6VhpA03uhSVX8OJ3D7wot
         yG9R6nCR/8hMomEGeO6cD6ylQijYK/GemACKuN661sEEGeL1rbLD4IlIauHL2trxrRXS
         +l7w5zJIUFJKRP+PNszJ9DM6mv12JCoygpH0tgMn2JNtcOmrTAWw28AGspcGfl7pIB5z
         hbdOpVQKmqOrAKWYELAj6I/vvAOpaieVUMzxwfgIswLKUVafYTluXZKkOOrGwfS8NZBq
         D9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778018138; x=1778622938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rypnrMHl2RyrnLOhfMVjvQ5uZ1QQC+jtTdscustbdnY=;
        b=bkBaN0IHUvnuqGnZGOS+haxU9m/GWLhFDYoMwj2gNAxtPpMN65U8LQR55D3uaAJqOU
         1QpUJZUsMpGEg4rKgmtOuXdF6kwDTzgVgXFYxc4f/CRB6EWepn9SIb3VwUQSqdQDpxo1
         IZmFNAvQOFckCe8QvmsUapJtTGBddwvIv0qS574I5MZnN5gO4UIl8EB0C4NXD4oDsa7m
         0iL9C6K0xvZAs80Byas4PJ87CODBtqgisz0HjthZRaOAM9QeWnjvHmRB5tqjb+nfCmZW
         pL0f3YWcyo9wutBKdL+AEn4ZJvzLw83Fzn9S0PoGIRfMiF7dw1nI7JmiMlFDVwckbY4Y
         faCA==
X-Gm-Message-State: AOJu0YzT7VgqBQiYNd7pGsszuj61OdBCJyJgndZQBWC03tPaUIswnhX6
	Go1a2SAGPVeOTfD9s5mua5Inr1Is/bLKv4QSg1GsDh8VmhW/WuBvgx0l1UJ1XEIT6fE=
X-Gm-Gg: AeBDiev/nX5D0A6zRE2kOwJvdNb+iYPNCGMfEyUKiN9VahyypBGsZN8gchgs0Fywk9u
	AafyY1hoKHpVykur3yR7422dPiXlmTn7SsMwr6B7Q0iabQXByipfERzU62+LVQEpeqPWGAp9y4m
	RwKvU+SOoKknQey7loqbMd1oTxKW1MYyu31hDBOS+P6iJ2EMZDkEJ9mh19Ag3Y0MI1K5vjGMcKU
	lwU6Xla0iZTlNnJtO5Yc1T7uFy3MxkM08icTxM8GqjwzJR7bQpywob9fKFeSX4EsJWL2yMGWKBo
	TkSiTVtTaR9ynEAZjFNkf8bQTJOu/qMWWsLmJ8Y0z15jnCVSFGs45QIfZ3/91LoDisMGcle+cid
	k4PQci7w8Zv69IItIeQw3LN00WIhPpIiCCgIVLTPM2V3bPq2ANpo5ROt76P5xmPlaFVdUciyvCN
	UOp8VunnzZQoGJzel7ZL5yC3Hp2UGYns4+idW5SxGenkc1niZavxSELS41HpVdvC3A0kfbmY475
	fE6uKPFkzFcLXbIc2E9gu24yE8=
X-Received: by 2002:a05:620a:4481:b0:8ed:11b9:1ecf with SMTP id af79cd13be357-904d496cdc7mr140033285a.17.1778018137488;
        Tue, 05 May 2026 14:55:37 -0700 (PDT)
Received: from localhost (pool-68-160-167-46.bstnma.fios.verizon.net. [68.160.167.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91e11fsm1418912985a.40.2026.05.05.14.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 14:55:37 -0700 (PDT)
Sender: Mike Snitzer <mike.snitzer@hammerspace.com>
From: Mike Snitzer <snitzer@hammerspace.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	ben.coddington@hammerspace.com,
	jonathan.flynn@hammerspace.com
Subject: [RFC PATCH 1/2] svcrdma: bound per-xprt sc_send_ctxts cache and apply backpressure on _get
Date: Tue,  5 May 2026 17:55:34 -0400
Message-ID: <20260505215535.68412-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260505215535.68412-1-snitzer@kernel.org>
References: <20260505215535.68412-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 225C14D4225
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21400-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:dkim,hammerspace.com:email,anthropic.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Benjamin Coddington <ben.coddington@hammerspace.com>

Under sustained heavy load over RDMA, kNFSD servers can pin tens of
gigabytes of memory in per-xprt svc_rdma_send_ctxt caches, never
released until the connection terminates.  A customer site reported
OOM kills under heavy NFS READ workloads with ~2.3M cached
send_ctxts visible via slab tracing (two stacks in
svc_rdma_send_ctxt_alloc, each kmalloc-4k, ~9.5 GB outstanding --
the same ctxt population double-counted across the sc_pages and
sc_xprt_buf allocations).  Aggregated across the customer's ~218
long-lived xprts that worked out to roughly 80 GB pinned, freed only
by knfsd restart.

Root cause is an unbounded cache, not a per-op leak.
svc_rdma_send_ctxt_get() pulls from rdma->sc_send_ctxts (an llist) or,
on empty, allocates fresh.  svc_rdma_send_ctxt_release() always
llist_add()s the ctxt back -- regardless of how many ctxts are
already on the list.  The only kfree() site is
svc_rdma_send_ctxts_destroy() at xprt teardown.  The list has no
shrinker, no cap, no aging: it can only grow.

Two effects compound to drive the high-water mark well above the
configured RPC slot count:

 1. _put runs through a workqueue.  svc_rdma_send_ctxt_put() does
    INIT_WORK(...) ; queue_work(svcrdma_wq, ...) and returns.  The
    actual _release (which puts the ctxt back on the llist) runs
    later on svcrdma_wq.  Between wc_send -> _put and _put_async ->
    _release, the ctxt is "in transit" -- off the list, off the SQ,
    not yet reusable.

 2. During that gap, a concurrent _get sees an empty llist and calls
    _alloc to mint a fresh ctxt.  When the in-transit one eventually
    lands on the llist, the cache has grown by one.  Under HCA-driven
    completion rates with even small workqueue dispatch lag, this
    happens constantly.  The cache settles not at the steady-state
    in-flight count but at the all-time peak of (in-flight +
    workqueue-pending), and never shrinks.

Fix: track sc_send_ctxts_depth as the count of *live* ctxts on the
xprt (incremented in svc_rdma_send_ctxt_alloc, decremented in
svc_rdma_send_ctxt_destroy).  Apply the cap in two places:

  - svc_rdma_send_ctxt_get(): when the llist is empty and depth has
    reached sc_max_requests, return NULL instead of allocating.  The
    caller drops the connection; the client reconnects with a fresh
    xprt that starts at depth zero.  This is the backpressure point
    that prevents in-test memory growth -- it stops new allocations
    regardless of where in the pipeline existing ctxts are stuck.

  - svc_rdma_send_ctxt_release(): if depth has overshot the cap (race
    between concurrent _get callers, or transient burst), free the
    ctxt instead of returning it to the llist.  This keeps depth
    convergent.

The cap is sc_max_requests because:
 - It is the configured number of credit slots per xprt -- the client
   can have at most this many RPCs outstanding on the transport.
 - Each RPC reply uses one send_ctxt at a time; concurrent in-flight
   ctxts therefore cannot legitimately exceed sc_max_requests in
   steady state.
 - Workqueue lag can momentarily push (in-flight + queued) above
   sc_max_requests, but those ctxts are exactly what the cap should
   shed -- they are not steady-state working set, just lag-inflation.

The reuse semantics of the cache are intentional and unchanged: ctxts
keep their first SGE DMA-mapped across cycles, so the steady-state
hot path stays alloc-free.  Only the *excess* ctxts are freed.

A simple-CID tracepoint, svcrdma_send_ctxt_capped, fires once per
freed-by-cap ctxt, so operators can confirm the cap is doing real
work on a given workload.

== Verification on the test rig ==

Diagnostic tool: svcrdma-wq-lag.bt (will be provided in reply to
this patch) -- per-5s rates of wc_send (queue inflow), _put_async
(workqueue dispatch), _get (demand), and the new tracepoint.

Negative case (cap on on-llist depth alone, with the atomic
incremented in _release and decremented in _get), sustained NFS
READ load:
  wc_send ~432K/s, release ~342K/s
  -> ~90K/s of ctxts pinned as queued sc_work items
  -> ~2.7M pinned after 30s; matches the slab measurement
  -> svcrdma_send_ctxt_capped fires 0 times during the test, then
     floods (~3.25M events) on test stop as the workqueue catches up

  The cap is structurally blind to ctxts pinned in workqueue items
  because depth only counts what's currently on the llist; during
  sustained load almost nothing makes it onto the llist before the
  next _get takes it back off.  Inflation accumulates as queued
  sc_work items, invisible to the cap, until load stops.

Post-patch (depth tracked at alloc/destroy + _get backpressure),
same workload, 5 minutes:
  wc_send and release rates match within 1% (~410K/s each)
  No accumulation; no flood at test stop
  svcrdma_send_ctxt_capped fires ~13 times total (rare overshoot
  recovery)
  Throughput slightly higher than the negative case (cache no longer
  bloats the slab/page allocator into reclaim)

The persistent wc_send/release gap in the negative case was itself
a consequence of the unbounded growth: cache bloat -> slab pressure
-> reclaim activity -> workqueue starvation -> larger gap.  Once
the cap breaks that spiral, the workqueue runs at full capacity and
the rates equalize.

Operators can confirm the cap is doing real work via:
   cd /sys/kernel/tracing
   echo 1 > events/rpcrdma/svcrdma_send_ctxt_capped/enable
   cat trace_pipe

If a workload genuinely needs more than sc_max_requests concurrent
in-flight Sends, raise it via the sunrpc.svcrdma_max_requests sysctl
rather than removing the cap.

== Diagnostics caveats ==

A previous diagnostic pass on this code path was misled by GCC
inlining of svc_rdma_send_ctxt_put into all in-tree callers (same
TU): the symbol stays in kallsyms (lowercase t) but no caller jumps
there, so kprobes attach without warning yet fire zero times.  This
made an inventory script's "@inflight = gets - puts" appear to be
monotonically rising, falsely confirming a per-op lifecycle leak.
Hooking svc_rdma_send_ctxt_put_async (a workqueue function-pointer
target, forced out-of-line by INIT_WORK) instead of _put gets
accurate accounting and shows gets/puts balanced within ~1% under
load.  Future probes in this path should prefer function-pointer
targets, tracepoints, or kmem tracepoints over kprobes on small
non-static functions in the same TU as their callers.

Reported-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
Diagnosed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Benjamin Coddington <ben.coddington@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
---
 include/linux/sunrpc/svc_rdma.h          |  1 +
 include/trace/events/rpcrdma.h           |  2 ++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 41 ++++++++++++++++++++----
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  1 +
 4 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index df6e08aaad570..b8ae1032bf293 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -97,6 +97,7 @@ struct svcxprt_rdma {
 
 	spinlock_t	     sc_send_lock;
 	struct llist_head    sc_send_ctxts;
+	atomic_t	     sc_send_ctxts_depth;
 	spinlock_t	     sc_rw_ctxt_lock;
 	struct llist_head    sc_rw_ctxts;
 
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index b79913048e1a0..945152e33af8c 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -2027,6 +2027,8 @@ DEFINE_SIMPLE_CID_EVENT(svcrdma_wc_send);
 DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_send_flush);
 DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_send_err);
 
+DEFINE_SIMPLE_CID_EVENT(svcrdma_send_ctxt_capped);
+
 DEFINE_SIMPLE_CID_EVENT(svcrdma_post_recv);
 
 DEFINE_RECEIVE_SUCCESS_EVENT(svcrdma_wc_recv);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 8b3f0c8c14b25..e487d2815b33e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -158,6 +158,7 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 
 	for (i = 0; i < rdma->sc_max_send_sges; i++)
 		ctxt->sc_sges[i].lkey = rdma->sc_pd->local_dma_lkey;
+	atomic_inc(&rdma->sc_send_ctxts_depth);
 	return ctxt;
 
 fail3:
@@ -170,6 +171,20 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 	return NULL;
 }
 
+/* Tear down a single send_ctxt: reverse of svc_rdma_send_ctxt_alloc. */
+static void svc_rdma_send_ctxt_destroy(struct svcxprt_rdma *rdma,
+				       struct svc_rdma_send_ctxt *ctxt)
+{
+	struct ib_device *device = rdma->sc_cm_id->device;
+
+	ib_dma_unmap_single(device, ctxt->sc_sges[0].addr,
+			    rdma->sc_max_req_size, DMA_TO_DEVICE);
+	kfree(ctxt->sc_xprt_buf);
+	kfree(ctxt->sc_pages);
+	kfree(ctxt);
+	atomic_dec(&rdma->sc_send_ctxts_depth);
+}
+
 /**
  * svc_rdma_send_ctxts_destroy - Release all send_ctxt's for an xprt
  * @rdma: svcxprt_rdma being torn down
@@ -177,17 +192,12 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
  */
 void svc_rdma_send_ctxts_destroy(struct svcxprt_rdma *rdma)
 {
-	struct ib_device *device = rdma->sc_cm_id->device;
 	struct svc_rdma_send_ctxt *ctxt;
 	struct llist_node *node;
 
 	while ((node = llist_del_first(&rdma->sc_send_ctxts)) != NULL) {
 		ctxt = llist_entry(node, struct svc_rdma_send_ctxt, sc_node);
-		ib_dma_unmap_single(device, ctxt->sc_sges[0].addr,
-				    rdma->sc_max_req_size, DMA_TO_DEVICE);
-		kfree(ctxt->sc_xprt_buf);
-		kfree(ctxt->sc_pages);
-		kfree(ctxt);
+		svc_rdma_send_ctxt_destroy(rdma, ctxt);
 	}
 }
 
@@ -226,6 +236,14 @@ struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
 	return ctxt;
 
 out_empty:
+	/* Backpressure: refuse to mint a new ctxt once the per-xprt total
+	 * (in-flight + queued for release + on-llist) has reached the
+	 * configured slot count. The caller drops the connection; the
+	 * client reconnects with a fresh xprt. Better than the unbounded
+	 * allocation that lets workqueue lag inflate the cache to OOM.
+	 */
+	if (atomic_read(&rdma->sc_send_ctxts_depth) >= rdma->sc_max_requests)
+		return NULL;
 	ctxt = svc_rdma_send_ctxt_alloc(rdma);
 	if (!ctxt)
 		return NULL;
@@ -257,6 +275,17 @@ static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
 				  DMA_TO_DEVICE);
 	}
 
+	/* Depth is now tracked at alloc/destroy, so it reflects total
+	 * live ctxts (in-flight + queued + on-llist), not just on-llist.
+	 * If we've blown past the cap -- via a race in the _get
+	 * backpressure check, or a transient burst -- destroy this ctxt
+	 * instead of returning it to the llist so the depth converges.
+	 */
+	if (atomic_read(&rdma->sc_send_ctxts_depth) > rdma->sc_max_requests) {
+		trace_svcrdma_send_ctxt_capped(&ctxt->sc_cid);
+		svc_rdma_send_ctxt_destroy(rdma, ctxt);
+		return;
+	}
 	llist_add(&ctxt->sc_node, &rdma->sc_send_ctxts);
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index f18bc60d9f4ff..7708634ebf587 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -176,6 +176,7 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 	INIT_LIST_HEAD(&cma_xprt->sc_rq_dto_q);
 	INIT_LIST_HEAD(&cma_xprt->sc_read_complete_q);
 	init_llist_head(&cma_xprt->sc_send_ctxts);
+	atomic_set(&cma_xprt->sc_send_ctxts_depth, 0);
 	init_llist_head(&cma_xprt->sc_recv_ctxts);
 	init_llist_head(&cma_xprt->sc_rw_ctxts);
 	init_waitqueue_head(&cma_xprt->sc_send_wait);
-- 
2.44.0


