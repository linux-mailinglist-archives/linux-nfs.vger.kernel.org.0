Return-Path: <linux-nfs+bounces-22224-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VS/mGB+8H2q9pAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22224-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 07:31:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21462634495
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 07:31:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=teRhLAjA;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22224-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22224-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F4DC304D4B8
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 05:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DCB37BE74;
	Wed,  3 Jun 2026 05:30:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D537CD53
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 05:30:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464646; cv=none; b=N1/QQcS3pR90ALzvUMznYTNlPKR52kPqKFUnr+b+zjARNf1IpHv4a3XaDkqjzFP35b5BvD7xfgTHra5BWu8GxcgvtUpyjg2bzbPHUgYcWm8A6pZDSDq9Glhi6wIzFvLJgu2rO5xhwarIezmOHk9A00VnJm81rrvFh/RIMDsZxWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464646; c=relaxed/simple;
	bh=xlRKe2tV08/PB0El33PK0KOegIfZJWy1WXcRZqpSlyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aRtwf5pbzuLC/pP1mvU0ZsG+1jlxIyqOXBsntZ1nQS1hqbVYJhYsqaXH0L2k9AMQJdJL4oijW+dsdzHZ+auE3HRSZ2DkYj3tY6ClDkg+d3MjYTcDKBtN/SDt2o6W4ft5jinIuGYPRhQN1pEFpEHCbnHsGccOuF8jpV8ocUgeTBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=teRhLAjA; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d98b828c8so5686979a91.2
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jun 2026 22:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780464643; x=1781069443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nehAld8TJlI8mrxna1q/NWiJX18b33YpMiePw0zAq0=;
        b=teRhLAjAKokOdx6KTZqvF8z3KoJgoEWcJTvY9nPgKQyDqiXhDbgN+UUF2Xo8Fx0hlS
         FSrUNp8NxIZCsWP1FytPiClIiRw5fAvY6DRoXj3d8wNJ/pxI7AMXhiYR4rq/Vr2Q1/dv
         hNL+PaDTauzDzRNppb4NCiH1MJB+w/mvNwqBb/xGaF+4aoPgYfZPWkYPVn/84GJPduL9
         7N/SNMY3t4PO0vPhtxR4clNQnR2fuM5hUkZ3vWzR+moMB3wmnDkjuEmp9Z/o+0gNErFN
         hoNXR8642DIAqvwJmT0/3qAdhmP8yYoVfGbD17g28QgUaBrG0DeN712VQCxwwnI96jgP
         dBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780464643; x=1781069443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nehAld8TJlI8mrxna1q/NWiJX18b33YpMiePw0zAq0=;
        b=dLeBOG5ppHITV1W2geMevimmsRjm54qGMQX2Xd+1LLoVgfye/YR+jjo955fjBlcaRw
         fc6d3AL/mWfUVMgRtYg/d1vEZUs3x4xO/BUBT4rckUM9yDeB3CN/qShYehdVx9BE6Clx
         QM9GC4fj03zs2/tGBjydgzOMdLTvp0wMcPDREltbh8fq7HNrWwLLychpObw04gpBRRBF
         2xYs8If5sIKHb6A8mNV4OU4VM1XWbXYNa8GUYV25dRKGvj3re/iDY7DhXaioMb+PzC7y
         I3KeVNqXUXXVBK/e2xBUsb6V19dOB77++8wxg2BqBEuaEK5gFiaCvrW2BLdWeFEYqHNK
         1bhQ==
X-Gm-Message-State: AOJu0YwSxSxX024+o4FXlSNvgq5c5xbiD7Fz2dhh7fSrUSZKzoAN/2Yo
	QSR6CuodD4Qt8B34cG1OTd6LwPTXIJ19GbV5lodovTxatxHuFnJNIt/QwJ/IQ6P6K37d5uwsdK3
	wDfWystMYmCVIRMo36Cfqvet8m/7o/7ETPh/QlseGkCehsBA/55nsstbJYCtwVO1x3TjS6k22fd
	4EG/7nrZMRcNi9eB9r/3BrQrQoNlBwcS2Vz4s=
