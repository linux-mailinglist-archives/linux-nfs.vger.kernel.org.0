Return-Path: <linux-nfs+bounces-22228-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qHdcGbK8H2rjpAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22228-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 07:33:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D70EA6344C9
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 07:33:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=cNwqxutk;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22228-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22228-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16BCB30FE7A9
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 05:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1D537CD50;
	Wed,  3 Jun 2026 05:30:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D737CD2C
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 05:30:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464653; cv=none; b=Aqf6+piE1D8ibj7oCATu/x7RWulagj3EXf5E4+ZET+ywr0wwz/yQCF+XGfmTLSIsuX22dj4vNhtsbu6ridG9SyWmSGjYVc6xh6kwJIQQkmgyWQ3LqYUrfYlC7L0kvvRcWGWSshBD0vFevJrriAEeSjyQf4aIfadOag/gBvlGVdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464653; c=relaxed/simple;
	bh=tot9ZqSWBGLET6Y1NhxRj5tdJGhWtAUdv0XhxLmkMKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ud1t8h9Kn3Zv+m/371C+pvbPfp6eDa5ydDWeo9gYhtDwuKCtLf5YM1ZtOoxT+wUx93FO7sInirLKZWuOgocbpdQW7VgcylniOukf3tNdOrmXjCNMCrXgJCq/fJaUv4AXgrkCg3UR3gIXPruYZ43QUxTejm6QGduL1Qk/OcCS240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cNwqxutk; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422875c676so277807b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jun 2026 22:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780464652; x=1781069452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=niRreLs/kA/7tR4N81wD/w0wwhdK/GuCLzmPNYHZL+U=;
        b=cNwqxutkmTXrsPbQoKtE0mwhwwvhQtvk8BysYQrhXUr3zJIHhvKUpnsjjeLCaMhr6F
         Yr46dEg72uE4Lg/c0IlABWCgHgbADJhj4MK4oFXC2CTaB5Nbt59ip2nIBIhB13FNIWY6
         j/7eriti9ivIl68jJ6WkHEkfQ7tBsDhOnha/BOsCqIW6ja+Dv/m6QEkceUgN/MxpNr+b
         1FQePH/fCoAR6LaZ06b2VaATpTXGaoltv9DSRRAqffLaE1cgIeBucydm0s0B0gtx8eZ7
         OwzGOJrRNaHdsTixfqzSDPwn6ikEcpcW7oOlb2Zn3MMnNuq6705SEuoDO/PgPQAd7o2d
         X/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780464652; x=1781069452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niRreLs/kA/7tR4N81wD/w0wwhdK/GuCLzmPNYHZL+U=;
        b=YlQrMUnz8emWv/AuY/oZYPMN2ASGyiybStO1I/jjySZ2nGZu+hK2VZs+fKLXz1PS1j
         4cFss7ypp29LsagX5VdXUA7trxN4a6x9dtS7PpixrIa4mNlG0p/S/AXF/Ca8BXQxh/oR
         Ov/Q0pT/H8UQthU0aDtdOGlddHPKOzqx8GePuMaepo9qWQ8zqdX4Y9BoJPb/xsGMGJmX
         g7z2Yy3UiWvgrtU2rIAh3zYzkUYJhaBg/8D4umLfr5ceSTpmneyU5Aequ0UeGONiAfdN
         AapR7mfYpZoIKtzRUt7BTQLAYP//tZQ5ixv3owgPqNOw3YHHXd1svXcpwGLoE6w51+4R
         LTNg==
X-Gm-Message-State: AOJu0YyHmIauIjhW8qS5afHad4erlKU13V8orKOhBJRoxFs1oPBSWDgI
	bqwEfCNIn0Y32JVtTvAoau1FqxA6TGW2B9O8Ks6qcyfAx9RekMm+7G0RQEIakb8P370NtZOl769
	HpA3igGbW6MKEJZ4BDOJFReMiRALzQfmsxBf6vBk8RD8xUqj6h5JSFMcVcWMyqhBjuxjUcKw8us
	2gnPvhZHTMLkPuftKFra/bC/PnkS7ThgpR+qI=
X-Received: from pfbfx13.prod.google.com ([2002:a05:6a00:820d:b0:82c:90c5:5e0d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:438c:b0:842:614b:50dc
 with SMTP id d2e1a72fcca58-842859e0fb5mr1398765b3a.13.1780464651185; Tue, 02
 Jun 2026 22:30:51 -0700 (PDT)
Date: Wed,  3 Jun 2026 05:30:33 +0000
In-Reply-To: <20260603053033.3300318-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603053033.3300318-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603053033.3300318-8-praan@google.com>
Subject: [PATCH v1 7/7] nfs: Cleanup the nfs_page_create_from_page helper
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22228-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,m:praan@google.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: D70EA6344C9

Remove the nfs_page_create_from_page() helper and its public export.
Following the migration of the Direct I/O path to folios, this
function no longer has any callers in the NFS client.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 fs/nfs/pagelist.c        | 35 -----------------------------------
 include/linux/nfs_page.h |  6 ------
 2 files changed, 41 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 74ae91151f83..be8e4ef998ac 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -427,41 +427,6 @@ static void nfs_page_assign_page(struct nfs_page *req, struct page *page, bool p
 	}
 }
 
-/**
- * nfs_page_create_from_page - Create an NFS read/write request.
- * @ctx: open context to use
- * @page: page to write
- * @pgbase: starting offset within the page for the write
- * @offset: file offset for the write
- * @count: number of bytes to read/write
- *
- * The page must be locked by the caller. This makes sure we never
- * create two different requests for the same page.
- * User should ensure it is safe to sleep in this function.
- */
-struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
-					   struct page *page,
-					   bool pinned,
-					   unsigned int pgbase, loff_t offset,
-					   unsigned int count)
-{
-	struct nfs_lock_context *l_ctx = nfs_get_lock_context(ctx);
-	struct nfs_page *ret;
-
-	if (IS_ERR(l_ctx))
-		return ERR_CAST(l_ctx);
-	ret = nfs_page_create(l_ctx, pgbase, offset >> PAGE_SHIFT,
-			      offset_in_page(offset), count);
-	if (!IS_ERR(ret)) {
-		nfs_page_assign_page(ret, page, pinned);
-		if (pinned)
-			ret->wb_nr_pinned = 1;
-		nfs_page_group_init(ret, NULL);
-	}
-	nfs_put_lock_context(l_ctx);
-	return ret;
-}
-
 /**
  * nfs_page_create_from_folio - Create an NFS read/write request.
  * @ctx: open context to use
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 14eb5de64d2f..2a3e066cbeb9 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -124,12 +124,6 @@ struct nfs_pageio_descriptor {
 /* arbitrarily selected limit to number of mirrors */
 #define NFS_PAGEIO_DESCRIPTOR_MIRROR_MAX 16
 
-extern struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
-						  struct page *page,
-						  bool pinned,
-						  unsigned int pgbase,
-						  loff_t offset,
-						  unsigned int count);
 extern struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context *ctx,
 						   struct folio *folio,
 						   bool pinned,
-- 
2.54.0.1013.g208068f2d8-goog


