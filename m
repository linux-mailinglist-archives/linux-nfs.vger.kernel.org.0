Return-Path: <linux-nfs+bounces-12916-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C2CAFBB17
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jul 2025 20:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F854A8CE6
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jul 2025 18:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4DC25394A;
	Mon,  7 Jul 2025 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbw6lRAt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB921CA03
	for <linux-nfs@vger.kernel.org>; Mon,  7 Jul 2025 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913974; cv=none; b=BG40a3gCzV6WGtzsCOyOgUIuzi2QBDeTaEsgUN27oFqka4OrcOx/4b6qlUbA6YOnHvcnnLXBDBGaQfk5N5AHI6hzKvNRFIGL41/5n6Df3O7hjNo9CKswlhhVA3Cd910clcVaRyRzwCG+m4F/D5YjQTVBLlndtNAK8fp5k1jopNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913974; c=relaxed/simple;
	bh=83Ba0mK1VEiznArAENk9nArtQQK30RYW79zt7Z+AzM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YntdDycQhZwiYD3OPBKx4XyFQtNc69y0n91sruW2uDUqENiX6Tq8GbuiWtlCn1p+ie7bMNf4Up1k8ouu8w+a1306IVnyVEmDLVLi53juhsS4CLQGUs2C5l3TK2RYK9p7HZISEbwBtHnU6muP3YUI4LhY0x1TrMU5I9rND1lY0Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbw6lRAt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751913971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6jUDIY0+wkpp5w9gqMEkqBb/sfMBkyBmQ7+Gp3OVZQ=;
	b=cbw6lRAtA76do7dk3nHuYVRCZEXRQhhm48biKkOPzJhdH5gE/X96coQMQtnAWTWd8GdEmQ
	SCiQT8gf76oCO7y7ydvpH5RXaFZZKlyd00+jqs7Rg8FUaaLQcILfwwUlnopM00rHbN/Z9a
	nMYk9AdHLycS0HeobItNRYpbsqn+gv0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-0crdWXRUMv6UFj4ZrVrLGw-1; Mon,
 07 Jul 2025 14:46:10 -0400
X-MC-Unique: 0crdWXRUMv6UFj4ZrVrLGw-1
X-Mimecast-MFC-AGG-ID: 0crdWXRUMv6UFj4ZrVrLGw_1751913969
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A17818089B4;
	Mon,  7 Jul 2025 18:46:09 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3326C1956095;
	Mon,  7 Jul 2025 18:46:08 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djeffery@redhat.com,
	loberman@redhat.com
Subject: [PATCH 2/2] NFS: Improve nfsiod workqueue detection for allocation flags
Date: Mon,  7 Jul 2025 14:46:04 -0400
Message-ID: <a4548815532fb7ad71a4e7c45b3783651c86c51f.1751913604.git.bcodding@redhat.com>
In-Reply-To: <cover.1751913604.git.bcodding@redhat.com>
References: <cover.1751913604.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The NFS client writeback paths change which flags are passed to their
memory allocation calls based on whether the current task is running from
within a workqueue or not.  More specifically, it appears that during
writeback allocations with PF_WQ_WORKER set on current->flags will add
__GFP_NORETRY | __GFP_NOWARN.  Presumably this is because nfsiod can
simply fail quickly and later retry to write back that specific page should
the allocation fail.

However, the check for PF_WQ_WORKER is too general because tasks can enter NFS
writeback paths from other workqueues.  Specifically, the loopback driver
tends to perform writeback into backing files on NFS with PF_WQ_WORKER set,
and additionally sets PF_MEMALLOC_NOIO.  The combination of
PF_MEMALLOC_NOIO with __GFP_NORETRY can easily result in allocation
failures and the loopback driver has no retry functionality.  As a result,
after commit 0bae835b63c5 ("NFS: Avoid writeback threads getting stuck in
mempool_alloc()") users are seeing corrupted loop-mounted filesystems backed
by image files on NFS.

In a preceding patch, we introduced a function to allow NFS to detect if
the task is executing within a specific workqueue.  Here we use that helper
to set __GFP_NORETRY | __GFP_NOWARN only if the workqueue is nfsiod.

Fixes: 0bae835b63c5 ("NFS: Avoid writeback threads getting stuck in mempool_alloc()")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/internal.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 69c2c10ee658..173172afa3f5 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -12,6 +12,7 @@
 #include <linux/nfs_page.h>
 #include <linux/nfslocalio.h>
 #include <linux/wait_bit.h>
+#include <linux/workqueue.h>
 
 #define NFS_SB_MASK (SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
 
@@ -669,9 +670,18 @@ nfs_write_match_verf(const struct nfs_writeverf *verf,
 		!nfs_write_verifier_cmp(&req->wb_verf, &verf->verifier);
 }
 
+static inline bool is_nfsiod(void)
+{
+	struct workqueue_struct *current_wq = current_workqueue();
+
+	if (current_wq)
+		return current_wq == nfsiod_workqueue;
+	return false;
+}
+
 static inline gfp_t nfs_io_gfp_mask(void)
 {
-	if (current->flags & PF_WQ_WORKER)
+	if (is_nfsiod())
 		return GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
 	return GFP_KERNEL;
 }
-- 
2.47.0


