Return-Path: <linux-nfs+bounces-11516-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 418FAAAC7D0
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF89462348
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B2F27FB2F;
	Tue,  6 May 2025 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Xy/7w8jR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1401C1A9B5B
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541455; cv=none; b=cZOz7F+NJLRa8Cn8GF7O5cYb+ExcTQ0GASe6tfmS7XZrHTUV2gHsoBBpXUY8Xma/UZiAGT+dJhjPXw4VrmU5WS1JpFr+XcDuMwcqCnMyzuG1kdwhaQe5mP17BZPuZeiuX/3/ES9VpaGIgCbl5/+2MTl0VlJ0qDcrN2DCFXwT8lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541455; c=relaxed/simple;
	bh=YH0pp7xcsev6MKyTamDozGymR2GfAkED7nYW/37/hIM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=jKIS9jc6B0e7iCrTqrkHKL0S8HjD83/hvvd5EJOgkVZBBXI5SuGZ9hnMyZAax1633i/Q8+owtbr0VgV0wYVmf82HUceqNR8GCVw9dZrN9Bul4C6sNwQhJBzMBg+22gurxFhLDhpNt8tMUqHeCs+k4DJmdtp+3XjMn6g0D64WEgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Xy/7w8jR; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1746541139; bh=5v04AZ2TtxIffc1jiqe3kUu1qgrpQB8oPCLtS8ZkItA=;
	h=From:To:Cc:Subject:Date;
	b=Xy/7w8jRttbA1m4qojt7mSl/UcQWz7NCHsQLpO0C+xPOvB5nLufIok0kV+eJ4lf+V
	 B3TKjpt3Z6OZw99+WSg65MqncezygQNq14y6OPJGGqCSNp+tzr2nnORmCAkOHF1P8C
	 +2130hlXO/YyJqrxFXVl80oJkqFSQgAE1u9RfehE=
Received: from localhost.localdomain ([115.60.183.182])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 4BA2DC30; Tue, 06 May 2025 22:18:58 +0800
X-QQ-mid: xmsmtpt1746541138tlmkwcss8
Message-ID: <tencent_86CDAF841D6F5657A618E706DD1CAAD95E05@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/gMPwy6PT9tKusv7N/hf0p/j5yKuNwNyZbLUhA2RK6Sh4JK9R1z
	 DQvR7gzwzESppotpHQF/TtbNR5HZDCcjo2bDPryrXklnNLpdEZQtrshO3gP025KRJdYr2XPW/gfq
	 aZyEY0djwBfwtigSyzdobuOxeTOwzjNf6Vv1+zYCZhLeAEn8a9myf81vOVpMVY0zIHnqVYVCx17q
	 dBs9lGVo07k3g8w+M90AI3diJsvMxRgkhrJZqB+9dO05xF58ZZWjVcfut3qy5W2A1JoJgP10kwhz
	 j3g4+LEZQ8FHmo4e6IpLubXXldlgtdowUgCdLD0pcAEgk4+C0Z6mXzEbKdF8vIcNR2blhHd1DAiw
	 +I/Ycnwi+qhZPxDrdJexwPAWSsfLXLQPb55eDKPPGxa6nnIalrr3soiK/PvIL5KvmmGS9F333aTI
	 Se6tZKTKGlo74PhK84rlLMTKCJtcLk1mTzb0zSKUmsR7fwJGbQlH8jMGzutogqMM7E5+J1uQx1xf
	 A7kflkSx/hZ6s+1T65UXmxWfNgfk5aCbbGuML9ZoSlOWf8UbTCjgW50e6Jfv6wQ8dOM42OnlQa++
	 QZXk731YkmdDyX+LcmW/5LgbCfeOxG97NYCeBgT6Z01Gmcg5LyrNRrEv8vj4TgSJJULMUhJ7gxMl
	 YltqrC8qGm0PmU1DQQ8rPYw/7PaS+/s6N9VclNt1YqNMZiDYtYjbylhI13qL3I/CGbX44RiKO/Mt
	 pDhof09MNGS5REW52xzGExAx1j7O+yQ9lBKR0IC+Hco6jn2v4EThC2y4ioEbvbUl/Puzo54hIh5p
	 AdWxYOsVJHmczvMz4aNFfgerFnRqBElsUeL1NYErsbmccPBvKRLpsqL52d//Y7Qt9077iklZs8Lw
	 XRcNqoEbAB01ajuPtBBW4XtYf2CmU0diDEXAIRCHKJwkCjRUReyJQ=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: 597607025@qq.com
To: linux-nfs@vger.kernel.org
Cc: zhangyaqi@kylinos.cn
Subject: [PATCH] gssd:fix the possible buffer overflow in get_full_hostname
Date: Tue,  6 May 2025 22:17:50 +0800
X-OQ-MSGID: <20250506141750.32879-1-597607025@qq.com>
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
 utils/gssd/krb5_util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 560e8be1..09625fb9 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -619,6 +619,7 @@ get_full_hostname(const char *inhost, char *outhost, int outhostlen)
 		goto out;
 	}
 	strncpy(outhost, addrs->ai_canonname, outhostlen);
+	outhost[outhostlen - 1] = '\0';
 	nfs_freeaddrinfo(addrs);
 	for (c = outhost; *c != '\0'; c++)
 	    *c = tolower(*c);
-- 
2.27.0


