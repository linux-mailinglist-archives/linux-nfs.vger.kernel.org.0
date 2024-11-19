Return-Path: <linux-nfs+bounces-8121-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDF59D2BFB
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 18:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB27D1F248FE
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 17:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B38014AD1A;
	Tue, 19 Nov 2024 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNq6PZuk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C0B1D0786
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035591; cv=none; b=DHtyVKxHCvW8a41/FwmEnhyGmmwLQBTp+Aj5V/Vap17bTRPa2alCntYJYU0E5o8IySxeTRucoQjBKJ6SPJ8PNuuSI/nKnQWU2cJBuw0JLv035//rMzKCdww7I/8YayRgYYRwy8bkaRWZoubrR+iqyZMLXLdJMeCJrFIyBGpxiOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035591; c=relaxed/simple;
	bh=ZnbVbTsDG+YLv3d3CZJK+o+0rAhoV2z8QNovd4+1FGA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o8bVj7SDV638AusrPXzTpnHc7PNbdCQjysNkLktL8G/HIGSj79U0b/P9eluL2KotJ6d4m26nEfvakOTmg86TikGKOVFJOq4D1c692ZiujhJ4GyMaWvwcdeAcerj5vgEBrLBLdg8CGEY1bXdIOik7uk65fCz34vnX19cSm6sQS0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNq6PZuk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732035588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d13TUlcfvIt5RZJyQ8k4MHpHnfGHE0sGrD+6AtF+HSo=;
	b=PNq6PZukDOqdw+naU0W/PfO5Jl8u5rWegWZZHz80C/QaWirrdCTIXEqPUX0HlizEIIKQO9
	seKZfLPHbO5ibT535Epio6v2ieuoEPjH0MTwFKy/YrZ0VQ3+prCe+O7tL7MLBDwBh0T7CM
	HEuE1l/wsqt4a+3T9kzcKqN0WAgIR2Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-6y9F1I4pPpC4yZAaymQPcA-1; Tue,
 19 Nov 2024 11:59:46 -0500
X-MC-Unique: 6y9F1I4pPpC4yZAaymQPcA-1
X-Mimecast-MFC-AGG-ID: 6y9F1I4pPpC4yZAaymQPcA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D491195609E
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 16:59:46 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.89.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A39830001A0
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 16:59:45 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH V2] nfs(5): Update rsize/wsize options
Date: Tue, 19 Nov 2024 11:59:42 -0500
Message-ID: <20241119165942.213409-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Seiichi Ikarashi <s.ikarashi@fujitsu.com>

The rsize/wsize values are not multiples of 1024 but multiples of the
system's page size or powers of 2 if < system's page size as defined
in fs/nfs/internal.h:nfs_io_size().

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mount/nfs.man | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

V2: Replaced PAGE_SIZE with "system's page size"

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 233a7177..eab4692a 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -215,15 +215,18 @@ or smaller than the
 setting. The largest read payload supported by the Linux NFS client
 is 1,048,576 bytes (one megabyte).
 .IP
-The
+The allowed
 .B rsize
-value is a positive integral multiple of 1024.
+value is a positive integral multiple of
+system's page size
+or a power of two if it is less than
+system's page size.
 Specified
 .B rsize
 values lower than 1024 are replaced with 4096; values larger than
 1048576 are replaced with 1048576. If a specified value is within the supported
-range but not a multiple of 1024, it is rounded down to the nearest
-multiple of 1024.
+range but not such an allowed value, it is rounded down to the nearest
+allowed value.
 .IP
 If an
 .B rsize
@@ -257,16 +260,19 @@ setting. The largest write payload supported by the Linux NFS client
 is 1,048,576 bytes (one megabyte).
 .IP
 Similar to
-.B rsize
-, the
+.BR rsize ,
+the allowed
 .B wsize
-value is a positive integral multiple of 1024.
+value is a positive integral multiple of
+system's page size
+or a power of two if it is less than
+system's page size.
 Specified
 .B wsize
 values lower than 1024 are replaced with 4096; values larger than
 1048576 are replaced with 1048576. If a specified value is within the supported
-range but not a multiple of 1024, it is rounded down to the nearest
-multiple of 1024.
+range but not such an allowed value, it is rounded down to the nearest
+allowed value.
 .IP
 If a
 .B wsize
-- 
2.47.0


