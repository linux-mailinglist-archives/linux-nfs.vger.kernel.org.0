Return-Path: <linux-nfs+bounces-21845-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL6XK7buEGrtfgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21845-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 02:03:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4A45BBA69
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 02:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 642DC30104A2
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 00:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E901E2BB1D;
	Sat, 23 May 2026 00:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4SVrnFp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26321862;
	Sat, 23 May 2026 00:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779494576; cv=none; b=hvOjvDZywLUYFOAgLWavcCE4QxYfcLLc3E/pOf5fLX3jZ7juBKjt9Kjxt+vJqZvaf/UxBFTEV3Rk6P6VgdrId5GT/r6F04OnFSaDiPe/FfEdha+6FtOtqDzSNLduhcgy1/2CmgAHAz7DdpEDrrvb025sM5KYvl7Jzg7CpoO28+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779494576; c=relaxed/simple;
	bh=wYGx6P4CG1vc34asubJJi4rAeoA9dz15zBkBD5Jyluw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nCYl5QlF4LQH/O2e9uq6GNNxRI11b/zLcIzOakrMMTV161giIduP/jRrjSAYEYyetFYRUqvZ41ZGt1IPpKKEN+U/cfNkVEqCdR76M/2BL5h3Yhn7GQcjoLC3Km+PhKfUoONcM0ZvAdtOjhN3zRNKaRPQ3mo1qc2uXi5nvjJ8BLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4SVrnFp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A49D1F00A3D;
	Sat, 23 May 2026 00:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779494575;
	bh=wVkaZ0xor75A7GVf85Ppq3DmYxJa8k0ldOR8zc0rLhM=;
	h=From:To:Cc:Subject:Date;
	b=a4SVrnFpEIml2G26yUmYoV71ObPxRFd11CeUPUgJfRgemWFwJcGJjDqOBYEYGdZUH
	 rsJvVgdw2p6GKN663KO22M/n9aURhqQU533MkZrhq/MMQK8VMzauCIUtFavbiy7X6j
	 e+Cw9TwtnusBMC001SI71uUjogFmCT8mumrC73Az7KBMbFaWXA/Sd6NO+oeGCDB0MW
	 NL3YniUyLfMsjgVubMkLb/HAuvPuIkbWlIlLFno8mokvMTR08grh4ofp2UnWZ+NyaK
	 tZ0xlnyD85Wt0QqWq33gNu/XXojbQy94sJSu8DF5mpptId+5bA3UjgelVMuMna4ZfM
	 miciYNHmI1DyA==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/3] xprtrdma: Decouple req recycling from RPC completion
Date: Fri, 22 May 2026 20:02:49 -0400
Message-ID: <20260523000252.465074-1-cel@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21845-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 2B4A45BBA69
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

Chuck Lever (3):
  xprtrdma: Use sendctx DMA state for Send signaling
  xprtrdma: Decouple req recycling from RPC completion
  xprtrdma: Add request-pool slack for delayed recycling

 net/sunrpc/xprtrdma/backchannel.c |  5 +--
 net/sunrpc/xprtrdma/frwr_ops.c    |  2 +-
 net/sunrpc/xprtrdma/rpc_rdma.c    | 63 ++++++++++++++-----------------
 net/sunrpc/xprtrdma/transport.c   | 55 ++++++++++++++++++++++++---
 net/sunrpc/xprtrdma/verbs.c       | 46 +++++++++++++++++++---
 net/sunrpc/xprtrdma/xprt_rdma.h   |  2 +-
 6 files changed, 124 insertions(+), 49 deletions(-)

--
2.54.0


