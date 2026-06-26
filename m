Return-Path: <linux-nfs+bounces-22849-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s+ZDN+znPWrs7wgAu9opvQ
	(envelope-from <linux-nfs+bounces-22849-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 04:46:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 878D16C9DB0
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 04:46:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=o5EAFetw;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="Y SMOEsx";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22849-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22849-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1632300C7CA
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 02:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAB02777F3;
	Fri, 26 Jun 2026 02:45:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A26B149C6F
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2026 02:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782441959; cv=none; b=mtRW+QsqZtBlUmnMWFxEO9ugN07b98A9/wXlTjLc0hsq53gaH6hgwMcdlv4tAK/p1TFpPFuILqc23ALJvGi/550vMkuC+rMti0f7wXYxTpcL2w3cSsq+GB6VqNBVT9OrHv3clvLAJgxzt5g1Jot0EVgECDOXfmMXvoDVKKfDvDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782441959; c=relaxed/simple;
	bh=I7A4xLnhYW8fQzuu6KL5x/VorVWBBi255sizVBuAgMs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gBZLzr71sE/kcGuYYXIL/54ZjA8uoR/QsgmnsiJbpREIW/7j335g7V0ypn+4NWXuuZE4T63/hImAiW3pyfLnwWhQt4rnekJ/ASXD0+rP18ETW22qr+eHplemHaU0fZfps3EJrVkRyGiS46X+zW0q23LL9nLSRfLfQxFQBWB+3zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=o5EAFetw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSMOEsxo; arc=none smtp.client-ip=202.12.124.145
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 54F2E1D000FE;
	Thu, 25 Jun 2026 22:45:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 25 Jun 2026 22:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1782441956; x=1782528356; bh=Pkt01ccpq47R5dLh6sm5YxO5bvUnWXXdiiP
	B8sutIz0=; b=o5EAFetwounPQiJU2MTQxutI9jmsVlLXOiLwrWlnfCEcCi4Eveh
	dAf+2HrQI86IXEUDTetN6/GNoxbZPIAE4JMxeEafjRfKbhKsTCdgI2Hi2Is2q7/K
	hDda5DhiTM8k+NH3nVtMmnNKPMQuWmWn50c9R1631ZNEomt2QVvP2wUTAGFGJdX0
	BFoBULjwDVT8ZP66iaCccZQevHEgyMRek7kMZI187Itwm7HeJJ/iBgVlrBcslSxU
	6JizY/HwbDaBHoRLzArdgSQJKNwWK+IwP2StmYzVT+K3dDSFO0Lcjy+a72z9TOne
	ZoEu6BSxvWSLECXl+qWywqS8LV9iQRg92vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782441956; x=
	1782528356; bh=Pkt01ccpq47R5dLh6sm5YxO5bvUnWXXdiiPB8sutIz0=; b=Y
	SMOEsxogZo8N03z468Pzs3R0pRZInnlMc5Zkacvx27hg7hmI1ZXcFGnf+a+aBTfl
	GbaCryviEZ/R3Rqxol9tsP3aAXCgvH2DD7zJ5yHA9yZML0sRu7ilUtwyPvGTdmpt
	e3HJBHHR28jTBqtHpWkwzI02xdmwnuUQ1sR0j5pm0BygNGB0E/pp3iRK1DIJMDsx
	TRAgPoJHz4KaSt/31RJcTqHgptLEzSN4gVl0RxxDP0i50f8bLkmPOr/CYPXsb3bV
	Ds2J4nHaz7OzHqJqWPn3qMNXflP9OTJNbkzPTMcDFTAWZ+kRMg+LbxJjCNnNht6o
	DnLAefdmfYZF3CRG4hgRw==
X-ME-Sender: <xms:4-c9agUxDrzHMMqZr3HtmsoupfSWyk35HXDPnMeRp_Z1hzFz23LzfA>
    <xme:4-c9ahJEfdBXOyJGGjwy0T15hgax-Nw-nAmn-xnCGkAGDE4ZMvKsyVA-8SHptMC8n
    0jriVCZ9DRZh0tsHaMjOV7_icHR7EzyX1GF4NPtJP7wJY3aMQw>
X-ME-Received: <xmr:4-c9ao1gvCB7B-NCsDsP0Ey2-SVmeK1LlGRMq11y04DfR4nbiAUOLPMQg-YA4gIISD16MfMvlaABFuFit1UUA-lzvm6RvUU>
X-ME-Proxy-Cause: dmFkZTGlQ8fcwGP2ef6HggM3qq+pgRkDbt/Mm2asvhIfAXfh6tY095h3FV4Xp1a6iyTWjG
    9VmivgSz2sbF/kQXKLJ4sdP2maDjlzJfVgRe3jJpdD8zcZLBEWgFKIJaRm+f27OCqcNLyQ
    bLV3K1dazcjY7z2V9XJlJI1tIDy0YQ3OSEClkfbHaIOPW6hQZAX1FM1EAAmH7ZZdHA8ejA
    6zjW3/EoGgbom3Uo+1Uu6b4Bu8sZXdSBxPEcJKE/VRRztdTA8dVXiZw8cG8zxD6/Oz8HN9
    5Ls187diyXSR7fKvNekRmA3rGq6cEr/Eklmdu8iJwTJ06dDf+sFvovyvoNz0Fy8wVQTjnW
    NEXSpJhUOwuuNpNBrm6SP1w/MWQ4bs6iKPBbkzmsgs8qEttZGGuXV2MMBPUrBPM/Ymj524
    NV8uilIjVm+/Qcq/Z+uMwggQWR/uT/sj2IowR8cnApPf5hjeh4nEXoE0pi3qWv8qdBUivk
    aO7gmqJ1zf0iO1rsvMp+yWw28uyqMI+juZj1h/bq3Y3KpPndrOVnvM7gy1V9kdgoZ0pTdZ
    3vGdeYcgGI8Zr3uwOXZOPPIboUkP0mCVdTl+GlJVSXkd0+avuznKb37d17o1pESSglRmNM
    zbiV5fwKZxi/XsuWrul6ydVL3TvjPJ2O52W41k1inkuyGqNY1Ths8CufuXSg
X-ME-Proxy: <xmx:4-c9amLLZKeEabusmDqYX2tD2HuzjKIwX4BRPSe2dnzJ_xp79iuo2w>
    <xmx:4-c9arh8GqsZFyFIezZa4-3aJ8_JAv4-Nfb01UETHmET9GxdpP1UOg>
    <xmx:4-c9auDh9gjG_TnHv753-qtcoUo-YBa2ca-Od9kxcFoRuGsq0xavIg>
    <xmx:4-c9al7VTa5LaDzUOb5SBs5HACS0XCQDoo5nH3EtsyFun1_ytJE_0Q>
    <xmx:5Oc9asDu59RgStkyxVZSnu_u6To6KrVTmJk4E24mw4RWMGL8CHDFC-nw>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 22:45:52 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>
Cc: "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Daire Byrne" <daire@dneg.com>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] SUNRPC: a latency floor for interactive clients
 via sparse-flow dispatch
