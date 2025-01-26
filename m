Return-Path: <linux-nfs+bounces-9623-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E3A1C735
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 10:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B0777A3E96
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 09:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1191547E9;
	Sun, 26 Jan 2025 09:33:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8812286358;
	Sun, 26 Jan 2025 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737883988; cv=none; b=KYsg9+Ci7HPaPiZyIr4hqWF4N1+XLHUDXLxio/DYTO3jEDIuViAr4+CLHXrMxYyNWP/0UL8tc6alBTJ6wdpMGowOzoPWT3aNDMol2cJDFseQ38dZ8Q9rWNp+BZyO6OYSisr4V9AnCdvfWzhHoV64DuR9I8MipdClrV/nsMzSCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737883988; c=relaxed/simple;
	bh=YgYdoATnfVz0GVRmFNHhSJHMZui04vZZ2+X8b8bDX2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6R0em16y4vF9FXXpBoY2yzoBY3Fb3L3I8reoFq34Bq1cvvhYdAJK4CFE6+bvm6PpwegPf6YwQ9ypuq8No+0vLGND3BXS1aB8YZx3zdclj0BbzvQqRbbPxo6n3c4wY4veGLlGvQLoTeV5Y5wC5zZPAnrrq5jrPOk2riMMDsWj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YgmVr4PWTz22lc0;
	Sun, 26 Jan 2025 17:30:28 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D32C1A016C;
	Sun, 26 Jan 2025 17:33:03 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 26 Jan
 2025 17:33:01 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <kolga@netapp.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <trondmy@hammerspace.com>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH 2/2] nfsd: remove the redundant mapping of nfserr_mlink
Date: Sun, 26 Jan 2025 17:50:45 +0800
Message-ID: <20250126095045.738902-3-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250126095045.738902-1-lilingfeng3@huawei.com>
References: <20250126095045.738902-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500017.china.huawei.com (7.202.181.81)

There two mappings of nfserr_mlink in nfs_errtbl.
Remove one of them.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfsd/vfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0f727010b8cb..42039cff2124 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -71,7 +71,6 @@ nfserrno (int errno)
 		{ nfserr_acces, -EACCES },
 		{ nfserr_exist, -EEXIST },
 		{ nfserr_xdev, -EXDEV },
-		{ nfserr_mlink, -EMLINK },
 		{ nfserr_nodev, -ENODEV },
 		{ nfserr_notdir, -ENOTDIR },
 		{ nfserr_isdir, -EISDIR },
-- 
2.31.1