X-Received: from pgal123.prod.google.com ([2002:a63:3e81:0:b0:c7c:4b52:febd])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7314:b0:3a8:21e0:1ffa
 with SMTP id adf61e73a8af0-3b49782cd85mr2233044637.27.1780464642818; Tue, 02
 Jun 2026 22:30:42 -0700 (PDT)
Date: Wed,  3 Jun 2026 05:30:29 +0000
In-Reply-To: <20260603053033.3300318-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603053033.3300318-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603053033.3300318-4-praan@google.com>
Subject: [PATCH v1 3/7] nfs: Introduce nfs_release_request_list helper
From: Pranjal Shrivastava <praan@google.com>
To: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Christoph Hellwig <hch@infradead.org>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22224-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,m:praan@google.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21462634495

Introduce a centralized helper, nfs_release_request_list, to handle
the bulk release of nfs_page requests from a list.

This serves as a preparatory step for two upcoming improvements:

   1. Pin-Aware Cleanup: As we migrate to iov_iter_extract_* API,
      requests will hold pins (GUP) instead of standard references. The
      helper ensures that the correct unpinning logic gets applied
      consistently across all requests in a list.

   2. Folio Support: In subsequent patches where nfs_page structures
      will cover multi-page folios, this helper provides a clean
      infrastructure to unlock these larger units of I/O in bulk during
      completion, similat to the pattern in bio_release_pages.

Additionally, refactor nfs_read_sync_pgio_error() to utilize this new
helper.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 fs/nfs/direct.c          |  8 +-------
 fs/nfs/pagelist.c        | 18 ++++++++++++++++++
 include/linux/nfs_page.h |  4 ++--
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 80319c5eeed4..2691eeaaeb8c 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -314,13 +314,7 @@ static void nfs_direct_read_completion(struct nfs_pgio_header *hdr)
 
 static void nfs_read_sync_pgio_error(struct list_head *head, int error)
 {
-	struct nfs_page *req;
-
-	while (!list_empty(head)) {
-		req = nfs_list_entry(head->next);
-		nfs_list_remove_request(req);
-		nfs_release_request(req);
-	}
+	nfs_release_request_list(head);
 }
 
 static void nfs_direct_pgio_init(struct nfs_pgio_header *hdr)
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index f59449918be7..74ae91151f83 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -620,6 +620,24 @@ void nfs_release_request(struct nfs_page *req)
 }
 EXPORT_SYMBOL_GPL(nfs_release_request);
 
+/*
+ * nfs_release_request_list - Release a list of NFS read/write requests
+ * @head: list of requests to release
+ *
+ * Removes each request from the list and drops it's refcount.
+ */
+void nfs_release_request_list(struct list_head *head)
+{
+	struct nfs_page *req;
+
+	while (!list_empty(head)) {
+		req = nfs_list_entry(head->next);
+		nfs_list_remove_request(req);
+		nfs_release_request(req);
+	}
+}
+EXPORT_SYMBOL_GPL(nfs_release_request_list);
+
 /*
  * nfs_generic_pg_test - determine if requests can be coalesced
  * @desc: pointer to descriptor
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 295280fe9571..14eb5de64d2f 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -135,8 +135,8 @@ extern struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context *ctx,
 						   bool pinned,
 						   unsigned int offset,
 						   unsigned int count);
-extern	void nfs_release_request(struct nfs_page *);
-
+extern void nfs_release_request(struct nfs_page *req);
+extern void nfs_release_request_list(struct list_head *head);
 
 extern	void nfs_pageio_init(struct nfs_pageio_descriptor *desc,
 			     struct inode *inode,
-- 
2.54.0.1013.g208068f2d8-goog


