Return-Path: <linux-nfs+bounces-19282-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBEDBLNeoGmMiwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19282-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 15:54:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E601A80CE
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 15:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0E543119338
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 14:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A73231329B;
	Thu, 26 Feb 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulvuxV0f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B4154BE2
	for <linux-nfs@vger.kernel.org>; Thu, 26 Feb 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117265; cv=none; b=Qa/CkiLPy7I0/jm7spqKKHa+G36QWZDvR4xUJc4JjLYBy2m8LYRGoJVN2NKaQ4OlPiMn9rnxkjMBC7fnE9R/3qHreuMH2TtHGVX6d2kEaE43mRKCzEk6Et8NPAkJZoSUVp8Dbp5eli90CKRZdYewjbkjXj4MAl7JcBsNn0d/3G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117265; c=relaxed/simple;
	bh=ag2WhmzQt0JeTuR6oPDjDKvCpi3ZfFTWTTecs0upkKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7E1IAqkYuSFTuHmHPJLOt98HRLFmOWKJm64a0DunNzp+XjoauBlbsJGwjKhvI+7L1t753hhrjzc/HdYHKzwBXRbLA7CYGxmC/KLsrBwi1CGGnOEe6nLxZypAKwqcYk5d1eIuNwhPwbnxML4Rdb9eD581hHWpA+hmjP6D5RqpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulvuxV0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEACC19423;
	Thu, 26 Feb 2026 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772117265;
	bh=ag2WhmzQt0JeTuR6oPDjDKvCpi3ZfFTWTTecs0upkKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ulvuxV0fRz1DZRuWkOG4sUvM1ZzooYS9i8G6q1GWZBNey1KLdBEqod3HdO4metLbc
	 v98Z/YJJtjA74Gp7UIXCH+yZN/d9GfMlB2z96CbUrOEgP028/s3MGBg5gtCeR78OPr
	 5pbDL0slQInRnBjV1Fom1OfytLd7YqbO4zw96MYP3eLENqMfMtIrZe7Y8tquPcNxRv
	 kk/m8D3+/jmx0JSGFy20M7++4ZeEagGmoGSAtSxVTM+WEFFDAhrfWesJlvltPNrkBE
	 5epFj5TTm3YriQabZ1v2QoXRhLq1pGIyAJVijxk3q9+d4fY+McYB0gZoBsAZtnpI/r
	 c6ZGFWekHUr/Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 3/6] SUNRPC: Handle NULL entries in svc_rqst_release_pages
Date: Thu, 26 Feb 2026 09:47:36 -0500
Message-ID: <20260226144739.193129-4-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226144739.193129-1-cel@kernel.org>
References: <20260226144739.193129-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19282-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70E601A80CE
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

svc_rqst_release_pages() releases response pages between rq_respages
and rq_next_page. It currently passes the entire range to
release_pages(), which does not expect NULL entries.

A subsequent patch preserves the rq_next_page pointer in
svc_rdma_save_io_pages() so that it accurately records how many
response pages were consumed. After that change, the range

  [rq_respages, rq_next_page)

can contain NULL entries where pages have already been transferred
to a send context.

Iterate through the range entry by entry, skipping NULLs, to handle
this case correctly.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 9abef638b1e0..0ce16e9abdf6 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -990,18 +990,24 @@ EXPORT_SYMBOL_GPL(svc_rqst_replace_page);
  * svc_rqst_release_pages - Release Reply buffer pages
  * @rqstp: RPC transaction context
  *
- * Release response pages that might still be in flight after
- * svc_send, and any spliced filesystem-owned pages.
+ * Release response pages in the range [rq_respages, rq_next_page).
+ * NULL entries in this range are skipped, allowing transports to
+ * transfer pages to a send context before this function runs.
  */
 void svc_rqst_release_pages(struct svc_rqst *rqstp)
 {
-	int i, count = rqstp->rq_next_page - rqstp->rq_respages;
+	struct page **pp;
 
-	if (count) {
-		release_pages(rqstp->rq_respages, count);
-		for (i = 0; i < count; i++)
-			rqstp->rq_respages[i] = NULL;
+	for (pp = rqstp->rq_respages; pp < rqstp->rq_next_page; pp++) {
+		if (*pp) {
+			if (!folio_batch_add(&rqstp->rq_fbatch,
+					     page_folio(*pp)))
+				__folio_batch_release(&rqstp->rq_fbatch);
+			*pp = NULL;
+		}
 	}
+	if (rqstp->rq_fbatch.nr)
+		__folio_batch_release(&rqstp->rq_fbatch);
 }
 
 /**
-- 
2.53.0


