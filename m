Return-Path: <linux-nfs+bounces-12578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32913AE099D
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 17:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D5F178495
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 15:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C9927E7D9;
	Thu, 19 Jun 2025 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3vXfrM2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D5C2750EE
	for <linux-nfs@vger.kernel.org>; Thu, 19 Jun 2025 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345350; cv=none; b=crY6VIiFZm0w9CvsHDeMDS54rb+kPjbppAZdC7iI4pmZgdfnCr5AxKysrYGn/Da22NLW7C1q4kuTJJ0+x3CvWMJdBAKFz08asft7OskFsTMZvvTyXVnrlz15+PyIQOqEcyv6qo24JMxLdFrQRdg9EYQnKdubya5hrAbA+yPazWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345350; c=relaxed/simple;
	bh=e/dpX/AuetQo81hEIfYOg6wsppxEBfyKjz9uyW11uEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkzPAtbyaZmBV0VE4Yqv8TMUAoHJ1mcnIoAzWPWa0abaMsu5TS7KShC7J5DKV4nifSmDWa3vSUVbcxLbJ0DgHAVs4SucoArEQb6cpauf5QDFoATQ0tnPc0UXoySWGTInNTK0rLiMRWPotIdWqEdE2RrMO+eZiWECF1EmnevZnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3vXfrM2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750345347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9mME1XoOkXk4dS4K73108SzcDJJx3z0ZY9t260z6A20=;
	b=F3vXfrM2fPT3skQ9fHmO2Qh5RNhdhVcia92s6QmuX5FLd3gFxFbsNxTq9WMB8DxiFvuYFu
	0Mqp8+PhXHSnLVOE5pgvEELBRx2Zvk7wQXPHqXqTActx4D7XV1b1y2Co1yH6l/ZbR69qwy
	ffONyHjIc4RJUDcYDQbn2f5qB+zp/MU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-SdpoujgRPIiALQA9iUBJgA-1; Thu,
 19 Jun 2025 11:02:24 -0400
X-MC-Unique: SdpoujgRPIiALQA9iUBJgA-1
X-Mimecast-MFC-AGG-ID: SdpoujgRPIiALQA9iUBJgA_1750345343
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01628180136B;
	Thu, 19 Jun 2025 15:02:23 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.58.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3316130001BB;
	Thu, 19 Jun 2025 15:02:22 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSv4/pNFS: Fix a race to wake on NFS_LAYOUT_DRAIN
Date: Thu, 19 Jun 2025 11:02:21 -0400
Message-ID: <344e1f482396bb779888918b4c010c62edbac43b.1750345287.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

We found a few different systems hung up in writeback waiting on the same
page lock, and one task waiting on the NFS_LAYOUT_DRAIN bit in
pnfs_update_layout(), however the pnfs_layout_hdr's plh_outstanding count
was zero.

It seems most likely that this is another race between the waiter and waker
similar to commit ed0172af5d6f ("SUNRPC: Fix a race to wake a sync task").
Fix it up by applying the advised barrier.

Fixes: 880265c77ac4 ("pNFS: Avoid a live lock condition in pnfs_update_layout()")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/pnfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 5f582713bf05..4291ac4cfdf1 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2042,8 +2042,10 @@ static void nfs_layoutget_begin(struct pnfs_layout_hdr *lo)
 static void nfs_layoutget_end(struct pnfs_layout_hdr *lo)
 {
 	if (atomic_dec_and_test(&lo->plh_outstanding) &&
-	    test_and_clear_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags))
+	    test_and_clear_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags)) {
+		smp_mb__after_atomic();
 		wake_up_bit(&lo->plh_flags, NFS_LAYOUT_DRAIN);
+	}
 }
 
 static bool pnfs_is_first_layoutget(struct pnfs_layout_hdr *lo)
-- 
2.47.0


