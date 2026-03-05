Return-Path: <linux-nfs+bounces-19805-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKDhHfSZqWm7AgEAu9opvQ
	(envelope-from <linux-nfs+bounces-19805-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 15:57:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCD4213FC9
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 15:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 167BF31E046F
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 14:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2008D3A9DB6;
	Thu,  5 Mar 2026 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3hcv9Tx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114F3A9D96;
	Thu,  5 Mar 2026 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722272; cv=none; b=pHR+pw9W4ZvGWLjhe+f1aj9QSVgWwryE7e04sNUj2KGFJCJnPE9hzJwpu6mkPyy2h5BaCm7Ap6zhKDdqjsZRJB3dto3UsDZsAqC/HbUv/BkZkSfzmv3Q3of0vstcsWKhPnjbRFE7gXfxlQ28G4COrKhx2+CdT+SR+t2xr/ez5o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722272; c=relaxed/simple;
	bh=e/OPfZTOUwLDN3X81q0euH+O1yzEZzCra0W5GskAonY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RU1muBX2N2Uktfh2ZnfMRXpWyOIDWuHZ0xb+8/xtBWN0fCVMzR6aoDJJpqivfFvFQ5VacCeZrruUuibu7x67OkivSTTmgdzJrRzByUmwkewsOASlF0VxYPMdOMpb01EGwMdKekiQsgIjlX3tVQgrEk7iwwup/3auOzgOnlNQGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3hcv9Tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5C4C2BC87;
	Thu,  5 Mar 2026 14:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722271;
	bh=e/OPfZTOUwLDN3X81q0euH+O1yzEZzCra0W5GskAonY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R3hcv9TxrKvzKHJm1ryR7WFhVgWDMMMJ9aiUaKIZFmS70v9I8EVxSAO99YvPVybLO
	 Op6qGdAdpuLI0C2MAffYhRDRYgD9UZk1H5zOqIbgFZpEaJS/XwsS7FQ6zinHyzXkOA
	 Lx93SYAyhP4QFumWRN/cQxkaB9c1y1QsTb8s3E0NVIENi67MOR7wTbQSr8RzgzknO5
	 qPOCavVq+y9GcRsf2rwmz4v1YkrqKwb6I3vCvYwiOwa0nBMbqCi/oLgH/vaCpfCD46
	 IA7qhGRcThdmmMs+bkXRUwyeS5rmWZ42PzmXPNL/uC/xuQrVpCdmrQ8lvo+NPsZe05
	 fLGJ2Edhi/ifw==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 7/8] xprtrdma: Scale receive batch size with credit window
Date: Thu,  5 Mar 2026 09:51:02 -0500
Message-ID: <20260305145054.7096-17-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305145054.7096-10-cel@kernel.org>
References: <20260305145054.7096-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; i=chuck.lever@oracle.com; h=from:subject; bh=uqy3ZamChHlcoW27MQbYShvbQZSA5/ts0PweXjp6dQw=; b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpqZhWX0H4cjzKAuDxaHd/HfZbg0Wc1pN8sFZiM GIY4wGVLdWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaamYVgAKCRAzarMzb2Z/ l4DpEACq8mcKMiXXEa52BPyCL1Y7IsrASBPfxoCHXLB8QWcqkFR57n9rZ5RqnaNXZ33VUZSREf1 bbKc27TkD1C5WzXd5i0fBF2ro6NwOq6GORYKM81P5OmvN/WW9xDvJF39psYA3/eX5xtkZ6RE24V VR13EvySifY+4k8DIflzDmhHHuSBK6jU/xPwHVtg4rqbf/t13TSSTPzkoR8xzJcQ8jtSwh9pbs1 /grhSIqRaBjIp6V5YX/gTDm/d1OXkIaXPPELwkBtDkdQcJaagkLcX7M3B0bzL13Ya64AUwmSYgz wnlOp84G2CCrWnga++6WhvU5gv2U4UDQM1GZJPziRNGNUtgdnDdnvM6YlPmeyXT5lRMwN1AsTrz q5l9oaIHNNxh+0nCWdTbC0ZBxRuOZAn/2Qin11olnF2OHOpAS9glmyba/Ds4crn8E/qCa5NEBiR T6GTsfAW4WOOYU0oxzpcBDiNwdFIWSacAzcQ+isc2dVvQDjvy/XJTz8tp5+c+mYXGTwVd8xaRT9 z9GeEo9hDnlDk66JH7GwkPHyTsZcNlaca1s4wOTvQe1vwY8i6PSL0baUVtKsWUWi5cYsN4GsIoP V0eMyDrNLUbnd9yWQnUE2SD4KDL/d+E9DAYrE21u9I2y5cGjiKS7Aj/AcU0nwA2x2z1msmHfbzb 9AiiwmMS/DlqHUw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EBCD4213FC9
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19805-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
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
index ef6a6ab9f940..ab7c46658c16 100644
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


