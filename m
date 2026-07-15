Return-Path: <linux-nfs+bounces-23326-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uMHGFxyfV2oxYAAAu9opvQ
	(envelope-from <linux-nfs+bounces-23326-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 16:54:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A0F75F9F4
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 16:54:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Iez82V+J;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23326-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23326-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F1FC3180279
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08343A2E33;
	Wed, 15 Jul 2026 14:35:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9839EF19
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2026 14:35:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126151; cv=none; b=mntAuprEwpjF1PTaMzDBTsSE4rUtlveVk0ykX89w+xqtbSRgv83jLOHAEGRL35zNRbTyAs8ujB0qN9xy49K4SqhfNmV71f6p3qZPbBY9ggI2WN3ZaPkCeUYdkXVbdHqZ6uvNcbwc0ACMHvO86ZTGsOIh/OiidA8icMZcmLzsSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126151; c=relaxed/simple;
	bh=EiK/0BOy13dfaHv1/1gIcOGTD4TXhwUWjevKgoWSbpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YqsfEqSjwI5CxBoAW3lBxnMxQohrl699TrC9tSfEjZn0eju1IZJiIdQ3by689/Zu7OoAYEBj2joBaRLYLH2xkm4Bvxe3/qkSZ2H0YdjPokIEAH6GY3QkqFIzjjSShnI01F2CKlGBz5DHaTzbLoPAc/DWd57RNQdKru2rQe8Fusw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iez82V+J; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-caf5fa127d4so3433088a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2026 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784126149; x=1784730949; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XhqenuXfmVALy/78xc7WpS0H1qGGlp44q39c/xt3Pa0=;
        b=Iez82V+JVk+cW8uDA+ieAFq8j4OksRZ497y5JrIKfNiC4zUovZqYufZMwZQVUTR50a
         1yaIzbSXVufX+FnhiBL9q9ATNKM/KRKvIN7pG82B9ZStBs2Pzgq8KMXhw2WOwEUsERZN
         5GC5WwCpHZtxsvFDjmP40aAtGl7BJKKzxH0YkqSR5FFXm6LJXnSZHBY6CMk/tlWIf2DF
         G5GIFkIJwKNPJFm3DjO5skIlnK1X2Ta3V5eOgUHOYaVl/o4Cro1czt6HCUD1ZhPHQCoz
         TmaVQQo7lizjTDls9Kd+4/JNxUJ8Sd66UHoMGAGBzt9GLWEWOUa0/8aPirmV8YdQjvuA
         1gGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784126149; x=1784730949;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XhqenuXfmVALy/78xc7WpS0H1qGGlp44q39c/xt3Pa0=;
        b=aQZ+8n1PSi0CZNfw+kDmSNY+qthD9p8yY2GOeyTvzYjRrzZO8BzVpY6NiHatuDpzx/
         Avjrgz4Eo/eYIWDkEaDVgmL7nQoi5rmpHlfuvHorsl3UWBlLGoBNhWjiOm41e+yzfTbu
         waf3BsWj7CHLtXHx4XLeP3WhIyH/MX29ctVCN+bVpr/afkLgi0xxpwGDCTqDtRkyW5LZ
         N0rK2b79AF1x7yr3inkz/yJOd/I7dbiQPGjWUlFEtamykVivm5j33+IZURYxW83l5IA+
         /PjhQO5aLpEsdjAlID79Eyt7lOlA5EzGu1cZ24KGFc+PNXqgmVnLn+/pxzx4GDdoXMOz
         ka4g==
X-Forwarded-Encrypted: i=1; AHgh+Ro/z4kQCDJMcaSkcCojtd55RcZ/6ZZb2hGTsnToJePh+uTroSu7xhvbOaJfkYUFOEBN+WbHe2bsJoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQWaEMg0lAjhS9bdvPu+sNwtJxjY9aSpvsgnLVXo8XM2TUNX6A
	tnAbq6qgxrMVIv++59KGN103hpyhGst0EYxx+kvb2mmq7IK6kLYIXYOSpLUCplysd73I9W262ks
	OpA==
X-Received: from pjqq12.prod.google.com ([2002:a17:90b:584c:b0:381:71cf:62c])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c89:b0:387:e0db:3fb2
 with SMTP id 98e67ed59e1d1-38dc779ac27mr16439182a91.43.1784126149280; Wed, 15
 Jul 2026 07:35:49 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:35:38 +0000
In-Reply-To: <20260715143540.3597616-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715143540.3597616-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260715143540.3597616-4-praan@google.com>
Subject: [PATCH v3 3/5] nfs: Introduce nfs_release_request_list helper
From: Pranjal Shrivastava <praan@google.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,m:jlayton@kernel.org,m:linux-kernel@vger.kernel.org,m:hch@lst.de,m:logang@deltatee.com,m:jgg@ziepe.ca,m:linux-pci@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:shivajikant@google.com,m:praan@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23326-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4A0F75F9F4
X-Rspamd-Action: no action

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
index 19792a38c924..96995736fac2 100644
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
index 7d51e10fe97a..569bac4faff7 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -622,6 +622,24 @@ void nfs_release_request(struct nfs_page *req)
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
index 080fa3e23580..d23208ed3a33 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -136,8 +136,8 @@ extern struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context *ctx,
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
2.55.0.229.g6434b31f56-goog


