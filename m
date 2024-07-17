Return-Path: <linux-nfs+bounces-4959-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD34933570
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 04:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A36282927
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 02:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41373469D;
	Wed, 17 Jul 2024 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HG1TN3Se"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478234C99
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jul 2024 02:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721183302; cv=none; b=SHeYWzSP6flKImLFs0XJX7VAmoV5fVw0lr9r1kb4jtrmyJECei+YcYcEX4IPX+W/9rSAtaxnChlbDUIruzMxs2VoevBFi8LNFnIc8SLdjWbDp3mepCK2L0NLB63j5wAqL0P1cOGLuum0dC1b6QIJ+qeGd8lt9Yqf3s07k2n18Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721183302; c=relaxed/simple;
	bh=jDuQ2/JGgFUTftUeOi3OhcScBUst85koeCjDXq4MHQI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ZnCMNHoMbMbLSEjjm1cX4QL3GBI1gxjyFi0vkZD42JPj/KGFriMYNHvT4imP9CmHXZbuNuMXs985XH5CkB16NU4vGYXg3dTq1EJarWewCc16UX6mqQ9I2nuZMXC06GEy4qw1z8buk7VTTmKZgVqstu0K3NdTDboX/JzIZd3lolc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HG1TN3Se; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721183289; bh=pirgFiecSv05H24ZNtrHCkO4UcUYxwHSjiqbR6wRIO4=;
	h=From:To:Cc:Subject:Date;
	b=HG1TN3SegRnCJwO2eRumpcn/KMDybx56rF+cIDjn1p158Xj9nitdAs+NSDHzWlS+E
	 /pHOUL8Jhxc11KdAX4c7PUDv/7nSdSKm1kfxZDIcqRJglqc47FTP+o3QKGCzS58Tfn
	 IKRFaCsw3JnkQWsu1oZBUfSpfXeFRXzQZY6msyG4=
Received: from localhost.localdomain ([123.150.8.42])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 6B60B833; Wed, 17 Jul 2024 10:26:54 +0800
X-QQ-mid: xmsmtpt1721183214t2rmke7m2
Message-ID: <tencent_DB960C1E4E3B7A2A549B3D95DF223BDAEC06@qq.com>
X-QQ-XMAILINFO: OUUXHEo9i1ukzs8WPNiJ4QMwWu5yuHkmA10NOc6WuzVsVEBg/GjHfLbc7AN0uy
	 yFmzxu6/7xPmbypT22mIY2UTfUin8PU8lgIt3dGDoW1Q1AhKr+f6nJA0na8gn1tMuQnXocgtkH3F
	 cWDHgKaILVsKnbbQXI4yo++Hlr6+w1WEDoj4id4pBen3fSG6paHuI1tFqMHcSkDxhxKeG2cJ1IV5
	 +RoOEhq7+Ke7BwA2Ax3o+ufmUn3rq/aiFhOSVTexAGK5GTphCdXagFMPwxFMKcSaiSXlVv6N/npT
	 mXrghJ5G8oXKCqafrjJcUuHygbNJFk43VkL9ULfIPy6l9f1RRi4hkMqGfudIfubcPbMf2lFLDtmv
	 Ol8NV7xLzFoZl+fy2l450Fqm72yRGA/9PfhsXAdV0HjVV0YdYAK7iBHw+nwHDCd6X+PKAFwgA58s
	 LnvB+C+TeMQ0U+BH9qglci0KsoMuic084VbnJjbPXV9VodOUUVE0oNe0r20Ikr0DEXx+U/cXmP29
	 vk58ALbSkUuIX2wcZLrr6HgBN8AMw3Jj0pKpyNmvcRmlRUx2QwG+ySCKBZpAHwBNMmFbBPK1W6tM
	 bzb+km/dawSMmABYfvxtaCLVrdbGYf/fo1dQuJaYnDIYjWBVzwNZvkdkjr2aYD4sQ7s7nlhhlOgS
	 KHK2CsehaTxaX0nKAOrgzrhrPsKaRmhpuLQsDSMqXbHhsfJr4VCC4pR+sqqoGdg6LQtrC56yf5o7
	 uM7629o8DiVw8mRqjPAP0Oa/WME7cRkHqyyOmRvDUVOYN1tz3HCI3XDfvTvqhasp3xvk+u9vGRlc
	 CnZZ/Uk0XsuS2hv8uxq88rk3akEU15piZPSJuMA2Vcb0S6lKGKVqD6I6yo1N/5bUMhl/FnlziRBP
	 m6czUq86QmOi22GbJnIkd/hPKRvICQePnaia8/JRVcbHt2EdhZmu5MfCLbp6mZX+NrK+5NOSbt0H
	 F+m/Li60nMjKUVSHwJTUrYAl3DqEELle697lkVgdr1181q/5EooNg+BccPpmdx
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: 597607025@qq.com
To: linux-nfs@vger.kernel.org
Cc: Zhang Yaqi <zhangyaqi@kylinos.cn>
Subject: [PATCH] tests/nsm_client: Fix nsm_client compile warnings 
Date: Wed, 17 Jul 2024 10:26:41 +0800
X-OQ-MSGID: <20240717022641.42982-1-597607025@qq.com>
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
  for (i = 0; *src && i < dstlen; i++) {
                        ^
nsm_client.c: In function bin2hex:
nsm_client.c:122:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  for (i = 0; i < srclen; i++)

Signed-off-by: Zhang Yaqi <zhangyaqi@kylinos.cn>
---
 tests/nsm_client/nsm_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nsm_client/nsm_client.c b/tests/nsm_client/nsm_client.c
index 8dc05917..67b593fa 100644
--- a/tests/nsm_client/nsm_client.c
+++ b/tests/nsm_client/nsm_client.c
@@ -101,7 +101,7 @@ hex2bin(char *dst, size_t dstlen, char *src)
 	int i;
 	unsigned int tmp;
 
-	for (i = 0; *src && i < dstlen; i++) {
+	for (i = 0; *src && (size_t)i < dstlen; i++) {
 		if (sscanf(src, "%2x", &tmp) != 1)
 			return 0;
 		dst[i] = tmp;
@@ -119,7 +119,7 @@ bin2hex(char *dst, char *src, size_t srclen)
 {
 	int i;
 
-	for (i = 0; i < srclen; i++)
+	for (i = 0; (size_t)i < srclen; i++)
 		dst += sprintf(dst, "%02x", 0xff & src[i]);
 }
 
-- 
2.27.0


