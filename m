Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE0179126
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2020 14:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbgCDNSW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Mar 2020 08:18:22 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39114 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387776AbgCDNSW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Mar 2020 08:18:22 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E2B5A618B0A5219B2B4F;
        Wed,  4 Mar 2020 21:18:14 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Mar 2020
 21:18:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <kolga@netapp.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] nfsd: Fix build error
Date:   Wed, 4 Mar 2020 21:18:03 +0800
Message-ID: <20200304131803.46560-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

fs/nfsd/nfs4proc.o: In function `nfsd4_do_copy':
nfs4proc.c:(.text+0x23b7): undefined reference to `nfs42_ssc_close'
fs/nfsd/nfs4proc.o: In function `nfsd4_copy':
nfs4proc.c:(.text+0x5d2a): undefined reference to `nfs_sb_deactive'
fs/nfsd/nfs4proc.o: In function `nfsd4_do_async_copy':
nfs4proc.c:(.text+0x61d5): undefined reference to `nfs42_ssc_open'
nfs4proc.c:(.text+0x6389): undefined reference to `nfs_sb_deactive'

Add dependency to NFSD_V4_2_INTER_SSC to fix this.

Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/nfsd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index f368f32..fc587a5 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -136,6 +136,7 @@ config NFSD_FLEXFILELAYOUT
 
 config NFSD_V4_2_INTER_SSC
 	bool "NFSv4.2 inter server to server COPY"
+	depends on !(NFSD=y && NFS_FS=m)
 	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2
 	help
 	  This option enables support for NFSv4.2 inter server to
-- 
2.7.4


