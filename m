Return-Path: <linux-nfs+bounces-12617-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248B4AE2DE6
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Jun 2025 03:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69E01895B21
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Jun 2025 01:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D92C72636;
	Sun, 22 Jun 2025 01:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="aO4YTWV9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D14690
	for <linux-nfs@vger.kernel.org>; Sun, 22 Jun 2025 01:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750557145; cv=none; b=alzlsGUwkihKr0+Q70Gb3sD7JM/ZCUTmj4Ac6Tzrj2awIY7hiimbApP/Aoc0ZApkEc4b/SUjJY+SttZwJDBUTKMlWcEhTyaf8xmKMLR01JHp8i618MokHa9/aLMWPjeVE8HCxaL5f2SuFbxMyA3OkEwkoRgQ8zI7D8NXHNVuo5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750557145; c=relaxed/simple;
	bh=po/OOME6mK9NOWKAcSmyxaGFA/UXxoi5+XVhycn+6og=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=O768FF9w+xV9/bFeXtPTOXk0FWkPaoL8j6SCSzuc1ZnblMs24v9OdyrzTcd4PIVrZjQkrY73CpARDwexbMMLRQQhSmpEfL63AtVVEH8L8OcwFltavGqtQ/iATL4haJKE79EywTVWWjXadV6Lw0JRCJcvv83T3TQVwrNU7zvmAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=aO4YTWV9; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1750556832; bh=1jQ4mIPwq/GXOAmPlaCI5u3Gkyign6StH6TULhfaEz4=;
	h=From:To:Cc:Subject:Date;
	b=aO4YTWV9loVGUFhxQv7/X7fA1Dd7bG/E/iegkRdQJ7NFxVplWnvLRJxXS82ZRMMlY
	 JTRWgvFjH/P9do7txO7tIg/SnS9/Kw4hTd3tZOUYm1kG3loU71ifJ0j0WmKg/G70fo
	 TGBA4AQkfCkAPrkFfEna48e0O7FwVU1SMxKLZsVo=
Received: from localhost.localdomain ([115.60.177.141])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id BCB83E0C; Sun, 22 Jun 2025 09:47:11 +0800
X-QQ-mid: xmsmtpt1750556831t350pw00a
Message-ID: <tencent_0350F1F6857E40ECA3B324321D3805E8A008@qq.com>
X-QQ-XMAILINFO: MVKy59SpMLfUTqEQ0xa4F7k+oQEQiQdafeaRPuh+2NTE0AQeqP1e6VEGXF6n04
	 2t+ttXTTNmsgouupdyQV6EJCUFnKIsDfdXGNMlSbKTmwrhQL5xaX9/RdEd1XS9ri6Plf+v0pboRo
	 iwYPqTsm4PpS5sw2TWeP/hwYieg5+SeXDKOWFG5aTxCnUiPZ+idF6vQZIBj+Dwnzxw9mAP92kQOB
	 xXy/qa9VGKWO1UkE5bduNmESCiJKTwoqJl/FZ6B2uUvp8Q8HzIOnSVEQG5YyaJnbqh2+SJM/qmI/
	 OLyJWUEdiq3rACOlFjHHph4lV6k/SnCopHHDyDjVnOwp2AcE7ufPC6ikYEZr5bUOIue53IoWylgB
	 +bmctbCZ2Rp6olsboA8lUGL8VSky0P7F6w8QWXp/INr0CDBHckBxXn8K2E5jeh7CRjbM95h/s2mD
	 5Er3aZJQlwH8LcIifWruLzhqi95MXS1rqOcBoxEfEKYVJlAYShW2E3LFXbW3hUNSKAN7oIup8oER
	 UaHR7XC/hKzGAS61OEGfz1MTF8cR7CgRYpp0OYWZxT6pbqPENS1eRPJLQVz+xivG24/Lo9pjea0F
	 /l9EI5wsSVx4yxlf51pBrN3rKdZo1vyr8s86S9Ut5yqxeHM11jKOIVq5M5efR4URn6+rDZ9omNBa
	 VQegLMpcG2rScPvrbCNhnqMGhtDPjNIm128eHyh4csGwupHeAvA7CukF0qYjFA0vZy6aswvSoBnD
	 E1bcjw3HvA5l4NakqlsrfLazR+TIJHFhnvULVwjbCRAnQ3H/U2jRPf2x0hgYet/2MkQ8X48POuQG
	 zneno6nTGT7LOPzrdrwGfc/9RWYsPKA7BtmkvFdhmtufI65bRO49RoeAxhGZZ79+kNmQqdZtQ5ac
	 XV2fBjsYuIhQhD7L2m6rTLr7IgyQ0IKB/Oy1ON+4rpcJt+5b2HeAQ=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: 597607025@qq.com
To: linux-nfs@vger.kernel.org
Cc: zhangyaqi@kylinos.cn
Subject: [PATCH] nfsdctl:Fix skip unsupported address families in socket activation
Date: Thu, 12 Jun 2025 00:35:43 +0800
X-OQ-MSGID: <20250611163543.8019-1-597607025@qq.com>
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
 utils/nfsdctl/nfsdctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index e7a0e124..bb372c0b 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1084,7 +1084,8 @@ static int update_listeners(const char *str)
 				    memcmp(&r6->sin6_addr, &l6->sin6_addr, sizeof(l6->sin6_addr)))
 					continue;
 			default:
-
+				xlog(L_ERROR, "Unsupported address family for %d", sock->ss.ss_family);
+				continue;
 			}
 			sock->active = (sign == '+');
 			found = true;
-- 
2.27.0


