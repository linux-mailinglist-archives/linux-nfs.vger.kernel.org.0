Return-Path: <linux-nfs+bounces-4080-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D3690F54C
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 19:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 932BFB233B7
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 17:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D3313FD83;
	Wed, 19 Jun 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+AJsI+E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828AB1E87B
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818810; cv=none; b=RLbo3VqO3mYGv/6GLP3IcczG1zZpIyHemjAAQtsChz4Lj+azrqtaoKNtAtz6RY7xjfMfRDl6eT3d2HMNcYXUOb0f9UYZC7f/zeFcdkFuROwE5BHazMpnChP2OiJFPHNF1A4mk3lS6/nHChtj6BO2mi8Qol1bpSsPfyynlAccfrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818810; c=relaxed/simple;
	bh=tG7rzn/GBGXbKgCKoY1Mye3wCqijmdFwhRvKQNJvujg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0QEX14kvV1Mi52xksYtVHapZzDMTUwx1HsPJIwpkgjfAC2glr2axtR7ISqmUawjYY1mP9E7hn/N8ksOdCTlflur7cSNa3yDroUKF08NedYqQJFEslrL/L2yNvueRpVtfVIKaiX5GaLGwtZExNlDBaYggLtpYnL3i6IRpFt3mXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+AJsI+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB07C2BBFC;
	Wed, 19 Jun 2024 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818809;
	bh=tG7rzn/GBGXbKgCKoY1Mye3wCqijmdFwhRvKQNJvujg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+AJsI+EgZj3o53kuU8vuaxWrXNYjHKp/7ng+1DXB881S85xbe6ofOgCahDVB9Esr
	 IEvHa+swUnOQUJk6rfYizANzV5UD1Yuo8OM6d1/XyK+psuBlQ+LYlcgmy1Tn+50vmy
	 htmTWI4UjPFMIZuNIPzQVbtZH9l1r7Rh+735hV+eRBkzfKtj3D97fnLfZd9xubf0Bz
	 R7JENWdXuWzdWfZGb8Om7jAqMMb+x3/5ymhJZ0y0nHbiH27gMINsqAHI5jkjoywvEk
	 XIYQjAF/CV1Cs4SxsDWfyRgBwscw1J8UcZqRQ4vFoDyqUhXfUP3EHvabSqAgN0fNkq
	 uO/kzn13m0AmQ==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/4] nfs/blocklayout: Report only when /no/ device is found
Date: Wed, 19 Jun 2024 13:39:32 -0400
Message-ID: <20240619173929.177818-8-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240619173929.177818-6-cel@kernel.org>
References: <20240619173929.177818-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693; i=chuck.lever@oracle.com; h=from:subject; bh=/RPBC7X+492DhdOrkWhyByy9G4vje6JR+0B9kohoCOw=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmcxfXIsWHC1AlQRUZNkR+feuLDq0k5xzBiGyyr 2WnGeiRk6CJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnMX1wAKCRAzarMzb2Z/ l3EIEACMoffOm2Y2bDf+1zaVntlAkoH1YpUA3UuE3rX0u4p+lEYzb67wvGUaimOewhsUVJqweIG x9I17R2NpksJRHJRi0Qy1/HtxQXAuA+uyhQt+pw4XX7sI7UFKYOkrT6R4QTFvlrQrgma9YjXdvr 7H/iwbtZBWuvFIC0U79ulWJ20hiLYX3DKX1fX+zqIdAOVkABGOXOZDrH1VCgx5zG4wmIocYWe4e LxdebtNBxvObNGctnp2KKOeea29YzwvACLd8fqGv0N4YInsrxw4/ZYTw+XaKs4qctB88n28zb9I CeWSwHA68sx2SXpgvFf0vUeWg+ziLvcrfQJK6CHDXY2osE7A/X9n+gs2//fR13XqbC1aUutUlNx BP/1kjLJ9HjYx81eETwDhn5qfibOgUG7EDg1Xx3djSaMc8mxcyMBnhC/H+n62qfAFyCBhTylepI MWL4HSbSvQnKyWuzZ5z5dBDmSDPJvm+bNBjaNlEjbvZh5SvRNvkmDMQ3xUAGx78uyg+yZK3iH5x pXA0WzcrZPKwid5NE7RkH6Vbgzdq4WZw6TbYM2mx2PLmHQBQVyuOYaRZqKWUm/4sJobgX+TGoQH 2FWvjU64dNAeqFV68ZQ53Xeqi0eSCzLvQbQORyI3bKbDP6CTsNC3AE+zhTRSsrFjrZE83ylyWto mvYdiXhe7DpcU3g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Since f931d8374cad ("nfs/blocklayout: refactor block device
opening"), an error is reported when no multi-path device is
found. But this isn't a fatal error if the subsequent device open
is successful. On systems without multi-path devices, this message
always appears whether there is a problem or not.

Instead, generate less system journal noise by reporting an error
only when both open attempts fail. The new error message is more
actionable since it indicates that there is a real configuration
issue to be addressed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/blocklayout/dev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index b3828e5ee079..356bc967fb5d 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -318,7 +318,7 @@ bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 	bdev_file = bdev_file_open_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE,
 					NULL, NULL);
 	if (IS_ERR(bdev_file)) {
-		pr_warn("pNFS: failed to open device %s (%ld)\n",
+		dprintk("failed to open device %s (%ld)\n",
 			devname, PTR_ERR(bdev_file));
 	}
 
@@ -348,8 +348,11 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	bdev_file = bl_open_path(v, "dm-uuid-mpath-0x");
 	if (IS_ERR(bdev_file))
 		bdev_file = bl_open_path(v, "wwn-0x");
-	if (IS_ERR(bdev_file))
+	if (IS_ERR(bdev_file)) {
+		pr_err("pNFS: no device found for volume %*phN\n",
+			v->scsi.designator_len, v->scsi.designator);
 		return PTR_ERR(bdev_file);
+	}
 	d->bdev_file = bdev_file;
 	bdev = file_bdev(bdev_file);
 
-- 
2.45.1


