Return-Path: <linux-nfs+bounces-14401-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B207CB5583E
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 23:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1580B1C25910
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 21:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259E1338F29;
	Fri, 12 Sep 2025 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDJ9wXM7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ABB3376BC
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711657; cv=none; b=mNAZZKcBZ/10MdW6zzoAVKKcdZGftMiLG61VNsoki2MQ61WswZ4UA/DKZRAGuZKkLQp31XaqOumW2X5dXTRe91CbAE5Mnccz7wzOMfuN32niuUczkpQQh4aHLOVfcgoG4nb1t2JiYGtyJW5QhK/xlerjXVBPrmMGxQlwO4PYeqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711657; c=relaxed/simple;
	bh=2KW6lK8Ayn+RVIasvBLugWwoynkkVHE3Xe2C3EJ7tTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4vuCVR1B4LvtvbU+zMK7uIeSmPbvNroM72xzJRUdut5r1ShqIu8YI/cXW3WKEgT8Z+4K/6xqHUNcTXugrVUt29OZ7kmydJ4pMrVaM4r9XiH1MreDUdx0bNmU0LjCNEyVKUzQNkCCLtzQv0XMFlYfFyKgRqmJ90VXoYj6ybrUzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDJ9wXM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F3EC4CEFA;
	Fri, 12 Sep 2025 21:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757711656;
	bh=2KW6lK8Ayn+RVIasvBLugWwoynkkVHE3Xe2C3EJ7tTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dDJ9wXM7binrNUQsomFEsOqYmvThUdQZ/OU2JwR0wCAOlBtZIQ5/bJmenV4ME16kA
	 za/2J9p6+ntWB+O+fVN/b6X3lWdBs3VGaVMzlqP0Yp+gok4v6rkBPDnjCKpIhcJ39c
	 6m5mivquYvtXP3uOopTMdKXdasgaBESYvLWlb9Z20BzmwcEZNytxP/ZQAanMRwRA9w
	 jzDybC2M9iqCIawZSzOuMGrtf3iGEoAPa9uEYV074DfzV5cIrWFTp2SnmFKkZCam5j
	 if+ABtT30rdzN/ACUSxsCb/IC9Dkkpm9Cj1bR8GFoTtWyzbGclm4cgo/vrcjk2a9dm
	 W5NPMptRvw3Sw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 9/9] SUNRPC: Update gssx_accept_sec_context() to use xdr_set_scratch_folio()
Date: Fri, 12 Sep 2025 17:14:10 -0400
Message-ID: <20250912211410.837006-11-anna@kernel.org>
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

This was the last caller of xdr_set_scratch_page(), so I remove this
function while I'm at it.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 include/linux/sunrpc/xdr.h        | 13 -------------
 net/sunrpc/auth_gss/gss_rpc_xdr.c |  8 ++++----
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 3ce17321689a..49278749ad0c 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -287,19 +287,6 @@ xdr_set_scratch_buffer(struct xdr_stream *xdr, void *buf, size_t buflen)
 	xdr->scratch.iov_len = buflen;
 }
 
-/**
- * xdr_set_scratch_page - Attach a scratch buffer for decoding data
- * @xdr: pointer to xdr_stream struct
- * @page: an anonymous page
- *
- * See xdr_set_scratch_buffer().
- */
-static inline void
-xdr_set_scratch_page(struct xdr_stream *xdr, struct page *page)
-{
-	xdr_set_scratch_buffer(xdr, page_address(page), PAGE_SIZE);
-}
-
 /**
  * xdr_set_scratch_folio - Attach a scratch buffer for decoding data
  * @xdr: pointer to xdr_stream struct
diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
index cb32ab9a8395..7d2cdc2bd374 100644
--- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
+++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
@@ -794,12 +794,12 @@ int gssx_dec_accept_sec_context(struct rpc_rqst *rqstp,
 	struct gssx_res_accept_sec_context *res = data;
 	u32 value_follows;
 	int err;
-	struct page *scratch;
+	struct folio *scratch;
 
-	scratch = alloc_page(GFP_KERNEL);
+	scratch = folio_alloc(GFP_KERNEL, 0);
 	if (!scratch)
 		return -ENOMEM;
-	xdr_set_scratch_page(xdr, scratch);
+	xdr_set_scratch_folio(xdr, scratch);
 
 	/* res->status */
 	err = gssx_dec_status(xdr, &res->status);
@@ -844,6 +844,6 @@ int gssx_dec_accept_sec_context(struct rpc_rqst *rqstp,
 	err = gssx_dec_option_array(xdr, &res->options);
 
 out_free:
-	__free_page(scratch);
+	folio_put(scratch);
 	return err;
 }
-- 
2.51.0


