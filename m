Return-Path: <linux-nfs+bounces-20162-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G5RGKlotGnxnQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20162-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 20:42:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A3628961E
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 20:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94AC431F722C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 19:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF533CCFC6;
	Fri, 13 Mar 2026 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOHZPlgr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C936C36C5A2;
	Fri, 13 Mar 2026 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430927; cv=none; b=O3Ko5599WRB5WefZMew5+UxeR+kh7mmw4i4v/yqTmrX4NWG/vzyouE/t0SJ5xG2CvcjELtZ/V9gKloQ3wsDy+EtNue3BVuk4Mmbn++nPDYpDjluMaUxVjaEOKZVaKKqpjXxeg8Ab8q4YPZxnAYNpkI42IjXxkshE/9nM88G18hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430927; c=relaxed/simple;
	bh=DfLJTQGBEp38XNcqoBxopqdaB2q8jtanALf+4nsXq7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g48AQ/r7eN0PaUnL2spK0wikPvxA509tEv4rA+scv1CaERm0HNITc03d35I3cepOpFckj6Hts/BvjZl7TAHbjrGLI/8Y9QR8Hw2GJrIkrly7nPpFVu64QR3jDwwA6W7PVjcrRuqNk1VNRhkMa2/t35NpxkdPaxrkhlGu+aPvkYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOHZPlgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C210EC2BC86;
	Fri, 13 Mar 2026 19:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773430927;
	bh=DfLJTQGBEp38XNcqoBxopqdaB2q8jtanALf+4nsXq7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LOHZPlgrYWlu1Td2VBFiaHv6MYpPUbGcmYnt4sfS6BP89ypycnmCkSgRpy+ip+qR6
	 KTwd1e9dPIHHKTrUWxJQV3+89pCeV0XreEKdWgVE4Ydd+Oc/Fm64xt5hRtEQuKqDox
	 goWow7OETearrh5fAat195B0P+ia5kMlwWhRQm20bANelwRdQeFSGjubrRGIlkEjFA
	 uwDl5RbolUs7f3elNmaspAtB3Qo5N8bMuO5/8hYlG+7wvJ+QcjA2lp2XXa46cEZ9AB
	 9BOs0/ym3qTfYgwXjDoOrm5dTyafmaZTQLFtX2kxcom3pOzSiqKG5tFWIFWy2yuYVp
	 VwjyobMJAPB/Q==
From: Chuck Lever <cel@kernel.org>
To: Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 3/4] SUNRPC: Add svc_rqst_page_release() helper
Date: Fri, 13 Mar 2026 15:42:00 -0400
Message-ID: <20260313194201.5818-4-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313194201.5818-1-cel@kernel.org>
References: <20260313194201.5818-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20162-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,lst.de,ownmail.net,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2A3628961E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

When replacing rq_pages[] entries during RPC processing,
old pages are queued in a per-rqst folio batch rather than
released individually. The add-or-flush sequence appears at
every replacement site, exposing folio batch internals to
each caller.

Introduce svc_rqst_page_release() to encapsulate the
batched release mechanism. Convert the call sites in
svc_rqst_replace_page() and svc_tcp_restore_pages().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 15 +++++++++++++++
 net/sunrpc/svc.c           |  7 ++-----
 net/sunrpc/svcsock.c       |  2 +-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 4dc14c7a711b..7a5c9433fda3 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -483,6 +483,21 @@ int		   svc_generic_rpcbind_set(struct net *net,
 
 #define	RPC_MAX_ADDRBUFLEN	(63U)
 
+/**
+ * svc_rqst_page_release - release a page associated with an RPC transaction
+ * @rqstp: RPC transaction context
+ * @page: page to release
+ *
+ * Released pages are batched and freed together, reducing
+ * allocator pressure under heavy RPC workloads.
+ */
+static inline void svc_rqst_page_release(struct svc_rqst *rqstp,
+					 struct page *page)
+{
+	if (!folio_batch_add(&rqstp->rq_fbatch, page_folio(page)))
+		__folio_batch_release(&rqstp->rq_fbatch);
+}
+
 /*
  * When we want to reduce the size of the reserved space in the response
  * buffer, we need to take into account the size of any checksum data that
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index d8ccb8e4b5c2..3e57959c1779 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -955,11 +955,8 @@ bool svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
 		return false;
 	}
 
-	if (*rqstp->rq_next_page) {
-		if (!folio_batch_add(&rqstp->rq_fbatch,
-				page_folio(*rqstp->rq_next_page)))
-			__folio_batch_release(&rqstp->rq_fbatch);
-	}
+	if (*rqstp->rq_next_page)
+		svc_rqst_page_release(rqstp, *rqstp->rq_next_page);
 
 	get_page(page);
 	*(rqstp->rq_next_page++) = page;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index f28c6076f7e8..ce28af88e632 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -994,7 +994,7 @@ static size_t svc_tcp_restore_pages(struct svc_sock *svsk,
 	npages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	for (i = 0; i < npages; i++) {
 		if (rqstp->rq_pages[i] != NULL)
-			put_page(rqstp->rq_pages[i]);
+			svc_rqst_page_release(rqstp, rqstp->rq_pages[i]);
 		BUG_ON(svsk->sk_pages[i] == NULL);
 		rqstp->rq_pages[i] = svsk->sk_pages[i];
 		svsk->sk_pages[i] = NULL;
-- 
2.53.0


