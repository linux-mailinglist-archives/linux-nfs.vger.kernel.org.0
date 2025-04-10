Return-Path: <linux-nfs+bounces-11080-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7BCA83B84
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 09:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1CF91892E42
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 07:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E7F1EE7DC;
	Thu, 10 Apr 2025 07:42:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC361E3DED;
	Thu, 10 Apr 2025 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270934; cv=none; b=JDwJeGEHrdQolSS04/FEQCLqTX4Ruav2wg1HC++yoHsBWvcgixeNAsJNuKBJCoy8G/A3hY/2fegzYn41e8sGAuzmkHbF/kLdq6VoacmlWd5Tf0OWd6aHY0pVOM0FIudPBdJp++v92+SL5j9uwsAXi/I42YMmiGd2SZUB5rR2Hmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270934; c=relaxed/simple;
	bh=LL98xKCN6BbyHGkK69YR/3hlThS2vvREo71YnuLBImA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D3kaG95KJHkNs3K9YTgoMp7+id5jIgVki1jS7laYAQz8vxepPGAvPbu+5eiko4MFCub9da51a2u7AQA279xpBO72pX3o6tp0Ta+toGBy/rdPHmgKKspnvX2wpLuwR7ROmUZO8z6hIx+FU5eXFnx0WGL0zVoi1ngRhRgafFGU4ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZYBZm4WwCz1d1K3;
	Thu, 10 Apr 2025 15:41:20 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 87307180473;
	Thu, 10 Apr 2025 15:42:02 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Apr
 2025 15:42:01 +0800
From: Wang Zhaolong <wangzhaolong1@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <rdunlap@infradead.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH RFC] nfs: Fix shift-out-of-bounds UBSAN warning with negative retrans
Date: Thu, 10 Apr 2025 15:35:25 +0800
Message-ID: <20250410073525.1982010-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500010.china.huawei.com (7.202.181.71)

The previous commit c09f11ef3595 ("NFS: fs_context: validate UDP retrans
to prevent shift out-of-bounds") attempted to address UBSAN warnings by
validating retrans values, but had two key limitations[1]:

1. It only handled binary mount options, not validating string options
2. It failed to account for negative retrans values, which bypass the
   check `data->retrans >= 64` but then get converted to large positive
   numbers when assigned to unsigned context->retrans

When these large numbers are later used as shift amounts in
xprt_calc_majortimeo(), they trigger the UBSAN shift-out-of-bounds
warning. This issue has existed since early kernel versions (2.6.x series)
as the code historically lacks proper validation of retrans values from
userspace.

As the NFS maintainer has previously indicated that fixes to
xprt_calc_majortimeo() wouldn't be accepted for this issue, this patch
takes the approach of properly validating input parameters instead:

This patch:
- Adds a proper validation check in nfs_validate_transport_protocol(),
  which is a common code path for all mount methods (binary or string)
- Defines a reasonable upper limit (15) that is still generous for
  real-world requirements while preventing undefined behavior
- Provides a clearer error message to users when rejecting values
- Removes the incomplete check from the binary mount path

By validating the retrans parameter in a common code path, we ensure
all mount operations have consistent behavior regardless of how the
mount options are provided to the kernel.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219988
[2] https://lore.kernel.org/all/5850f8a65c59436b607c9d1ac088402d14873577.camel@hammerspace.com/#t

Fixes: c09f11ef3595 ("NFS: fs_context: validate UDP retrans to prevent shift out-of-bounds")
Signed-off-by: Wang Zhaolong <wangzhaolong1@huawei.com>
---
 fs/nfs/fs_context.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 13f71ca8c974..cb3683d5d37f 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -33,10 +33,11 @@
 #else
 #define NFS_DEFAULT_VERSION 2
 #endif
 
 #define NFS_MAX_CONNECTIONS 16
+#define NFS_MAX_UDP_RETRANS 15
 
 enum nfs_param {
 	Opt_ac,
 	Opt_acdirmax,
 	Opt_acdirmin,
@@ -358,10 +359,19 @@ static int nfs_validate_transport_protocol(struct fs_context *fc,
 {
 	switch (ctx->nfs_server.protocol) {
 	case XPRT_TRANSPORT_UDP:
 		if (nfs_server_transport_udp_invalid(ctx))
 			goto out_invalid_transport_udp;
+		/*
+		 * For UDP transport, retrans is used as a shift value in
+		 * xprt_calc_majortimeo(). To prevent shift-out-of-bounds
+		 * and overflow, limit it to 15 bits which is a reasonable
+		 * upper limit for any real-world scenario (typical values
+		 * are 3-5).
+		 */
+		if (ctx->retrans > NFS_MAX_UDP_RETRANS)
+			goto out_invalid_udp_retrans;
 		break;
 	case XPRT_TRANSPORT_TCP:
 	case XPRT_TRANSPORT_RDMA:
 		break;
 	default:
@@ -378,10 +388,13 @@ static int nfs_validate_transport_protocol(struct fs_context *fc,
 	}
 
 	return 0;
 out_invalid_transport_udp:
 	return nfs_invalf(fc, "NFS: Unsupported transport protocol udp");
+out_invalid_udp_retrans:
+	return nfs_invalf(fc, "NFS: UDP protocol requires retrans <= %d (got %d)",
+			  NFS_MAX_UDP_RETRANS, ctx->retrans);
 out_invalid_xprtsec_policy:
 	return nfs_invalf(fc, "NFS: Transport does not support xprtsec");
 }
 
 /*
@@ -1155,19 +1168,10 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
 		memcpy(mntfh->data, data->root.data, mntfh->size);
 		if (mntfh->size < sizeof(mntfh->data))
 			memset(mntfh->data + mntfh->size, 0,
 			       sizeof(mntfh->data) - mntfh->size);
 
-		/*
-		 * for proto == XPRT_TRANSPORT_UDP, which is what uses
-		 * to_exponential, implying shift: limit the shift value
-		 * to BITS_PER_LONG (majortimeo is unsigned long)
-		 */
-		if (!(data->flags & NFS_MOUNT_TCP)) /* this will be UDP */
-			if (data->retrans >= 64) /* shift value is too large */
-				goto out_invalid_data;
-
 		/*
 		 * Translate to nfs_fs_context, which nfs_fill_super
 		 * can deal with.
 		 */
 		ctx->flags	= data->flags & NFS_MOUNT_FLAGMASK;
@@ -1270,13 +1274,10 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
 out_no_address:
 	return nfs_invalf(fc, "NFS: mount program didn't pass remote address");
 
 out_invalid_fh:
 	return nfs_invalf(fc, "NFS: invalid root filehandle");
-
-out_invalid_data:
-	return nfs_invalf(fc, "NFS: invalid binary mount data");
 }
 
 #if IS_ENABLED(CONFIG_NFS_V4)
 struct compat_nfs_string {
 	compat_uint_t len;
-- 
2.39.2


