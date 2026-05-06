Return-Path: <linux-nfs+bounces-21403-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE22MWrZ+ml8TQMAu9opvQ
	(envelope-from <linux-nfs+bounces-21403-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 08:02:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD184D66E4
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 08:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D8A730028DB
	for <lists+linux-nfs@lfdr.de>; Wed,  6 May 2026 06:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8481E7C18;
	Wed,  6 May 2026 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDT0TrSp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AA313AD1C
	for <linux-nfs@vger.kernel.org>; Wed,  6 May 2026 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778047333; cv=none; b=s4oQ5joZ2m9Iy/lIvLvBnl3XWsWrkggj+qj31Ad+gUJobrdcQI7bWaL9wyPuTF5cxD5DvS3q3C+NYwNrHmyee+YeI1ffmeEmN+yyXVHbE+TsFKd2/GSA/zsjmIrUqCBUPNTUvv5nGbHLA3lT80uhOVFcwU0Q8R4DdxuIL23DvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778047333; c=relaxed/simple;
	bh=QtLVs3zBzk46qx2LaVlm+gUg28FUB++0gks4zqQaLGA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h+ntmcI5tbe+hrkxFYzg0pURd5C0OlG+rWavvQiaBODICdsW/mBa8Huy0cCmIpyXCJK6QDs8uwWqrP0E3vC4M87zUkkwZqVMdakaKiL+L+Y+/F9xr3oJ75cpe7HaC+11UN53TZdTm4s52kowNHWAC6+P/igLGJDScc50fUaC6KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDT0TrSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B83C2BCB8;
	Wed,  6 May 2026 06:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778047333;
	bh=QtLVs3zBzk46qx2LaVlm+gUg28FUB++0gks4zqQaLGA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HDT0TrSpXpqhaLM8TOBeXV7lS+LBEqCbgq65ACmvpMCdivmQ4eMYZYxYEqiojboBL
	 MLQVbLHqRrm/KmTME6KuIMXOZClDjR5nbmwH1KvAagNzaNsHnxTTIMqtdw4IWLbrMv
	 4G/+KP/xG2/+DSWBpXEnm3UxYjhXQ02NVtF2xfRb6RH5tcBL2EJw5DzIZnNuPXYv1m
	 zrOHrO3YjGZ98t1nwzC/qsbdTY9G65vG3Oxls1qTz0Dx5KT6Mn+qUwkpXbZiWqFetM
	 xw8Sv2ZUBq5NhyS3MRbrTV+XQiRVOmRr4NuhW4sNirzO9EnVWh1K7P+g3UdXT5RDMn
	 UKtfRUnYm8pag==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id EFBD2F40079;
	Wed,  6 May 2026 02:02:11 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 06 May 2026 02:02:11 -0400
X-ME-Sender: <xms:Y9n6aXEjTLgRYGS1bbSw3BBacyG4L0Ax7i5B5LA8BOkAlyqpAHfKkQ>
    <xme:Y9n6afJw_WUDIlJutxAN_D7of2Xl__SK9BhAuzEYw3JXD87fiEmmz0mtI-FyUvbxs
    RahHOkOropzGEYoI7lMGcCEgze4tgkderVcFkErqcC0la3ts42O0rE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsggvnhdrtghougguihhnghhtohhnsehhrghmmhgvrhhsphgrtggvrdgtohhmpd
    hrtghpthhtohepjhhonhgrthhhrghnrdhflhihnhhnsehhrghmmhgvrhhsphgrtggvrdgt
    ohhmpdhrtghpthhtohepshhnihhtiigvrheshhgrmhhmvghrshhprggtvgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Y9n6aYvY5UxVnvmK-Y8kvlJ43LQQNFJVfau_gRfqxDB8UoR5FgDuBg>
    <xmx:Y9n6aTQjrkHL3cfKTffVCIEfbx_-tr5iiLS7WDP5zEILxvv5RExWmg>
    <xmx:Y9n6aePq9qPkhO7P90M4uENzeZQveoD9VSheID_iYCq-oS4oHSfD7Q>
    <xmx:Y9n6aYZCBFlxOerCLqtQ5F6-3q4L_GTDu4gBlTERLm89qJeGI9WFzQ>
    <xmx:Y9n6aYzKB8paO6DyfRZgPV9UFQc0dcKIHSwLCPDLl8QFCKqhmYpd3QPp>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CEB8A780070; Wed,  6 May 2026 02:02:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Az3pGS3ONw8o
Date: Wed, 06 May 2026 08:01:50 +0200
From: "Chuck Lever" <cel@kernel.org>
To: "Mike Snitzer" <snitzer@hammerspace.com>
Cc: linux-nfs@vger.kernel.org, ben.coddington@hammerspace.com,
 jonathan.flynn@hammerspace.com
Message-Id: <0010c891-174d-468a-be80-f53fa60ac5c7@app.fastmail.com>
In-Reply-To: <20260505215535.68412-2-snitzer@kernel.org>
References: <20260505215535.68412-1-snitzer@kernel.org>
 <20260505215535.68412-2-snitzer@kernel.org>
Subject: Re: [RFC PATCH 1/2] svcrdma: bound per-xprt sc_send_ctxts cache and apply
 backpressure on _get
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CBD184D66E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21403-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,app.fastmail.com:mid];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On Tue, May 5, 2026, at 11:55 PM, Mike Snitzer wrote:
> From: Benjamin Coddington <ben.coddington@hammerspace.com>
>
> Under sustained heavy load over RDMA, kNFSD servers can pin tens of
> gigabytes of memory in per-xprt svc_rdma_send_ctxt caches, never
> released until the connection terminates.  A customer site reported
> OOM kills under heavy NFS READ workloads with ~2.3M cached
> send_ctxts visible via slab tracing (two stacks in
> svc_rdma_send_ctxt_alloc, each kmalloc-4k, ~9.5 GB outstanding --
> the same ctxt population double-counted across the sc_pages and
> sc_xprt_buf allocations).  Aggregated across the customer's ~218
> long-lived xprts that worked out to roughly 80 GB pinned, freed only
> by knfsd restart.
>
> Root cause is an unbounded cache, not a per-op leak.
> svc_rdma_send_ctxt_get() pulls from rdma->sc_send_ctxts (an llist) or,
> on empty, allocates fresh.  svc_rdma_send_ctxt_release() always
> llist_add()s the ctxt back -- regardless of how many ctxts are
> already on the list.  The only kfree() site is
> svc_rdma_send_ctxts_destroy() at xprt teardown.  The list has no
> shrinker, no cap, no aging: it can only grow.
>
> Two effects compound to drive the high-water mark well above the
> configured RPC slot count:
>
>  1. _put runs through a workqueue.  svc_rdma_send_ctxt_put() does
>     INIT_WORK(...) ; queue_work(svcrdma_wq, ...) and returns.  The
>     actual _release (which puts the ctxt back on the llist) runs
>     later on svcrdma_wq.  Between wc_send -> _put and _put_async ->
>     _release, the ctxt is "in transit" -- off the list, off the SQ,
>     not yet reusable.
>
>  2. During that gap, a concurrent _get sees an empty llist and calls
>     _alloc to mint a fresh ctxt.  When the in-transit one eventually
>     lands on the llist, the cache has grown by one.  Under HCA-driven
>     completion rates with even small workqueue dispatch lag, this
>     happens constantly.  The cache settles not at the steady-state
>     in-flight count but at the all-time peak of (in-flight +
>     workqueue-pending), and never shrinks.
>
> Fix: track sc_send_ctxts_depth as the count of *live* ctxts on the
> xprt (incremented in svc_rdma_send_ctxt_alloc, decremented in
> svc_rdma_send_ctxt_destroy).  Apply the cap in two places:
>
>   - svc_rdma_send_ctxt_get(): when the llist is empty and depth has
>     reached sc_max_requests, return NULL instead of allocating.  The
>     caller drops the connection; the client reconnects with a fresh
>     xprt that starts at depth zero.  This is the backpressure point
>     that prevents in-test memory growth -- it stops new allocations
>     regardless of where in the pipeline existing ctxts are stuck.
>
>   - svc_rdma_send_ctxt_release(): if depth has overshot the cap (race
>     between concurrent _get callers, or transient burst), free the
>     ctxt instead of returning it to the llist.  This keeps depth
>     convergent.
>
> The cap is sc_max_requests because:
>  - It is the configured number of credit slots per xprt -- the client
>    can have at most this many RPCs outstanding on the transport.
>  - Each RPC reply uses one send_ctxt at a time; concurrent in-flight
>    ctxts therefore cannot legitimately exceed sc_max_requests in
>    steady state.
>  - Workqueue lag can momentarily push (in-flight + queued) above
>    sc_max_requests, but those ctxts are exactly what the cap should
>    shed -- they are not steady-state working set, just lag-inflation.
>
> The reuse semantics of the cache are intentional and unchanged: ctxts
> keep their first SGE DMA-mapped across cycles, so the steady-state
> hot path stays alloc-free.  Only the *excess* ctxts are freed.
>
> A simple-CID tracepoint, svcrdma_send_ctxt_capped, fires once per
> freed-by-cap ctxt, so operators can confirm the cap is doing real
> work on a given workload.
>
> == Verification on the test rig ==
>
> Diagnostic tool: svcrdma-wq-lag.bt (will be provided in reply to
> this patch) -- per-5s rates of wc_send (queue inflow), _put_async
> (workqueue dispatch), _get (demand), and the new tracepoint.
>
> Negative case (cap on on-llist depth alone, with the atomic
> incremented in _release and decremented in _get), sustained NFS
> READ load:
>   wc_send ~432K/s, release ~342K/s
>   -> ~90K/s of ctxts pinned as queued sc_work items
>   -> ~2.7M pinned after 30s; matches the slab measurement
>   -> svcrdma_send_ctxt_capped fires 0 times during the test, then
>      floods (~3.25M events) on test stop as the workqueue catches up
>
>   The cap is structurally blind to ctxts pinned in workqueue items
>   because depth only counts what's currently on the llist; during
>   sustained load almost nothing makes it onto the llist before the
>   next _get takes it back off.  Inflation accumulates as queued
>   sc_work items, invisible to the cap, until load stops.
>
> Post-patch (depth tracked at alloc/destroy + _get backpressure),
> same workload, 5 minutes:
>   wc_send and release rates match within 1% (~410K/s each)
>   No accumulation; no flood at test stop
>   svcrdma_send_ctxt_capped fires ~13 times total (rare overshoot
>   recovery)
>   Throughput slightly higher than the negative case (cache no longer
>   bloats the slab/page allocator into reclaim)
>
> The persistent wc_send/release gap in the negative case was itself
> a consequence of the unbounded growth: cache bloat -> slab pressure
> -> reclaim activity -> workqueue starvation -> larger gap.  Once
> the cap breaks that spiral, the workqueue runs at full capacity and
> the rates equalize.
>
> Operators can confirm the cap is doing real work via:
>    cd /sys/kernel/tracing
>    echo 1 > events/rpcrdma/svcrdma_send_ctxt_capped/enable
>    cat trace_pipe
>
> If a workload genuinely needs more than sc_max_requests concurrent
> in-flight Sends, raise it via the sunrpc.svcrdma_max_requests sysctl
> rather than removing the cap.

