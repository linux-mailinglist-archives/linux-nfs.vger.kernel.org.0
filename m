Return-Path: <linux-nfs+bounces-21966-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK18D7aqFWpuXgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21966-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:14:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDE45D73CB
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B5553003506
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F23C9882;
	Tue, 26 May 2026 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNY7hnq1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6516838F922;
	Tue, 26 May 2026 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804851; cv=none; b=Bds2tYzvOr1eg1DCRvE5couMTT5TR63EOIYs1rg72j6GRSIxU8mIqn/kbv8Z6IWFPiIZz3LyqcVFVdsmAzB9XQbTRdAOMVAA4ZopIlcjpl1SHpG7VNbsuwMdX1gkna2kZZUfv1O1T55f9kBUtFbVD9+Fs9Q53CANmBSnmdC1otc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804851; c=relaxed/simple;
	bh=MEgqZlaT0uBgRJfviNL43RZyBndLQaDFruUN0180uFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQ9onX0upJSFGemceOEAcAB8dNfHZshoUY1MxLurXzP8c4ZkjnuRNlUgaQrU7dkf9IsfPs7y/gQG/OzZxjKJWpVkQNEmLi0MyiJA39TLL9YeABgH6Zy0ZGn8ktgTlSUbmBGGZxyXkUXVE7lpFu4OnQM0r30OTA7CTLFa8bQwQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNY7hnq1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06E81F000E9;
	Tue, 26 May 2026 14:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779804850;
	bh=u6bPZgukci/fYwrNaCPdkfWrKSd5H8v3df9otNrmCxc=;
	h=From:To:Cc:Subject:Date;
	b=eNY7hnq1AvzVknkzeBV2e3wvJHq1uQ9SqHUUQTbmQyULWbNPEDWAG+rmyGmFMFE7+
	 XFSK2n2xDfzHpebEPZvWSSApFQOW90u7c74cA11bTm0j0kAs8eNDXxmIoSDFbxQL44
	 P26pMG4bmJzW9BY5o45bAZw0DigYpDOiq5bWTuIREkrPgdiNiynK7c5HMldE0zhIHS
	 RVJO8TqqiOUOoUbbKnlQu7noVYcw8NAHpAtFd1a3p1DV5MD3dnV5+nOtWBBrQXVX3n
	 TgxROS4ACo/P9I1p3SYWrYfuTGg5tWlwSvCJwlVHnJ/2Y48tXA5UvT3IXMOnFcJE35
	 pEJccMj6NGncw==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: <linux-rdma@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 0/5] xprtrdma: Decouple req recycling from RPC completion
Date: Tue, 26 May 2026 10:14:00 -0400
Message-ID: <20260526141405.39877-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21966-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9EDE45D73CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

rl_kref currently conflates two lifetimes through one refcount:
it gates when a Reply can wake its RPC task, and it gates when
an rpcrdma_req can return to its free pool. The marshal path
takes the Send-side reference only when sc_unmap_count > 0, so
a Send carrying only pre-registered buffers takes no Send-side
reference. When the Reply for such an RPC arrives before its
Send completes, the Reply handler drops rl_kref from 1 to 0
and frees the req while the HCA may still be DMA-reading from
its send buffer. A retransmission can put different bytes on
the wire.

This series narrows rl_kref's job. The RPC layer takes one
reference at slot allocation; rpcrdma_prepare_send_sges() takes
a Send-side reference unconditionally after WR prep succeeds.
A req returns to its free pool only after both owners release.
Replies complete the RPC directly, without atomic activity on
rl_kref.

Three design choices shape the series.

The Send-side reference is taken only on the success path of
rpcrdma_prepare_send_sges(). Marshal failure runs
rpcrdma_sendctx_cancel(), which unmaps the SGEs and clears
sc_req without touching rl_kref. Sendctx ring walks in
rpcrdma_sendctx_put_locked() and rpcrdma_sendctxs_destroy()
skip entries whose sc_req is NULL, so a burst of -EIO marshal
failures cannot hold reqs off rb_send_bufs.

Connection teardown drains the sendctx ring against pre-reset
reqs by ordering rpcrdma_sendctxs_destroy() ahead of
rpcrdma_reqs_reset() in rpcrdma_xprt_disconnect(). The drain
releases Send-side references whose unsignaled Sends never had
a later signaled completion to walk the ring. On the
backchannel, releasing a bc_prealloc req re-adds it to
bc_pa_list, which xprt_destroy_backchannel() has already
emptied; xprt_rdma_destroy() runs xprt_rdma_bc_destroy() a
second time after the disconnect to reclaim those reqs.

With recycling now gated on Send completion, completed RPCs
can remain pinned by the sendctx ring until the next signaled
Send completion. The headroom is bounded: re_send_batch is set
to re_max_requests >> 3. The req pool gains max_reqs/8 slack
(patch 3) so the recycle delay does not stall a slot
allocation that the RPC/RDMA credit window would admit.

Changes since v2:
- While addressing sashiko review comments, substantially
  reworked to simplify and better align the series with the
  current architecture of xprtrdma

Link to v2: https://lore.kernel.org/linux-nfs/20260523000252.465074-1-cel@kernel.org/#r

Changes since v1:
- Split into three patches. A prep patch converts the
  Send-signaling test from a kref_read to sc_unmap_count, and
  a separate patch names the request-pool slack at its
  allocation site.
- Wrap the bc_prealloc release branch in
  CONFIG_SUNRPC_BACKCHANNEL (kernel test robot, build break on
  configs without the backchannel).
- Order rpcrdma_sendctxs_destroy() ahead of
  rpcrdma_reqs_reset() in rpcrdma_xprt_disconnect() so the
  drain runs against pre-reset reqs.
- Run xprt_rdma_bc_destroy() a second time from
  xprt_rdma_destroy() to reclaim bc_prealloc reqs returned by
  the disconnect's drain.
- Add rpcrdma_sendctx_cancel() for the marshal-failure path;
  sendctx ring walkers skip entries with sc_req == NULL.

Link to v1: https://lore.kernel.org/r/20260520175016.29480-1-cel@kernel.org

Chuck Lever (5):
  xprtrdma: Use sendctx DMA state for Send signaling
  xprtrdma: Decouple req recycling from RPC completion
  xprtrdma: Add request-pool slack for delayed recycling
  xprtrdma: Clear receive-side ownership pointers on release
  xprtrdma: Document and assert reply-handler invariants

 net/sunrpc/xprtrdma/backchannel.c |   5 +-
 net/sunrpc/xprtrdma/frwr_ops.c    |   2 +-
 net/sunrpc/xprtrdma/rpc_rdma.c    | 134 ++++++++++++++++++++++--------
 net/sunrpc/xprtrdma/transport.c   |  68 +++++++++++++--
 net/sunrpc/xprtrdma/verbs.c       |  68 +++++++++++++--
 net/sunrpc/xprtrdma/xprt_rdma.h   |   2 +-
 6 files changed, 225 insertions(+), 54 deletions(-)

-- 
2.54.0


