Return-Path: <linux-nfs+bounces-4850-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDFD92F548
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 08:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84ECA28395A
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 06:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2C413CFAB;
	Fri, 12 Jul 2024 06:03:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F028917BBE;
	Fri, 12 Jul 2024 06:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720764199; cv=none; b=SVCGxpICJlwmMlBrkSElAJecgRajG1CgltEAEOnj2EhoxXwBL5ULodlXJYRcr1sKft1nYqzp6lOYmrsU9rLZCJ6RFz2+wHedHyubuINIkFZ/TO0YweEc4ZEud1V3RjyVGTBrS46KftQezS8lRr2FBbLTjhh+WtEhGzH5CZlg/24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720764199; c=relaxed/simple;
	bh=tyewlfss8ZeV5s3yyTIvFQCYXD1GPH4DJE/N7DyKZIg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JoldyAMHOGZ8LZUAdWHpn8dkkzosMXv6Z3WKM7GsLIHQl+LGl8DtIqFc1lpGNGF6RsdxMhftL0OhzaWGXZLECPitBGtDfxx7IiaTtvHHVtNbXPjekqaxtRAHUxBtIIrClEox9Gltelau2FPWtHeFaL7JELgY24Prd3nKTWBcXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WL19m6gWZzxW1X;
	Fri, 12 Jul 2024 13:58:36 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 19018140973;
	Fri, 12 Jul 2024 14:03:14 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 12 Jul 2024 14:03:13 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <kolga@netapp.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <cuigaosheng1@huawei.com>
CC: <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH -next] gss_krb5: refactor code to return correct PTR_ERR in krb5_DK
Date: Fri, 12 Jul 2024 14:03:12 +0800
Message-ID: <20240712060312.1905013-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200011.china.huawei.com (7.221.188.251)

Refactor the code in krb5_DK to return PTR_ERR when an error occurs.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 net/sunrpc/auth_gss/gss_krb5_keys.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
index 4eb19c3a54c7..b809e646329f 100644
--- a/net/sunrpc/auth_gss/gss_krb5_keys.c
+++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
@@ -164,10 +164,14 @@ static int krb5_DK(const struct gss_krb5_enctype *gk5e,
 		goto err_return;
 
 	cipher = crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
-	if (IS_ERR(cipher))
+	if (IS_ERR(cipher)) {
+		ret = IS_ERR(cipher);
 		goto err_return;
+	}
+
 	blocksize = crypto_sync_skcipher_blocksize(cipher);
-	if (crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len))
+	ret = crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len);
+	if (ret)
 		goto err_free_cipher;
 
 	ret = -ENOMEM;
-- 
2.25.1


