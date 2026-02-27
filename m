Return-Path: <linux-nfs+bounces-19397-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEohBkCmoWmivQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19397-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A001B87F0
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E147C30DA610
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A780C299948;
	Fri, 27 Feb 2026 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC5Jx48J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9B283FC8
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201028; cv=none; b=feDh376888azt0RthXjKiqXcIHlhpHJjHY0xqlCCemJt6snibxc4hRVeAwCL55X4ZCH4TVbhxHkYFxOwsJizopGDqpw8UVzrRYTOlMZAdMOmuMv2OH8jKcB2Q0MPvWIRjzSRE4CecO0ZEX1HTYSpfUzfeGl8KHsncaJJqvUsprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201028; c=relaxed/simple;
	bh=Laumg8DuoPa07/FWD2M0aFqLtgzolVF/Hto98yb74OU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orQpDtUzuC34V/MKGNAxgUnhZ/Ho1HEiJJRRkwXor4/DwuFV+bbifIWuNnfJJ6UPKtoOWkO7UXjUXckbvxG8aE/yjzGxabe4X2kv8xK4ijH9lQQlJjxLrZ1Q5yrigqiykwOBqdgJTgjCX9CQeZ5Hle5izTfsuQEXZV9/7zpqJlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC5Jx48J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D72DC116C6;
	Fri, 27 Feb 2026 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201027;
	bh=Laumg8DuoPa07/FWD2M0aFqLtgzolVF/Hto98yb74OU=;
	h=From:To:Cc:Subject:Date:From;
	b=nC5Jx48JgEbWlzcQi5oy2kaGiOAC0+jw9Es6CxqlbUMvoYSSf2PZ41Z+sSseWMMTj
	 ioD1slgz+Tfg7frWsTOgaRxC+o/p4yXo3QmtfVt0OHn1umUIZ8mb+pRiRAVmE9tcCR
	 ePq3UPaFp/pPFCcQriwu7mjB2gOpF7pzQMSc7IuKw4PAvsMEDxYU5fLEj/eRSrnUF9
	 SFww+4QMMdNsGaPGx2F+opaipxyp61BmkhFumWipXM8UGcGSu7idt+XitSiNcr+wBV
	 0t2zOPb3JtUxYVS8R71sp2UhDlqqzdLDQeEOcBgBuarhJebSgjQR/CiL9XLSKXA9li
	 lLsInWsCNOEeQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 00/18] svcrdma performance scalability enhancements
Date: Fri, 27 Feb 2026 09:03:27 -0500
Message-ID: <20260227140345.40488-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19397-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: A0A001B87F0
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

When considering NFS I/O throughput and latency, typically the RPC
transport is not the primary bottleneck. The CPU cost of the
RPC/RDMA transport is insignificant in comparison to other resource
utilization on the server.

However, when considered from a scalability point of view, the
incremental costs of things like memory-per-connection and interrupt
rate or doorbell rate per connection do add up.

The following series lowers the per-connection resource utilization
of svcrdma in several areas. The main benefits are lower lock
contention, lower interrupt and doorbell rate per RPC, and less CPU
cache theft.

Profiling an 8KB NFSv3 read/write workload over RDMA identifies
where overhead accumulates as connection count grows. Roughly 4% of
total CPU time goes to contention on the svcrdma_wq unbound
workqueue pool lock, driven by cascading work item re-queues through
the Send completion path. Receive completion processing acquires a
per-transport spinlock on every inbound message. Doorbell and
completion event counts scale with Write chunk usage.
svc_alloc_arg() scans ~259 rq_pages slots per receive even when only
a few pages need replacement.

Three strategies recur throughout this series.

Lock-free lists replace spinlock-protected queues on the hottest
paths. The receive completion queue, Read completion queue, and send
context release path all convert to llist, eliminating producer-side
locking. The global svcrdma_wq workqueue -- the single largest
contention source -- is replaced by per-transport kthreads that
drain completed send contexts from an llist in batches. The
intermediate re-queue for write chunk resource release is thus
removed as well. Those resources are now freed inline during send
context teardown.

Work Request chaining reduces per-RPC doorbell and completion rates.
Write chunk RDMA Write WRs are linked onto the Reply Send WR chain,
so a single ib_post_send() covers both operations with one
completion event. Receive Queue posting switches from small fixed
batches to watermark-triggered bulk replenishment, provisioned at
twice the negotiated credit limit. Ticket-based fair queuing for
Send Queue slot allocation prevents starvation when the SQ fills
under concurrent use.

Per-object caching and cache line separation reduce allocation cost
and cross-CPU invalidation traffic. Each recv_ctxt includes a
single-entry svc_rdma_chunk cache, covering the >99% common case
without kmalloc. Cache line annotations on struct svcxprt_rdma place
the Send context cache, R/W context cache, and SQ availability
counter in separate cache lines.

XPT_DATA flag handling upon sc_read_complete_q consumption is
corrected to clear and recompute the flag. Trace data from a 256KB
write workload shows ~14 transport enqueue attempts per RPC; in 62%
of cases, no work is pending. Clearing the flag on consumption
eliminates the majority of these spurious dispatches.

Base commit: v7.0-rc1
URL: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=svcrdma-next

---

Changes since RFC:
- Rebase on v7.0-rc1
- Address thundering herd in SQ fairness implementation
- Release Send contexts during xpo_release_ctxt
- Skip xpt_reserved accounting for RDMA
- Close several races

Chuck Lever (18):
  svcrdma: Add fair queuing for Send Queue access
  svcrdma: Clean up use of rdma->sc_pd->device in Receive paths
  svcrdma: Clean up use of rdma->sc_pd->device
  svcrdma: Add Write chunk WRs to the RPC's Send WR chain
  svcrdma: Factor out WR chain linking into helper
  svcrdma: Reduce false sharing in struct svcxprt_rdma
  svcrdma: Use lock-free list for Receive Queue tracking
  svcrdma: Convert Read completion queue to use lock-free list
  svcrdma: Release write chunk resources without re-queuing
  svcrdma: Defer send context release to xpo_release_ctxt
  svcrdma: Use watermark-based Receive Queue replenishment
  svcrdma: Add per-recv_ctxt chunk context cache
  svcrdma: clear XPT_DATA on sc_read_complete_q consumption
  svcrdma: retry when receive queues drain transiently
  svcrdma: clear XPT_DATA on sc_rq_dto_q consumption
  sunrpc: skip svc_xprt_enqueue when no work is pending
  sunrpc: skip svc_xprt_enqueue in svc_xprt_received when idle
  sunrpc: Skip xpt_reserved accounting for non-UDP transports

 include/linux/sunrpc/svc_rdma.h          | 103 +++++++--
 include/linux/sunrpc/svc_rdma_pcl.h      |  12 +-
 include/linux/sunrpc/svc_xprt.h          |   2 +
 net/sunrpc/svc_xprt.c                    |  55 +++--
 net/sunrpc/svcsock.c                     |   1 +
 net/sunrpc/xprtrdma/svc_rdma.c           |  18 +-
 net/sunrpc/xprtrdma/svc_rdma_pcl.c       |  52 ++++-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 156 +++++++++-----
 net/sunrpc/xprtrdma/svc_rdma_rw.c        | 165 ++++++++-------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 256 ++++++++++++++++-------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  29 +--
 11 files changed, 582 insertions(+), 267 deletions(-)

-- 
2.53.0


