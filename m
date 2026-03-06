Return-Path: <linux-nfs+bounces-19854-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNWyIPFNq2lYcAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19854-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:58:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E410822827F
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E349C30B12C2
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 21:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7474B421A10;
	Fri,  6 Mar 2026 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAwI96Q3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50561369984;
	Fri,  6 Mar 2026 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772834197; cv=none; b=JAGe3sVOooJFiSHjhK1B+PapmK4C510y1cdTjJtnIV81/vzzb6wfZZNcQLfOj7u3/aWNwEn1zibSTTupQTxObo8SclcgbJCt3yFFAW31NGTl6FbKKJm1Pk8B/e9pZWHg8RDHc8V68gFLeFSnHdb+0NlR1Qw2mqNUx30SMz6Y4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772834197; c=relaxed/simple;
	bh=Klvejl1QE1SYQFDJLGvPbasjr0SRGDRKc+6VHQ195S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iobwhNEB6Rfs9f1P4Jyk2Plo2sZ+LmZanIMwNxg7cqtNkrHincKJP8UhdIj/SkwZHcm49bIexYtU2oASf2SGEAEDhY5XSo3JBpmlY6mMUuG+ghU3yhZxExjPQBsMjnsrQpgsbNU8KlsbxXtcG2vUh4msoOiJGG/gz2tn6mwI+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAwI96Q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE63DC2BC9E;
	Fri,  6 Mar 2026 21:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772834197;
	bh=Klvejl1QE1SYQFDJLGvPbasjr0SRGDRKc+6VHQ195S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAwI96Q3+pMUeGsPlGrygg4u/BMB6o7HgKxxnDkMiyFKsREO0b0tb5DT+lBUBDIYY
	 /nCQ+0AxD9Y3NW9LRHdRhzDs743VkQXszveIspaXe1mRzkKeRk8OxHJ+7K3sWR6mc/
	 AxS/xOFUXAfWP7hQsQaAInN/3p/u0TEWZFtD4MxWle2p7SAki+jD9t9VtdXeVmga0x
	 lxA756hBJRzPcEoxjZflihmPeR7LivLroyGEfTxph1F9s+PJcLHp1jP9KGZlkUOO44
	 2UCZW0RhEDZq98ly2DrETTRDTwQvVVbTEUm0W5ZQ94q4vUY+bOSyGmqjWjy+Sl5Uy2
	 s7aIJ7+zSUOLA==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 7/7] xprtrdma: Post receive buffers after RPC completion
Date: Fri,  6 Mar 2026 16:56:28 -0500
Message-ID: <20260306215620.3668-16-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306215620.3668-9-cel@kernel.org>
References: <20260306215620.3668-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877; i=chuck.lever@oracle.com; h=from:subject; bh=D8DCTRYU0QiHo18PpbEtHoniuCV4T47EzXPmEHMZMxQ=; b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpq02N5b708vUlMX4M8LFJZg/sbAV1e4xjr2Lga xfdVYQ5rq2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaatNjQAKCRAzarMzb2Z/ l7tmD/0b9pRU3LrOviYklol/x56tMDDYCGHduCEwQddcEWBxh54B1lYSaTVHb4lcMXVqCyKyOH0 eetwo9ix49iFLYFW9YPdkQG6v1cDJzCKyA1EIR9gSnhFVgz+BmEAwJYAz2IGrArynOjqVn9m2+F f3CsulNXfxjiEXO9TqHXWuJ+JAVDan2jsvKGq2iCMjE4qELBNawrnvuzTJcjUUD2GkoE3SPksVD hulh++AK1JwZdtGnd2BimCOZ3oCAZ4JZ4buQC62fIGJaUzODUZigtlkH2ScChv3vqC2nuRXQOJp m+Pf9j+elJFWFt1nfKcZwArtDOBOokKyqJGUl1Lu8yYWW7EjXQ5aLb++zCHfCGzuaf2F/fJu+e/ odeR+4+E4xTJG+ZfF0qcLoXC1+mvYStu7Mb+GUL2zJwcHYQt7SUdIIAZXqMubf7XJKiQW9XpP76 OYfmsyD6UYwSIQOD+/iPCQ4iHsQE/F6ppskvXtE9uPGjlBqPYMoK4SZNA2yscxjFQM6jqFygVF9 TnoIaflv3+BcY/e3HNjZDWn2pQ+X9wSafjSB7jIGRhFPzHDWOByz8+ooefWzoWbIlq8kPXHCpEc 6N/NIJOq2ZP1hwwzZuqgvxiDlvPlPp7U3ysCupB8UhDj6s5X9yyza01jL8xrvRhmFdq4FoDu3/M KjjARobaGrYqPbw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E410822827F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19854-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

rpcrdma_post_recvs() runs in CQ poll context and its cost
falls on the latency-critical path between polling a Receive
completion and waking the RPC consumer. Every cycle spent
refilling the Receive Queue delays delivery of the reply to
the NFS layer.

Move the rpcrdma_post_recvs() call in rpcrdma_reply_handler()
to after the RPC has been decoded and completed. The larger
batch size from the preceding patch provides sufficient
Receive Queue headroom to absorb the brief delay before
buffers are replenished.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index a77e7e48aab2..0e0f21974710 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1422,7 +1422,6 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 		credits = 1;	/* don't deadlock */
 	else if (credits > r_xprt->rx_ep->re_max_requests)
 		credits = r_xprt->rx_ep->re_max_requests;
-	rpcrdma_post_recvs(r_xprt, credits + (buf->rb_bc_srv_max_requests << 1));
 	if (buf->rb_credits != credits)
 		rpcrdma_update_cwnd(r_xprt, credits);
 
@@ -1441,15 +1440,20 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 		/* LocalInv completion will complete the RPC */
 	else
 		kref_put(&req->rl_kref, rpcrdma_reply_done);
-	return;
 
-out_badversion:
-	trace_xprtrdma_reply_vers_err(rep);
-	goto out;
+out_post:
+	rpcrdma_post_recvs(r_xprt,
+			   credits + (buf->rb_bc_srv_max_requests << 1));
+	return;
 
 out_norqst:
 	spin_unlock(&xprt->queue_lock);
 	trace_xprtrdma_reply_rqst_err(rep);
+	rpcrdma_rep_put(buf, rep);
+	goto out_post;
+
+out_badversion:
+	trace_xprtrdma_reply_vers_err(rep);
 	goto out;
 
 out_shortreply:
-- 
2.53.0


