Return-Path: <linux-nfs+bounces-4305-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFB991721D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 22:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1B52889A1
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 20:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483B917E462;
	Tue, 25 Jun 2024 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DENlNKhx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C0017D357
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345739; cv=none; b=n185Y0MH+gvzXDlF5xyfu4+Q2eC/xoxzw19fd8zgKfPIdbtOz85pduTMXLYfn50dSD0+B+Z8Kcqbvu3kExQN2DgLFrR2bNxIOcnh3IDZ/4x4kshnNnfxYyaONT+S4uAA8HF+Hv5FWFPrwz4YlqeVqjRHa3ZvnASIZZif3pR/sMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345739; c=relaxed/simple;
	bh=qVZsrmhLADFrwXeGquzGJpCWMKhlBsnWs7ue5Mux2s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhmmx4dfDIgNVWFXxCaHfDkG3Td85K3pLPkov7ZM/aARLg2T1JE3AsoW2248BSor8FqUc4j26OVZAqFsk0DEB7xfb5Lit1Y94ewnlfm/ga0Q2Y5jTSHW21/V+N/bvNCLut/qmpYsW1f+sxE0XsnoiN0+UkEZrW7AhD5qIY8Ur/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DENlNKhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6A6C32782;
	Tue, 25 Jun 2024 20:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719345738;
	bh=qVZsrmhLADFrwXeGquzGJpCWMKhlBsnWs7ue5Mux2s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DENlNKhxks6mbIPbkwzS5cucgBuEEwIW/otLAbXg6KnpD1frVd2iJvCkAh5eklNHt
	 vQyZJWs65yzG4KmwKJnlX2tSNqj1edh4TLkoA6sv/lA/911I+yHMRct82Pou3ElaVU
	 CSYW8VvCHi49xrRqFCCaclhxfUOm8b/0AkUuYADAdy7R0N80LZbwAKh5BRY2I1nAZR
	 6JSTCUlvFeIrzxuNmal8CPtqnTIYtdnJH4RX77+C195UeBVa3USLqfo+iEwRetKSRY
	 Xtw5uG5nCZCTJQcCvH7sdhv+Y4C9yO7tsTkIFnqZ3a9mGJH/9QuoRYx3AQ4W1KT84/
	 N8eWMPX/LnZlQ==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH v3 2/3] nfs/blocklayout: Report only when /no/ device is found
Date: Tue, 25 Jun 2024 16:02:07 -0400
Message-ID: <20240625200204.276770-7-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240625200204.276770-5-cel@kernel.org>
References: <20240625200204.276770-5-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822; i=chuck.lever@oracle.com; h=from:subject; bh=zehYuD43oBNIoiNM4I3Q5BqGsVBXQrmexrDvvzgyFAA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmeyJCBuVh6FeSZ6txr7WxlkR1hxPjN5JR6xPjZ NcNDjaubjGJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnsiQgAKCRAzarMzb2Z/ lx8JD/wNPi8APv/Mt1C7O70rluI3Vh21WFSQIcEFVUQhxkzkppwAjbO3vfq29+vjuzYDYI6AdJe svrblBOO0p9eQx8GlgBCbUhGgAKnJCjGWj+HoFtVO2GyeSfMm+p3ZrSfAMBy8+rBFDfsfWIBsN0 /kx3VchzL6Ov8ZcbBrb+P8JrzcnzbBDDONxt6Hyhi49H0Nuk8iH1CAO4dwlIaGOsT5W2Hw+aurf DeaGfvbhE2WQ3y1/fODkwH595a3VLxelfT15KT7wZHNXZwTYuVJ4+uEmBPGV22BfhIzZhVRdaw2 p7rM9lWxCw0cddhuYN5E9asygqW1sJ43xT3WONfdD6121w5g3aczZjUQDWxluz8JWag/Q5Qrrf0 ekJlW0XV41wVHox2rCgjX1oLLPAO3yvfC+rGGyQAiUZWdvK4oJxmCj0HHANz1lIXQie988+1g2d yb5L/UMKa+k5vcRHLJx56gu5lAgN3JZFBeXC7tc/dT5BOBfd6OIGpzypuWf5BITtdet4aw3lCw9 t/CAG4RwpIE1Jf0yDTqiZ+BHrEG7ziJFt3Sna45c1JqXH7b0muagtys9T2lGTHd0jLHaQh/BOGv zoS2s51ymVzuuSXq2Kb1SgVGkiOdBGuJRYXqrbOImPMNd5h89mQxxlJZQU23RMWEMlyST/tvdDq NKWp1Gfz/BHxB2w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Since commit f931d8374cad ("nfs/blocklayout: refactor block device
opening"), an error is reported when no multi-path device is found.
But this isn't a fatal error if the subsequent device open is
successful. On systems without multi-path devices, this message
always appears whether there is a problem or not.

Instead, generate less system journal noise by reporting an error
only when both open attempts fail. The new error message is more
actionable since it indicates that there is a real configuration
issue to be addressed.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/blocklayout/dev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index fc4eeb7bbf05..ebd268f81419 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -369,7 +369,7 @@ bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 	bdev_file = bdev_file_open_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE,
 					NULL, NULL);
 	if (IS_ERR(bdev_file)) {
-		pr_warn("pNFS: failed to open device %s (%ld)\n",
+		dprintk("failed to open device %s (%ld)\n",
 			devname, PTR_ERR(bdev_file));
 	}
 
@@ -398,8 +398,11 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	bdev_file = bl_open_path(v, "dm-uuid-mpath-0x");
 	if (IS_ERR(bdev_file))
 		bdev_file = bl_open_path(v, "wwn-0x");
-	if (IS_ERR(bdev_file))
+	if (IS_ERR(bdev_file)) {
+		pr_warn("pNFS: no device found for volume %*phN\n",
+			v->scsi.designator_len, v->scsi.designator);
 		return PTR_ERR(bdev_file);
+	}
 	d->bdev_file = bdev_file;
 
 	d->len = bdev_nr_bytes(file_bdev(d->bdev_file));
-- 
2.45.1


