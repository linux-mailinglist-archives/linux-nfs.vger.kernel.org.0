Return-Path: <linux-nfs+bounces-8152-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3BF9D3D8C
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 15:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE5BB2A8D3
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9101C7B69;
	Wed, 20 Nov 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJlCPff6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C397F1B5808
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111789; cv=none; b=GkHrXGw6Qt3n4CGQQ3qkAL1YACX6udkjt3jCngsQ/Wklq5HK92xicSlrnuBfTr71Hzv7+tDrv4jaUdyi7K2pVkh8knLcJBTHC4EoPUoHzkbmel+kAoUgRWaO1pCY7Pc3HNaDKYqTaxzkxWfUjJumMVN3j5LmCMsNSqBYTEDMq3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111789; c=relaxed/simple;
	bh=3xktHGjcwKLhOF8Z8CDzVVn2fFRzytFyj2iHYgJ233s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRA4iTjdaGiwc6ZTqCmFCk4bLkAtVh8l0RsAAFO4P/4hsyTrCUCZTnJj8XqvvbuDjUBu8D/R6CORh/ML8U8pvbosh5pVz33xB5W9XP+OensF6/4ets4xIkM9L2MrXtf6ImnO+fTTd9JQmYGRgilQ8llqO7ErvzuOP5y0czUtT/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJlCPff6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732111786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obBlFw7qbM1McyMjnug/w2OVz6Lnb7eCQvB8k59rMVI=;
	b=ZJlCPff64Y36S0nnIa9nEGHGqRhl4B/hIZyUs/B4xapB9lQtcILizVATIT107ST3EC/UVF
	kY0xRzIb76b1CV1kMFycvdx5W0hwqbdhdaaNXrF76KxS017gbAoLFKQMlb0u05cBUM3vCV
	RERsQiCD64Dm903YzgTYw3tTOraj6PQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-rslvtjznM5CuQKOZoWDIyQ-1; Wed,
 20 Nov 2024 09:09:43 -0500
X-MC-Unique: rslvtjznM5CuQKOZoWDIyQ-1
X-Mimecast-MFC-AGG-ID: rslvtjznM5CuQKOZoWDIyQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD18F1955DC1;
	Wed, 20 Nov 2024 14:09:41 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A35461955F43;
	Wed, 20 Nov 2024 14:09:40 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] nfs/blocklayout: Limit repeat device registration on failure
Date: Wed, 20 Nov 2024 09:09:35 -0500
Message-ID: <d156fbaf743d5ec2de50a894170f3d9c7b7a146c.1732111502.git.bcodding@redhat.com>
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

If we're unable to register a SCSI device, ensure we mark the device as
unavailable so that it will timeout and be re-added via GETDEVINFO.  This
avoids repeated doomed attempts to register a device in the IO path.

Add some clarifying comments as well.

Fixes: d869da91cccb ("nfs/blocklayout: Fix premature PR key unregistration")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/blocklayout/blocklayout.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 0becdec12970..b36bc2f4f7e2 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -571,19 +571,29 @@ bl_find_get_deviceid(struct nfs_server *server,
 	if (!node)
 		return ERR_PTR(-ENODEV);
 
+	/*
+	 * Devices that are marked unavailable are left in the cache with a
+	 * timeout to avoid sending GETDEVINFO after every LAYOUTGET, or
+	 * constantly attempting to register the device.  Once marked as
+	 * unavailable they must be deleted and never reused.
+	 */
 	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags)) {
 		unsigned long end = jiffies;
 		unsigned long start = end - PNFS_DEVICE_RETRY_TIMEOUT;
 
 		if (!time_in_range(node->timestamp_unavailable, start, end)) {
+			/* Force a new GETDEVINFO for this LAYOUT */
 			nfs4_delete_deviceid(node->ld, node->nfs_client, id);
 			goto retry;
 		}
 		goto out_put;
 	}
 
-	if (!bl_register_dev(container_of(node, struct pnfs_block_dev, node)))
+	/* If we cannot register, treat this device as transient */
+	if (!bl_register_dev(container_of(node, struct pnfs_block_dev, node))) {
+		nfs4_mark_deviceid_unavailable(node);
 		goto out_put;
+	}
 
 	return node;
 
-- 
2.47.0


