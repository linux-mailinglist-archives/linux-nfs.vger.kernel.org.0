Return-Path: <linux-nfs+bounces-19091-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P4iLL0sm2llugMAu9opvQ
	(envelope-from <linux-nfs+bounces-19091-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 17:20:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2129F16F9B4
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 17:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EB76300C810
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC792253EE;
	Sun, 22 Feb 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdv++0A5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCC63D3B3
	for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771777207; cv=none; b=bcYQhLKw2cryht0RezKHNzhiul0kQFhZdUFvPFehmqjZuEmx0D2hNipkk0hjdhC7el82nua72v5taDm66yxVGa/2ZZ5BIenxuGfYaBZVLiX3XnlcGjyoaRCwks/IzoyKWSA1ZOwxI22Idgt8LMsvmHnM2L35dREOgMvMA/T1XGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771777207; c=relaxed/simple;
	bh=lgmrL3Uon4dgKrcyeEdnsAGfpcHeS+3/Lx3CtIBMXHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaPGba8yDGueKPyAJasYPzY5bPDGdYd2tHfgC7rETu1M2k09DX16HhpxCi8aVQdN5TmKaAR/XWF18zBiy/rHVQaCjMII8GO2pndSPnqmZR6EvZRXO1sxiGizvbWilnWX17OD1pLIQFxSkpmkf0svB0QkHVSD4LVqcfR4RcgE4xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdv++0A5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C489BC19425;
	Sun, 22 Feb 2026 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771777207;
	bh=lgmrL3Uon4dgKrcyeEdnsAGfpcHeS+3/Lx3CtIBMXHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qdv++0A5Y2WqpK3OXOCaZ3/jqYU5vwq+q4zDWP9ql41wm2P1Hxk5eEWEdoYQ10xQy
	 5JDFVWQjIT1/BZsj9e5JTr/4PWC+Sc6AcIdmlMEx98MaYyHRZmbfrXo7dxH3oTIE+w
	 q0PxYQc9jHYPQ8ka/nAftb73JQ0LkEUfHNxxNVZclyoyE6kJy+9qhinKPpTueNvJRn
	 ZUijEXf1E3tHhE8YBJWMYHdDPhjwRlKssu20312oatkPidkLRFr0ae4NQWBYk3oErQ
	 IRbTwXDI+/oNSYyCap6XqmD8zE318i9BdS+gG6QFMuX7lmwzqaZ7T769jWKomF69lr
	 kwwC+e5Y33DOw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/6] sunrpc: Tighten bounds checking in svc_rqst_replace_page
Date: Sun, 22 Feb 2026 11:19:57 -0500
Message-ID: <20260222162002.10613-2-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222162002.10613-1-cel@kernel.org>
References: <20260222162002.10613-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19091-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 2129F16F9B4
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

svc_rqst_replace_page() builds the Reply buffer by advancing
rq_next_page through the response page range. The bounds
check validates rq_next_page against the full rq_pages array,
but the valid range for rq_next_page is
[rq_respages, rq_page_end]. Use those bounds instead.

This is correct today because rq_respages and rq_page_end
both point into rq_pages, and it prepares for a subsequent
change that separates the Reply page array from rq_pages.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 346ac560dcc2..05ba4040a24a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -935,11 +935,11 @@ svc_set_num_threads(struct svc_serv *serv, unsigned int min_threads,
 EXPORT_SYMBOL_GPL(svc_set_num_threads);
 
 /**
- * svc_rqst_replace_page - Replace one page in rq_pages[]
+ * svc_rqst_replace_page - Replace one page in rq_respages[]
  * @rqstp: svc_rqst with pages to replace
  * @page: replacement page
  *
- * When replacing a page in rq_pages, batch the release of the
+ * When replacing a page in rq_respages, batch the release of the
  * replaced pages to avoid hammering the page allocator.
  *
  * Return values:
@@ -948,8 +948,8 @@ EXPORT_SYMBOL_GPL(svc_set_num_threads);
  */
 bool svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
 {
-	struct page **begin = rqstp->rq_pages;
-	struct page **end = &rqstp->rq_pages[rqstp->rq_maxpages];
+	struct page **begin = rqstp->rq_respages;
+	struct page **end = rqstp->rq_page_end;
 
 	if (unlikely(rqstp->rq_next_page < begin || rqstp->rq_next_page > end)) {
 		trace_svc_replace_page_err(rqstp);
-- 
2.53.0


