Return-Path: <linux-nfs+bounces-14393-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B05B55836
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 23:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2953B80AB
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 21:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D38232F77D;
	Fri, 12 Sep 2025 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlMJo9ld"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997832F75F
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711653; cv=none; b=laUOjnsNltCWC03EjMdp9aqOuAfxQYHVWu9AWmLExLMI6vHWTAvD55mLyewGdqr2ogLVZ1qqj9cUWIhEDDeNJWqcbstMuTyvMVzrCNQt1SfX0E9nOwCrBfxApoCGvTXOGZfJJQRsvg3d3EdN2HG0WmKfSbQ0v324dpAnIMBiqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711653; c=relaxed/simple;
	bh=9j1xF3KG0DbvtxGm8bKVzmDWJHOyo8ijF90M0l7Ek9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNHQe/M90OKq18WriIIGaRR5mosNrptnqR4AENpCPYO4rVCB++sbr4iVUUO9uUEmYXkVPkBBLdR3kuvzsURv20xl2ZL8gD1d5JocZUdMEmXqsV9riGtG8DwtBSYujR6b4csWzxP0IDf19fkZmYb/xs/2JYsNXCZXAyKD4reqSy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlMJo9ld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80800C4CEF1;
	Fri, 12 Sep 2025 21:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757711652;
	bh=9j1xF3KG0DbvtxGm8bKVzmDWJHOyo8ijF90M0l7Ek9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UlMJo9ld7jVKGE7/QgPB4JrM/dP6tcW6z6a9h9Zbie/9BuMi9viFphtktpWKP8FEQ
	 SeOe/NHFciLaJ4DYsMNPXUg0SJH811lSYtXe1Z/U2MUjBUZHmz4wBm3OYW+rAQ9FCg
	 5GZgo3rtKhmKNYQ7Wn0IYARVra658l4L1tTVW918OwtN3bFyinQebxLpY/BHgzrkl3
	 0/O8DbjHaOAPXkvxWBNqPyUh5MXBBQ4NVNnsFZgZdbq2Gjd7RI+/VuDO5Tf0BskH69
	 1kBcmyQ/6dyT9jb13XQQOegfvY/AZohLCP6DnTzDKBVYLj0B9hYXmZGCyMR3xdmwyE
	 p+uuW5GzsYbqA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 1/9] SUNRPC: Introduce xdr_set_scratch_folio()
Date: Fri, 12 Sep 2025 17:14:02 -0400
Message-ID: <20250912211410.837006-3-anna@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912211410.837006-1-anna@kernel.org>
References: <20250912211410.837006-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

This will replace xdr_set_scratch_page() when we switch pages to folios.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 include/linux/sunrpc/xdr.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 8a9ec617cf66..3ce17321689a 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -300,6 +300,19 @@ xdr_set_scratch_page(struct xdr_stream *xdr, struct page *page)
 	xdr_set_scratch_buffer(xdr, page_address(page), PAGE_SIZE);
 }
 
+/**
+ * xdr_set_scratch_folio - Attach a scratch buffer for decoding data
+ * @xdr: pointer to xdr_stream struct
+ * @page: an anonymous folio
+ *
+ * See xdr_set_scratch_buffer().
+ */
+static inline void
+xdr_set_scratch_folio(struct xdr_stream *xdr, struct folio *folio)
+{
+	xdr_set_scratch_buffer(xdr, folio_address(folio), folio_size(folio));
+}
+
 /**
  * xdr_reset_scratch_buffer - Clear scratch buffer information
  * @xdr: pointer to xdr_stream struct
-- 
2.51.0


