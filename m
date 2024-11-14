Return-Path: <linux-nfs+bounces-7983-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0039C8EFE
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 17:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576E81F2155F
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 16:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C237C14B06C;
	Thu, 14 Nov 2024 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+hFYKb2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7FE17BB16
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599953; cv=none; b=pYj30EKOnnGVa+CNJfgsGTyNw4YsCUS8KhUGpfBkf8wB2t5qnePwTepywIukzGkVwzh0iVdPO9QBvGbJG6sX7nPUboPdBDufY1qIq3k3sXwP4JhOS47wTcaoYEsCl8cNIvhynibiRW9h899NtW6JlW5A6w8chE5EkOogUYLXiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599953; c=relaxed/simple;
	bh=D/Rvp9aUTFTNr8hFDKl2bne34s3QJZSjHZ0BkRTUwvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nCuT8B0y5VKtskKwa4RYSQXarIF0buXoiw6dS2dd45WzQulXh36mvqE+DfIuNRGQntQcty6FuiOH/3QptKZ4kx4Yd7ZGWbJ313JFvFhHuwL9pxqWk7isDozrxXcDf7eZdEuRZPCgIexBg5yimUGoZe51qlHW0Owf1OB1edckw/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+hFYKb2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731599951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lXSbh/4T2zg9n/M3o5myscq2vFgBsPKUmrA4Na+KyPw=;
	b=D+hFYKb2c//jgCuaXAI1eu5u/jnuf748HzUjjhZ/HubFOJWtWt7su/c3lglCYyH1iErDyZ
	hQhYamwZkw//kQzD6hhTE5GosFowJk0jS6ATCc7zDo/pu0BJQ9M+EBR7YoV3K0T6O8r+7O
	C/gsTMjhmac2C+OPC/iWgXxNMT1kauA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-CXyv39PyMzOJexKLl49Feg-1; Thu,
 14 Nov 2024 10:59:07 -0500
X-MC-Unique: CXyv39PyMzOJexKLl49Feg-1
X-Mimecast-MFC-AGG-ID: CXyv39PyMzOJexKLl49Feg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95B981955F3C;
	Thu, 14 Nov 2024 15:59:06 +0000 (UTC)
Received: from dobby.kenosha.org.com (unknown [10.22.64.144])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D98E91955F3D;
	Thu, 14 Nov 2024 15:59:05 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] Revert "getnetconfig.c: free linep to avoid memory leakage"
Date: Thu, 14 Nov 2024 10:59:04 -0500
Message-ID: <20241114155904.591057-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This reverts commit f138e68e7ffefa3f4d71857ddb137fff877fd1d0.

There was no memory leak and freeing allocated
memory is not a good thing

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 src/getnetconfig.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/getnetconfig.c b/src/getnetconfig.c
index 7888f8c..d547dce 100644
--- a/src/getnetconfig.c
+++ b/src/getnetconfig.c
@@ -503,7 +503,9 @@ getnetconfigent(netid)
 	    break;
 	}
     } while (stringp != NULL);
-    free(linep);
+    if (ncp == NULL) {
+	free(linep);
+    }
     fclose(file);
     return(ncp);
 }
-- 
2.47.0


