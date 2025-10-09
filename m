Return-Path: <linux-nfs+bounces-15110-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 78173BCAD29
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B9EE352AE2
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 20:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A334023C8A1;
	Thu,  9 Oct 2025 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9wH7zdF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF31632DD
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760042542; cv=none; b=SkdAEJZ/rDLg4mq8klhQJvmefgYBiWHU8Uea40f9K9G4X7MddVV7CqHzWVOXzBHtdhPrDwMPspzkEJHpK+RYVjX6aAN+n+IMrjm2k564BMIS8OgiYV7Jfk6HPHMpspkfG/7P6Z00n1CdfMm+aQv0DtSR8pKOnwAmIkCJ5WV2QF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760042542; c=relaxed/simple;
	bh=9XbwoXAFpj3r6tYzeyANI9QT92FUot2YqrubKc1Jldk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=defYdcD3wySUMoMUDambkK2GVSavKJeWYzCmMKMPUSbqoR+eGQJ3aq505sjjtKvDjS7/MMpAH1oxlrnqYiHf48y4m4E4ZTw1zOTgmSS+BWgC5zktTg8qJ/UNRJv7fnISxhWM2vDfUDIDp23VHqRLCdzXTCPISWYmI054+d+DjtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9wH7zdF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760042539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0IJ76+w5CQnB7It6a80ym8krD/rfbBUYFuHqeCWUrOQ=;
	b=f9wH7zdFb5n5NZ5CflsvG6n+iOOTUNp+hJg2IRXzvRM4DvO8Ynjqd/73qKflUYc9DCGD62
	v7uqmNUI5O3L/uaq22EGXMqYaeYuh2rQCbTz2XYGstqT6NXQrscJYGbZpNAWERozyEztrg
	CgsDz/iiqo9cYUhocraRn+v/W9hZ0Fg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-toubMPtkP12J4z_sDQTS6w-1; Thu,
 09 Oct 2025 16:42:15 -0400
X-MC-Unique: toubMPtkP12J4z_sDQTS6w-1
X-Mimecast-MFC-AGG-ID: toubMPtkP12J4z_sDQTS6w_1760042534
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A2191800578;
	Thu,  9 Oct 2025 20:42:14 +0000 (UTC)
Received: from smayhew-thinkpadp1gen4i.remote.csb (unknown [10.22.80.132])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0829B1800576;
	Thu,  9 Oct 2025 20:42:13 +0000 (UTC)
Received: from smayhew-thinkpadp1gen4i.remote.csb (localhost [IPv6:::1])
	by smayhew-thinkpadp1gen4i.remote.csb (Postfix) with ESMTP id BE0B8381C989;
	Thu, 09 Oct 2025 16:42:12 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: check if suid/sgid was cleared after a write as needed
Date: Thu,  9 Oct 2025 16:42:12 -0400
Message-ID: <20251009204212.78113-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

I noticed xfstests generic/193 and generic/355 started failing against
knfsd after commit e7a8ebc305f2 ("NFSD: Offer write delegation for OPEN
with OPEN4_SHARE_ACCESS_WRITE").

I ran those same tests against ONTAP (which has had write delegation
support for a lot longer than knfsd) and they fail there too... so
while it's a new failure against knfsd, it isn't an entirely new
failure.

Add the NFS_INO_REVAL_FORCED flag so that the presence of a delegation
doesn't keep the inode from being revalidated to fetch the updated mode.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/write.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 0fb6905736d5..336c510f3750 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1535,7 +1535,8 @@ static int nfs_writeback_done(struct rpc_task *task,
 	/* Deal with the suid/sgid bit corner case */
 	if (nfs_should_remove_suid(inode)) {
 		spin_lock(&inode->i_lock);
-		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE
+				| NFS_INO_REVAL_FORCED);
 		spin_unlock(&inode->i_lock);
 	}
 	return 0;
-- 
2.51.0


