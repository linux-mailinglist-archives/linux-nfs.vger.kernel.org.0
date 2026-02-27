Return-Path: <linux-nfs+bounces-19415-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CmzIn6moWmqvQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19415-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:13:18 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 431EB1B88A7
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D63B30EFFF5
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0333941322F;
	Fri, 27 Feb 2026 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtL3xNcH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE9413224
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201042; cv=none; b=SpU/RjQ4pm/5X0nqOC3lDvn9jnK/gmkYkCEsIWUodltk5RALPKSY3bidQFzxa4bWFAL+Pr/OXS/MfWcueF39FRaSj0O+OQguukdtBGhBDpi3lELBFp/ECxAjv+wWZ7fdxjInTbFZADB65fMhqDUkM8opGAH0OrmI/iUoJ21d4ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201042; c=relaxed/simple;
	bh=Lpve2/+PMjaOx+yXhMWLaQ5hoCTTwYs44LZmhlZSWpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fh/DytfDexblXQDIO3xvkS6vr8zWJ70mcHpmg+dpafxd26uPjM2wQc+LD06nSs8U9ur2BHBuDRh2QwFDUlMFtGZtF3oYZNXzPe1MDGIZqezZoad9gnE7niEKOFV/A+Fp0UaOC310AV+NFWzXO4ZsiIO0U9Nw+hGGuboyJ6StDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtL3xNcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8EFC19425;
	Fri, 27 Feb 2026 14:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201042;
	bh=Lpve2/+PMjaOx+yXhMWLaQ5hoCTTwYs44LZmhlZSWpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KtL3xNcHi1uVD25gQczepiVudwxws7swFRpxtm2crLOmj1BUEfoQqBrS+5oWzdhoy
	 OQ3LGXzXT9Z526GhqCy2fd3rhTnRHYp4EaCM4oVHfGUh7Z36Q1P5NJNzpcB79XJnUV
	 Sq0MnMD08Gg2ut1Pvo/d9NvCQ7znGkPrMZt1wruISmYzcPGwwE8tSzN4NP7vRIXO3G
	 2EA8i+gPlaWPQRCcOU21x11uuLDNNeuiuwlniKMns8yF7MauSkE+f5FeFULkTF6kbZ
	 mp7yAbXmFwxUEflWldz6pej0AjxgPLxQCTiCjwMyATuDqYnv4fY8OTeLQsWq4y34sp
	 N5tmZm4V8ChnQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 18/18] sunrpc: Skip xpt_reserved accounting for non-UDP transports
Date: Fri, 27 Feb 2026 09:03:45 -0500
Message-ID: <20260227140345.40488-19-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227140345.40488-1-cel@kernel.org>
References: <20260227140345.40488-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19415-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 431EB1B88A7
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The xpt_reserved counter exists for UDP socket-buffer back-pressure:
svc_udp_has_wspace() is the only has_wspace implementation that
consults it. Neither svc_tcp_has_wspace() nor svc_rdma_has_wspace()
read this counter.

On TCP and RDMA transports, svc_reserve() fires twice per RPC, each
time executing an atomic_sub on xpt_reserved, smp_mb(), and a
svc_xprt_enqueue() attempt that bails on XPT_BUSY. At 257K ops/sec
over NFS/RDMA, this is measurable dead overhead.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_xprt.h |  2 ++
 net/sunrpc/svc_xprt.c           | 22 +++++++++++++---------
 net/sunrpc/svcsock.c            |  1 +
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index da2a2531e110..077cec38ed8d 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -37,6 +37,8 @@ struct svc_xprt_class {
 	struct list_head	xcl_list;
 	u32			xcl_max_payload;
 	int			xcl_ident;
+	u32			xcl_flags;
+#define SVC_XPRT_FLAG_WSPACE_RESERVE	BIT(0)
 };
 
 /*
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 36c8437cfd8d..94d21b68c1f8 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -468,11 +468,11 @@ static bool svc_xprt_ready(struct svc_xprt *xprt)
 
 	/*
 	 * If another cpu has recently updated xpt_flags,
-	 * sk_sock->flags, xpt_reserved, or xpt_nr_rqsts, we need to
-	 * know about it; otherwise it's possible that both that cpu and
-	 * this one could call svc_xprt_enqueue() without either
-	 * svc_xprt_enqueue() recognizing that the conditions below
-	 * are satisfied, and we could stall indefinitely:
+	 * sk_sock->flags, xpt_reserved (UDP only), or xpt_nr_rqsts,
+	 * we need to know about it; otherwise it's possible that both
+	 * that cpu and this one could call svc_xprt_enqueue() without
+	 * either svc_xprt_enqueue() recognizing that the conditions
+	 * below are satisfied, and we could stall indefinitely:
 	 */
 	smp_rmb();
 	xpt_flags = READ_ONCE(xprt->xpt_flags);
@@ -552,10 +552,13 @@ void svc_reserve(struct svc_rqst *rqstp, int space)
 	space += rqstp->rq_res.head[0].iov_len;
 
 	if (xprt && space < rqstp->rq_reserved) {
-		atomic_sub((rqstp->rq_reserved - space),
-			   &xprt->xpt_reserved);
+		if (xprt->xpt_class->xcl_flags & SVC_XPRT_FLAG_WSPACE_RESERVE) {
+			atomic_sub((rqstp->rq_reserved - space),
+				   &xprt->xpt_reserved);
+		}
 		rqstp->rq_reserved = space;
-		svc_xprt_resource_released(xprt);
+		if (xprt->xpt_class->xcl_flags & SVC_XPRT_FLAG_WSPACE_RESERVE)
+			svc_xprt_resource_released(xprt);
 	}
 }
 EXPORT_SYMBOL_GPL(svc_reserve);
@@ -834,7 +837,8 @@ static void svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 		else
 			len = xprt->xpt_ops->xpo_recvfrom(rqstp);
 		rqstp->rq_reserved = serv->sv_max_mesg;
-		atomic_add(rqstp->rq_reserved, &xprt->xpt_reserved);
+		if (xprt->xpt_class->xcl_flags & SVC_XPRT_FLAG_WSPACE_RESERVE)
+			atomic_add(rqstp->rq_reserved, &xprt->xpt_reserved);
 		if (len <= 0)
 			goto out;
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index f28c6076f7e8..ce840f8e86c6 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -828,6 +828,7 @@ static struct svc_xprt_class svc_udp_class = {
 	.xcl_ops = &svc_udp_ops,
 	.xcl_max_payload = RPCSVC_MAXPAYLOAD_UDP,
 	.xcl_ident = XPRT_TRANSPORT_UDP,
+	.xcl_flags = SVC_XPRT_FLAG_WSPACE_RESERVE,
 };
 
 static void svc_udp_init(struct svc_sock *svsk, struct svc_serv *serv)
-- 
2.53.0


