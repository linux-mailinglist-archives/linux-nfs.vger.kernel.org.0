Return-Path: <linux-nfs+bounces-4218-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BEE912B42
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 18:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B06E1C2383C
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC7515FCF6;
	Fri, 21 Jun 2024 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IibhThhU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF5615FA8E
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986968; cv=none; b=I3mEIbA7BMlq76bXXyP0QICsIVaTXiyvsdMeSOS8YFoCrxUKiBOVOgckKhE9fzxmTPklueXJEBW4RiOfIm0xGpgGxFYqeIyPvU8jotLg5s4dXOX3mxYfNdPXxbr2cJYqy6ug3Ba1PPYgOPVrM9LNkG6BlmAbVAEhOKW9U4uSA+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986968; c=relaxed/simple;
	bh=XxHBKFUgCKg2xyacrqzKz+eonu2yKQTOyCo1Zf4Bm6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkkypS+de2QLTNwePaWAeT12JcK1mOuy12TaqB4SONV+VUERfeJIEGMVQlOmkQgxObBI8lqAXwZhr16x3dyxs058obYaJUUUTAkCBGF3bdKATO7m5djVBMZ8ZstXn5AgsaokV3zpwFxxUYd6/s+DFRvKkEHoB117SAt1eXy/hdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IibhThhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBB7C3277B;
	Fri, 21 Jun 2024 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718986967;
	bh=XxHBKFUgCKg2xyacrqzKz+eonu2yKQTOyCo1Zf4Bm6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IibhThhUrRBC7fY4DW3kXilVAJG7pA9ALdlcUZUA3M0BbEs0maXqvTrrTNH7IbFyz
	 vo/AiyfEYp3ekj0roH0mny7WBRQzWCGXA3Vo96lRd2dZdTEyu0in9+7MCe4L1PNfb3
	 /eZ6TIumnWst1wA6t09ea2jcl/SK1K82l070hDIA73zTDU18Ab0FyaQb3iEjFrHNKk
	 k/UjmWR7gI9Vk6su90WgvcEpy78fOLanH9yGoqkUivJp/7uv2EdEu9mkBfC1t+jWHP
	 VzqSg11Dw/YJ2Q1X7bfogD0WzxkVy7UmZg3r2sTjHU2dzK1D2YWD6uey28mqQZn2oc
	 LC/GvIkOYGekw==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 3/4] nfs/blocklayout: Report only when /no/ device is found
Date: Fri, 21 Jun 2024 12:22:31 -0400
Message-ID: <20240621162227.215412-9-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240621162227.215412-6-cel@kernel.org>
References: <20240621162227.215412-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766; i=chuck.lever@oracle.com; h=from:subject; bh=JXCWdR0tBvdkJh40ZArpq43pt9oBHejJ+7HeGkgKvPw=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmdajIp4dVUnDsv7nPQuod8ZNFjVCA1BfiJOQUm HAghjG59lyJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnWoyAAKCRAzarMzb2Z/ l951EACAwg8sJ2da9gEYbvlXaHFqekHiB/P/4Ewfkvj85d7eRvMjLQPF8KmQ6/gOoN/Xbz1/fSi 4aWMa+koU9n7lhy6MoLxdRAlmYJpBrCEJ83uPGzvxft2/nTGDX5QX2IcOWZeedonmfg8AiwUbC/ EQmlw/xHbU5ExMXnwUcciw+GJp167a2Qtl3Z3OfVFK2HqtxWvY9N4jNwIS6LU9i0b2mMnhFrvRM ra6OVe8on9qRbASqA69GXFdQqa0XUwO/AoulZuh61f8Se8ce6297BpQWMh9msNwXlDnA047xiAV UsSCJBYyMd3BY2GmT7QEccn7rPP3a+0enQeW3ntpkwM+WgeFcYqzHroa+YtDfi7e1Jsa7vWYKuQ +CGkmL6f2EGalVsLr5Gf+deBicsf9SpEM91p0BUUg9cZUoFHW/05KO6NHUvFuNoemRXzJWaLeKI cqwlVn8dgsOmdmUgLPA+j6eoQidHJSuY3vDWyQgh0snWamk0VZ0Q0FAsDveCC2+fCBlIHA8D87J yPoG2KjItUlhC0gitJKVE/ji+6eBkJCVbV7H2SEKqRMWoGTRiglqFgA93RVnN5i12xbJ8e/e2xl mtrWmVPuYYv9rVbLRYUJQxUkXY84wADcqGylnRPgWxfuzyaKyOXwLQBESXZ7EOYmiPww+3VXq1M k/r1Gmly++74ecA==
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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/blocklayout/dev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 83753a08a19d..568f685dee4b 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -338,7 +338,7 @@ bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 	bdev_file = bdev_file_open_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE,
 					NULL, NULL);
 	if (IS_ERR(bdev_file)) {
-		pr_warn("pNFS: failed to open device %s (%ld)\n",
+		dprintk("failed to open device %s (%ld)\n",
 			devname, PTR_ERR(bdev_file));
 	}
 
@@ -367,8 +367,11 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
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


