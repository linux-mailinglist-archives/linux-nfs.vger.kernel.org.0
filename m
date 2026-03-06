Return-Path: <linux-nfs+bounces-19848-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCibLLpNq2lYcAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19848-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:57:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 127BB228245
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 972B33028B29
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 21:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5142370D79;
	Fri,  6 Mar 2026 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9XoIQvT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFAF36C0AF;
	Fri,  6 Mar 2026 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772834193; cv=none; b=AD09cP/Qxi4zLodSOaFoSDY5cbiVhVgRX8NaVkKxBrxK2THowl5GSR1J00tnl8+zAKpW06zKAjm1h97o9ma6ZZko9PSFP0SJwrFdUMGxYfo9Tne4QCeQdEm+9kh8LUpLbTrPo6mITAUDxilJLwl03qRtMqi3pGw1DleIZjZfrAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772834193; c=relaxed/simple;
	bh=z1MJC3FRweYmPEPq5YHZ5jyoBMGe/oJK14mlqTwgr2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cv3UP65hP422RQ9iEQuTgbpAjdMNpCQBSjGOIeBP1TTCXs3NgVVYmnfkDJp49BdryahhT4niLiSHOAUivmnA353YpCEFYinUIseB46dub8Tym8MZmB/b+c4xwzS19TxLgg4hmm3Z5YTjMxPAS5C2F2Io8Md8DNC3hluF0LKpzqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9XoIQvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2564C2BC86;
	Fri,  6 Mar 2026 21:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772834193;
	bh=z1MJC3FRweYmPEPq5YHZ5jyoBMGe/oJK14mlqTwgr2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h9XoIQvT9LdAIyihUx0FEyCJDcc+b6V1T/xmoj3XBcE8EZYRGtQsC8gW9R7rsayOE
	 sJqPyqEQ5S5CClNqyaNmpOJrgR6NZ8KwNegNhdCc9Vcn0x92FSXLQev6LuL+2s0Zwf
	 qxjpnrbDnN7vU5Hw94c2Hjr2dI4gU4Sm19PZzDjU8R/aU+9A0H0r/6SQVJrS37lPwE
	 JtSJ/p3GlvkGPm1U2IeC5X4OeaE5IIwJX+3ARPHgDG9z7bqsg9gLDX1CzgiaFpqUjt
	 nu1D82vNuwBglt1wlDV7PutRIcWfs9opVNE5gWTSClko5z6MaWsLPCTnQJjxTouhNT
	 zEUQa1me7aOUw==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 1/7] xprtrdma: Close sendctx get/put race that can block a transport
Date: Fri,  6 Mar 2026 16:56:22 -0500
Message-ID: <20260306215620.3668-10-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306215620.3668-9-cel@kernel.org>
References: <20260306215620.3668-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2576; i=chuck.lever@oracle.com; h=from:subject; bh=Vj3diU24cdWhFoe5Txt6pOMwv2moztIOqmveQ9QcMSA=; b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpq02MOKb0U0pFAM9Sh6N1f9tHKLUfISLAkXkA2 QBwL5FiF3yJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaatNjAAKCRAzarMzb2Z/ l0tSEACIMewPcHOlCTldPnOtLl8al6HPSAIgK48H8Z/mlSAzjbZXFaSU6RSD+4Lcy6Ve8W8U8AU MvRTmLrhbXGL6g5+Ne7AGJRA/AqYqCMUZboBSU/6mz66wexTlIqr/BvfwGKXJieO7PZ4XNo53Ta iIhQ+LGH+CsLlLfwtfdEoVpmDnUppyvD7lE4kiVESnCy+Ms/x9b/g/P5NzTsd+jrh87qvmjdIy/ /U5JqoTtlxqO61NAO5Imb1d5NOd6sgjelGxcuXRm+k9c3qT/ZvEw1R+G8zhyeZSOv6hTmt9R1Zg 3Zp92bj1e3QhDurUJzyfsKzYXki5vXJ1sEl48/RNLy//n8nX5Fb9EYfsjSd4ML1ASLL3xT3y2vz +5UZg+dWBkc33E2LW1lAZpq3FM4Vz7EuSH7VbfqvSR7rCvut+rme4EkqrW87bQ0NjFkhFbr09YY vfwiGumO0kZnWF7vSivhL5kZAocWOeUrxuJUrXG3nD9XsrmHTva0JSdziYcR3UosdynVPdf3h7L tbEDHCfqZzlFzMK7zMCwimG/+jetCleQhTMODgFHIePLPHY6UiSRN9IekkjxtoJf+f0r4z4TTfg 3ZamFsituaCthZIkQd9Jecb/fZiaQ0bozxosp2v3LDbCtrhGBxeVbrwBEvF810NxJInqUYYJUZM soZtBuThYhnNcHA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 127BB228245
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
	TAGGED_FROM(0.00)[bounces-19848-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.986];
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


