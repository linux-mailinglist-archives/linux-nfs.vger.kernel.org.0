Return-Path: <linux-nfs+bounces-11607-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74539AB018A
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 19:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC82D4C6D8A
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323EB1AAA1C;
	Thu,  8 May 2025 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxbB6/Iv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B928153C
	for <linux-nfs@vger.kernel.org>; Thu,  8 May 2025 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725867; cv=none; b=ajL+Ldp83OnXbCVXI8KEciapKfXvrm1bNJxQm4OhfNuqkI4BWqDFTskRhybpp4mbzlowjooYgL2JN5fk9PvNyVBj4drSLuUC2IEd1a7EBH8U4cH8AyUlofhj1czg63xa+nrFzgdG6cJUdbYO93IVtqe1J5vXqlNkUo7lB+bDksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725867; c=relaxed/simple;
	bh=1LrHCnvjrVwOY8fPciSNHg2pcSP2e5AZbG7sV6Om58g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUAbJ8nPuQszEZWYMeEKiASUyxMXTqY2bExTf1dlXAQA7H7MKPpgt4caVREkXgWHOHfOq42fURdLgii0pcVsnNd8zLig1K5C3FJW7gsWBn98NC45zFgHaFhBcEqQYbXWDnKIeLUWnm2YqXwBym5nwtgKo4rIafqOvbMS8FHWptY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxbB6/Iv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE2EC4CEEB;
	Thu,  8 May 2025 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746725866;
	bh=1LrHCnvjrVwOY8fPciSNHg2pcSP2e5AZbG7sV6Om58g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZxbB6/Ivlsjpdrz7mg6EILm7o2s7P4y8dVf8DwaVRepeL6LbXZ6huW6ufMbmr6LRA
	 LfuYx2EaBepPVt9NMtGcghE3frMhdbpArLD8BY+90s8QfSQ7sFGYl0SFiO7dWdiW1T
	 EJ2hVrpsYvGjl9oEaXw5mX8K25qxpNjP7Cd8j6JVqAJXJwXGblrFXFY0QAzLLrqWtu
	 HaxjpH0w+HoMudxuxaDNILcCmoAeAnXhbHZGKPTIHGkprZh4QQYhneaFfVn5G6iatN
	 zQnaueDYgwiyZFp6+G0a6/xTyVzy2nZc6pKvn3a6Z8LX4jqdXnTj5FYYtmOPzQWdbh
	 nqI0gwE4HRC9w==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 5/6] SUNRPC: Remove svc_fill_write_vector()
Date: Thu,  8 May 2025 13:37:39 -0400
Message-ID: <20250508173740.5475-6-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508173740.5475-1-cel@kernel.org>
References: <20250508173740.5475-1-cel@kernel.org>
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
 net/sunrpc/svc.c           | 43 --------------------------------------
 2 files changed, 45 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 088c162ae7d6..a1b48ad1d464 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -463,8 +463,6 @@ const char *	   svc_proc_name(const struct svc_rqst *rqstp);
 int		   svc_encode_result_payload(struct svc_rqst *rqstp,
 					     unsigned int offset,
 					     unsigned int length);
-unsigned int	   svc_fill_write_vector(struct svc_rqst *rqstp,
-					 struct xdr_buf *payload);
 char		  *svc_fill_symlink_pathname(struct svc_rqst *rqstp,
 					     struct kvec *first, void *p,
 					     size_t total);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index d113f44798a1..c086f46265f6 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1725,49 +1725,6 @@ int svc_encode_result_payload(struct svc_rqst *rqstp, unsigned int offset,
 }
 EXPORT_SYMBOL_GPL(svc_encode_result_payload);
 
-/**
- * svc_fill_write_vector - Construct data argument for VFS write call
- * @rqstp: RPC execution context
- * @payload: xdr_buf containing only the write data payload
- *
- * Fills in @rqstp->rq_bvec, and returns the number of elements it
- * populated in that array.
- */
-unsigned int svc_fill_write_vector(struct svc_rqst *rqstp,
-				   struct xdr_buf *payload)
-{
-	struct page **pages = payload->pages;
-	struct bio_vec *vec = rqstp->rq_bvec;
-	struct kvec *first = payload->head;
-	size_t total = payload->len;
-	unsigned int base, len, i;
-
-	/* Some types of transport can present the write payload
-	 * entirely in rq_arg.pages. In this case, @first is empty.
-	 */
-	i = 0;
-	if (first->iov_len) {
-		len = min_t(size_t, total, first->iov_len);
-		bvec_set_virt(&vec[i], first->iov_base, len);
-		total -= len;
-		++i;
-	}
-
-	base = payload->page_base;
-	while (total) {
-		len = min_t(size_t, total, PAGE_SIZE);
-		bvec_set_page(&vec[i], *pages, len, base);
-		total -= len;
-		base = 0;
-		++i;
-		++pages;
-	}
-
-	WARN_ON_ONCE(i > rqstp->rq_maxpages);
-	return i;
-}
-EXPORT_SYMBOL_GPL(svc_fill_write_vector);
-
 /**
  * svc_fill_symlink_pathname - Construct pathname argument for VFS symlink call
  * @rqstp: svc_rqst to operate on
-- 
2.49.0


