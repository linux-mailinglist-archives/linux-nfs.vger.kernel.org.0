Return-Path: <linux-nfs+bounces-11037-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3E3A7F33E
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 05:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C3317928F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 03:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631625F7A7;
	Tue,  8 Apr 2025 03:34:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC025F7AA;
	Tue,  8 Apr 2025 03:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744083264; cv=none; b=Ap32mKi9gzuW/tMfCgoa7MNJr/ZCmnDkIcE4Q5cSVrdOGnAdNteKsn0a6uTGL0hE4rLqcRbtY3sUxxp3yfyc/8SV9GJu0g9/Nt6A5sSnCCvNpGma1KQRafmIIgCuNje9dP3KDCoUMkgok6GBZVBRu3dVVl3BV4jlhtLR1QbnlWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744083264; c=relaxed/simple;
	bh=OPfZ2nM6pi8vS7FSQbfP0uRktjyXcE3cK0Pmr5vN78I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SysbtVpDJBy2a8NBC0t2FyaKHTBmD4Ee8+vHvGH8f61yGMrNC24OjEhkpQkaEBvhsAt3Fxq8wepQoU137Bs3ocrosFUvP32q9xCgz3pFQ5mak/C6mNOHWSYco9z+Xz2nCsTJAeMvRjNUtgn4oUqHMWetiBxo2A+sRaheQR6IvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZWrlk5NH7z1d16C;
	Tue,  8 Apr 2025 11:14:26 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CF4171800D1;
	Tue,  8 Apr 2025 11:15:05 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 8 Apr
 2025 11:15:04 +0800
From: Wang Zhaolong <wangzhaolong1@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <rdunlap@infradead.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wangzhaolong1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH V2] NFS: Fix shift-out-of-bounds UBSAN warning with negative retrans
Date: Tue, 8 Apr 2025 11:15:04 +0800
Message-ID: <20250408031504.2549173-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500010.china.huawei.com (7.202.181.71)

The previous commit c09f11ef3595 ("NFS: fs_context: validate UDP retrans
to prevent shift out-of-bounds") added a check to prevent shift values
that are too large, but it fails to account for negative retrans values.
When data->retrans is negative, the condition `data->retrans >= 64` is
skipped, allowing negative values to be copied to context->retrans,
which is unsigned. This results in a large positive number that can
trigger the original UBSAN issue[1].

This issue has actually been present since very early kernels (dating
back to 2.6.x series), as the code has historically not validated
retrans values from userspace. When these large or negative values are
later used as unsigned in bit shift operations, they cause the UBSAN
warning.

This patch modifies the check to explicitly handle both negative values
and values that are too large, completing the fix that was partially
implemented by c09f11ef3595.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219988
Fixes: c09f11ef3595 ("NFS: fs_context: validate UDP retrans to prevent shift out-of-bounds")
Signed-off-by: Wang Zhaolong <wangzhaolong1@huawei.com>
---
 fs/nfs/fs_context.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 13f71ca8c974..0703ac0349cb 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1161,11 +1161,12 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
 		 * for proto == XPRT_TRANSPORT_UDP, which is what uses
 		 * to_exponential, implying shift: limit the shift value
 		 * to BITS_PER_LONG (majortimeo is unsigned long)
 		 */
 		if (!(data->flags & NFS_MOUNT_TCP)) /* this will be UDP */
-			if (data->retrans >= 64) /* shift value is too large */
+			/* Reject invalid retrans values (negative or too large) */
+			if (data->retrans < 0 || data->retrans >= 64)
 				goto out_invalid_data;
 
 		/*
 		 * Translate to nfs_fs_context, which nfs_fill_super
 		 * can deal with.
-- 
2.34.3


