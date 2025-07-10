Return-Path: <linux-nfs+bounces-12961-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBBCAFF67F
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 03:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6914F5A59BB
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 01:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F2827EC73;
	Thu, 10 Jul 2025 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcKk6F5A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F3E17A300
	for <linux-nfs@vger.kernel.org>; Thu, 10 Jul 2025 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752112073; cv=none; b=TdCq/ELSqcucWLVdXpQ/N6KnXyZqzl4jqHpXD2ooTX2f73rWPAGROpfCHp23+Mt6tOoFPnMfK8mIzMWEFbgUMv2IM32cPnrH4BcPnAciQSnpoG7+t9Be5j4iUUY/ufXnsDX88BelCMMCtdfu7mHdzUiBZth0y8TSMu7K+bh+wIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752112073; c=relaxed/simple;
	bh=DQTD7y7cv7owoVXkdUip8vQLTuU6DMRTruw/sxIFpJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=faFxHWd3x7LK/3MmpJ80wedarvvaZC1XuM+wN6S5pW7WVKW2I54QI/87QR3tx/fUuJ9e7ERibDLSeJiZ+AzCAdeFGpSPtBzLVyzkmC3DL3qOiVDVs/81dab4kk7FvemC3H7i1gFLLO3rpyiUb5EWkUoyukHt4cB1PRwUDDTR5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcKk6F5A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752112071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jh0rx+XXfIHWexmg7+WdmaTwcOzgWBvsa/tZ8r1I2KA=;
	b=fcKk6F5AFabMXbJQEuCY2uE3yuMlnmN7SJlsBg4Z9gCyc5keHdW736eUj14x+bDZv3MwbD
	bAgPgKPahDzF2vwHg4Xu8O2kbvHHu2felhwJCKqxqqFxhvPGcfg2mN7OknZsza5Jqu4Jjr
	j53JEDcRZ5ESiEVBU4sdQFIuOjCqzKE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-IUdYY6naM1mIRWJqS1IxGQ-1; Wed,
 09 Jul 2025 21:47:47 -0400
X-MC-Unique: IUdYY6naM1mIRWJqS1IxGQ-1
X-Mimecast-MFC-AGG-ID: IUdYY6naM1mIRWJqS1IxGQ_1752112066
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 787051944A82;
	Thu, 10 Jul 2025 01:47:46 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E52F6195608F;
	Thu, 10 Jul 2025 01:47:44 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3] NFS: Fixup allocation flags for nfsiod's __GFP_NORETRY
Date: Wed,  9 Jul 2025 21:47:43 -0400
Message-ID: <f83ac1155a4bc670f2663959a7a068571e06afd9.1752111622.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If the NFS client is doing writeback from a workqueue context, avoid using
__GFP_NORETRY for allocations if the task has set PF_MEMALLOC_NOIO or
PF_MEMALLOC_NOFS.  The combination of these flags makes memory allocation
failures much more likely.

We've seen those allocation failures show up when the loopback driver is
doing writeback from a workqueue to a file on NFS, where memory allocation
failure results in errors or corruption within the loopback device's
filesystem.

Suggested-by: Trond Myklebust <trondmy@kernel.org>
Fixes: 0bae835b63c5 ("NFS: Avoid writeback threads getting stuck in mempool_alloc()")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---

	On V3: fix ugly return (Thanks Paulo), add Jeff's R-b
	On V2: add missing 'Fixes' and Laurence's R-b T-b

 fs/nfs/internal.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 69c2c10ee658..d8f768254f16 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -671,9 +671,12 @@ nfs_write_match_verf(const struct nfs_writeverf *verf,
 
 static inline gfp_t nfs_io_gfp_mask(void)
 {
-	if (current->flags & PF_WQ_WORKER)
-		return GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
-	return GFP_KERNEL;
+	gfp_t ret = current_gfp_context(GFP_KERNEL);
+
+	/* For workers __GFP_NORETRY only with __GFP_IO or __GFP_FS */
+	if ((current->flags & PF_WQ_WORKER) && ret == GFP_KERNEL)
+		ret |= __GFP_NORETRY | __GFP_NOWARN;
+	return ret;
 }
 
 /*
-- 
2.47.0