The current svcrdma design assumes that the workqueue always keeps up
with the transport's Reply transmission rate. For the send_ctxt cache
to reach 2.3M ctxts, the workqueue itself must be running orders of
magnitude slower than wc_send.

The "in transit" gap between wc_send -> _put and _put_async ->
_release is structurally one workqueue dispatch; under normal
scheduling, microseconds. The verification numbers show a sustained
90K/s deficit (432K wc_send/s vs 342K release/s) that accumulates
linearly. That deficit is the actual pathology here...

So I'm wondering: Why does svcrdma_wq lag at steady state? _put_async
is small work -- ib_dma_unmap_page_list plus an llist_add. On a busy
box it should easily outpace wc_send, not trail it by ~21%.

The cover letter posits a spiral: cache bloat -> slab pressure ->
reclaim -> workqueue starvation -> more bloat. That makes the eventual
collapse plausible, but it does not establish what initiates the
spiral. If the workqueue keeps up at low cache size and only loses
ground after slab/reclaim kicks in, the early-load gap should be
small and growing. If the gap is fixed at 21% from second zero,
something structural is throttling the workqueue independent of slab
state.

Under sustained workqueue lag the cap fires not because the working
set exceeds sc_max_requests but because the workqueue backlog does.
Capping at sc_max_requests then translates "workqueue is slow" into
"drop the connection." That bounds memory but substitutes one failure
mode for another, and it punishes the client for what is essentially
a server-side scheduling problem. Not to mention the risks inherent
in repeated spurious connection loss.

I have a couple of patches that replace the use of svcrdma_wq, and
could alleviate the spiral issue. Would you be interested in trying
them with your reproducer?


-- 
Chuck Lever

