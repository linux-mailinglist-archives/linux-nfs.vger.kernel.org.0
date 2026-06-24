Return-Path: <linux-nfs+bounces-22802-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1J+DJPsOPGqDjQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22802-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:08:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF45D6C03B9
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:08:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b="DLwA1/Mf";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22802-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22802-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E84673034AA2
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 17:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EAC37998A;
	Wed, 24 Jun 2026 17:04:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8263783A2
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 17:04:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320697; cv=none; b=Ldit+6P7Qqe30hiTouPMkRE/tUnadwc1eo+swUxet8Otxr/bZKiNqJDm7ir4GOBx+8snDc2PcdVVXUCzgeVb4Es7M3AvkHRAgUVhNNZveOuyJjlCOTTtc90C2P8z/Ak3De+aU/NuErGFdH8j2trZOCCU4Q6T2HVayh7qVcys2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320697; c=relaxed/simple;
	bh=pIUhTP2ugB+zgYb2vphUUt+ddJRhvq1k90I9HfN+4J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uz4tYcabgIrhHLUduBoBGdQBqc1ItK5gkO/cJ+opnMrhFTXvrxqp4tOX1Q1wlQKLawIIOr18h7vAd0qbuxmRe8GDp82gQzy5t247puiXE9fzzqN8J6Pdl7OKFyjZS/PmgmuGQt1dxD4aqmI7euapntjpnL/x7pqjCpVOLReN0CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=DLwA1/Mf; arc=none smtp.client-ip=209.85.210.48
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6dcc22cbcso1034365a34.1
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782320693; x=1782925493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk3gR1mNZQHdLxdzJufJLDLy/yMJjKDsLP8cD57Pm/s=;
        b=DLwA1/MfabI7ZvmIkjHFgzN0RkSmVH5/BXvZ1+tA7KzAdATQeeip7O3wFDYG0Y7j/+
         slAYYreH3akEiS9QMMZnKIWoGO5rb7dyrykSBJtCoete+AWvnWJ5/CkCubnuaiOuZc3F
         12SZiqxk9BXkVYhmR16zQ8Oo7/1JpoNpsnlpWwOlHAVAhkROqevsMN665XyNX8k+zk2/
         kELDmxaq8eskWiUnY2dV2jNSCprFnyOqjk4qf2MUTdPO1uwBrhkoKd7SsNrqq7oUCp4R
         EJi5dRom/vaSWzoQNZfAIlD37poft577BgY2tW9BbWBKbpoQpaitKt8Mg/iIefGjYrSt
         k3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782320693; x=1782925493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk3gR1mNZQHdLxdzJufJLDLy/yMJjKDsLP8cD57Pm/s=;
        b=co6tZsKD+EMwwIKef4b2aTuvVUBH2XV93nLz5xt0ukNToycO55VtqrjY4kyvhyaLEN
         czs+57KkNVlX6nI9M0Hba+CIwv9fQStDUv9TD2APUUCHJ1EkaYNU4s0yBWjwYn0Op5Yy
         Ah1DAqStNN6m6M8UFJYdxXPZprm72Zxeb4hAmdOXFP3psskpXCXGJ52c7q3eJu3uV08J
         jfzwVdDEx/UKtyNePr5jUoU96WcrcI3WcfSmu4RQFWRnA9nDp9Q2BSSl7bkd6BdS7saM
         U8CD4zLNiO0yR18+ZqomSiXND1cQdoujSw6hbVkhfsou7RpbJutLP1iMO42i/y3qw+6Z
         VLQw==
X-Forwarded-Encrypted: i=1; AFNElJ8kZciDRcoj3BHgsiS4IBTcPL0WENwoiIxikO3Dj1MlLvXiRwUeF5gaBPVmRpg1JR+hZULE4vEe9rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ0eHzdDyqJaegTk6iY5h7kBoc/fxpx1+riBxGfzyAkxo7PIsu
	ccjbdZWNvCi686tuNkcS1fvteQP7i3xnLxGi3ItHUvHMFTHhaOKG6YwSX2rMLp+qn3o=
