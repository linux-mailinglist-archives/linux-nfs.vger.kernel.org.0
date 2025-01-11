Return-Path: <linux-nfs+bounces-9139-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFE2A0A276
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jan 2025 10:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC90D1658A5
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jan 2025 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36227156F54;
	Sat, 11 Jan 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRoBKw1K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E62018A931
	for <linux-nfs@vger.kernel.org>; Sat, 11 Jan 2025 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736589317; cv=none; b=V2gmX9VCfXz18Uzz0qLaGdJBwHFpNmoH3LoY9soYOLWXglIQjMjyTMOThEybamai8xOr6hcjRFkB6nro3nEOCwCoN5dbKdM4zdrt+MXUS8LVH1cUvYY33ZNgVdd6iido5pIObeD6MUsnwlOqBSppYp0J9Kxv0rsxlTc5084P4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736589317; c=relaxed/simple;
	bh=rrO0TAF+d/kSc9UBkA55BU2G/J97Tb0oQNmmsBDMTZ0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BZUnAor3aHmA2gB86UM7KdrYgccnDQ/9VnpC6gtjAgYg65mHBOl2lKW0e9K7QjnMmLlBbrbNxE/NIydbn400Y8wQHqZQQ3L2X6WzkNVR47mKM9aQ1uFSt6pz0YtKa7vWrOHJzerRAjlQ3hH6LoTKkUkZaCpGUJr/1QSaIZMIcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WRoBKw1K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736589314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zm3aVuxYa27QqSa4SryBiyty1vmNBXA1S9TRd/V/NGk=;
	b=WRoBKw1KFvy5Ry2qp2erP8zTdtbH4Z5SJx5bDt9XJiVuqJpJlYTCr9hX+/vbgpynRbAlFR
	CIN2MoarX17DMbXHOQM24aOTCf2hSsHpr77wxD9F3pnlqzFt0AA9g5TSwJIMNcu5Pvu8V4
	cAjXW7pCeccQJYfJi1TifW/Qc+3Poos=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-mgD4d__0NUeC13eNDZ6aFg-1; Sat,
 11 Jan 2025 04:55:12 -0500
X-MC-Unique: mgD4d__0NUeC13eNDZ6aFg-1
X-Mimecast-MFC-AGG-ID: mgD4d__0NUeC13eNDZ6aFg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D124195608F
	for <linux-nfs@vger.kernel.org>; Sat, 11 Jan 2025 09:55:11 +0000 (UTC)
Received: from bighat.boston.devel.redhat.com (unknown [10.22.88.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C080B30001BE
	for <linux-nfs@vger.kernel.org>; Sat, 11 Jan 2025 09:55:10 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfsdcltrack related manpage and configure file cleanup
Date: Sat, 11 Jan 2025 04:55:09 -0500
Message-ID: <20250111095509.61461-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fixes: https://issues.redhat.com/browse/RHEL-73500
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 nfs.conf             |  4 ----
 systemd/nfs.conf.man | 14 --------------
 2 files changed, 18 deletions(-)

diff --git a/nfs.conf b/nfs.conf
index 087d7372..3cca68c3 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -60,10 +60,6 @@
 # debug=0
 # storagedir=/var/lib/nfs/nfsdcld
 #
-[nfsdcltrack]
-# debug=0
-# storagedir=/var/lib/nfs/nfsdcltrack
-#
 [nfsd]
 # debug=0
 # threads=16
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index d03fc887..e6a84a97 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -158,19 +158,6 @@ is equivalent to providing the
 .B \-\-log\-auth
 option.
 
-.TP
-.B nfsdcltrack
-Recognized values:
-.BR storagedir .
-
-The
-.B nfsdcltrack
-program is run directly by the Linux kernel and there is no
-opportunity to provide command line arguments, so the configuration
-file is the only way to configure this program.  See
-.BR nfsdcltrack (8)
-for details.
-
 .TP
 .B nfsd
 Recognized values:
@@ -329,7 +316,6 @@ for deatils.
 Various configuration files read in order.  Later settings override
 earlier settings.
 .SH SEE ALSO
-.BR nfsdcltrack (8),
 .BR rpc.nfsd (8),
 .BR rpc.mountd (8),
 .BR nfsmount.conf (5).
-- 
2.47.1


