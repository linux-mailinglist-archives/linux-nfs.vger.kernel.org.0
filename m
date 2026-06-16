Return-Path: <linux-nfs+bounces-22634-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 28W/OmhTMWphgwUAu9opvQ
	(envelope-from <linux-nfs+bounces-22634-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 15:45:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C11D6900EE
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 15:45:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=HWhxNwMG;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22634-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22634-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36B95323B41B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC883322A1C;
	Tue, 16 Jun 2026 13:40:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C332D0FC
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 13:40:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617213; cv=none; b=IrkLJvrECE2/QoEacpk5nnnIVbwxPmoHnC404QIjW1H/ahq65SGotjJJi4i38jz33BiofJXngrhjW9HIjAZWnE3F5kW0XHRJl8inJChosepXEYEgtk6rZqAod2FXD/8aHkwP9j/j9i0BzaYHCyxdwyu3N9Wkxa/u1oiGsDIyRoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617213; c=relaxed/simple;
	bh=9zc+askoL1ATgiLD8YSTiK2AN5nek4qQ+NVERdoXP08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T8/wW0rPMMynSX3mgYi43i1YMJMAAsodXBS5bYnG4LgzVxFMubr97+mrMrTPTDjgUzGNyHjAw0ADY2U5Waz3w66tz75uZdmiRLCaptpXLLohHM7wIPwUkGkpbLO06gGVd3bkaCMdvzUm1f980+OpygBFW1PxvgPnTkIepsHkb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HWhxNwMG; arc=none smtp.client-ip=209.85.215.202
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a298cd62so3157057a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781617210; x=1782222010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xMHrFftLaHtT96ybBlaZZgXQIL+oQ5YQ4pNzx3a56ME=;
        b=HWhxNwMGoIVxogZ3xsmj56MwAPhSHOnL1myx3MqZrJ/RAWW4XFdmfPbVfgNhhE9Xo3
         zpPoeoxo+v0e5CxUHuMeJUjaCsktO2HZcsliO5rTPXn21tYshircRSq9NK1WR1i5iwgd
         Abu0uZuvhuPmbeDypT4aH0wosEQdvbSfXRfq8AiOtFlmVRn2As+hoax9KDYunErxw4bQ
         otghVy268Uhnom3yBstktFk52zsFmWVABAAoa74T4tptf7tujqUMgFIu5ksYrqpqglCR
         jHzsqsgQt1HU9HmxwglaexVK4PDRiNT+mZU1B64nmaSpgwtvcJwneLEPMRJ3pQ7Kw/IS
         D/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617210; x=1782222010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMHrFftLaHtT96ybBlaZZgXQIL+oQ5YQ4pNzx3a56ME=;
        b=TfIXJkVg7IEK9Ej3oEJAkf1ncT2kyAqfoLHhy2lpmBXNwHsXYEuqI9fNP7k4Gx7rBI
         Hx5VRE0q3e5z4CEse8D56/jI7te8T3XxDrfmUkJc1Vp+higXD1NXDdsyvXhcLSPWFn7d
         VB8bZLLvKD2CDojy0VYxxNohfuGk4VXKdUZfvHZMUKJMk30ChkCfBr/U8N/FOyl+BQD7
         J2PHYsuH4SU9ZRx1Yajlt5vJ5BBc6F8I7WbCGAiv1VRinI7RIgP9AdWQJYvxua3dW3jG
         isStjNjt2PfrHS4q0+iGn7I5q+FybcDJlJLtY0mk6Yeod95qkeqihpQRV2ECXVT5SHr9
         VD1A==
X-Gm-Message-State: AOJu0Yx9u61OwJHG18f3oGeoUdmsqIxj+UIoGZJaj6tbKZQnaE2VI9bM
	0VrUPb9kfYZEZvmXF/xTh/2vdkvn21omaq30ncnbyZu+qxSkjQ4ImzOmr5k6i46Yzby8fNxwLER
	zpONjJWJfFN0Te47jYz4+adDDxTUzhMYjqWUO+WscmwqDmT1rh2wPRO9oXnW9+6kpSK2h6CYabM
	BbpUIm2q7hwi1EBJof6XtzZYGUji8q9Emx8BU=
X-Received: from pgab185.prod.google.com ([2002:a63:34c2:0:b0:c73:7b68:90d9])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4d8e:b0:3b3:223f:d3f1
 with SMTP id adf61e73a8af0-3b7962bb2e0mr18445875637.18.1781617209493; Tue, 16
 Jun 2026 06:40:09 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:39:56 +0000
In-Reply-To: <20260616134000.2733403-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616134000.2733403-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616134000.2733403-4-praan@google.com>
Subject: [PATCH v2 3/7] nfs: Introduce nfs_release_request_list helper
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22634-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,m:praan@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C11D6900EE

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
2.54.0.1136.gdb2ca164c4-goog