X-Gm-Gg: AfdE7ckbZO5EjN8CYJ8SY4/N96oeiNp1/DB1Aiq6WKbISw1UP0QkI+SpQM/4g0XG9/n
	QGAAA7TX74DdArEbMesryKie4B2JUqF+eTyuZXdO5VdLZCgapj5PDh0UkBb3K3+U56jgREj6cD+
	JJr0+SJl4IoTYjtTPWxKlhi4U56JVjjRUlX+KP+IJh1kJKnmYDqo2ejUC2k2WDPh7dKZfGFUuJ+
	WDDOvU6qhVoFwFWjrh4X9AmkbjWWNINrBZbgeNN9LvW4JfR6wil2l2Wvu4m2RDC6eXuMsE/wBqf
	m6FUw6Ls7IdLTlN8nlY9fXe1esIuobhJ0LX4LaXhvrwxnEX0MrdQMRyWGSAtVh+De4DuX233m0j
	azDvRkPrh2PB/21Ig8nnNxjWBtoe6OMWFTPMvOkyqXQcU3tny0+1wkTyN8Zez1VkkOx7xSfN675
	Y9lUtE7AXTT+8tKXCH5O6p5RSYAz0L/y9ZKgXyKTK6IWdq01D/
X-Received: by 2002:a05:6830:91c:b0:7e6:da40:b7fa with SMTP id 46e09a7af769-7e986c83537mr3416981a34.24.1782320692785;
        Wed, 24 Jun 2026 10:04:52 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94429a031sm11959103a34.23.2026.06.24.10.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 10:04:52 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@ownmail.net>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Daire Byrne <daire@dneg.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH RFC 0/3] SUNRPC: a latency floor for interactive clients via sparse-flow dispatch
Date: Wed, 24 Jun 2026 13:04:47 -0400
Message-ID: <cover.1782314746.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22802-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:neilb@ownmail.net,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:daire@dneg.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:dkim,hammerspace.com:mid,hammerspace.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF45D6C03B9

This RFC follows the per-client fair-scheduling discussion from May/June
[1], and Chuck's slot-growth clamp that grew out of it [2].  It takes the
direction that thread settled on: rather than enforce proportional
fairness between clients, give an interactive client a latency floor that
a busy neighbour cannot push it below.

Problem
-------

nfsd dispatches ready transports per-pool in FIFO order, with no notion of
how much work each transport already has outstanding.  A client that keeps
many requests in flight -- nconnect, a deep v4.1 slot table, or simply
several connections -- sits in that queue on equal terms with a client
that has been idle.  So the request a user is waiting on (a stat, an open,
a directory listing) waits behind a backup job's backlog, even though
servicing it costs a single round trip.  The user-visible symptom is an
interactive session that stutters whenever a bulk client is busy.

Approach
--------

This is starvation avoidance, not proportional fairness (per Chuck's
reframe on [1]).  The protected unit is the interactive cycle: one user
command fans out into a burst of correlated RPCs, so it is the whole
burst, not a single RPC, that must be allowed to jump ahead.

The signal is already on every transport: xpt_nr_rqsts, the count of
requests in flight.  A transport with nothing in flight when new work
arrives is, by definition, not the one hogging threads -- so it goes on a
second, high-priority per-pool queue that is drained ahead of the normal
one.  To cover the whole burst rather than only its leading edge, an
idle->active transport is granted a budget of 64 high-priority dispatches,
spent down as the burst is serviced and refilled only when the transport
next idles.  A transport that never idles spends its budget once and then
shares the normal queue like everyone else.

There is no client identity anywhere in this -- it keys only on a
transport's own in-flight depth -- so it covers v3, v4.0 and v4.1
uniformly, needs no lookup or lifecycle, adds no lock (the existing lwq
barriers carry the sleep/wake), and is always on with nothing to tune.
(LOCALIO is out of scope: a local client's reads and writes bypass the
RPC dispatch path entirely, so they neither contend here nor are
reordered by this change.)

  patch 1  add the second per-pool ready queue (no functional change)
  patch 2  dispatch idle transports ahead of backlogged ones
  patch 3  grant the 64-RPC burst budget

Relationship to Chuck's slot-growth RFC
---------------------------------------

This series is based on Chuck's "Stop NFSv4.1 slot-growth heuristic from
rewarding busy clients" [2], and both A and B above include it -- so the
A/B delta isolates this series and the clamp does not account for the
improvement.

