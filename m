Return-Path: <linux-nfs+bounces-19800-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HIrFeeZqWm7AgEAu9opvQ
	(envelope-from <linux-nfs+bounces-19800-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 15:57:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF807213FB4
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 15:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE34331CDC03
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E847C3AA1B9;
	Thu,  5 Mar 2026 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCqUfgDt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE563AA1A4;
	Thu,  5 Mar 2026 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722268; cv=none; b=YtdhC6WpRBI+wzqIx7JaKD/p0ybmdKh/l9DzZGPhTiW5HvA0LDqEFDneXZRJ0LFUCY7xlR+k7E4s51LI3KG2VBtMpCr5HLaYeibv4hOb33c72/+cRHhtT8CsUPDEQS1kpmjkboRZ0sv4fyKRgp3EAxJpUDCQq4j/MzJDZ5Dqg6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722268; c=relaxed/simple;
	bh=z1MJC3FRweYmPEPq5YHZ5jyoBMGe/oJK14mlqTwgr2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTd2fhhCijYlekbnyRgEVYfq7uC21jQAFmk1dhcpdY6y+lZ5yjSIBtP2kP+MGAxY18sg0lg80moShWYNxqqdl3BfLa0sZqzR90THtO81h7PrkWSqRnpQbli1P7inKSYO8JNXJm0i5shMlJsYPR8vu9D1vc572JY80j8tgi2IzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCqUfgDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A6DC2BCB2;
	Thu,  5 Mar 2026 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722268;
	bh=z1MJC3FRweYmPEPq5YHZ5jyoBMGe/oJK14mlqTwgr2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCqUfgDtAMRuBloIeMBdO5woK5MhRvEABy/vWszqjFiasJwr1FEBPGf0f9m8AcWTL
	 DAde67hUsfYOPH27zL88wNZhNtBT2+7ACPnoZl1MgdFx90ZQcQn8hi5168Nmr/s+1x
	 VgLYJqT6do7fWh2EMqaospMZ7wXf/ah/r1oOmyXRqbSaoejvXUj1NRpqeJOOZC3bTl
	 W9QMj84j28rGJyIbhLnZ9dftosgBB8ot5czDpbo4MPsxZXi/PAdsZEXNYlUIEriFQJ
	 AtcvdvFyL2f89IlhTAvWUMYaJnre8dETjS1vD2A7ERUuPKMNlHb2FdtdOqiV/7ZxCL
	 U65Cy5p+6OxKg==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/8] xprtrdma: Close sendctx get/put race that can block a transport
Date: Thu,  5 Mar 2026 09:50:57 -0500
Message-ID: <20260305145054.7096-12-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305145054.7096-10-cel@kernel.org>
References: <20260305145054.7096-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2576; i=chuck.lever@oracle.com; h=from:subject; bh=Vj3diU24cdWhFoe5Txt6pOMwv2moztIOqmveQ9QcMSA=; b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpqZhVOKb0U0pFAM9Sh6N1f9tHKLUfISLAkXkA2 QBwL5FiF3yJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaamYVQAKCRAzarMzb2Z/ l1JsD/9kKf+u9X3l2tWUdIRSqNc4lrN7FEKsX3eMM9G27ATvQzuFSAF3nbTe/mJtL5NgiXFTLOK WGQQ/pv7qYXA0/MTZBz6iinLJJvzmS3+DruEfH0CiOOGIUWFztxQyIpnJd215hXM02yIIbN+LTd 77sdq9RE7hK8H23DxiU1N9FsginCfnM7gJP8/suwlhOiCb0o2YORRNmVBUfoh83HWgFCmGw107k QuXhaIDkEeZm5sJp1pIPrGbn4q3nZc1Y/3tKBAKcR7XdIp83dnGNxOCjBaAf5HE+qLyBOEQeH2i Nwf2BGU0UV+BC1RfBG+5RcC2L8ots8vzeBEaDpia+vmqv1lEXCOgyHfifsnnUlgAJIj7uqqixP7 DFSUKnd7Kaiu0PodUNNOFpLf9aWBsmQAY/qTwE/QfjrlE9Dm9LS7TBVkMH4auzGWuqd4yINORxg oUyKlFGmmuWKn/48+oivy4X3onj5PLPc/bjER0f/jMg9rI8td7dhtgA6csNLMR3+nRop4aPgZcP Ivr/fD7DLbVxf4tVc0mrwDPiugibv/MAxbRZIUVrNSk17FwMYG3ILeUU5/Wyl2blKbJTD++keCp A7JqOOkrUovwEKoV5Dki/+s4/s23EXpksrDeTJBkzfrsbHh6rzSwWPhgBQYCaeERWyFEVRS2dFP XDk/RvipE3ODmXg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF807213FB4
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
	TAGGED_FROM(0.00)[bounces-19800-lists,linux-nfs=lfdr.de];
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

rpcrdma_sendctx_get_locked() and rpcrdma_sendctx_put_locked() can
race in a way that leaves XPRT_WRITE_SPACE set permanently, blocking
all further sends on the transport:

  get_locked              put_locked (Send completion)
  ----------              --------------------------
  read rb_sc_tail
    -> ring full
                          advance rb_sc_tail
                          xprt_write_space():
                            test_bit(WRITE_SPACE)
                            -> not set, return
  set_bit(WRITE_SPACE)
  return NULL (-EAGAIN)

After the sender releases XPRT_LOCKED, the release path refuses to
wake the next task because XPRT_WRITE_SPACE is set. The sender
retries, finds XPRT_WRITE_SPACE still set, and sleeps on
xprt_sending. No further Send completions arrive to clear the flag
because no new Sends can be posted.

With nconnect, the stalled transport's share of congestion credits
are never returned, starving the remaining transports as well.

Fixes: 05eb06d86685 ("xprtrdma: Fix occasional transport deadlock")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index b51a162885bb..90fd83f2d846 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -708,6 +708,18 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
 	 */
 	xprt_wait_for_buffer_space(&r_xprt->rx_xprt);
 	r_xprt->rx_stats.empty_sendctx_q++;
+
+	/* Recheck: a Send completion between the ring-empty test
+	 * and the set_bit could cause its xprt_write_space() to
+	 * miss, leaving XPRT_WRITE_SPACE set with a non-full ring.
+	 * The smp_mb__after_atomic() pairs with smp_store_release()
+	 * in rpcrdma_sendctx_put_locked().
+	 */
+	smp_mb__after_atomic();
+	next_head = rpcrdma_sendctx_next(buf, buf->rb_sc_head);
+	if (next_head != READ_ONCE(buf->rb_sc_tail))
+		xprt_write_space(&r_xprt->rx_xprt);
+
 	return NULL;
 }
 
@@ -739,7 +751,10 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 
 	} while (buf->rb_sc_ctxs[next_tail] != sc);
 
-	/* Paired with READ_ONCE */
+	/* Paired with READ_ONCE in rpcrdma_sendctx_get_locked():
+	 * both the fast-path ring-full test and the post-set_bit
+	 * recheck in the slow path depend on this store-release.
+	 */
 	smp_store_release(&buf->rb_sc_tail, next_tail);
 
 	xprt_write_space(&r_xprt->rx_xprt);
-- 
2.53.0


