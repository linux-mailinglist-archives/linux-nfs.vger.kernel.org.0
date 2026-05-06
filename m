Return-Path: <linux-nfs+bounces-21409-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMdcI0Mn+2kQXAMAu9opvQ
	(envelope-from <linux-nfs+bounces-21409-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 13:34:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF7E4D9BC7
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 13:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2435230095E1
	for <lists+linux-nfs@lfdr.de>; Wed,  6 May 2026 11:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB3542DFE0;
	Wed,  6 May 2026 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8wBESc7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637D438FEE
	for <linux-nfs@vger.kernel.org>; Wed,  6 May 2026 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778067261; cv=none; b=tAQsY1gItr8WlN1XjKuJ4IYuSl9LXXlirr5XDO/VtHQ8rTOrnaGTxGrORDccZmCaankZ1w0F7RmyXrQTZn+IHAPA7/LxIqfxhoJyihYjNb1XPCDz5qAUhsBgSjTjwQzhkS53PwyOqO39KvFCUdhElb6BNQrBX5BWw87Nno4IbDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778067261; c=relaxed/simple;
	bh=IBZxUt25QyRMx3vB3c/efu/nEpizSafL7Il9mWbqYDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrGkaHugJTIUBlWzfUomuKt+Gtk9kUMcQkfOwvA/l7/u85i0nAo9syRq+UocVwaekrHb+MXOp+Sxq7rPBavwWOU31x52MmY/V2gVTYQI/CmyNqEL10fAMWCAX5fgsBZZs+G0sUi5epEU3iMn+AgxtPVV5uHGte6QYQPj45ru4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8wBESc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B33C2BCB8;
	Wed,  6 May 2026 11:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778067261;
	bh=IBZxUt25QyRMx3vB3c/efu/nEpizSafL7Il9mWbqYDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8wBESc7Url1vPRKJA7wLkq5M55484Hiaf/v3HUVh2F9JxTgZM8dB2gzc/KDak7GE
	 9BCvDoC+4OoDkFZXUEgxo48IeUcga8dPegbApGKg1zwDmLevOvP9LuQ9yQwSvIhQL1
	 U3e20KSj0p7Vd6Hk/BwyGylqeiow5xNMsEoAf2CIKyGoVcQdIV2ZLmaJhbOkQruFdi
	 xs7V4rO2UorPL7euVF10VXwDkN/p3/P6lz91a4Ie4a5gx278MCFwpdcc+lc8IlyTXu
	 RiDW4vXSEumer7pfS/qAw1/gEHCAsYnmr6kWlSi/Te83iBzZVmS3UpWBOEsgKS3At0
	 vOnnuqSkPOX4A==
Date: Wed, 6 May 2026 07:34:20 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Mike Snitzer <snitzer@hammerspace.com>, linux-nfs@vger.kernel.org,
	ben.coddington@hammerspace.com, jonathan.flynn@hammerspace.com
Subject: Re: [RFC PATCH 1/2] svcrdma: bound per-xprt sc_send_ctxts cache and
 apply backpressure on _get
Message-ID: <afsnPPujM016BExw@kernel.org>
References: <20260505215535.68412-1-snitzer@kernel.org>
 <20260505215535.68412-2-snitzer@kernel.org>
 <0010c891-174d-468a-be80-f53fa60ac5c7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0010c891-174d-468a-be80-f53fa60ac5c7@app.fastmail.com>
X-Rspamd-Queue-Id: 8CF7E4D9BC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21409-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Wed, May 06, 2026 at 08:01:50AM +0200, Chuck Lever wrote:
> 
> 
> On Tue, May 5, 2026, at 11:55 PM, Mike Snitzer wrote:
> > From: Benjamin Coddington <ben.coddington@hammerspace.com>
> >
> > Under sustained heavy load over RDMA, kNFSD servers can pin tens of
> > gigabytes of memory in per-xprt svc_rdma_send_ctxt caches, never
> > released until the connection terminates.  A customer site reported
> > OOM kills under heavy NFS READ workloads with ~2.3M cached
> > send_ctxts visible via slab tracing (two stacks in
> > svc_rdma_send_ctxt_alloc, each kmalloc-4k, ~9.5 GB outstanding --
> > the same ctxt population double-counted across the sc_pages and
> > sc_xprt_buf allocations).  Aggregated across the customer's ~218
> > long-lived xprts that worked out to roughly 80 GB pinned, freed only
> > by knfsd restart.
> >
> > Root cause is an unbounded cache, not a per-op leak.
> > svc_rdma_send_ctxt_get() pulls from rdma->sc_send_ctxts (an llist) or,
> > on empty, allocates fresh.  svc_rdma_send_ctxt_release() always
> > llist_add()s the ctxt back -- regardless of how many ctxts are
> > already on the list.  The only kfree() site is
> > svc_rdma_send_ctxts_destroy() at xprt teardown.  The list has no
> > shrinker, no cap, no aging: it can only grow.
> >
> > Two effects compound to drive the high-water mark well above the
> > configured RPC slot count:
> >
> >  1. _put runs through a workqueue.  svc_rdma_send_ctxt_put() does
> >     INIT_WORK(...) ; queue_work(svcrdma_wq, ...) and returns.  The
> >     actual _release (which puts the ctxt back on the llist) runs
> >     later on svcrdma_wq.  Between wc_send -> _put and _put_async ->
> >     _release, the ctxt is "in transit" -- off the list, off the SQ,
> >     not yet reusable.
> >
> >  2. During that gap, a concurrent _get sees an empty llist and calls
> >     _alloc to mint a fresh ctxt.  When the in-transit one eventually
> >     lands on the llist, the cache has grown by one.  Under HCA-driven
> >     completion rates with even small workqueue dispatch lag, this
> >     happens constantly.  The cache settles not at the steady-state
> >     in-flight count but at the all-time peak of (in-flight +
> >     workqueue-pending), and never shrinks.
> >
> > Fix: track sc_send_ctxts_depth as the count of *live* ctxts on the
> > xprt (incremented in svc_rdma_send_ctxt_alloc, decremented in
> > svc_rdma_send_ctxt_destroy).  Apply the cap in two places:
> >
> >   - svc_rdma_send_ctxt_get(): when the llist is empty and depth has
> >     reached sc_max_requests, return NULL instead of allocating.  The
> >     caller drops the connection; the client reconnects with a fresh
> >     xprt that starts at depth zero.  This is the backpressure point
> >     that prevents in-test memory growth -- it stops new allocations
> >     regardless of where in the pipeline existing ctxts are stuck.
> >
> >   - svc_rdma_send_ctxt_release(): if depth has overshot the cap (race
> >     between concurrent _get callers, or transient burst), free the
> >     ctxt instead of returning it to the llist.  This keeps depth
> >     convergent.
> >
> > The cap is sc_max_requests because:
> >  - It is the configured number of credit slots per xprt -- the client
> >    can have at most this many RPCs outstanding on the transport.
> >  - Each RPC reply uses one send_ctxt at a time; concurrent in-flight
> >    ctxts therefore cannot legitimately exceed sc_max_requests in
> >    steady state.
> >  - Workqueue lag can momentarily push (in-flight + queued) above
> >    sc_max_requests, but those ctxts are exactly what the cap should
> >    shed -- they are not steady-state working set, just lag-inflation.
> >
> > The reuse semantics of the cache are intentional and unchanged: ctxts
> > keep their first SGE DMA-mapped across cycles, so the steady-state
> > hot path stays alloc-free.  Only the *excess* ctxts are freed.
> >
> > A simple-CID tracepoint, svcrdma_send_ctxt_capped, fires once per
> > freed-by-cap ctxt, so operators can confirm the cap is doing real
> > work on a given workload.
> >
> > == Verification on the test rig ==
> >
> > Diagnostic tool: svcrdma-wq-lag.bt (will be provided in reply to
> > this patch) -- per-5s rates of wc_send (queue inflow), _put_async
> > (workqueue dispatch), _get (demand), and the new tracepoint.
> >
> > Negative case (cap on on-llist depth alone, with the atomic
> > incremented in _release and decremented in _get), sustained NFS
> > READ load:
> >   wc_send ~432K/s, release ~342K/s
> >   -> ~90K/s of ctxts pinned as queued sc_work items
> >   -> ~2.7M pinned after 30s; matches the slab measurement
> >   -> svcrdma_send_ctxt_capped fires 0 times during the test, then
> >      floods (~3.25M events) on test stop as the workqueue catches up
> >
> >   The cap is structurally blind to ctxts pinned in workqueue items
> >   because depth only counts what's currently on the llist; during
> >   sustained load almost nothing makes it onto the llist before the
> >   next _get takes it back off.  Inflation accumulates as queued
> >   sc_work items, invisible to the cap, until load stops.
> >
> > Post-patch (depth tracked at alloc/destroy + _get backpressure),
> > same workload, 5 minutes:
> >   wc_send and release rates match within 1% (~410K/s each)
> >   No accumulation; no flood at test stop
> >   svcrdma_send_ctxt_capped fires ~13 times total (rare overshoot
> >   recovery)
> >   Throughput slightly higher than the negative case (cache no longer
> >   bloats the slab/page allocator into reclaim)
> >
> > The persistent wc_send/release gap in the negative case was itself
> > a consequence of the unbounded growth: cache bloat -> slab pressure
> > -> reclaim activity -> workqueue starvation -> larger gap.  Once
> > the cap breaks that spiral, the workqueue runs at full capacity and
> > the rates equalize.
> >
> > Operators can confirm the cap is doing real work via:
> >    cd /sys/kernel/tracing
> >    echo 1 > events/rpcrdma/svcrdma_send_ctxt_capped/enable
> >    cat trace_pipe
> >
> > If a workload genuinely needs more than sc_max_requests concurrent
> > in-flight Sends, raise it via the sunrpc.svcrdma_max_requests sysctl
> > rather than removing the cap.
> 
> The current svcrdma design assumes that the workqueue always keeps up
> with the transport's Reply transmission rate. For the send_ctxt cache
> to reach 2.3M ctxts, the workqueue itself must be running orders of
> magnitude slower than wc_send.
> 
> The "in transit" gap between wc_send -> _put and _put_async ->
> _release is structurally one workqueue dispatch; under normal
> scheduling, microseconds. The verification numbers show a sustained
> 90K/s deficit (432K wc_send/s vs 342K release/s) that accumulates
> linearly. That deficit is the actual pathology here...
> 
> So I'm wondering: Why does svcrdma_wq lag at steady state? _put_async
> is small work -- ib_dma_unmap_page_list plus an llist_add. On a busy
> box it should easily outpace wc_send, not trail it by ~21%.
> 
> The cover letter posits a spiral: cache bloat -> slab pressure ->
> reclaim -> workqueue starvation -> more bloat. That makes the eventual
> collapse plausible, but it does not establish what initiates the
> spiral. If the workqueue keeps up at low cache size and only loses
> ground after slab/reclaim kicks in, the early-load gap should be
> small and growing. If the gap is fixed at 21% from second zero,
> something structural is throttling the workqueue independent of slab
> state.
> 
> Under sustained workqueue lag the cap fires not because the working
> set exceeds sc_max_requests but because the workqueue backlog does.
> Capping at sc_max_requests then translates "workqueue is slow" into
> "drop the connection." That bounds memory but substitutes one failure
> mode for another, and it punishes the client for what is essentially
> a server-side scheduling problem. Not to mention the risks inherent
> in repeated spurious connection loss.

Thanks for all that context.  Yes the imposed connection loss isn't
ideal when the cap hits but in practice its relatively rare even with
the more extreme small (16K) workload.  If larger IO size used the
workqueue is able to keep up.

> I have a couple of patches that replace the use of svcrdma_wq, and
> could alleviate the spiral issue. Would you be interested in trying
> them with your reproducer?

Yes, please share and we'll do our best to get time on the system.

We have some constraints at the moment that confine us to only making
module changes (otherwise, if core kernel changes needed, it'd trigger
a much more involved general kernel update that'd require coordination
with the admins due to netboot infra).

Thanks,
Mike