In-reply-to: <cover.1782314746.git.bcodding@hammerspace.com>
References: <cover.1782314746.git.bcodding@hammerspace.com>
Date: Fri, 26 Jun 2026 12:45:48 +1000
Message-id: <178244194881.27465.15942469476886027226@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22849-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:cel@kernel.org,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:daire@dneg.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:from_mime,messagingengine.com:dkim,brown.name:replyto,vger.kernel.org:from_smtp,noble.neil.brown.name:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 878D16C9DB0

On Thu, 25 Jun 2026, Benjamin Coddington wrote:
> This RFC follows the per-client fair-scheduling discussion from May/June
> [1], and Chuck's slot-growth clamp that grew out of it [2].  It takes the
> direction that thread settled on: rather than enforce proportional
> fairness between clients, give an interactive client a latency floor that
> a busy neighbour cannot push it below.
>=20
> Problem
> -------
>=20
> nfsd dispatches ready transports per-pool in FIFO order, with no notion of
> how much work each transport already has outstanding.  A client that keeps
> many requests in flight -- nconnect, a deep v4.1 slot table, or simply
> several connections -- sits in that queue on equal terms with a client
> that has been idle.  So the request a user is waiting on (a stat, an open,
> a directory listing) waits behind a backup job's backlog, even though
> servicing it costs a single round trip.  The user-visible symptom is an
> interactive session that stutters whenever a bulk client is busy.
>=20
> Approach
> --------
>=20
> This is starvation avoidance, not proportional fairness (per Chuck's
> reframe on [1]).  The protected unit is the interactive cycle: one user
> command fans out into a burst of correlated RPCs, so it is the whole
> burst, not a single RPC, that must be allowed to jump ahead.
>=20
> The signal is already on every transport: xpt_nr_rqsts, the count of
> requests in flight.  A transport with nothing in flight when new work
> arrives is, by definition, not the one hogging threads -- so it goes on a
> second, high-priority per-pool queue that is drained ahead of the normal
> one.  To cover the whole burst rather than only its leading edge, an
> idle->active transport is granted a budget of 64 high-priority dispatches,
> spent down as the burst is serviced and refilled only when the transport
> next idles.  A transport that never idles spends its budget once and then
> shares the normal queue like everyone else.
>=20
> There is no client identity anywhere in this -- it keys only on a
> transport's own in-flight depth -- so it covers v3, v4.0 and v4.1
> uniformly, needs no lookup or lifecycle, adds no lock (the existing lwq
> barriers carry the sleep/wake), and is always on with nothing to tune.
> (LOCALIO is out of scope: a local client's reads and writes bypass the
> RPC dispatch path entirely, so they neither contend here nor are
> reordered by this change.)
>=20
>   patch 1  add the second per-pool ready queue (no functional change)
>   patch 2  dispatch idle transports ahead of backlogged ones
>   patch 3  grant the 64-RPC burst budget
>=20
> Relationship to Chuck's slot-growth RFC
> ---------------------------------------
>=20
> This series is based on Chuck's "Stop NFSv4.1 slot-growth heuristic from
> rewarding busy clients" [2], and both A and B above include it -- so the
> A/B delta isolates this series and the clamp does not account for the
> improvement.
>=20
> The two are complementary, not overlapping.  [2] stops nfsd from growing a
> busy session's slot table past the thread ceiling: nfsd slot accounting.
> This series changes the order in which ready transports are dispatched:
> sunrpc dispatch.  Basing on [2] changes neither the design nor the result
> here -- a slot-capped session still fills the pool, so the dispatch-layer
> floor is still wanted on top of it.
>=20
> Results
> -------
>=20
> Because the goal is a latency floor and not a share, the measurement
> differs from the earlier bucket RFC and the numbers are not comparable:
> that series measured a greedy client's share of throughput; this one
> measures how long an interactive client's command takes to complete while
> a neighbour is busy.
>=20
> Workload: a backlogged aggressor (K connections, deep offered load,
> saturating the pool) shares the server with one interactive client that
> issues a burst of N requests, waits for all replies, idles 50ms, and
> repeats.  A 10ms service time is injected per op (a test-only debug hook,
> not part of this series) so the measurement isolates the dispatch path from
> filesystem work.  A is stock nfsd-testing; B is the same plus this series.
> Figures are NFSv3 burst-completion p50 in ms; NFSv4.1 tracks within a few
> percent (the classifier uses no source identity, so v3 runs on plain
> loopback and behaves the same).
>=20
> Interactive burst completion vs aggressor connection count K (N=3D32;
> unobstructed floor 45ms):
>=20
>     K       4      8     16     32
>     A    81.6  242.0  432.9  826.6
>     B    60.9   64.5   65.4   64.4
>          1.3x   3.8x   6.6x  12.8x
>=20
> Baseline climbs ~linearly with the aggressor's backlog; patched holds the
> floor no matter how deep that backlog is -- the property that matters.
>=20
> vs burst size N (K=3D16), showing the 64-credit knee (floor for reference):
>=20
>     N        1      8     32     64     96    128
>    floor  14.9   31.9   44.8   71.5   96.8  122.4
>     A     28.6  122.0  434.2  862.4 1272.6 1696.3
>     B     16.7   36.0   65.1  124.5  546.4  961.6
>=20
> For N <=3D 64 the whole burst is covered and tracks the floor (B within
> 1.7x); beyond 64 the uncovered tail -- the N-64 RPCs that spill to the
> normal queue -- degrades toward baseline (B/floor jumps 1.7x -> 5.6x
> across the 64->96 boundary).  The knee at exactly 64 is the budget working
> as designed, not a regression.
>=20
> Aggregate throughput (aggressor + interactive) is within 1% A vs B at
> saturation (~1290 ops/s) -- the dispatcher reorders, it does not throttle.
> With no aggressor the interactive floor is identical A vs B; the kernels
> differ only under contention.
>=20
> Figures are p50; longer runs are available for firmer tails.
>=20
> What this deliberately does not do
> ----------------------------------
>=20
> - It is not proportional fairness.  Two backlogged clients still split the
>   pool by connection count; this protects only flows that idle.
>=20
> - The normal queue can wait under sustained high-priority load.  v1 drains
>   high-priority strictly first; bounding that starvation -- an inter-tier
>   deficit round-robin, the way fq_codel actually interleaves its sparse
>   and bulk tiers -- is left for a follow-up, pending the question below.
>=20
> - The 64-dispatch budget defeats a pipelined aggressor (it lands wholly in
>   the normal queue), but a client that shapes its traffic to look sparse
>   -- send <=3D64, drain, repeat -- can still scale its high-priority share
>   with connection count.  Whether to harden against that is the open
>   question: if this is cooperative scheduling (Neil's framing) a bulk
>   floor suffices; if it is an attack surface (Chuck's framing) the
>   high-priority tier needs intra-tier fairness, which reintroduces
>   identity.
>=20
> Open questions for the list: is the budget (64 here) the right shape, and
> should it be fixed, derived from the thread count, or hinted by the v4.1
> slot table?  And does the cooperative framing hold, or must we resist
> deliberate sparse-shaping?

I wonder if we should make "batch" the special case, rather than
"interactive".
I don't think this makes a big difference to the code (there are still
two queues and everyone starts out interactive) but it might change how
we think about it.

I would wait a lot longer than 64 requests before considering an
xprt to be "batch", and I would probably want to measure it in
seconds rather than requests.  Maybe 10-15 seconds.
I might also only consider an xprt batch if xpt_nr_rqsts remains above
some small number - maybe 5.

Maybe we could keep track of the number of "batch" xprts and compare it
to the thread limit.  Batch xprts might only be allowed some share of
the thread limit...

If there are a bunch of READ requests on the same file, the first could
trigger a read-ahead, and the next several might wait for that
read-ahead, so they would all be blocked on the same thing, which can be
pointless.  nfsd doesn;'t have any direct visibility into this, but
limiting requests-per-xprt differently for batch and interactive might
be useful.  non-sync WRITE requests probably behave differently...

While this approach does seem pleasingly simple, I wonder how easy it
would be for a client to accidentally start appearing to be "batch".
Multiple interactive sessions on the one client could incorrectly
trigger the batch detection.

Maybe it would be useful to collect some statistics of what a "batch"
stream typically looks like (OP mix, concurrency,...) as there may be a
better signal to look for than xpt_nr_rqsts.

Thanks,
NeilBrown


>=20
> [1] https://lore.kernel.org/linux-nfs/cover.1780498019.git.bcodding@hammers=
pace.com/
> [2] https://lore.kernel.org/linux-nfs/20260610-nfsd-slot-growth-clamp-v1-0-=
7b966700df0b@kernel.org/
>=20
> Benjamin Coddington (3):
>   SUNRPC: add a second per-pool ready queue for high-priority transports
>   SUNRPC: dispatch idle transports ahead of backlogged ones
>   SUNRPC: grant an idle flow a burst allowance on the high-priority
>     queue
>=20
>  include/linux/sunrpc/svc.h      |  1 +
>  include/linux/sunrpc/svc_xprt.h |  1 +
>  net/sunrpc/svc.c                |  1 +
>  net/sunrpc/svc_xprt.c           | 52 +++++++++++++++++++++++----------
>  4 files changed, 39 insertions(+), 16 deletions(-)
>=20
> --=20
> 2.53.0
>=20
>=20


