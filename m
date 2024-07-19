Return-Path: <linux-nfs+bounces-4987-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A666E937294
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 04:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592B51F21C9E
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 02:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C7428F5;
	Fri, 19 Jul 2024 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="k+LiWoYx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF1415D1
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jul 2024 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721357170; cv=none; b=Z583jKnbZAvKdUIu8GucH//8tnoDSvwvYW19fXAXJoZBtBrE9a8Yu1CzPX6SN9P4c/55V6uMzNekUyamhsLsmAS2hGF+9fFVcnYehfVpXIj3in6sz4ox6h0xnSdnvNxe+uTMtbLSmTK2vcV1xP+a0sBuZ/9SfYi1P5tj7s+4dmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721357170; c=relaxed/simple;
	bh=FtSPa5Sb//ix6+ZrbA5BG7TXdUv4TN7KDqh/xKt6Mkk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=GYB2XZ/h+022wRpG5tkDTB96rKM8c+duAPHo7x40hs3f7huKcYZ6Ts3YPt4XlaAb9/qsm6XzGHY2ahYkUbil/ufrw/m+zDAeGGu+cyshxn7MFbo3xceA1fah3RTrBBnYy1YZboBK/ZnDcTyoudLJxSrgn6XTrEU6M+3IQhniJI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=k+LiWoYx; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721357160; bh=iOCowDgZxoILXLZxq7BswaTpbXcSpCLKjEQSmRIoV00=;
	h=From:To:Cc:Subject:Date;
	b=k+LiWoYxM0PAIHxMrJGPVXXg+O19VcjFzq+tYmm7CUdFyaMN1jo91abfYOiL+zTFj
	 woG7UGhL+avpAFYHu4t4iOBy6vZimhaxFvVSPMZ3rd5bliaMXuV/Wt9KT685eSb+8q
	 ARkPt4i7D6S4QRFRmRDxuEoCPXIhCq3PirpjZ/VA=
Received: from localhost.localdomain ([123.150.8.42])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 9F62F8E9; Fri, 19 Jul 2024 10:39:54 +0800
X-QQ-mid: xmsmtpt1721356794t42w71cxe
Message-ID: <tencent_9E711ED0F5A07CEDABFDD0D9856693648609@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9gMmYYRtKNN71spxflPzm9xGeMai2tBotbB2DVFYqM97t0mufxL
	 SJgfKDI+PrV0gMguLfUaMBUKxZtyWIil52b6FcEc0A2pJOFFAG2zkOmmLx38VEQSUy6COS467J98
	 Y7VnkwSDtPvTQO9a++qQ/wfyUmanEpO6/UTxT89u5bW7ZSqAInVEBGjgdnDMv31CLDmjNI2ZpT/B
	 ZwFNlam9dRhcJEe8vAuM6n9IybU9OICSlS4XVro2kr78/f3lEfAmyUFrGyzET/K2OVPtoF3u/p3m
	 vEnirDjpoOkxjElBe73RwzraOtZM2BYafCkm1t2kmIFE3CFE0nlDf7lfHqgEkJPD5hy/Km9DF+0o
	 o4cZhr0J2Y3dhpLkNGt6XceOolVj8dtsjXZ9tjsGhX0id2aOgZ1wpPyQ7iNf+yVMb4OU+yJ+diFo
	 IApPIaRWR+LZPX8XHvSeJFbsBlJCyLmHTTqIMk1I8FcPfuBdavGZw9IX3zkNORU6x0DptOLMJY8m
	 XNG2gYXtmg3FJJjN8GG0i90VWIN6R5twgKPJC7XQurS6cDTwdXRqc18Bu2vNrGaAHwKzALSo5UxE
	 3ccZYJYJy9xtYnwWriF5A9GPxTH/7E6jwoGuhyOWXJ3rk8LJ16bS+elRShH296e+BWW53b2GID5o
	 29DnmJqAHEe+k1lwrRnEJeef5zIhs/IjUSOYB2Z39WouQKo8zLnuCwkMrExnBsJzoSet4oMrfRxW
	 MD142tmgPvjlibpz0VST+R+sgtgN2JatTEyNfVTxm4IwsBu89qw6E4iLmcyJ78XvcncbBb/uGcPS
	 O3ggAW7HBPpo6dH3tyoys2a4pbPBNTNsaejHC8R8Bze+/IP2hHka9S478c3nov1ZtuE3oKPIy4Ug
	 8sb9xmHjNWyEpHeQUqyoeAIhsEc+vktO1f2QQxFD8XBA9LAQByc2gDgy3s/JP1viNvK5zXQgYY/m
	 Vesg+1B006W5T3bGFOZr5gCCIu94R1dVlebxboc42ptDnT0CWKsw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: 597607025@qq.com
To: linux-nfs@vger.kernel.org
Cc: Zhang Yaqi <zhangyaqi@kylinos.cn>
Subject: [PATCH V2] tests/nsm_client: Fix nsm_client compile warnings
Date: Fri, 19 Jul 2024 10:39:42 +0800
X-OQ-MSGID: <20240719023942.46472-1-597607025@qq.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yaqi <zhangyaqi@kylinos.cn>

when  compiling after make
cd tests/nsm_client
make nsm_client
then it shows:

nsm_client.c: In function hex2bin:
nsm_client.c:104:24: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
nsm_client.c: In function bin2hex:
nsm_client.c:122:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]

Signed-off-by: Zhang Yaqi <zhangyaqi@kylinos.cn>
---
 tests/nsm_client/nsm_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nsm_client/nsm_client.c b/tests/nsm_client/nsm_client.c
index 8dc05917..d34be1b2 100644
--- a/tests/nsm_client/nsm_client.c
+++ b/tests/nsm_client/nsm_client.c
@@ -98,7 +98,7 @@ usage(char *program)
 static int
 hex2bin(char *dst, size_t dstlen, char *src)
 {
-	int i;
+	size_t i;
 	unsigned int tmp;
 
 	for (i = 0; *src && i < dstlen; i++) {
@@ -117,7 +117,7 @@ hex2bin(char *dst, size_t dstlen, char *src)
 static void
 bin2hex(char *dst, char *src, size_t srclen)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < srclen; i++)
 		dst += sprintf(dst, "%02x", 0xff & src[i]);
-- 
2.27.0


