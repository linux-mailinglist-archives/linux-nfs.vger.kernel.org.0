Return-Path: <linux-nfs+bounces-20601-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEqKDsx1zWnYdgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20601-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:45:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE46737FECD
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB5603040B8E
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 19:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BBB218592;
	Wed,  1 Apr 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hA1W8m8z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21774086A
	for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2026 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775072713; cv=none; b=lXyzF9Y8/Yh3NIflyZkBQg76JtU13wrhC8QaJFUMJqsqu339pw84OHcY07RgOg3PeHbgsW7LF0nfdK5GO8Wal8spunMz4LtRt1PAu3u/Ui1MjZ5YvCit7PVA/S/IT2wuR5L+kdBdf9dM1Y9aA1p0NelXQ2/1fGZuu+9HZB83IMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775072713; c=relaxed/simple;
	bh=CdMDlHbKywlpFCBGl3OVn97IqE1emiTs97NUtj79NW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QwF0GL1+T5uE3c1hlbZS+MBVunrj4XiM8hEeC8UqN6KM4RyLHxXt0ayT6jW9Yk30RMHf9YhijxLQ1sNZYCWtw4LZNNp5j4ZoUAGXSxtytfUIxFCdAN4houL32N7vbNJLlbtonqpxnGwfuyY6y3H8oMXQaDHywkaP651RRCqS9oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hA1W8m8z; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76b6db8bb2so26766a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 01 Apr 2026 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775072711; x=1775677511; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZuzvlEZmJ6kG3JliNifQvylb1PwJkEr7RALOkoPIGk=;
        b=hA1W8m8zgARuk77AsW8or92x/33K/8LRlhGO2Qov8VBXJpR8pO/txk3b/C99NTZz61
         mMSYiGAvwrXauP5RQkdoxFO6pXftp1ERcF4XQT/DLzrxk2jwwmMVBa1Ip+90Cf7OOg2e
         vwgG0lemNHUaFWWHRNqukxr+wwAIiCEYypUbU/zqi70nyntWheOWMI9dEivUyUkvgUZN
         maVJvxCeO8UZv+Gk5gb1yUgLyfPaGA6YlMIwz/DcYjRaTjg6JyNFB/fnVZgUty4+H3U/
         lpav3gLad6XQsTfoXyEzk7162fj7y/QA0ebOVSeSMJVevFk+zWqXK6XyMUWnXi09GQGv
         GXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775072711; x=1775677511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZuzvlEZmJ6kG3JliNifQvylb1PwJkEr7RALOkoPIGk=;
        b=XjG7G+C2VsZv2Rvf2VACZ1tPXs7Vt+9d5xHb4IFL9smXKZ6Tw7i0iJbYX4/2svxHCJ
         4O7sxTU2gp19PIcoWLWw/ya/QXpZRX6Na4yJdu5j2DEhj1cY13sjr3p6EVN/YXBAICuD
         H3sAIOE2b6wunDtYjGtIfhM4goFeIAt/ZEvQ2k1mDcB9UEz7EB1M1VOtaoCzSORCQGOd
         Jg0gK34xWYNsKlP4aPq1cKiIJi24A8H92oOCM6kQjYTb6mE03pgjLei4MEEPo9flZ5xS
         s1RkI49W/ey9Cl43VCR/mXoeOJabGJuLBpekQQC0xHiDDi4aoANmjKz2JGMu6qO4zAW6
         0G9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWC7QcS84KvnZitDS4li2Es1lEHUAAlupiFdbA8C4JxtL8bN3fDOkqDlJJ/f0clMDZJRIfkDHuBHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBdkxFMbFvyjVSQB9eUY1Pt7QOThCjBo3UCUX68I1ofuUZmkM9
	VSehM0nnNQGmTnk8c8VdtbPvMB6/Xczn2ZJVoxehRjkkfYL3GgMQSNOfO1bgoAQzY2z3X15YH2+
	AOQ==
X-Received: from pge24.prod.google.com ([2002:a05:6a02:2d18:b0:c76:a209:f392])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d491:b0:39b:f026:6f8e
 with SMTP id adf61e73a8af0-39ef7685e24mr4884632637.34.1775072711051; Wed, 01
 Apr 2026 12:45:11 -0700 (PDT)
Date: Wed,  1 Apr 2026 19:44:57 +0000
In-Reply-To: <20260401194501.2269200-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401194501.2269200-1-praan@google.com>
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260401194501.2269200-2-praan@google.com>
Subject: [RFC PATCH 1/4] sunrpc: add supports_p2pdma to rpc_xprt_ops
From: Pranjal Shrivastava <praan@google.com>
To: trond.myklebust@hammerspace.com, anna@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, chuck.lever@oracle.com, jlayton@kernel.org, tom@talpey.com, 
	okorniev@redhat.com, neil@brown.name, dai.ngo@oracle.com, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20601-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AE46737FECD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new transport op, supports_p2pdma, to allow upper layers (such as
NFS) to query whether the underlying RPC transport supports PCI
Peer-to-Peer DMA (P2PDMA).

Since the capability is hardware-dependent. For the RDMA transport,
implement this by querying the underlying InfiniBand device via
ib_dma_pci_p2p_dma_supported() to ensures that P2PDMA is only
attempted when both the transport and the HCA drivers support it.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 include/linux/sunrpc/xprt.h     | 1 +
 net/sunrpc/xprtrdma/transport.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index f46d1fb8f71a..e451acd2e047 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -187,6 +187,7 @@ struct rpc_xprt_ops {
 	void		(*bc_free_rqst)(struct rpc_rqst *rqst);
 	void		(*bc_destroy)(struct rpc_xprt *xprt,
 				      unsigned int max_reqs);
+	bool		(*supports_p2pdma)(struct rpc_xprt *xprt);
 };
 
 /*
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 9a8ce5df83ca..1c1714189a29 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -717,6 +717,14 @@ xprt_rdma_disable_swap(struct rpc_xprt *xprt)
 {
 }
 
+static bool
+xprt_rdma_supports_p2pdma(struct rpc_xprt *xprt)
+{
+	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
+
+	return ib_dma_pci_p2p_dma_supported(r_xprt->rx_ep->re_id->device);
+}
+
 /*
  * Plumbing for rpc transport switch and kernel module
  */
@@ -742,6 +750,7 @@ static const struct rpc_xprt_ops xprt_rdma_procs = {
 	.enable_swap		= xprt_rdma_enable_swap,
 	.disable_swap		= xprt_rdma_disable_swap,
 	.inject_disconnect	= xprt_rdma_inject_disconnect,
+	.supports_p2pdma	= xprt_rdma_supports_p2pdma,
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
 	.bc_setup		= xprt_rdma_bc_setup,
 	.bc_maxpayload		= xprt_rdma_bc_maxpayload,
-- 
2.53.0.1185.g05d4b7b318-goog


