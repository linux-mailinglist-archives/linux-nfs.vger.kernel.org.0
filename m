Return-Path: <linux-nfs+bounces-8088-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15FF9D1B30
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 23:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F39C1F21D2F
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BBD1E9094;
	Mon, 18 Nov 2024 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdCvfO87"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CD31E9060
	for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731969653; cv=none; b=HL3mogrOABKL+ONBdZCxrCmv/l7n2eyS6EgcAB1ROqYfSchZCyBlfiumUMyQ0B2UWFMKtwZipPlqOrC4G54NL6w6/PGk/hyX0wfaIHtesdfMr4Zg4W9Q322BjLEva/EOuPwWc+pitLU70uKU9cEGDxYHZNCfdGRjmT8jbgCDIFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731969653; c=relaxed/simple;
	bh=OZpi5m0VvYR7a432BKb/ytZedlbv1XMZi/Rq7CZphiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeS6CZxt3A6hi6btZeYiaZb+Ge/95WYXZiXRtWXYx5e3pXY+hhDv5BUvm9qOEwD44iL939eCF6l4GDRgG/cyFv7fFdrhDMLqExeetd5j9wijTedlrSwDkPwJvxJZLr1VlAdu/ImCiNBiYX/I+JRw8zrQ6JE6zeEl71SIjehPL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdCvfO87; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731969650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oq9D3YuPWdAFaJGMJXmXZX1ELQaSyVylt8P6iK1TrM8=;
	b=TdCvfO87aroNoMZKBp2RDhk9iBjbiRbQBJMh1ruP4YYc82brIuZYlyBGfFw+PswJiBk3Pm
	FNkF6ZVeFY/LvyNS+e03XtvCk8FDG8/XhfIbM78ZfIstAXAir8Lt9bXtQLkItkA41x1lXo
	Uwv6meTcDfS3DKKkaZXqOPOGoaLTHyU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-RJ_T4mIKN_Otdu3UblSYPQ-1; Mon,
 18 Nov 2024 17:40:46 -0500
X-MC-Unique: RJ_T4mIKN_Otdu3UblSYPQ-1
X-Mimecast-MFC-AGG-ID: RJ_T4mIKN_Otdu3UblSYPQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B15B1977331;
	Mon, 18 Nov 2024 22:40:45 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B8AB1955F43;
	Mon, 18 Nov 2024 22:40:44 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nfs/blocklayout: Don't attempt unregister for invalid block device
Date: Mon, 18 Nov 2024 17:40:40 -0500
Message-ID: <eeb62d9260f2e9b61ff5e186eec0048e51bc8758.1731969260.git.bcodding@redhat.com>
In-Reply-To: <cover.1731969260.git.bcodding@redhat.com>
References: <cover.1731969260.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Since commit d869da91cccb, an unmount of a pNFS SCSI layout-enabled NFS
will dereference a NULL block_device in:

  bl_unregister_scsi+0x16/0xe0 [blocklayoutdriver]
  bl_free_device+0x70/0x80 [blocklayoutdriver]
  bl_free_deviceid_node+0x12/0x30 [blocklayoutdriver]
  nfs4_put_deviceid_node+0x60/0xc0 [nfsv4]
  nfs4_deviceid_purge_client+0x132/0x190 [nfsv4]
  unset_pnfs_layoutdriver+0x59/0x60 [nfsv4]
  nfs4_destroy_server+0x36/0x70 [nfsv4]
  nfs_free_server+0x23/0xe0 [nfs]
  deactivate_locked_super+0x30/0xb0
  cleanup_mnt+0xba/0x150
  task_work_run+0x59/0x90
  syscall_exit_to_user_mode+0x217/0x220
  do_syscall_64+0x8e/0x160

This happens because even though we were able to create the
nfs4_deviceid_node, the lookup for the device was unable to attach the
block device to the pnfs_block_dev.

If we never found a block device to register, we can avoid this case with
the PNFS_BDEV_REGISTERED flag.  Move the deref behind the test for the
flag.

Fixes: d869da91cccb ("nfs/blocklayout: Fix premature PR key unregistration")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/blocklayout/dev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 6252f4447945..7ae79814f4ff 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -16,13 +16,16 @@
 
 static void bl_unregister_scsi(struct pnfs_block_dev *dev)
 {
-	struct block_device *bdev = file_bdev(dev->bdev_file);
-	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
+	struct block_device *bdev;
+	const struct pr_ops *ops;
 	int status;
 
 	if (!test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags))
 		return;
 
+	bdev = file_bdev(dev->bdev_file);
+	ops = bdev->bd_disk->fops->pr_ops;
+
 	status = ops->pr_register(bdev, dev->pr_key, 0, false);
 	if (status)
 		trace_bl_pr_key_unreg_err(bdev, dev->pr_key, status);
-- 
2.47.0


