Return-Path: <linux-nfs+bounces-11022-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80598A7E01C
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 15:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736BD1896023
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 13:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B051BC07E;
	Mon,  7 Apr 2025 13:48:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8A19D8A0;
	Mon,  7 Apr 2025 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033737; cv=none; b=K/5QlTL5i7409cCVSHSKf4DsaP6iZsyie5pYwst5mp3V61mfOwa3Yi6zTIRFR01r54ed60HPK8BpBmlewSvkUBrZjdohRBKgSUZjruMOjFXWI3vKdOyeDvo1vHAIElSSynIWdfOrX56MJHczSqj85Bo0GBFpg2xJ9YkVBdaULcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033737; c=relaxed/simple;
	bh=DFeb1yPJZH9VmNhTkFCD3qVmWE+EwOxODBllxBF1Kpc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kwmy6tlHllHTNrwgLu3+/dJ9I1DJIeUXMeGRd8pvH3Emlnbx6Gudw1Rl4XKaXhE4AhawC08yChiNglr311dz5hoeRbqzIBZa7h9Q/QGCiVP3iVp6vbJ+aALFo/h7s8Ac9lUUP8LarJSH1OLJiVI2kRNPqDNKW/pMjM+rLj/IIA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZWVr30gC5z1R7nl;
	Mon,  7 Apr 2025 21:46:59 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C52E01A0188;
	Mon,  7 Apr 2025 21:48:51 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 7 Apr
 2025 21:48:50 +0800
From: Wang Zhaolong <wangzhaolong1@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <dhowells@redhat.com>,
	<viro@zeniv.linux.org.uk>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wangzhaolong1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH] NFS: Fix shift-out-of-bounds UBSAN warning with negative retrans
Date: Mon, 7 Apr 2025 21:48:50 +0800
Message-ID: <20250407134850.2484368-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500010.china.huawei.com (7.202.181.71)

The previous commit c09f11ef3595 ("NFS: fs_context: validate UDP retrans
to prevent shift out-of-bounds") added a check to prevent shift values
that are too large, but it fails to account for negative retrans values.
When data->retrans is negative, the condition `data->retrans >= 64` is
skipped, allowing negative values to be copied to context->retrans,
which is unsigned. This results in a large positive number that can
trigger the original UBSAN issue[1].

This patch modifies the check to explicitly handle both negative values
and values that are too large.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219988
Fixes: 9954bf92c0cd ("NFS: Move mount parameterisation bits into their own file")
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


