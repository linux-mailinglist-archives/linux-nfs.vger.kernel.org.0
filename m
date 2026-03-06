Return-Path: <linux-nfs+bounces-19853-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLRrGepNq2lYcAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19853-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:58:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE97228271
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E10830910BA
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 21:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80173EDAC9;
	Fri,  6 Mar 2026 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocDvnOMc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4555370D79;
	Fri,  6 Mar 2026 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772834196; cv=none; b=KE7E4puWsE3faH3qojqGmGaHxCRf1gdiygRC6ahDYoNBoVAuhUozKxdANeT8vVgNUnTWpss963R38GgZcrUwi6A4x3VvhNgAzs07DXp72NLDCbECUkVzIxCMKAZMMavTu7fuHDnYf9CCGKy+1JPJ0/+3K4/lUrrttJnY4ZunyUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772834196; c=relaxed/simple;
	bh=RG0K30OybickcacHK2Sc+1JfjMn2++oRvVSIUCDX1s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWLwbrhZVfgumKXY2Xt30GLnQ2M7yTlqP0MCB4AjaTQ0OZ++NGNoiwsfh9XlRx4mFTsenVFRvnU9MCRIqIdHGmoKZBejmKyGIrUtFE0Lo6od7ZMZ857lHG+OYYb1cP3occTBvw450m1OPNoQ+wR3FgOnldK5f/TdgxVZChKyhJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocDvnOMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251FEC4CEF7;
	Fri,  6 Mar 2026 21:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772834196;
	bh=RG0K30OybickcacHK2Sc+1JfjMn2++oRvVSIUCDX1s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocDvnOMcDN4in2Da8wwfzxIzcbgko+9ab2ae5cVxitj/tmbdAcWnvxmI8X8NjJMdA
	 6Yt6Q5k1rYdvCxwsNqR6dTAmOO3bCXcwgyFdvpCflGbMEXEYaJLcU5jfdTqiVBPcO+
	 HbDBrFEsW8p73o+2Emq3K0yLijyG0rEWsMbVmfR44+i4Q4nVk0TGy7bt3iPOYpw79a
	 uijqp5OWI52WMURkFrhKfW7tnSfl5jaZRzglibmrD9ERPUd+G+a2B+4TiSsY4RxvYQ
	 /Ea1YsilGrJLTzUx0Q4g2FNkx0t4jQvCv7kxao71Cj5aos4AevdZLyTHOCgz9oc3m7
	 3PKQC1H0JgsMw==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 6/7] xprtrdma: Scale receive batch size with credit window
Date: Fri,  6 Mar 2026 16:56:27 -0500
Message-ID: <20260306215620.3668-15-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306215620.3668-9-cel@kernel.org>
References: <20260306215620.3668-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; i=chuck.lever@oracle.com; h=from:subject; bh=9IhiSakUcyYL0S35sQ9Mr2PEKHg2AeG+TToByd5+fts=; b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpq02NZZYOGgyxXoEp46T5kXF1kLK+op6fPW7bg tkbVJ01QJiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaatNjQAKCRAzarMzb2Z/ l92JEACKoPkSKv04erisOJrGm357wMfm+TIARK1xCfC0jN+vFejrznl8xrqx+sMciwCTuqh7TeV xhcql8ROuo7ikBe7N5HXZaPxXi2JAJhsNIoc+jSnOWWoD3LRTNfDve3apjFYaoFlsT8G58x/CEd 3R8N7oJ/sGTRNZvJHujSZD9RNow4AmZopHuqKIEYjRFL6LP7xvGt+BDhe5/UTZ4GbIdLwPEqrYf 0WAAUAEio/0a3h4y25y61T5bNzm3luVHU3dyFk6hKTUzUsgTtjsqZxnf8YdlYLOjrf6PQwyFn17 5qV0I1iEju8yH4CTegKM+kLpmw/KzJTzlvZnJS6YOL1qXJsU35OlZBug68oTJyORbJ/TXCgisMu fl0pFDT93MofoW8iOJTlDyNOuU+2qvyn7vXc8JxWRcq3q4CA2b9QxZip+KLzFoIgUF+StAdAdlg zmmgzU/3e0E6YW0+clrAxw5GboahGOEeGv5wWFGXkhgqV2cElntL0I9V6ud9HdPdM/zSLC9u5dP jQEWDGR7UTGTth3Lc5aO9zNVKDHV6zSbuQOucxvU3gm7bkjUU9+a23FQa5WLKH6EYaFIxS6Gf1z yhFQjiSKuWzVxWbMkyrpLM2kQKwCgqi77LlquBsRxTKrPyNRZorOHeIffn4eA1Y7Z8i8Pdw+egi 5DDaZqsDgSVkjWQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EAE97228271
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19853-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The fixed RPCRDMA_MAX_RECV_BATCH of 7 results in frequent
small ib_post_recv batches during high-rate workloads. With
a 128-slot credit window, receives are reposted every 7th
completion, each batch incurring atomic serialization and a
doorbell write.

Replace the fixed batch constant with a per-endpoint value
scaled to 25% of the negotiated credit window. For a typical
128-credit connection this raises the batch from 7 to 32,
reducing doorbell frequency by roughly 4x and amortizing the
per-batch atomic and MMIO costs over a larger group of
receive WRs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  | 3 ++-
 net/sunrpc/xprtrdma/verbs.c     | 2 +-
 net/sunrpc/xprtrdma/xprt_rdma.h | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 229057d35fb8..7f79a0a2601e 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -244,9 +244,10 @@ int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
 	}
 	ep->re_attr.cap.max_send_wr += RPCRDMA_BACKWARD_WRS;
 	ep->re_attr.cap.max_send_wr += 1; /* for ib_drain_sq */
+	ep->re_recv_batch = ep->re_max_requests >> 2;
 	ep->re_attr.cap.max_recv_wr = ep->re_max_requests;
 	ep->re_attr.cap.max_recv_wr += RPCRDMA_BACKWARD_WRS;
-	ep->re_attr.cap.max_recv_wr += RPCRDMA_MAX_RECV_BATCH;
+	ep->re_attr.cap.max_recv_wr += ep->re_recv_batch;
 	ep->re_attr.cap.max_recv_wr += 1; /* for ib_drain_rq */
 
 	ep->re_max_rdma_segs =
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 90fd83f2d846..aecf9c0a153f 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1374,7 +1374,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed)
 	if (likely(ep->re_receive_count > needed))
 		goto out;
 	needed -= ep->re_receive_count;
-	needed += RPCRDMA_MAX_RECV_BATCH;
+	needed += ep->re_recv_batch;
 
 	if (atomic_inc_return(&ep->re_receiving) > 1)
 		goto out_dec;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 37bba72065e8..f53a77472724 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -96,6 +96,7 @@ struct rpcrdma_ep {
 	struct rpcrdma_notification	re_rn;
 	int			re_receive_count;
 	unsigned int		re_max_requests; /* depends on device */
+	unsigned int		re_recv_batch;
 	unsigned int		re_inline_send;	/* negotiated */
 	unsigned int		re_inline_recv;	/* negotiated */
 
-- 
2.53.0


