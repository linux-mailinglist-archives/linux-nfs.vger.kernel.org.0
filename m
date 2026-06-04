Return-Path: <linux-nfs+bounces-22288-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n8rVK7axIWqwLQEAu9opvQ
	(envelope-from <linux-nfs+bounces-22288-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 19:11:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D3D642389
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 19:11:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=h04Wp0oi;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22288-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22288-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C624B308DA54
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 17:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDA34963B5;
	Thu,  4 Jun 2026 17:06:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689849551D;
	Thu,  4 Jun 2026 17:06:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592810; cv=none; b=ZCqRtZ7TvVV6C6fJ9I8ced60vGZbwJ6G5nyF06gFN+Z22wp+p5+Q8nVjCt/AYQQNBmLCRbgVi79+ZM+EMhyht1Ov2wntIiERBObQ69IqxCLi2TEV7khouq2mleWeWWK9BgcXkAiF+ml5ehrRCXu8vJbZlu8EpxyWxPEoilyiz5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592810; c=relaxed/simple;
	bh=mWJ4hgBz6wh3cPrtaiGXfiK9rFgFPtbvpfnuy2EzPp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hK6Vh3bTmNIjPY4kgmQfemy0D9RD6NbA+hNbvxTARVrlmYA+2PLjMzHeNjBnmMaQdfQKqyyD6kNecZqR14a9qdIHipaQjpyPMG9kW0XZ6YJXv0P6XxiFqxCVo9iC3RH9AZ+y6WzfwWyIHoYGS55LgidQelUfbyzDK6AagSwwSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h04Wp0oi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A151F0089E;
	Thu,  4 Jun 2026 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780592809;
	bh=jXPDbP/fSjahV+3HrYKUTN2IWblJVY2hw9YG++KnT3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h04Wp0oiSUAF9XcGJo1MTpblmKNVMgGm6MZCkF6EnPnePBBRy+XwLyAnvfaOso0r/
	 45R6w2mv9xGN2Q2fKFKlN5MeMCC6dB1SxG1Ul/X5SGj4/T6ZdeU2lGygfBhX+R2TLc
	 RFoV1wXa0rAozXkyChrXsVWFAi5j2t+awOIdH8dTSw75TbbJPV8bBm1zzgG2oGdu6R
	 HYPTlxtu5TaZbHGRPa8kbjY7YdtCAYeRoe2EIKmbzL/dsBGh2QJSuyGWXPiLsZLCef
	 szZ17dyt2INesSkyu0ekfxEf4GeSiJZjMAL35/MIVmgmNVNaFqOYlUEv8yxe21cgUC
	 rZwFmEm7EuWZA==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 04 Jun 2026 13:06:40 -0400
Subject: [PATCH 8/8] xprtrdma: Return sendctx slot after Send preparation
 failure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-xprtrdma-refcount-v1-8-f74553f461e9@oracle.com>
References: <20260604-xprtrdma-refcount-v1-0-f74553f461e9@oracle.com>
In-Reply-To: <20260604-xprtrdma-refcount-v1-0-f74553f461e9@oracle.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=6003;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=qiSuMwGT+0SR7lmDBPExfZ6vUVtPYXrKo7RVD7cCzOY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIbCmiCJ0dazMa38cyFQ5dLM9eky5eesnV0GmN
 bYRo54adouJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiGwpgAKCRAzarMzb2Z/
 lys0D/9eQWUDrXarRHLLwedV0JOAu28EfFPCQGJeVko/CdOsZNWuHWXs5lpFx836P1ShMJViRSG
 hdnLydvKSgOLlx/V2MKfYyMgCoOdVLtTC9ILqcdfqDOFO8JWP3TYbqC7ojkJteC3U7hIHvUKWkZ
 /BwkOzkDFOH5EfEWaWiNIHSBa14awCGFig1oKvkGZ8j+Hnf16ruwxarwKMvZxPMHuPKXosfezj+
 mGSaPEJ9UGV41a/dG9y54RCLnwduPcYOG7e64TTvxtdrUn5CL8vdh4EnQgjkhxTQAJLvf3IE4b/
 12ImVUHixVGCWSYuEphWe6e7FS6KN3K4cJOlhXqonYVSlpxKg/yhXjqNj1844VewC5u6CWFeuus
 OGzt5IBvNwxOs3FBEyvAt3w9y98F7W3yLrEXxORa0beHcsrSdqgoHu9yrwp5rywjNUUkmkSnDWD
 ZSyACEzKG6OEy7Fni/DVZ6ciRdFe6DRtPEUIHQ/DQ3UYguyvtXvDDPoHLk1ApBQQfaglYCgCDjM
 sNkgr88v38t0S9vVEGg7lT+0Ac3A2jgTenKaIvf+bn8AhGB44XYcFXDYInY5CfHWxuMbHTPka1O
 FTBpKMrslc3YSCVpErlpFm3FFYM3z5+7iScBE2gRwJnbykf6l/VKMfFVw/3hMM6m2p+/Wzlq/0s
 PZi5YfFsHuCnLpQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22288-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oracle.com:mid,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48D3D642389

From: Chuck Lever <chuck.lever@oracle.com>

rpcrdma_prepare_send_sges() gets a sendctx before it maps the SGEs
for the Send WR. If one of the mapping helpers fails, no Send WR
is posted, so no Send completion is guaranteed to advance rb_sc_tail.

Current cleanup clears sc_req so a later completion can sweep over
that slot, but a consecutive run of preparation failures can still
advance rb_sc_head until the ring appears full. At that point
rpcrdma_sendctx_get_locked() returns NULL and no Send can be posted to
produce the completion needed to recover the ring.

The trigger requires CONFIG_SUNRPC_XPRT_RDMA and an NFS/RDMA mount.
Mount setup and reliable DMA-map fault injection require local admin
authority. Unprivileged I/O on an existing mount can exercise the send
path, but a remote peer alone cannot force this local DMA-map failure.

Add rpcrdma_sendctx_unget_locked() for the single-consumer send path
to rewind rb_sc_head when the just-acquired sendctx is canceled before
ib_post_send(). Wake waiters after making the slot available again.
After the rewind, every slot the completion sweep visits belongs to a
posted Send, so rpcrdma_sendctx_put_locked() no longer needs to test
sc_req before unmapping.

Fixes: ae72950abf99 ("xprtrdma: Add data structure to manage RDMA Send arguments")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c  |  5 ++++-
 net/sunrpc/xprtrdma/verbs.c     | 40 ++++++++++++++++++++++++++++++++++++----
 net/sunrpc/xprtrdma/xprt_rdma.h |  2 ++
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 3f50828802de..1285f04cdac1 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -747,6 +747,7 @@ inline int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
 				     struct xdr_buf *xdr,
 				     enum rpcrdma_chunktype rtype)
 {
+	struct rpcrdma_sendctx *sc;
 	int ret;
 
 	ret = -EAGAIN;
@@ -789,7 +790,9 @@ inline int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
 	return 0;
 
 out_unmap:
-	rpcrdma_sendctx_cancel(req->rl_sendctx);
+	sc = req->rl_sendctx;
+	rpcrdma_sendctx_cancel(sc);
+	rpcrdma_sendctx_unget_locked(r_xprt, sc);
 out_nosc:
 	trace_xprtrdma_prepsend_failed(&req->rl_slot, ret);
 	return ret;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 4f763961547b..0a9e51605f4a 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -631,6 +631,11 @@ static void rpcrdma_sendctxs_destroy(struct rpcrdma_xprt *r_xprt)
 	/* The QP is drained, but the final unsignaled Sends might not
 	 * have been walked by a signaled Send completion. Release those
 	 * Send owners before request buffers are reset.
+	 *
+	 * Unlike the completion sweep, this walk can visit slots with
+	 * no Send posted: after a partial rpcrdma_sendctxs_create()
+	 * failure on reconnect, rb_sc_head and rb_sc_tail are stale,
+	 * and slots between them can be NULL or have sc_req clear.
 	 */
 	for (i = rpcrdma_sendctx_next(buf, buf->rb_sc_tail);
 	     i != rpcrdma_sendctx_next(buf, buf->rb_sc_head);
@@ -703,6 +708,12 @@ static unsigned long rpcrdma_sendctx_next(struct rpcrdma_buffer *buf,
 	return likely(item < buf->rb_sc_last) ? item + 1 : 0;
 }
 
+static unsigned long rpcrdma_sendctx_prev(struct rpcrdma_buffer *buf,
+					  unsigned long item)
+{
+	return item > 0 ? item - 1 : buf->rb_sc_last;
+}
+
 /**
  * rpcrdma_sendctx_get_locked - Acquire a send context
  * @r_xprt: controlling transport instance
@@ -759,6 +770,29 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
 	return NULL;
 }
 
+/**
+ * rpcrdma_sendctx_unget_locked - Release an unposted send context
+ * @r_xprt: controlling transport instance
+ * @sc: send context to release
+ *
+ * Usage: Called when no Send is posted for the sendctx most
+ * recently returned by rpcrdma_sendctx_get_locked().
+ *
+ * The caller serializes calls to this function and to
+ * rpcrdma_sendctx_get_locked() (per transport).
+ */
+void rpcrdma_sendctx_unget_locked(struct rpcrdma_xprt *r_xprt,
+				  struct rpcrdma_sendctx *sc)
+{
+	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
+
+	if (WARN_ON_ONCE(buf->rb_sc_ctxs[buf->rb_sc_head] != sc))
+		return;
+
+	buf->rb_sc_head = rpcrdma_sendctx_prev(buf, buf->rb_sc_head);
+	xprt_write_space(&r_xprt->rx_xprt);
+}
+
 /**
  * rpcrdma_sendctx_put_locked - Release a send context
  * @r_xprt: controlling transport instance
@@ -776,8 +810,7 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 	unsigned long next_tail;
 
 	/* Release previously completed but unsignaled Sends by walking
-	 * up the queue until @sc is found. Entries left behind by a
-	 * failed rpcrdma_prepare_send_sges() have sc_req cleared.
+	 * up the queue until @sc is found.
 	 */
 	next_tail = buf->rb_sc_tail;
 	do {
@@ -787,8 +820,7 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 
 		/* ORDER: item must be accessed _before_ tail is updated */
 		cur = buf->rb_sc_ctxs[next_tail];
-		if (cur->sc_req)
-			rpcrdma_sendctx_unmap(cur);
+		rpcrdma_sendctx_unmap(cur);
 
 	} while (buf->rb_sc_ctxs[next_tail] != sc);
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index f879d9b9f57e..57be5776aaff 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -495,6 +495,8 @@ void rpcrdma_req_destroy(struct rpcrdma_req *req);
 int rpcrdma_buffer_create(struct rpcrdma_xprt *);
 void rpcrdma_buffer_destroy(struct rpcrdma_buffer *);
 struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt);
+void rpcrdma_sendctx_unget_locked(struct rpcrdma_xprt *r_xprt,
+				  struct rpcrdma_sendctx *sc);
 
 struct rpcrdma_mr *rpcrdma_mr_get(struct rpcrdma_xprt *r_xprt);
 void rpcrdma_mrs_refresh(struct rpcrdma_xprt *r_xprt);

-- 
2.54.0


