Return-Path: <linux-nfs+bounces-21411-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLebHNNd+2n2aAMAu9opvQ
	(envelope-from <linux-nfs+bounces-21411-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 17:27:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B86694DD2FF
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 17:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAAFF3003E8B
	for <lists+linux-nfs@lfdr.de>; Wed,  6 May 2026 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7697147DFA5;
	Wed,  6 May 2026 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTVDRWNI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532FF47CC80;
	Wed,  6 May 2026 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081232; cv=none; b=DN/J6sQo3AMBLIZK6UWwULRnlfvDog8PeRljo5PjwCgHyyKRj18AS2xs9nAImAb9hm5oLHOncSggbiZsGuMwsGI0OsHO9FH8cH1OcmUZ3qHjkUYnpUBVp+KZW9PkIXDlOfb+ckUdfpxg//+d65K+hgP++1nYsFhTbpP+rXxmA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081232; c=relaxed/simple;
	bh=qWMgOTaGHoSPGjDfpz75zlbDR1En4PdFFZBci8/4Sc4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Iscpel7ysP08nuzhy9Fs9SoO9P61Pfol4gmfkiFlAF5Go28XyM5uKRI8AA2c9q7/WqtGzznpwBqXHkCZEWlD6/aqOmtNTS5Jt2SqLmlcwwmJd8EAk5iiO0DSF/wvzDY2zLDF+T9HG3dKTanQW0x3/8Gz08c+Wq6cY6JC+uEOKdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTVDRWNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89C2C2BCB0;
	Wed,  6 May 2026 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778081231;
	bh=qWMgOTaGHoSPGjDfpz75zlbDR1En4PdFFZBci8/4Sc4=;
	h=From:Subject:Date:To:Cc:From;
	b=ZTVDRWNIbl45cjumiWRH5llCv/yGkjVD+lhaF9XV9c+IMg+6X1aIBZsPI45KgTbU0
	 KBG79UOkPOKFe93vKK+BqEecLxyDFmxUdyRS45pqlyiUf1eS/J4rV8AZYiYx7zh87f
	 FLN9meslQgLZMuEE72ndOLtRwdUh3sIjSCqEsrl/8PljR6BcaiHyEjkvdSH+x60jiB
	 QQvrW6x60OQrTxs/B2gohyOHHO1YFOrhg0m2BZee+Qq6mhrXq/2BLpzXf3FVLRiex1
	 D/+Cpa/kJ8TQixzLWA6z2tMXDd/aNYWKQpDTCVncHt4/YfW6FTJ7caBJyeYNbh+8Zf
	 37IcPhsBok24A==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH 0/2] svcrdma: Reduce svcrdma_wq contention on the Send
 completion path
Date: Wed, 06 May 2026 11:26:49 -0400
Message-Id: <20260506-svcrdma-next-v1-0-915fce8c4fbb@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALld+2kC/yWMSw7CMAwFr1J5TURIIahcBbHIx2mNwKA4VJWq3
 p0ElvP0ZlYQzIQCl26FjDMJvbjCYddBmByPqChWBqON1Sdtlcwhx6dTjEtRBs+9NcehH3SCqrw
 zJlp+uevtz/LxdwylNdrDO0Hls+MwtSngY89JoioohXiEbfsCN1/3epMAAAA=
X-Change-ID: 20260506-svcrdma-next-2e736249390f
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2530;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=qWMgOTaGHoSPGjDfpz75zlbDR1En4PdFFZBci8/4Sc4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp+13BZWcuJYUbZxFBs+HOtgieBQyA6RSctnhuF
 wCcUju+jh+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaftdwQAKCRAzarMzb2Z/
 lybdD/sEN+85k7CiYM0CvAI1qU4bMHlpclYvpNBIqAu8oQguYvfYA5EXawcPMCw4/aVAkeOpU8z
 lWueYP3gXoxWpKKf9E58TUojva5pvRS058aql00OPT7QVSvNCB1Yo1KxD8eThXbM8/ixXkDWWa+
 1Nq4jWacqujEnObH3YryU9b980fKO2gNfCwu8gDRNk1VIOJkaIzVeGFZtNllre3BfEQc3Hri27U
 jA6D5qVxJXv/EoZeBV8jo/tvHD/WTTLCVIW2khxwVMvvr/AEcGJqk9sxaq9XkBBJFBIIbnVLBaM
 IBgR2YKVxY716pncjt/oNwr3Xb4i4WA5Fvx5jvvW+Z+np+iDBgoZcKa7DyRBABeyk4EeULceqIH
 exTo9i+ZMOe0e3udZpJQz47oZWEWxbiiJkOFH/wjqsQ++Ex3pRUzlGLNO1ZymfJ4XlJfCsBOJ7G
 ZL2ZR3Eti/+VZfry0iW4yvzKJW18qUBBQSHY7SUY8vPE8/61lxaNjOH7VZUAH08xfms+VRCBDNm
 LcsHBgu0NZfCqOlEcQrAg1/VKn5npfQE3mpknAfYoajC5dHlwWJ6/+n3bzS4FAA7pg7kO50WWRh
 PGscBFOJLVG+8FXy2B1SVcXHqX+xCYj7i4FWlsZZsIK1XG2mR9bDAThIi3wko7p06IrY9ovCPRX
 77YgY0JN73szHvw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: B86694DD2FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21411-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Profiling an 8KB NFSv3 read/write workload over RDMA shows about
4% of total CPU spent on the svcrdma_wq unbound workqueue pool
spinlock. Each Send completion queues work on svcrdma_wq to
release the send_ctxt, and that work item queues another item
for each write_info chunk it owns. Every queue_work step contends
on the same pool lock.

The first patch removes the inner re-queue.
svc_rdma_write_info_free already runs on svcrdma_wq from its
caller, so the extra work item only adds another spinlock
acquisition with no parallelism to gain. Inlining the chunk
release recovers roughly 1% of CPU cycles. Mike, your workload
might see relief from just this patch alone.

The second patch retires svcrdma_wq. Send completion handlers
append the send_ctxt to a per-transport lock-free list, and the
nfsd thread drains the list in xpo_release_ctxt between RPCs.
DMA unmap and page release move out of the completion context.
That matters when an IOMMU runs in strict mode, where each unmap
synchronously invalidates the IOTLB; the nfsd thread absorbs that
latency where it is harmless and batches teardown across all
completions that accumulated during the prior RPC.

A self-enqueue covers the trailing edge of a burst. When a Send
completion finds sc_send_release_list previously empty on an idle
connection, it sets XPT_DATA and enqueues the transport. The nfsd
thread enters svc_rdma_recvfrom, finds nothing to receive, and
returns; svc_xprt_release then runs xpo_release_ctxt and drains
the list. Without that wakeup, a Send completion arriving after
the last xpo_release_ctxt would leave the send_ctxt's DMA mappings
and reply pages pinned until the next RPC, send-context exhaustion,
or transport close.

Patches were rebased today, but have not been recently tested.

---
Chuck Lever (2):
      svcrdma: Release write chunk resources without re-queuing
      svcrdma: Defer send context release to xpo_release_ctxt

 include/linux/sunrpc/svc_rdma.h          |  6 +--
 net/sunrpc/xprtrdma/svc_rdma.c           | 18 +------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  9 ++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c        | 13 +----
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 91 +++++++++++++++++++++++---------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  3 +-
 6 files changed, 84 insertions(+), 56 deletions(-)
---
base-commit: d1c29a34fe35c1eb9331cab0537c7bb583692187
change-id: 20260506-svcrdma-next-2e736249390f

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


