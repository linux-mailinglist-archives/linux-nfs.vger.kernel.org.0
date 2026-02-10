Return-Path: <linux-nfs+bounces-18857-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOdmJUhei2mYUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18857-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:35:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC99F11D470
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6A443082050
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD073112DC;
	Tue, 10 Feb 2026 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFogwoJy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983930C608;
	Tue, 10 Feb 2026 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741158; cv=none; b=jjk3XJlDDZdLvbThyMdObi1tfklcSWsXkkRIgMUEkjYukc5uxBRgpu266/GBrOT5pBOgvPGTe6Ibj7qjulw7GetAq5Xxj+1as4ED7fxUn6xVQIsZ+zHa3XxUKoKBFYxeHmpx9nSzKJ8hp5afK7daF8xALbQlcvc/LB5yc7ZZGqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741158; c=relaxed/simple;
	bh=khSActo4A1X98gu20W8ohNobqcA+itkS33JnJ7SwFJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EABgCsri6BWqMv/SnDHvPGTG5tQ9zLqWhX8CJOnIPCL170vfDbtFZUC0Z1Wjh3qHYg51nY3T+Mq4eS1LGVAUNhpaNRRde06+tzLSD4mtnkFjv9w6TWpDwnbSz6vbgzBHTXSvbBOY76dWhQBt9E4lNVpMCTjF2ons7AtQjWcGkzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFogwoJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF9CC19425;
	Tue, 10 Feb 2026 16:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770741158;
	bh=khSActo4A1X98gu20W8ohNobqcA+itkS33JnJ7SwFJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mFogwoJyjRGcCNCh3jkw5C/l+eZ1rZWpwmvOLFjGBBvChbQtC5ZmRKvaukaJ4XRPv
	 tL7pS9lSTnlKttgCgJpeSNofJ41Oi0MajFY78Z1e7zCpS/xvrDfzvx8IVDjiQBXbSJ
	 CS7rqYbVcRWJdC4UTyuFKFrGEfXdYcXTLRk8/gbngcvDhxxnmvEWEl640l04PjZODE
	 vZDwbQ17oNUjYzleIEdYswbIR6dzMxTHnzDxDPFfcuC/EL7OS+3pHH9VJbN3Xp1h1b
	 mbZO6wVMri0k7i/VovuDwSc+d3JF2wgtlXFBishJpJ4bnwkaCPdARyJ1WtRKUaKiKY
	 mwlOUpV+eSJBw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 14/15] svcrdma: retry when receive queues drain transiently
Date: Tue, 10 Feb 2026 11:32:21 -0500
Message-ID: <20260210163222.2356793-15-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210163222.2356793-1-cel@kernel.org>
References: <20260210163222.2356793-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18857-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: EC99F11D470
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

When svc_rdma_recvfrom finds both sc_read_complete_q
and sc_rq_dto_q empty, svc_rdma_update_xpt_data clears
XPT_DATA, executes a barrier, and rechecks the queues.
If a completion arrived between the llist_del_first and
the recheck, XPT_DATA is re-set, but recvfrom returns
zero regardless. The thread then traverses the full
svc_recv cycle -- page allocation, dequeue, recvfrom,
release -- only to find the item that was already
available at the time of the recheck.

Trace data from a 256KB NFSv3 workload over RDMA shows
267,848 of 464,355 transport dequeues (57.7%) are these
empty bounces. Each bounce costs roughly 37 us. During
the READ phase, empty bounces consume 8.6% of thread
capacity and inflate inter-RPC gaps by an average of
87 us.

The calling thread holds XPT_BUSY for the duration, so
no other consumer can drain the queue between the
recheck and the retry. A retry is therefore guaranteed
to find data on its first iteration.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 2ee9819a53d7..a124c6ed057a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -981,6 +981,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 
 	rqstp->rq_xprt_ctxt = NULL;
 
+retry:
 	node = llist_del_first(&rdma_xprt->sc_read_complete_q);
 	if (node) {
 		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
@@ -995,8 +996,17 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
 	} else {
 		ctxt = NULL;
-		/* No new incoming requests, terminate the loop */
 		svc_rdma_update_xpt_data(rdma_xprt);
+		/*
+		 * A completion may have arrived between the
+		 * llist_del_first above and the queue recheck
+		 * inside svc_rdma_update_xpt_data. This thread
+		 * holds XPT_BUSY, preventing any other consumer
+		 * from draining the queue in the meantime.
+		 * Retry to avoid a full svc_recv round-trip.
+		 */
+		if (test_bit(XPT_DATA, &xprt->xpt_flags))
+			goto retry;
 	}
 
 	/* Unblock the transport for the next receive */
-- 
2.52.0


