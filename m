Return-Path: <linux-nfs+bounces-15128-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76354BCD5D8
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 15:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F5DA4E2A01
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE1E2F3C3B;
	Fri, 10 Oct 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBux4V0e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93492F1FFE
	for <linux-nfs@vger.kernel.org>; Fri, 10 Oct 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104591; cv=none; b=cPDTR+vIWRQR4ivDnLNhnHTA8tcoVWqY+8VkZLMB6yeXRubMUdeczN+WK63eyVEIXsj2/Bo5ODmydyyhBXKcH4+UMUB8rHr+tmQvq/rYyqVu2e/E9zGk/XlUKg8LgOtJyIsIiLa0bK2uMJV8VbV6enGPKRpGPXk6ZyRsDNWuJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104591; c=relaxed/simple;
	bh=z+NMsp/xGawEnLlY4qoG+nqDJMsW9ocapuCNp1rSaNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxOoBGuzgAWB4bWiSltN2v4nHrzehyuwqiOGDaUNJ/M++E3xTdPw+DsGnei4d/LeAmRjxGOuAuHJju+pDOmUBCY7WrbpYnOlqh8hAzAdLR2pv92J9YEEpJOTjGQAgkCS+P3XCPdKzep1utEpg+UNHAQshHRdnCBtFmHGl+rG8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBux4V0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63493C4CEF9;
	Fri, 10 Oct 2025 13:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760104591;
	bh=z+NMsp/xGawEnLlY4qoG+nqDJMsW9ocapuCNp1rSaNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBux4V0e5K74jxHcuoIoTt2KcUoW7s2YYjBixUGAAYwzeoGw2KXYzyOILo45duyX+
	 e6DMud8kbqAcLaTmpqw8+HxtxbJKUIAd9/ZSyMJgpd/5wYiY6leQqSw0ZPwgHPWnT2
	 TZBF17lLsAVOtvaqkz+IBTqWoBN83AKjd+hUgegfNskO2sRWwYhKRoETRjKTs88JZX
	 km4LwohWpPO6OxpRX1WDpLn0eaA0Qh5+pJsPc5mVo6J3eX9kFiliskAfngDu//m2HJ
	 D7fgBx/6mKZGroM+pCigeNG2sSiKT3aSXRqkb2kRAhxq3787q3WauGQyVIrKhK/t8z
	 HqS4NXLzgc1iw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 3/5] nfsd: Never cache a COMPOUND when the SEQUENCE operation fails
Date: Fri, 10 Oct 2025 09:56:21 -0400
Message-ID: <20251010135623.1723-4-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010135623.1723-1-cel@kernel.org>
References: <20251010135623.1723-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 8881 normatively mandates that operations where the initial
SEQUENCE operation in a compound fails must not modify the slot's
replay cache.

nfsd4_cache_this() doesn't prevent such caching.

Fixes: 468de9e54a90 ("nfsd41: expand solo sequence check")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c9053ef4d79f..7b80f00fb32c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3477,16 +3477,26 @@ gen_callback(struct nfs4_client *clp, struct nfsd4_setclientid *se, struct svc_r
 }
 
 /*
- * Cache a reply. nfsd4_check_resp_size() has bounded the cache size.
+ * Maybe cache a reply. nfsd4_check_resp_size() has bounded the cache size.
  */
 static void
 nfsd4_store_cache_entry(struct nfsd4_compoundres *resp)
 {
-	struct xdr_buf *buf = resp->xdr->buf;
+	struct nfsd4_compoundargs *args = resp->rqstp->rq_argp;
 	struct nfsd4_slot *slot = resp->cstate.slot;
+	struct xdr_buf *buf = resp->xdr->buf;
 	unsigned int base;
 
-	dprintk("--> %s slot %p\n", __func__, slot);
+	/*
+	 * RFC 5661 Section 2.10.6.1.2:
+	 *
+	 * Any time SEQUENCE ... returns an error ... [t]he replier MUST NOT
+	 * modify the reply cache entry for the slot whenever an error is
+	 * returned from SEQUENCE ...
+	 */
+	if (resp->opcnt == 1 && args->ops[0].opnum == OP_SEQUENCE &&
+	    resp->cstate.status != nfs_ok)
+		return;
 
 	slot->sl_flags |= NFSD4_SLOT_INITIALIZED;
 	slot->sl_opcnt = resp->opcnt;
-- 
2.51.0