The two are complementary, not overlapping.  [2] stops nfsd from growing a
busy session's slot table past the thread ceiling: nfsd slot accounting.
This series changes the order in which ready transports are dispatched:
sunrpc dispatch.  Basing on [2] changes neither the design nor the result
here -- a slot-capped session still fills the pool, so the dispatch-layer
floor is still wanted on top of it.

Results
-------

Because the goal is a latency floor and not a share, the measurement
differs from the earlier bucket RFC and the numbers are not comparable:
that series measured a greedy client's share of throughput; this one
measures how long an interactive client's command takes to complete while
a neighbour is busy.

Workload: a backlogged aggressor (K connections, deep offered load,
saturating the pool) shares the server with one interactive client that
issues a burst of N requests, waits for all replies, idles 50ms, and
repeats.  A 10ms service time is injected per op (a test-only debug hook,
not part of this series) so the measurement isolates the dispatch path from
filesystem work.  A is stock nfsd-testing; B is the same plus this series.
Figures are NFSv3 burst-completion p50 in ms; NFSv4.1 tracks within a few
percent (the classifier uses no source identity, so v3 runs on plain
loopback and behaves the same).

Interactive burst completion vs aggressor connection count K (N=32;
unobstructed floor 45ms):

    K       4      8     16     32
    A    81.6  242.0  432.9  826.6
    B    60.9   64.5   65.4   64.4
         1.3x   3.8x   6.6x  12.8x

Baseline climbs ~linearly with the aggressor's backlog; patched holds the
floor no matter how deep that backlog is -- the property that matters.

vs burst size N (K=16), showing the 64-credit knee (floor for reference):

    N        1      8     32     64     96    128
   floor  14.9   31.9   44.8   71.5   96.8  122.4
    A     28.6  122.0  434.2  862.4 1272.6 1696.3
    B     16.7   36.0   65.1  124.5  546.4  961.6

For N <= 64 the whole burst is covered and tracks the floor (B within
1.7x); beyond 64 the uncovered tail -- the N-64 RPCs that spill to the
normal queue -- degrades toward baseline (B/floor jumps 1.7x -> 5.6x
across the 64->96 boundary).  The knee at exactly 64 is the budget working
as designed, not a regression.

Aggregate throughput (aggressor + interactive) is within 1% A vs B at
saturation (~1290 ops/s) -- the dispatcher reorders, it does not throttle.
With no aggressor the interactive floor is identical A vs B; the kernels
differ only under contention.

Figures are p50; longer runs are available for firmer tails.

What this deliberately does not do
----------------------------------

- It is not proportional fairness.  Two backlogged clients still split the
  pool by connection count; this protects only flows that idle.

- The normal queue can wait under sustained high-priority load.  v1 drains
  high-priority strictly first; bounding that starvation -- an inter-tier
  deficit round-robin, the way fq_codel actually interleaves its sparse
  and bulk tiers -- is left for a follow-up, pending the question below.

- The 64-dispatch budget defeats a pipelined aggressor (it lands wholly in
  the normal queue), but a client that shapes its traffic to look sparse
  -- send <=64, drain, repeat -- can still scale its high-priority share
  with connection count.  Whether to harden against that is the open
  question: if this is cooperative scheduling (Neil's framing) a bulk
  floor suffices; if it is an attack surface (Chuck's framing) the
  high-priority tier needs intra-tier fairness, which reintroduces
  identity.

Open questions for the list: is the budget (64 here) the right shape, and
should it be fixed, derived from the thread count, or hinted by the v4.1
slot table?  And does the cooperative framing hold, or must we resist
deliberate sparse-shaping?

[1] https://lore.kernel.org/linux-nfs/cover.1780498019.git.bcodding@hammerspace.com/
[2] https://lore.kernel.org/linux-nfs/20260610-nfsd-slot-growth-clamp-v1-0-7b966700df0b@kernel.org/

Benjamin Coddington (3):
  SUNRPC: add a second per-pool ready queue for high-priority transports
  SUNRPC: dispatch idle transports ahead of backlogged ones
  SUNRPC: grant an idle flow a burst allowance on the high-priority
    queue

 include/linux/sunrpc/svc.h      |  1 +
 include/linux/sunrpc/svc_xprt.h |  1 +
 net/sunrpc/svc.c                |  1 +
 net/sunrpc/svc_xprt.c           | 52 +++++++++++++++++++++++----------
 4 files changed, 39 insertions(+), 16 deletions(-)

-- 
2.53.0


