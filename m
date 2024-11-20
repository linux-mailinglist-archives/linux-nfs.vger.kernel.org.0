Return-Path: <linux-nfs+bounces-8151-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6419D3D6B
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 15:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90407B2C9F5
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C061B5337;
	Wed, 20 Nov 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2Rh/alP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9811AB538
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111786; cv=none; b=p9gwklC121MHmz3ES/y89s4cnrnSk8XixFIdqPazeoJsxOzHDH6OwSTmBo6VYN+ik7aUl1LGRwtl0duimbJw+vD45raS351I9VrOTtqOg5KzQkLEc7Sh2SHGBiL/hcV/EK+/DgzHbcDI/ySsRAwRJF2ecxU8FRU78OEPmRfsDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111786; c=relaxed/simple;
	bh=P0esqpfCVIKD6GC5qpermc9EFlN4zlzNggcWx08FVXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPokKNY90SqVBLZg3GHnr857UARav3zZAIA2aYq/xHafGbRZbhkUZ5ONKiQFrVxk66Ep04/54Tq/7sQGZlKtu6xPg2OnCgpy4kHkkBHdxHWjOovskBYj3jaLpPz0Vd0p3jmkIamvsD93QZ9y8BUrN1vOMhFixilzYGnmcvuTn0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2Rh/alP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732111783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exClAK1Ex5b7lb7CBU4f4Lt0EX/bR7auCnoEN47gAdc=;
	b=R2Rh/alP2J5FG9bfFCiwB6gg4v7ff94AzZz8IRZHjyYsqWUob2YzjEJYARqzZoohshZL8s
	RoGSVGN6MEhNz5/fONDY6RTnvY8sBVYk5QIKSol9wd7kA6OVMAnYSGdxgZER4XBSFiyJsf
	XffqB6T/dt/bOODq8RbtphU3/37cYTg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-_iFhFkQLOneNDoERyeNNBA-1; Wed,
 20 Nov 2024 09:09:41 -0500
X-MC-Unique: _iFhFkQLOneNDoERyeNNBA-1
X-Mimecast-MFC-AGG-ID: _iFhFkQLOneNDoERyeNNBA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DF451956096;
	Wed, 20 Nov 2024 14:09:40 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A38FA1955F43;
	Wed, 20 Nov 2024 14:09:38 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] nfs/blocklayout: Don't attempt unregister for invalid block device
Date: Wed, 20 Nov 2024 09:09:34 -0500
Message-ID: <4e9690bed3d95d1c4cf2a7b1cc76f7cd1b333847.1732111502.git.bcodding@redhat.com>
In-Reply-To: <cover.1732111502.git.bcodding@redhat.com>
References: <cover.1732111502.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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


