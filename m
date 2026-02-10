Return-Path: <linux-nfs+bounces-18843-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLZ/AZ1di2mYUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18843-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:32:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8235B11D359
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FC9F30104A5
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7B228A3F8;
	Tue, 10 Feb 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geJw08c5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACD73A1C9;
	Tue, 10 Feb 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741146; cv=none; b=lqlbg0oI1XNSZ0I4xs5Mlri0vR0mKl8b6luELVL8D4YWiMNEZhw9/HMcu3xtrzOShaijHVdbh+77I1H+mSmENPPvS6Omz8TU7liLRdFof9ZW5f0H3eH2BBSg61PWnH/MP1hr0nM4nRFZmahuVW/n7tvb2TClXQCbIY5ZmgJWqaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741146; c=relaxed/simple;
	bh=zN/UrlvAKE2iAKTeLS6/7SQLLqDanA49AsNSNe4UIjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYidE9/FkZsWx2kt0dshMs6uhHyxIHMFGGwct/Zpg9ptzQte8I8WxyzLxU1Xjsi1lNX0SXHsi1T6YEcvNDz/ATGYhQjrH5WBjwAgFJrANRRClqoEOp9IK4LCxiwmEB4hz5SprNiR2k9sgy8azkAvjpfcWNwROlojMvBP0Ll0+EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geJw08c5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AA3C116C6;
	Tue, 10 Feb 2026 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770741146;
	bh=zN/UrlvAKE2iAKTeLS6/7SQLLqDanA49AsNSNe4UIjM=;
	h=From:To:Cc:Subject:Date:From;
	b=geJw08c5HG0EAyRUUUu6Q3LMf2dwMqobEeA5EEN29Q5qZyK9+6kzbKS/0A46W4VKT
	 mjcuRLkN2+j6xbNBH4ylX5YPQkDelnzhjCNmxI51cvrzKsn6EUo2lIX0UCuP5TgeUW
	 rcJyIu2DwgyFZ2gSo2dJeOplSRJ7ONl+EUpuEspAObjCX7QR7xlM4nDs7dXhyV/iqZ
	 l8gEVmO2IYAzNg9GalyoZXIBmvAlYZmzqIWMfNWqJywf6rm6EMJxkAHXdkIinsO5Ki
	 TmUqKy/MFpBlQd0YiZKekhONgRgNh/+Xpq31taFAYLokYOTFr1CVXV9Zzeeb+4oWkx
	 DtaDaaBhh7Sog==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 00/15] svcrdma performance scalability enhancements
Date: Tue, 10 Feb 2026 11:32:07 -0500
Message-ID: <20260210163222.2356793-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18843-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8235B11D359
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

Base commit: v6.19
URL: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=svcrdma-next

---

Chuck Lever (15):
  svcrdma: Add fair queuing for Send Queue access
  svcrdma: Clean up use of rdma->sc_pd->device in Receive paths
  svcrdma: Clean up use of rdma->sc_pd->device
  svcrdma: Add Write chunk WRs to the RPC's Send WR chain
  svcrdma: Factor out WR chain linking into helper
  svcrdma: Reduce false sharing in struct svcxprt_rdma
  svcrdma: Use lock-free list for Receive Queue tracking
  svcrdma: Convert Read completion queue to use lock-free list
  svcrdma: Release write chunk resources without re-queuing
  svcrdma: Use per-transport kthread for send context release
  svcrdma: Use watermark-based Receive Queue replenishment
  svcrdma: Add per-recv_ctxt chunk context cache
  svcrdma: clear XPT_DATA on sc_read_complete_q consumption
  svcrdma: retry when receive queues drain transiently
  svcrdma: clear XPT_DATA on sc_rq_dto_q consumption

 include/linux/sunrpc/svc_rdma.h          |  80 ++++++---
 include/linux/sunrpc/svc_rdma_pcl.h      |  12 +-
 net/sunrpc/xprtrdma/svc_rdma.c           |  18 +-
 net/sunrpc/xprtrdma/svc_rdma_pcl.c       |  55 +++++-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 158 +++++++++++------
 net/sunrpc/xprtrdma/svc_rdma_rw.c        | 169 ++++++++++--------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 209 ++++++++++++++++-------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  28 +--
 8 files changed, 488 insertions(+), 241 deletions(-)

-- 
2.52.0


