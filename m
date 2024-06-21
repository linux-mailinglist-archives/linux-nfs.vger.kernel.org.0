Return-Path: <linux-nfs+bounces-4217-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3814912B40
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 18:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A368288529
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0602715FA7F;
	Fri, 21 Jun 2024 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZBz+q/7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE7757F8
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986966; cv=none; b=dtNBD639NBb94lXr87hfYsggDEcyXtSxJhxS/wP/H+KrQcMjEGWc1FYZ2daAjcpT2tnd2snV6G9DtMJjASvRlNU7jbhowzdWdFWcgrH9Zln5g1lAaR6vuORnPpuxdQ9/8rZcaOwc6wlaLwr1j8iSZWMOHT4mhrZPMKohcTzKnxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986966; c=relaxed/simple;
	bh=zJ2XQCK0MP3WAtBTnxZaYNqZ+n/5Y3zGhBDNbYIwEn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yu2I07nKU4UqhUSe17Z2wWtlMCnWR6es6mJ4p7EUh+xT6qhdjYn6xJlLow08u0P7jzK9PrTUcQRuExtrJRwcEm3jcCKpGelwUdppJYpamihb8+Jl0x/Ag5/FjaOZcrx9FU8Ev5L3EP/iByn+5FdtxiVKgxwA0yhNYUCYtZxoZAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZBz+q/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4A5C2BBFC;
	Fri, 21 Jun 2024 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718986966;
	bh=zJ2XQCK0MP3WAtBTnxZaYNqZ+n/5Y3zGhBDNbYIwEn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZBz+q/7eG0PzDOmU3+x/Qjb/NR7JXi6nL3GYaX+RJoziDxcW6baAm3U91gIaCSy1
	 eDZklLdrZh5zA0eR3RuPrikojmsxJXNjm/53X7f35oKUFsUlAqrGxCFVkrfCE6Fe8u
	 QasyOEERrc9XnPcYs3lzViiIDviB62gYGOXMIGfOzPa/b0PaiyPLT58lJOhGbmzS8i
	 BH07yhqSneZEaUymM516cHp5/rQC4Img1vXFx+1a+akjaVnJvXch8tRXzKY6pZ8Cwe
	 JUkXXqPhPpETu/EupDjwwILez3yfAzOiF9IGujxcpvK7NRDzgpLO2H1X8AcrAcb8cf
	 6v/nXmCX43qDg==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/4] nfs/blocklayout: Use bulk page allocation APIs
Date: Fri, 21 Jun 2024 12:22:30 -0400
Message-ID: <20240621162227.215412-8-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240621162227.215412-6-cel@kernel.org>
References: <20240621162227.215412-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=chuck.lever@oracle.com; h=from:subject; bh=64CPDNNydmmWUps9bRG2EqBzhLBVti4LBhnx7kukaOQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmdajIifVBaxsBLvS44MUM7iy6e1jrCUVyxCgw8 ZVuIdrS49aJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnWoyAAKCRAzarMzb2Z/ lzI0D/4gn9+PFchmuYIEcXhpZF5hTjcLsUnp8DMFZlquas3S19p/C9i+rMnPhWc01Pu3NCtueSH tflAI77za3hlZyBC6M/HRD/LutKDZ2UP7e7PhDbtqT7kQPmuSEaTZdzI1OhhCyaKgN3TlH9dQ3X 2ZcdZDBHUHe8XOyh0LnmYgncSbBprnkyB/1Yn/CpW2Zg8LfxRKqWRxL+pgH7ZLxdMWs/VTxx5gk tjnrz3ZTbkE3mYt7/efq9IPQB5Zc9J7BpVoNPnYPOvxM2gsRUXQgfY5RSYnPHa0aBqk5oaNL0ZT ZuAHPE6aHCL9WsTFGzC8/LPAwNLrAfaSzaHpTooshErax5H5aECnn4FObCuVH9CsVgloyV0Fgjq 8nBCI0J/vMDJrCW+zvPHhpvTRFCw6CtYiXlRjgJPkYjI7bx23dDNFG+nPF2aErawHKLaKvCvVfz 6FKKR9XrYRHRc5GTNaBRa4r1fPDzV5kIDgOfk1pmEOlhbT1G95SVf2LCHIa/GgxH8gNSzMOoVno sHYrlxRWqg1BllZYDxH/4exBSbvfK91xGIRzVezBQ5NBPgpuG+ZvRLTSSrmn+fDEcn8TkogMRfC qaFgfXl//IppzVOcnzREs/ko9tAf/3y5sbP+ftt+7DEnMgEBK1aiHy9gbCj9VIsWYNnWWzgYrmx U0c0vRKXuiJq2KQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

nfs4_get_device_info() frequently requests more than a few pages
when provisioning a nfs4_deviceid_node object. Make this more
efficient by using alloc_pages_bulk_array(). This API is known to be
several times faster than an open-coded loop around alloc_page().

release_pages() is folio-enabled so it is also more efficient than
repeatedly invoking __free_pages().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/pnfs_dev.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/pnfs_dev.c b/fs/nfs/pnfs_dev.c
index 178001c90156..26a78d69acab 100644
--- a/fs/nfs/pnfs_dev.c
+++ b/fs/nfs/pnfs_dev.c
@@ -101,9 +101,8 @@ nfs4_get_device_info(struct nfs_server *server,
 	struct nfs4_deviceid_node *d = NULL;
 	struct pnfs_device *pdev = NULL;
 	struct page **pages = NULL;
+	int rc, i, max_pages;
 	u32 max_resp_sz;
-	int max_pages;
-	int rc, i;
 
 	/*
 	 * Use the session max response size as the basis for setting
@@ -125,11 +124,9 @@ nfs4_get_device_info(struct nfs_server *server,
 	if (!pages)
 		goto out_free_pdev;
 
-	for (i = 0; i < max_pages; i++) {
-		pages[i] = alloc_page(gfp_flags);
-		if (!pages[i])
-			goto out_free_pages;
-	}
+	i = alloc_pages_bulk_array(GFP_KERNEL, max_pages, pages);
+	if (i != max_pages)
+		goto out_free_pages;
 
 	memcpy(&pdev->dev_id, dev_id, sizeof(*dev_id));
 	pdev->layout_type = server->pnfs_curr_ld->id;
@@ -154,8 +151,8 @@ nfs4_get_device_info(struct nfs_server *server,
 		set_bit(NFS_DEVICEID_NOCACHE, &d->flags);
 
 out_free_pages:
-	while (--i >= 0)
-		__free_page(pages[i]);
+	if (i)
+		release_pages(pages, i);
 	kfree(pages);
 out_free_pdev:
 	kfree(pdev);
-- 
2.45.1


