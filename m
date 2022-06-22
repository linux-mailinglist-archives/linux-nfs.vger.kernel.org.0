Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B6E554BF0
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jun 2022 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357988AbiFVN67 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jun 2022 09:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357785AbiFVN63 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jun 2022 09:58:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F7B33E81
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 06:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uU3NNF0Vo1g5YtaNfcpdBsJnEGu5p8U2gNBLDFyCV1k=; b=BvgSiPAH3/fmeaxdLyf++p+Z7z
        hhSzAIU7zXvCBe6zIpSbi9TI7nbevISGBI19RoD2iaBx2ptaUVf+RpYh7GuScXxywYCkTuudCtk6R
        AdomsFYsCUgSyDCAMhNtPlMENgEt8oTq5cLOHPRQBViljQc1lEz7pVeJalR/0Qs12WICUAMC1XbXY
        rSo8T9RsR7GiQ8IR+65APG17txrJbVuNBB5PZAB9ANyaVxPxtgI/vQEdwMKzqnyhjhIt/w4mQloBq
        bMVu9CLcgC+b7m1IdH9T9gX1DJoyTkIya2498u9UjdLtUfGZjUifbsFCDoQhgP/6ITCaQCRAyMptf
        7IWByINg==;
Received: from [2001:4bb8:189:7251:42c6:7c8:8ccc:6d9b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o40sC-00AkYW-TN; Wed, 22 Jun 2022 13:58:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfs/blocklayout: refactor block device opening
Date:   Wed, 22 Jun 2022 15:58:22 +0200
Message-Id: <20220622135822.3564952-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Deduplicate the helpers to open a device node by passing a name
prefix argument and using the same helper for both kinds of paths.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/blocklayout/dev.c | 42 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 5e56da748b2ab..fea5f8821da5e 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -301,18 +301,14 @@ bl_validate_designator(struct pnfs_block_volume *v)
 	}
 }
 
-/*
- * Try to open the udev path for the WWN.  At least on Debian the udev
- * by-id path will always point to the dm-multipath device if one exists.
- */
 static struct block_device *
-bl_open_udev_path(struct pnfs_block_volume *v)
+bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 {
 	struct block_device *bdev;
 	const char *devname;
 
-	devname = kasprintf(GFP_KERNEL, "/dev/disk/by-id/wwn-0x%*phN",
-				v->scsi.designator_len, v->scsi.designator);
+	devname = kasprintf(GFP_KERNEL, "/dev/disk/by-id/%s%*phN",
+			prefix, v->scsi.designator_len, v->scsi.designator);
 	if (!devname)
 		return ERR_PTR(-ENOMEM);
 
@@ -326,28 +322,6 @@ bl_open_udev_path(struct pnfs_block_volume *v)
 	return bdev;
 }
 
-/*
- * Try to open the RH/Fedora specific dm-mpath udev path for this WWN, as the
- * wwn- links will only point to the first discovered SCSI device there.
- */
-static struct block_device *
-bl_open_dm_mpath_udev_path(struct pnfs_block_volume *v)
-{
-	struct block_device *bdev;
-	const char *devname;
-
-	devname = kasprintf(GFP_KERNEL,
-			"/dev/disk/by-id/dm-uuid-mpath-%d%*phN",
-			v->scsi.designator_type,
-			v->scsi.designator_len, v->scsi.designator);
-	if (!devname)
-		return ERR_PTR(-ENOMEM);
-
-	bdev = blkdev_get_by_path(devname, FMODE_READ | FMODE_WRITE, NULL);
-	kfree(devname);
-	return bdev;
-}
-
 static int
 bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)
@@ -360,9 +334,15 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	if (!bl_validate_designator(v))
 		return -EINVAL;
 
-	bdev = bl_open_dm_mpath_udev_path(v);
+	/*
+	 * Try to open the RH/Fedora specific dm-mpath udev path first, as the
+	 * wwn- links will only point to the first discovered SCSI device there.
+	 * On other distributions like Debian, the default SCSI by-id path will
+	 * point to the dm-multipath device if one exists.
+	 */
+	bdev = bl_open_path(v, "dm-uuid-mpath-0x");
 	if (IS_ERR(bdev))
-		bdev = bl_open_udev_path(v);
+		bdev = bl_open_path(v, "wwn-0x");
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 	d->bdev = bdev;
-- 
2.30.2

