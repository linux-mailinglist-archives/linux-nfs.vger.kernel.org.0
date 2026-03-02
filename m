Return-Path: <linux-nfs+bounces-19626-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNYMDIMPpmkJJwAAu9opvQ
	(envelope-from <linux-nfs+bounces-19626-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 23:30:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1671E5797
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 23:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A132430532AF
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2026 22:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3166D31E846;
	Mon,  2 Mar 2026 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrizRNFx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52031E843;
	Mon,  2 Mar 2026 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490310; cv=none; b=iDfZdFDheSBJIvJmoL5sDqvNzFchDVUjIV7xGMspU1cOdVkEVuJv95rBR5jJ0yi0B6r5MfNIU/5iSRtIZ1V8fs6P/AcSlofcY/DvzgT2Eo0KVvGNdJzthFSqup1VvkMVN3wYZo0gAilVlFHK8/rKmptBmhIx8p/+fon5LmfCevo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490310; c=relaxed/simple;
	bh=z1MJC3FRweYmPEPq5YHZ5jyoBMGe/oJK14mlqTwgr2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUGwrGbOdZVnl/Xfu81s6Aqpjtnnht/sikHrbNPJzEMugwB2fX9yYDT4siz7L6wV/uY6PhEo6DlOJnhC7zSqDvlu8EQOzVHShAzmn/YpRHZYxsKRXe59NlHklZTfnFCUuNkKFdNpMyTUYC7VDOHiPLwRgNsOfv9dST4HXNXJRG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrizRNFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D8DC19425;
	Mon,  2 Mar 2026 22:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772490310;
	bh=z1MJC3FRweYmPEPq5YHZ5jyoBMGe/oJK14mlqTwgr2g=;
	h=From:To:Cc:Subject:Date:From;
	b=OrizRNFxFCUYh9V6TNt+BvDhyObGNEUKV3fn/Rr/BWn6s0kWOwrpCE5bMKwA6pesf
	 O1gryPbYigQ8oLt7XQwowrqGbujrKJFMwcJIVn2GQSE8sNd8Av7VBzTiehXwMF2Ahq
	 roY4ukT9SWDPvCVm4bKrO6u1tGD7Z43jRO8DaPkHFmnJzJFRrwMtGrgkquo3Cm8nZ6
	 I121G0Znf3eZGNPeITB+OFKlxaY/lziu25T1pCj7qP6JHKTdpbEdMFCLrwX3JVtmW6
	 W8FTyak6mq7ydLm9W4jBQ5ylFmFXks/9QgAeiHM0iRuWSmXU77o24JRmf+SE0231B+
	 3Ts3XPcHOmAPA==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] xprtrdma: Close sendctx get/put race that can block a transport
Date: Mon,  2 Mar 2026 17:24:46 -0500
Message-ID: <20260302222445.2230-2-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2576; i=chuck.lever@oracle.com; h=from:subject; bh=Vj3diU24cdWhFoe5Txt6pOMwv2moztIOqmveQ9QcMSA=; b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBppg4tOKb0U0pFAM9Sh6N1f9tHKLUfISLAkXkA2 QBwL5FiF3yJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaaYOLQAKCRAzarMzb2Z/ l60HD/wJXPCoPFqjVPIINXFdTIqQ2qTrlfC0UggaJ1kToE6h2TMf9xzD5dZ/SwJjiCXu4oDw95Y +eOZvjnDp+v4nPsEqtCW3zJHm9NjkVMMslEpwXZNWUVlkN0PQ4zVqeUz1rG9hRkNnvrCqGLkN3O z0lhsyNDUZ2STKXtxO3wY8ukmWFT29EoheUZ+uRAkVz0X4vqtFXwhximSTnsWbY4qoIwenoYOEa 8BNlA2OHvHzfAfEi9XO5XAsgGJ0zNxHdrOWxK+Un7UJhBynbFTtArkwO5xibI5XEzkcutg29LrB mH+wzv0KSkW73iL5IrTddtwkTlR0tWK+ShDXITjJKuQcQHhClWLllBLbME38h6/BW7VsQZf3+yS WJny3o5+7vqoUz5FQFFGlpHUaZQDOhYRJtBcmOJghc+OR9uh2StFhZpCq9kLgiRHSyamljansjj NW6mciCRkwYgDlmKaEuojgoiNzvapreECR4ll5eYiKuwAt4UvGcD3cZ8Jd5uj/l6UsD5wRv/Xx9 IZl1jhnqbBR0QffnXwDV2w0kpyhFQu3CZI9+nK0W/eUr+QFIr1B0eHmsImy81kLSTxoM7nrDZhy 5ewMRyoxTvJhi2prEfrkVdc1/aEtGkFLBnbsirOhPtFXCHVP1WHmxkuDf1eyZhR6YxQMOBwQC48 beiEsTQHwQqCCoQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BD1671E5797
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19626-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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


