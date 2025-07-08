Return-Path: <linux-nfs+bounces-12925-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8927AFC9FF
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 14:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44276563F02
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0E821FF29;
	Tue,  8 Jul 2025 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ih5x0FJg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE3E221FC9
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976102; cv=none; b=Q5CxwV4fqY3Kvm9Qx0lvR/gc/6BIEcwM0/xqPttiIvDKJwZm16Qlp9B7xo25N+Up6SJcXZ0CXKV7Fsk86dB3Kii0a9MIF+6z1cvP/22lIPN1Hp8d79WV7+z8V8GZyUgw3+17MjkQHa5VVZvky0Q2G/pXdbM94cYGXad1bsXcHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976102; c=relaxed/simple;
	bh=6enTbjISh/ggaTlWAxO4ZSmWEu6zk8pRVADt6xV7ZiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gv91wlRzlg1huUWv4Ka6Jzzkmaz0qfeLplmmKeV9ar5PNAf5ePam6hEAFDUMo+Sinr3ARj0ZKzRl8kJHqRUK6ZZtywcngx7e5BoBOPx5rLk34C9ZO3c+QQFpjv1JYvUmdFbi0u0cPIzZEYe0krndbfsgOpOSdtzZm1SDLAeAbh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ih5x0FJg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751976099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NOmknd3tfwXt5NDzbW98QiWjIDrGNrd3BnWKKjrRVs4=;
	b=ih5x0FJgQwDS5bdjMX69TGMvf2P1NU9Mdb0rfN80BIfQm+UWHsSDY1JtxM2c3Ua12msCHF
	AT3YgD/dk1AYgKqdPaI6N5spbrTVrkPZRuWjmPnD3vYfL3udvQruZrPMIi1HzaXLb1HoJp
	PEjrU9wO3wvlYZaoJ1eFm6BpU2JosOE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-Ob_gfft1NKS7ZC1bFB1c1Q-1; Tue,
 08 Jul 2025 08:01:38 -0400
X-MC-Unique: Ob_gfft1NKS7ZC1bFB1c1Q-1
X-Mimecast-MFC-AGG-ID: Ob_gfft1NKS7ZC1bFB1c1Q_1751976097
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7801518DA5C7;
	Tue,  8 Jul 2025 12:01:37 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A895B195609D;
	Tue,  8 Jul 2025 12:01:36 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Fixup allocation flags for nfsiod's __GFP_NORETRY
Date: Tue,  8 Jul 2025 08:01:35 -0400
Message-ID: <6892807b15cb401f3015e2acdaf1c2ba2bcae130.1751975813.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

If the NFS client is doing writeback from a workqueue context, avoid using
__GFP_NORETRY for allocations if the task has set PF_MEMALLOC_NOIO or
PF_MEMALLOC_NOFS.  The combination of these flags makes memory allocation
failures much more likely.

We've seen those allocation failures show up when the loopback driver is
doing writeback from a workqueue to a file on NFS, where memory allocation
failure results in errors or corruption within the loopback device's
filesystem.

Suggested-by: Trond Myklebust <trondmy@kernel.org>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/internal.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 69c2c10ee658..7f3213607431 100644
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
+		return ret |= __GFP_NORETRY | __GFP_NOWARN;
+	return ret;
 }
 
 /*
-- 
2.47.0


