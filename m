Return-Path: <linux-nfs+bounces-17034-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B5ECB5E45
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 13:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6C7B3004B95
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5AB30F92C;
	Thu, 11 Dec 2025 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRqp1YP9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D830F92B
	for <linux-nfs@vger.kernel.org>; Thu, 11 Dec 2025 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456481; cv=none; b=pZlpF1t/2lBiIq0jC0mlfhVpbatPYgwnd2dM4rIb9I5GBnTGozzynvBs/lIdBxjGdOdX4WcRi1zzMmff1wHcD1BkKSXDmaG23gYLfucu1qGibp2Ge2oXOfq45J1K6AiumMEFazXjg5uS+RRhkeawxB6x+zP1X5tENvd5dZJQnv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456481; c=relaxed/simple;
	bh=aZxq/Wmqbd86VjP37O09xeQLjJIGH7VZflOpLHiHywQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZMnh/O26yRXy0ydw4Ufu/eGXdrhQSQYRvLXpqmzAWxXA+Gb29tWepQWHlE61EqCeqfWgg5bbiAo0N2u/9uauprKCQ/FRusTktyRDsww7fko8BC3LYiBkEiT6zMKjr05Cj8sdUS+fJJV9E5c3bS4oJqJJ1Neez+HYnua3uc+cnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LRqp1YP9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765456479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ofb5A0cYx1PD1lpb7hAtLTnvTyviL7hyIWl+FrwNW+E=;
	b=LRqp1YP9QjJwEGiTdswipbtnJ2ta8meNd4ILGnaDpMcAYsfPKdBB5zmOOf52QiqEsOI+i3
	IJu023jX+kJ6qU17aRK5Loi1czRTSxXLTx1Ds0xduUR1T9igx94GwnZhUP0Le87LPAc40b
	V13uAiXXBHduqZ/qpJ+QoS1DmNmTpyo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-evmBSHneMf-fnq36JX8ByA-1; Thu,
 11 Dec 2025 07:34:37 -0500
X-MC-Unique: evmBSHneMf-fnq36JX8ByA-1
X-Mimecast-MFC-AGG-ID: evmBSHneMf-fnq36JX8ByA_1765456476
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5940718011DF;
	Thu, 11 Dec 2025 12:34:36 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.38])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D71631953984;
	Thu, 11 Dec 2025 12:34:35 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 4ADDE54DAB4;
	Thu, 11 Dec 2025 07:34:34 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: Fix permission check for read access to executable-only files
Date: Thu, 11 Dec 2025 07:34:34 -0500
Message-ID: <20251211123434.3261028-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Commit abc02e5602f7 added NFSD_MAY_OWNER_OVERRIDE to the access flags
passed from nfsd4_layoutget() to fh_verify().  This causes LAYOUTGET
to fail for executable-only files, and causes xfstests generic/126 to
fail on pNFS SCSI.

To allow read access to executable-only files, what we really want is:
1. The "permissions" portion of the access flags (the lower 6 bits)
   must be exactly NFSD_MAY_READ
2. The "hints" portion of the access flags (the upper 26 bits) can
   contain any combination of NFSD_MAY_OWNER_OVERRIDE and
   NFSD_MAY_READ_IF_EXEC

Fixes: abc02e5602f7 ("NFSD: Support write delegations in LAYOUTGET")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfsd/vfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 964cf922ad83..168d3ccc8155 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2865,8 +2865,8 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 
 	/* Allow read access to binaries even when mode 111 */
 	if (err == -EACCES && S_ISREG(inode->i_mode) &&
-	     (acc == (NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE) ||
-	      acc == (NFSD_MAY_READ | NFSD_MAY_READ_IF_EXEC)))
+	     (((acc & NFSD_MAY_MASK) == NFSD_MAY_READ) &&
+	      (acc & (NFSD_MAY_OWNER_OVERRIDE | NFSD_MAY_READ_IF_EXEC))))
 		err = inode_permission(&nop_mnt_idmap, inode, MAY_EXEC);
 
 	return err? nfserrno(err) : 0;
-- 
2.51.0


