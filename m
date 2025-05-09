Return-Path: <linux-nfs+bounces-11632-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2805AB1D04
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2228189C2F7
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBE224466C;
	Fri,  9 May 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyJvC6oU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF8244665;
	Fri,  9 May 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817445; cv=none; b=pZ1Uik7qdnN4bnAttkBo077MxplqBLxjcrYtrXnsUD5s+FHebfqeE87M6Kz6mAN/HBN4/eOsJiKiQYKBNksnJ8lRwDkXTkn8NcM1OvmdXjOt4/297kf2fMouGtAr8piNM4i00p5jFp9kT9h8xzh2xahVWEMWVvfQ28qms6+AXwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817445; c=relaxed/simple;
	bh=JgZeGSv0c4pzpGEbwYPu464tC/Pkf4OLN+rQfjgF+Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWCWes4pwUw/YxzrADQfCDZ9vIqQFvdVzHj+wBMLPfJW9KcO7SluMymR/+edjAzarB9jnjAtpFBfoapZ4+BkP9NyJS6eZ13xTz7bKGkQmB8Qmkwyx3k93BS9UGihPqsgiFffx+AWo9XNYdIe0LgkfdNY6QZemZLdAyttfRME8HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyJvC6oU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A103DC4CEEF;
	Fri,  9 May 2025 19:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817445;
	bh=JgZeGSv0c4pzpGEbwYPu464tC/Pkf4OLN+rQfjgF+Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WyJvC6oUn26KPuvXBrcC8qfk3cFBpKXrW0hQR5BVpO51yUM0NNqWL49VgBJtZo6hd
	 tldqYo+r1XL1CpdhTPJTZiUOMGTtFTE41yd0nSaZnwK8nc2EN6u7ZrY87Kh2H+xmQM
	 U0CN7Y1+D8UO4PuAxPKTElOYKc78UImqDcZ8Y0FyLRmjDyVA4sdrTd6yFUzGdUiStS
	 kLCr3S90InGKxpiNWDYTB8eMbuQ7YZi39ndnjtAilIac26QWJumwFl2a3lmYGDxmHw
	 KwE44R/rj78a/5iunhFKyiyv65mUFw6UNPl8D9XfLUo3gvTuqJnnwD/zmm/ZGq+wcY
	 /wHwIy5veMerQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 10/19] SUNRPC: Remove svc_fill_write_vector()
Date: Fri,  9 May 2025 15:03:44 -0400
Message-ID: <20250509190354.5393-11-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up: This API is no longer used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |  2 --
 net/sunrpc/svc.c           | 40 --------------------------------------
 2 files changed, 42 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index dec636345ee2..510ee1927977 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -470,8 +470,6 @@ const char *	   svc_proc_name(const struct svc_rqst *rqstp);
 int		   svc_encode_result_payload(struct svc_rqst *rqstp,
 					     unsigned int offset,
 					     unsigned int length);
-unsigned int	   svc_fill_write_vector(struct svc_rqst *rqstp,
-					 const struct xdr_buf *payload);
 char		  *svc_fill_symlink_pathname(struct svc_rqst *rqstp,
 					     struct kvec *first, void *p,
 					     size_t total);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index a8861a80bc04..939b6239df8a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1719,46 +1719,6 @@ int svc_encode_result_payload(struct svc_rqst *rqstp, unsigned int offset,
 }
 EXPORT_SYMBOL_GPL(svc_encode_result_payload);
 
-/**
- * svc_fill_write_vector - Construct data argument for VFS write call
- * @rqstp: svc_rqst to operate on
- * @payload: xdr_buf containing only the write data payload
- *
- * Fills in rqstp::rq_vec, and returns the number of elements.
- */
-unsigned int svc_fill_write_vector(struct svc_rqst *rqstp,
-				   const struct xdr_buf *payload)
-{
-	const struct kvec *first = payload->head;
-	struct page **pages = payload->pages;
-	struct kvec *vec = rqstp->rq_vec;
-	size_t total = payload->len;
-	unsigned int i;
-
-	/* Some types of transport can present the write payload
-	 * entirely in rq_arg.pages. In this case, @first is empty.
-	 */
-	i = 0;
-	if (first->iov_len) {
-		vec[i].iov_base = first->iov_base;
-		vec[i].iov_len = min_t(size_t, total, first->iov_len);
-		total -= vec[i].iov_len;
-		++i;
-	}
-
-	while (total) {
-		vec[i].iov_base = page_address(*pages);
-		vec[i].iov_len = min_t(size_t, total, PAGE_SIZE);
-		total -= vec[i].iov_len;
-		++i;
-		++pages;
-	}
-
-	WARN_ON_ONCE(i > ARRAY_SIZE(rqstp->rq_vec));
-	return i;
-}
-EXPORT_SYMBOL_GPL(svc_fill_write_vector);
-
 /**
  * svc_fill_symlink_pathname - Construct pathname argument for VFS symlink call
  * @rqstp: svc_rqst to operate on
-- 
2.49.0


