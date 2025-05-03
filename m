Return-Path: <linux-nfs+bounces-11389-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A805AAA7EAA
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 07:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C80C67B5E5C
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 05:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272F435957;
	Sat,  3 May 2025 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bl+n0iaI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACA131E49
	for <linux-nfs@vger.kernel.org>; Sat,  3 May 2025 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746251210; cv=none; b=qaKQADiAJx3dXv3oBB/FmaG6aAKldnB862Jpebc8dz2amc2Qc/VBYMfWDue3ORfGXnoui6FiAybrL+juuMNfm6Dr8jeZIJ7ZvF0Q7qYp4CvXWiQRvVjMIgCQ/6LZhto/G8o8x2TqZRa4KMfhGHdNz+7BqvZAd2wib3FB6OzPcgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746251210; c=relaxed/simple;
	bh=mp9PzsdyYkzZ94S3K5DyC/U2BnQ1GpoVnR/Mw7NvVSA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Pw9Lv8rc/FKqN65pjEKDebcyi53ef3GqtjfmW83XaR8OhdtI23N/d4SBKRh2V8ewzghGsqqOvYkelHNa8vco12ES9LRzJ82gmowREothXGwPV9kJkSTV25j40rYyyFJczRpxCCIxgZPxzUTGMVf767ochBinU1EL7yIXjZhUDA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bl+n0iaI; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1746251202; bh=LJAEi0Unmp6vPcGBZwxaUrM+UY28t/mmBsRPGZpsSC8=;
	h=From:To:Cc:Subject:Date;
	b=bl+n0iaIDiTiH5nrKIAMcRZ5RH8NOu5CIa9LmdC338nwTn+rWN2xnU/aYYkpn+Eb7
	 N/OBBBucyoelq2mmC+v/pp/neYUQJ9H8+1DWi7H5dfyhBE53nUrEiQSfazbqmqYn72
	 1UCjTiwI5ZWBkkiN1mWx/ai7Rd57rWjRbWXHYRU0=
Received: from localhost.localdomain ([115.60.180.68])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 8903684B; Sat, 03 May 2025 13:34:16 +0800
X-QQ-mid: xmsmtpt1746250456tgbvu9vxo
Message-ID: <tencent_44C49EC60F8F9D7E3647861067115D0DEA05@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r77bbksq9NMmhgfMPjWEeHf2iOgGI3xUeCigm4aTUqwmuDG+5gZk
	 ai1qLCPsd0K0Z9u2iVoEJT+ASu8RMtmfuhVtm7eaPCBcRKzNsYHBoBZm3ryOxDc7p9zWACLVaO5F
	 X6rif65o3BsrMqXYsoJ7p00fxcE7nWxGMF7kZ6YtFIV/uIFfS2HprG+6De7fXQlBcZIlaM0Jc9d9
	 7ZZlWohW1QODFrzC7kRwO4cP2h+gpPJzNqT/rL5RrH/N+Taq7rNJFeJDAnRhX51jsuDk07caU8hM
	 KvDxAt9DLfp2jxFAnnZQrbMAdX6v9w8MGDht7oEYD5JRZMhd/WfA+uEpww0XyR05tV4hmpoQ2L4t
	 e2RFemP+lEf9bEX5m7eVNHbI3A/36/UnuDl5VXKDy1mijEBlursF8MVg9ca1s2EPhio4XCEtyJCE
	 d8SLIo0F4QnuvHckU++veFqYlCsKNAjwFVpxeNspJuPhSrTaoSvaeXSoolRF6YPlpMMJ1HeLhilS
	 OOYR8ct+lbw5lvvFgFgj1kS5htbin/b7njJmCSyRqGUrMsNpcbDV/iB0athzQc8vyhqzyK6uffu2
	 DLfErL2tMwxtPegRbBaDBWSLpG5gFpz+DATU84vkXXKRfBYmTn6SXEtOLf2xcKbuHYzUgRuF/JJR
	 Kzy7TTTvTc1V/ek4u3oeKzcLF0y6A+/Is2jAp3BGi68WlTY8pNqBcWwbqKGkGZz/XlVs5jUipdEq
	 2HBHuAuTTnOgAe0xjqbEL/dOhuOYLsZRrfHh2u+awwZCgJAdcsmFeGicbMfVTm31kRdW/Oo7RXC/
	 pN0YOQldYPZW/WYjpjY8n3QZRgRs9BxMNkANIp4A5m1ru0Md6opEqJGUBULCw6KH3R6hak8b3TXG
	 sxnL7n70uOq3RhmA2I4M6DHqUAzFp39SGzKQmn4poOOnpURasCN5clIGtN9qX345h4aGgu1M/sHD
	 OA4xPy8vE0DILYoxsINyvOpesoN5bngAfFumeyJi8=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: 597607025@qq.com
To: linux-nfs@vger.kernel.org
Cc: zhangyaqi@kylinos.cn
Subject: [PATCH] nfsdcld:Fix a memory leak
Date: Sat,  3 May 2025 13:33:09 +0800
X-OQ-MSGID: <20250503053309.14207-1-597607025@qq.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhangyaqi <zhangyaqi@kylinos.cn>

Signed-off-by: zhangyaqi <zhangyaqi@kylinos.cn>
---
 utils/nfsdcld/nfsdcld.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
index f7737d92..8551dc97 100644
--- a/utils/nfsdcld/nfsdcld.c
+++ b/utils/nfsdcld/nfsdcld.c
@@ -822,6 +822,7 @@ main(int argc, char **argv)
 	evbase = event_base_new();
 	if (evbase == NULL) {
 		fprintf(stderr, "%s: unable to allocate event base.\n", argv[0]);
+		free(progname);
 		return 1;
 	}
 	xlog_syslog(0);
-- 
2.27.0


