Return-Path: <linux-nfs+bounces-4082-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CB490F54D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 19:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E45D1F213AA
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF24E13FD83;
	Wed, 19 Jun 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ1NlUMt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE301E87B
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818815; cv=none; b=dWOSRrVXHsawKynekVgIPo3c9kIw7YOAOP2M/9orBiaf3+eZGm86weFjWCU3geah+IOK1bvEzE2wSyi6oqwx9bhHaMXkaOKdRY+OGTT1AKPU3VoUTcWBW72RbTTNUikLc7vVcWQS3Oi9gpa8b+ODbtl+9FswXoXjGdScmdEIPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818815; c=relaxed/simple;
	bh=zJ2XQCK0MP3WAtBTnxZaYNqZ+n/5Y3zGhBDNbYIwEn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqgxnsTHximj8NDmv7Egm0YcXgr2viJJW8afRO+cDM47+cBt6pdj1d7aVtYsGk5lR4thHX0XlYUd30yKPOAdekKZJHf0MD+YoFR93ZH8sa7NJ9sf0SzfhhApK+ltqOSqX0TMMTlgN7PXGBp1sLQt3aD0u8Kdh+hUwc4zT3L40+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ1NlUMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E5CC32786;
	Wed, 19 Jun 2024 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818815;
	bh=zJ2XQCK0MP3WAtBTnxZaYNqZ+n/5Y3zGhBDNbYIwEn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQ1NlUMtp1CQFlqLPkvKxd+1m66Ojodlb8VLZ7l79gI4UparijWcSjYZdrUNw3eOL
	 WimgwBzI91pu46F36uGu4U41ldhCpmpBNvnR7VMFZprdv/wSbQWelHDEbKCY/NvMBI
	 WAFENZga9KTfnr0ngELPPLmRk44uOihc0l4r1iickUtVxTp1ghaIez3m+8R6DGmwg9
	 1zIAXGGkqOAcudOxOln2hQJh1s8u7MUzQWEvUNCdkhuYeoUGE1UWQDsnDG4gQ6ABic
	 o8luBOmz02tMU6wV/8O8ermWhLUKJPVyID9q2CuQDmv4e/WQQZVDKyxw/WUEP+qVlG
	 I+BQYoLi1lvpA==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 4/4] nfs/blocklayout: Use bulk page allocation APIs
Date: Wed, 19 Jun 2024 13:39:34 -0400
Message-ID: <20240619173929.177818-10-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240619173929.177818-6-cel@kernel.org>
References: <20240619173929.177818-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=chuck.lever@oracle.com; h=from:subject; bh=64CPDNNydmmWUps9bRG2EqBzhLBVti4LBhnx7kukaOQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmcxfYifVBaxsBLvS44MUM7iy6e1jrCUVyxCgw8 ZVuIdrS49aJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnMX2AAKCRAzarMzb2Z/ l3NWD/9tVSTni7pWmae6kLIDJ3XRz1pA4jTYI1tcx4ziYC64/jluqvzKqShzu7n7IbcXOyEQZ+s VLU0o8HMojix9UsZW+ffFve1bgyFckqdzpAJmA/fyjfIN1O9A7TUh6VjBZVHIGyMFCcTDJwOTd7 5cUzoNAjuJalYAV980G70xP5XOwouZcdjtxa/kjZOHxwOIAor5jxwNk7EBiyC1BRBX6TntidXRt lEQXOJVIWlD1QOK4Ryvm4tnMGqZeKTQ5dPZFP6GRzYNiBi5tAl3gcl1L/7ENecuVKCLXR0XJlK8 YHn7/N7NoHsbhjcU879Hv7xHVjgt/fhmFyrNdQhZ/4R1wNUFR3jk4O9YJhq9jywBSed9IX2BTRq LDc68NcTX+T2A43C3k7nv7PMuhK0a5XDZjJl0WprzHXiQTMs2JqgUSH5tT4KmNGZb8AtfLoPOKh FdljbKpQGLkSluR+1SOMaGHtpIlZ2B1CZMw2BfXBi+P/FsqfLPyNflwo3DoSxxipbKleZ1YiuJx XIn4rWwhwpHtUKwhRysRmlJZ4EEeT6A9VlxC9NPv8aaIa80m0ZMUilplUjGafiuJJWlWUOcJYR5 EpmOKYbmgjQ2OduqCYIZBfvbWbsNpSiyWGPTY4IBP/fUDpDYal89SL/DxJ7FwAAY4sIH8JxVYXh D75fDPzMSnJsJzQ==
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


