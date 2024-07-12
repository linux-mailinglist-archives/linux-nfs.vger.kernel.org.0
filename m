Return-Path: <linux-nfs+bounces-4853-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593A792F61D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 09:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8041C227D7
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 07:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BE813D8B2;
	Fri, 12 Jul 2024 07:24:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C973429CF4;
	Fri, 12 Jul 2024 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720769070; cv=none; b=MBzkvOEMdAuxIjACdAURjj/u5k+kqfHNycdc/iwrtZ4cumljhEe+0Ezgy3nT67N8YHdm6JCK/yLteuzABIZI8Gaolgx5+sf2q+h7tDhoXP3O+V8R5uOG1LDzQwpBBkOGxZw59R1o4ABZhEZ3ldg0tjOJuodxutGfz3xUK0JHLa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720769070; c=relaxed/simple;
	bh=gy1XpxBXA8zAMxbYqFcppaBT//fJvcfmYAoOqiTCUBA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HhoOczO1rLGTVEPmWwPt1qCqCqB0sEYzAdPl8JM0hJZBj1FOIA7RrxEC1u3dP/paArhbD/nHrWZwWqSVVJRFLYKdVeIlu7bcf/A97g98XaHvLoj8zoH9iFw+hphxQwYsMaa9qxVQL2un9U/G5ex6qmEDZ5WyYDIGEctg4fTsW9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WL2zt3cC7z1X4Xn;
	Fri, 12 Jul 2024 15:20:10 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id E2DF114037C;
	Fri, 12 Jul 2024 15:24:24 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 12 Jul 2024 15:24:24 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <kolga@netapp.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <cuigaosheng1@huawei.com>
CC: <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH -next,v2] gss_krb5: refactor code to return correct PTR_ERR in krb5_DK
Date: Fri, 12 Jul 2024 15:24:23 +0800
Message-ID: <20240712072423.1942417-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200011.china.huawei.com (7.221.188.251)

Refactor the code in krb5_DK to return PTR_ERR when an error occurs.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
v2: Update IS_ERR to PTR_ERR, thanks very much!
 net/sunrpc/auth_gss/gss_krb5_keys.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
index 4eb19c3a54c7..5ac8d06ab2c0 100644
--- a/net/sunrpc/auth_gss/gss_krb5_keys.c
+++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
@@ -164,10 +164,14 @@ static int krb5_DK(const struct gss_krb5_enctype *gk5e,
 		goto err_return;
 
 	cipher = crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
-	if (IS_ERR(cipher))
+	if (IS_ERR(cipher)) {
+		ret = PTR_ERR(cipher);
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


