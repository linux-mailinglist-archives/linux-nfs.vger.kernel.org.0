Return-Path: <linux-nfs+bounces-8047-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BD59D198F
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FB528323F
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 20:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52C01E6DC2;
	Mon, 18 Nov 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4j6StbH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EFE1E6316
	for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961221; cv=none; b=eJ/b9UdQ7+bbcmCz7l4fHOPfiXIpYMD3JNOiHcmEpJ9nWVwfKSpqw3kj8a4s/tBGv3heBKuPW/G3H0JRBVQD2LtKeNMoAyvCWWRvAF+2Khwu0qBKuUU1foBZu1VIhZHn8gTBark3s+wjj4/6L2oMVKHGNgjWJUWfOUGK1rqNuUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961221; c=relaxed/simple;
	bh=vkKVf//HMS7+nmAmucsHSrJmn9oFNMKW507K7bTNtns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9tscAJm6wwc+lYUIqCyiqK/Aa0pe8LnIB16NZAscsF/wve3Zvs0vS/rv9/BZieFVTGr4bTc+yOPB0Lgy6K+ooEzQGVLcYJL6GYDrm+sqyHzpwWC2seOnausagSbZsGyH1GB9r0L3Yy9Ae6Z5KapCU0gNjoThrCWCJwhsCmdwPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4j6StbH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731961219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e1LviGIYs3wANNFJytB/OsW3y4SfAfogbC31hbmO8kM=;
	b=K4j6StbHNv1xNmLnQMdDzhCj4ErVdup2dBL9OTPfXjeS81jupGmO6htzL1yohWyCZP8Cs7
	GpqaulmtbgDdBFFfjw+eeEg9ItK89Oh4XPIcoRdESe9TnpqEK8cOejeeqqEXQ+rA05CnfL
	MJIXnQU4GQOFynQXwfcAyDoMpCJwDNw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-RalIYDq6ObmK7EXhvhP1zw-1; Mon,
 18 Nov 2024 15:20:16 -0500
X-MC-Unique: RalIYDq6ObmK7EXhvhP1zw-1
X-Mimecast-MFC-AGG-ID: RalIYDq6ObmK7EXhvhP1zw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CACE19DBA4A
	for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 20:20:13 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.18])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02BFF3003CCA;
	Mon, 18 Nov 2024 20:20:13 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 3A2F1222556;
	Mon, 18 Nov 2024 15:20:11 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] nfsd: dump default number of threads to 16
Date: Mon, 18 Nov 2024 15:20:11 -0500
Message-ID: <20241118202011.1115968-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

nfsdctl defaults to 16 threads.  Since the nfs-server.service file first
tries nfsdctl and then falls back to rpc.nfsd, it would probably be wise
to make the default in rpc.nfsd and nfs.conf 16, for the sake of
consistency and to avoid surprises.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 nfs.conf          | 2 +-
 utils/nfsd/nfsd.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/nfs.conf b/nfs.conf
index 23b5f7d4..087d7372 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -66,7 +66,7 @@
 #
 [nfsd]
 # debug=0
-# threads=8
+# threads=16
 # host=
 # port=0
 # grace-time=90
diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
index 249df00b..f787583e 100644
--- a/utils/nfsd/nfsd.c
+++ b/utils/nfsd/nfsd.c
@@ -32,7 +32,7 @@
 #include "xcommon.h"
 
 #ifndef NFSD_NPROC
-#define NFSD_NPROC 8
+#define NFSD_NPROC 16
 #endif
 
 static void	usage(const char *);
-- 
2.46.2


