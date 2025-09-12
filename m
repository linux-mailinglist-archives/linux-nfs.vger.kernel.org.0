Return-Path: <linux-nfs+bounces-14394-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BC2B55834
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 23:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28AC81C25853
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 21:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB7D334720;
	Fri, 12 Sep 2025 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjmLpR0a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF4334711
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711653; cv=none; b=WxnwhzKuelB3a2D+Oz+Si/kq+txd718VngdQlLlSH+h8RCNtZcNL19oYx60SZ2qGAK1iIgwiEYGSMpBrYWHmNLfL/vNsrhfqFpdte2sZtWnlGX7Ev4cFn5gvcf23cgymcEgTU+vrtB1TwidjTSvMICrBViFAXJ4q7khhkic2UVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711653; c=relaxed/simple;
	bh=r/HsL+EPyqmWo9qnquhZGhbkH5JxiKy+BAMVXQ5S6yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxHH2LqxbIQ39yPvmyS10kvjOmHcETt8rDD1oOwvxFnucEFxu+XaGmznaRC9B75y2XbhftSFq8Qv8ScceI40+vn/dIo/d3VuD+INpw1UnPrbeU1oyWloujMjuoPpB1spiMei/0biwBrVDn6FMbJYYOKNziFoCKUUHLoJ8veXgNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjmLpR0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AEFC4CEF8;
	Fri, 12 Sep 2025 21:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757711653;
	bh=r/HsL+EPyqmWo9qnquhZGhbkH5JxiKy+BAMVXQ5S6yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fjmLpR0a6r6yLGTj2rL3sSOaABIwCOlFvNMe95TwmTWEgQ+7iz/WhiUcLDEam73CS
	 uvfFBLPfBArK4b6IKBeKTm+x4e6GU/gaFYU4jGY5WsvOhABYWNzlxVI9OMk8LMtGak
	 F4ovTTSnlAqvzWpyJ1HM35YoUUhtErnoPToslyJ0meHrKxBI2w9guPhmy4br65k1IV
	 oTWtcmB3pJK45tP0Fo9XZMhpD1sUL+LXmoGOI8xcc3QnQOGiYj6ptnbgbO+8sczPFG
	 iJ+TlcNZFNjXBrNi9X4A2LPa39l8+di0j3MGvoIBQXQ6lhbWl+ffV+vRAtFYoU3f10
	 0LLH4/snfcRVg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 2/9] NFS: Update readdir to use a scratch folio
Date: Fri, 12 Sep 2025 17:14:03 -0400
Message-ID: <20250912211410.837006-4-anna@kernel.org>
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

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index d81217923936..263aae15eb68 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -829,17 +829,17 @@ static int nfs_readdir_folio_filler(struct nfs_readdir_descriptor *desc,
 	struct address_space *mapping = desc->file->f_mapping;
 	struct folio *new, *folio = *arrays;
 	struct xdr_stream stream;
-	struct page *scratch;
+	struct folio *scratch;
 	struct xdr_buf buf;
 	u64 cookie;
 	int status;
 
-	scratch = alloc_page(GFP_KERNEL);
+	scratch = folio_alloc(GFP_KERNEL, 0);
 	if (scratch == NULL)
 		return -ENOMEM;
 
 	xdr_init_decode_pages(&stream, &buf, xdr_pages, buflen);
-	xdr_set_scratch_page(&stream, scratch);
+	xdr_set_scratch_folio(&stream, scratch);
 
 	do {
 		status = nfs_readdir_entry_decode(desc, entry, &stream);
@@ -891,7 +891,7 @@ static int nfs_readdir_folio_filler(struct nfs_readdir_descriptor *desc,
 	if (folio != *arrays)
 		nfs_readdir_folio_unlock_and_put(folio);
 
-	put_page(scratch);
+	folio_put(scratch);
 	return status;
 }
 
-- 
2.51.0


