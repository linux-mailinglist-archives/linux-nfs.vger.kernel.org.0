Return-Path: <linux-nfs+bounces-4958-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7614933540
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 04:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3A31F22B7E
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 02:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F10ED8;
	Wed, 17 Jul 2024 02:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="s8qeoV72"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85801749C
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jul 2024 02:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721181829; cv=none; b=fCcIdGSYh2aybYRcfW9pze2GNeaTu+dcasfNHyX9fcsP83BwamCGcCNR0N7/SaiY/p8OHDp8VMCqg7vEXODZRJNFvyO1VsgNzMdE5ptjdb8rDy6K63VBntFARgiHXwJbg6PQzWT1iCl6WnD7Y6KDX24oTx5KFbPut+JidCoEm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721181829; c=relaxed/simple;
	bh=E3HyFyTNw/TyCtWqmiCHaanIiuKclvmC1/LI8ttAwOY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=h9MlC0k4/zk464j/XQlwHk2OUNwg/QvBH9Ls70uucmOnjnx+xZVnBFe9OmGNU+MOgD1SCmjv2bMhG7xsIUUMtsODM8VdY0jYHOXCLFU99zR9n4FWHX8pNUhacvQjeQQ6DDfR7cybW0bmyo2x2R9aMiREb5EvzP76ewowpoW/MzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=s8qeoV72; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721181518; bh=Y7sYY4dhYDTnGVwiN6MTL3KlcnW7yEjnpiwyBbkQyTA=;
	h=From:To:Cc:Subject:Date;
	b=s8qeoV72JOYxT2EeBeRAK/TvQaKL2vM5BcmReXhDq2fM33gUMX95iBciyVAb/wbSA
	 TcVVHmyWoAt9QpHuf7AZLI6Rq94cne5+46C76fFiwprPkPwSKPFeGCLtf7Qu84sXF0
	 ABY3QTnZla209GpkMDU2ADTN2SRYH3RMNZQg/xu4=
Received: from localhost.localdomain ([123.150.8.42])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id EA48C8AC; Wed, 17 Jul 2024 09:58:36 +0800
X-QQ-mid: xmsmtpt1721181516tw3ss803o
Message-ID: <tencent_A858F696592599629C0E743528247B763F07@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uTvYm/QMfwMHW+YRCUsLBrl8OIlKfX9LF9kYjU48o16YzBJaWx6M
	 Th9xQrHIY4wI+V+7S+nw2qqN+jrxipirhznUnyCW4GW/0xEbvXbL2buoFz11rV3aN33/kYj1rkFy
	 Uo+lMGNN8ri0p6fiIXH75ZN/9Il/eaLAS1XwvKWVmrCKZMvBqGee8rF7tV7vJNEzNAEi6oADOMcg
	 oiJwKmAaYFmUZ0OjaBIDFJKWdjM4X08VYZHNQRTv3qSHcTTY2IqRVLtN23I/VDEHI1mlQqk95Rnl
	 KDqxkgbPTcvWaCE81C8/0gBQPdMXDtmjg1M11rMJepG9LZUvaZ2NPoKK6fGLQLdfjlhYwl2Y2LCw
	 m49uFo68/Tcr+lHvC8urL9KQzCVgANwg/ZMyPF7itB5hZFD5R0Sw4Vfs28oR2zu1/TszdvIg2lVQ
	 9zoDe18dhQHSJDoiiRe+TNcpZFGXisoJy7Pm/8g/0aZvuFjTpF8L8mQic2+5EhIIMgPUt79lKu9q
	 hviq4e1T3A9P7vP3AaTk26CPxSKveOx0+wQgVVOq/PXMUGetWlng1C87XrT6u06BelOi6uIJ1IHn
	 oiSdHH9VRFirntxgvNYjOciwX59h524eP5Y+Bu+d+Sbt8nfPlg+Du7+Sz5OHybgFA2b9ESgrdrZU
	 hBaC6I2eTbS/qhztPbYkI9UIx69978p8o6XtVzpr+kD0LfAcsmSCZMiJVdbYxVxMizOtJETwW9bn
	 qdEpPjHuT7zeu6236R88oQqiu5xG1twUYmU1LF87EtaQZbtSmc5uk4lYHFnKXhJqOz1WRMG5aVQ7
	 BT+dIadaxBGiDqvUT437Ayje+oSxc/a6bk88PD6cfI8mX6S7dkgREzX9BRuh3yu05gs/PiL5TXNo
	 raG24llI8tJl93KalN6x6kxnnFlqUfoq9xhLC7mbkL
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: 597607025@qq.com
To: linux-nfs@vger.kernel.org
Cc: Zhang Yaqi <zhangyaqi@kylinos.cn>
Subject: [PATCH] tests/nsm_client: Fix nsm_client compile warnings
Date: Wed, 17 Jul 2024 09:58:18 +0800
X-OQ-MSGID: <20240717015818.42771-1-597607025@qq.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

From: Zhang Yaqi <zhangyaqi@kylinos.cn>

when compiling after make
cd tests/nsm_client
make nsm_client
then it shows:
nsm_client.c: In function ‘hex2bin’:
nsm_client.c:104:24: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  for (i = 0; *src && i < dstlen; i++) {
                        ^
nsm_client.c: In function ‘bin2hex’:
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


