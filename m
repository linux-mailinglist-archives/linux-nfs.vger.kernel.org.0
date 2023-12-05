Return-Path: <linux-nfs+bounces-337-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFCE805828
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 16:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429BB1F21716
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 15:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C3B67E81;
	Tue,  5 Dec 2023 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBPqNMbz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB271A4
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 07:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701788727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJVrQ86Upg97715uXOZzxuCF7iHUqkzdPc0E5Z+ZF9A=;
	b=OBPqNMbzq0pEmrjij+1+sZbhX/QlP4siPoGUhGzLBQeANu4XB/coe+wi7RBUDVthHC2OpV
	904ySPoZneZmCMxPeXWxPZQXhRsAczWcVA/RnYNk+gNh4fvxhwx7gSTttWi1Ks/bjr8pXH
	ad7FkygkhqJoqGtRdjfW4dbiYqbiuI8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-AWaGb-NUMpOQeZU5YydEkQ-1; Tue, 05 Dec 2023 10:05:04 -0500
X-MC-Unique: AWaGb-NUMpOQeZU5YydEkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A2B9831082;
	Tue,  5 Dec 2023 15:05:04 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A6F3C1C060AF;
	Tue,  5 Dec 2023 15:05:03 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] pnfs/blocklayout: Don't add zero-length pnfs_block_dev
Date: Tue,  5 Dec 2023 10:05:02 -0500
Message-ID: <53e2ab90d83d4cdc15f1b48b2eb671ad26f54a6a.1701788600.git.bcodding@redhat.com>
In-Reply-To: <33e0ddfaad92ca5d6b0a4d1cc7541cf5a7480d7a.1701788600.git.bcodding@redhat.com>
References: <33e0ddfaad92ca5d6b0a4d1cc7541cf5a7480d7a.1701788600.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

We noticed a SCSI device that refused to allow READ CAPACITY when the
device had a PR with exclusive access, registrants only.  The result of
this situation is that the blocklayout driver adds a pnfs_block_dev of zero
length which always fails the offset_in_map tests.  Instead of continuously
trying to do pNFS for this case, just mark the device as unavailable which
will allow the client to fallback to the MDS for the duration of
PNFS_DEVICE_RETRY_TIMEOUT.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/blocklayout/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index f318a05a80e1..c97ebc42ec0f 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -351,6 +351,9 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	d->map = bl_map_simple;
 	d->pr_key = v->scsi.pr_key;
 
+	if (d->len == 0)
+		return -ENODEV;
+
 	pr_info("pNFS: using block device %s (reservation key 0x%llx)\n",
 		d->bdev_handle->bdev->bd_disk->disk_name, d->pr_key);
 
-- 
2.43.0


