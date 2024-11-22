Return-Path: <linux-nfs+bounces-8198-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EE29D611C
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2024 16:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3531F21FC9
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2024 15:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C82413D2B2;
	Fri, 22 Nov 2024 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rp9bPEKV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1E26A009
	for <linux-nfs@vger.kernel.org>; Fri, 22 Nov 2024 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288283; cv=none; b=KHP/cuVR14Qpo1n07f09LeUti16E1zPUQGAtN195KBJI4mjAxcM4pgNxyF321poOLpzL8cFBa3VfwnEQtY1WoAIjbxPc4WRcNwgzXy8nqAuUc2Qu9rVUhAMMcHRamn+uy79TI/Q24M1tarzkjJv4cWwoIcC0ZCvHVLrpTLRG8Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288283; c=relaxed/simple;
	bh=AimJ11uxufoed/sDRYAOLuvEayVn4YN6qm5ISIiR3q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ga4cse07BmYbDa8I1FoIJbeAtWP/I/KBq4qx4yFEqFWqgKLSgZmADkaLRugXnvJsm8gykIPpfxwC/AaRhRnzaRhzod4o1Ca/lzB65Aai03ZnLYtgAftTu8ZnXgjVyRL7aEIz0HBavf9A+BXy3qMpUI9dKhSytwH9lQKp1thwfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rp9bPEKV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732288281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Uuqe0QCVbyX763fc1rUZSeIQKe9ONR1oYq0/7YUtzA=;
	b=Rp9bPEKVPsI1gauxrxdov7EksqSboDRmoYCHkBODr5wjoz8HrDAiFJ/ugkL2aBEv8r9YgI
	mvs7g51Vr8PFVJw2T5OvYAo8wJjju4q59xPSkz0MkVDfireaVSZGZ8sYW/zGmnPuzDqwoa
	7rcPjhfpop6kz8QQH2ONSBbK1pyZ5o4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-pkPjr96HMdC1csYqW5qrIg-1; Fri,
 22 Nov 2024 10:11:17 -0500
X-MC-Unique: pkPjr96HMdC1csYqW5qrIg-1
X-Mimecast-MFC-AGG-ID: pkPjr96HMdC1csYqW5qrIg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EB3C1955F77;
	Fri, 22 Nov 2024 15:11:16 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FAE6195E481;
	Fri, 22 Nov 2024 15:11:14 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 1/2] nfs/blocklayout: Don't attempt unregister for invalid block device
Date: Fri, 22 Nov 2024 10:11:11 -0500
Message-ID: <328bdcc958ebc16e95dca0c712a19cdb9b42bb99.1732288202.git.bcodding@redhat.com>
In-Reply-To: <cover.1732288202.git.bcodding@redhat.com>
References: <cover.1732288202.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Since commit d869da91cccb ("nfs/blocklayout: Fix premature PR key
unregistration") an unmount of a pNFS SCSI layout-enabled NFS may
dereference a NULL block_device in:

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/blocklayout/dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 6252f4447945..cab8809f0e0f 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -20,9 +20,6 @@ static void bl_unregister_scsi(struct pnfs_block_dev *dev)
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	int status;
 
-	if (!test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags))
-		return;
-
 	status = ops->pr_register(bdev, dev->pr_key, 0, false);
 	if (status)
 		trace_bl_pr_key_unreg_err(bdev, dev->pr_key, status);
@@ -58,7 +55,8 @@ static void bl_unregister_dev(struct pnfs_block_dev *dev)
 		return;
 	}
 
-	if (dev->type == PNFS_BLOCK_VOLUME_SCSI)
+	if (dev->type == PNFS_BLOCK_VOLUME_SCSI &&
+		test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags))
 		bl_unregister_scsi(dev);
 }
 
-- 
2.47.0


