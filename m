Return-Path: <linux-nfs+bounces-8622-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A4F9F4517
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 08:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55959167948
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 07:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457AB18C939;
	Tue, 17 Dec 2024 07:27:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B8A192D69;
	Tue, 17 Dec 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420478; cv=none; b=Zswh2uOdghaRwgugCobKuqjzgtGNTEd6xHkSywgaQg9WdgmY/mxA/aXgrO9cjXEG2bVy3Z3Jn5dUM/zKU/U5odeI6C7QPeXe7aKJUfl7yoR8mBUoAM1moHxTuDqpLLjDgr3R4dfwjjjO4AVk448keOADUaxeGBVgvdRqrTKPz2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420478; c=relaxed/simple;
	bh=OdewV4615FId0WACNx+91iHsJ8vh/kQT1TGkcrL/w2g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EUXTvwoe+Fp3/6tcnrsmkDk2+REAHPG8dxVMK+A15/9NEVC4Yx2ljpFL0zyoXnqkFrTnHljjs90R3xPVtKSNJPjqxy7wWgttTFfv8uQ5jg/rVsQHjjHNgg8h2qPiz9iyHQb8N4kv03LSjZQPprZlvuhFzFm8tN7th5Mhl/QNmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YC7c814H8z11Mq2;
	Tue, 17 Dec 2024 15:24:40 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id A20C914034D;
	Tue, 17 Dec 2024 15:27:53 +0800 (CST)
Received: from huawei.com (10.67.175.69) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Dec
 2024 15:27:53 +0800
From: Zhang Kunbo <zhangkunbo@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chris.zjh@huawei.com>, <liaochang1@huawei.com>
Subject: [PATCH -next] fs/nfs: fix missing declaration of nfs_idmap_cache_timeout
Date: Tue, 17 Dec 2024 07:19:21 +0000
Message-ID: <20241217071921.2635013-1-zhangkunbo@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh100007.china.huawei.com (7.202.181.92)

fs/nfs/super.c should include fs/nfs/nfs4idmap.h for
declaration of nfs_idmap_cache_timeout. This fixes the sparse warning:

fs/nfs/super.c:1397:14: warning: symbol 'nfs_idmap_cache_timeout' was not declared. Should it be static?

Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
---
 fs/nfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index ae5c5e39afa0..aeb715b4a690 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -73,6 +73,7 @@
 #include "nfs.h"
 #include "netns.h"
 #include "sysfs.h"
+#include "nfs4idmap.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
-- 
2.34.1


