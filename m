Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3372D9DE8B
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 09:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfH0HQw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Aug 2019 03:16:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43512 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfH0HQw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Aug 2019 03:16:52 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 09FC057D8CFFA656992E;
        Tue, 27 Aug 2019 15:16:51 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 27 Aug 2019
 15:16:43 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] NFS: remove set but not used variable 'mapping'
Date:   Tue, 27 Aug 2019 15:16:36 +0800
Message-ID: <20190827071636.15460-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/nfs/write.c: In function nfs_page_async_flush:
fs/nfs/write.c:609:24: warning: variable mapping set but not used [-Wunused-but-set-variable]

It is not use since commit aefb623c422e ("NFS: Fix
writepage(s) error handling to not report errors twice")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/nfs/write.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index d193042..85ca495 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -606,7 +606,6 @@ static void nfs_write_error(struct nfs_page *req, int error)
 static int nfs_page_async_flush(struct nfs_pageio_descriptor *pgio,
 				struct page *page)
 {
-	struct address_space *mapping;
 	struct nfs_page *req;
 	int ret = 0;
 
@@ -621,7 +620,6 @@ static int nfs_page_async_flush(struct nfs_pageio_descriptor *pgio,
 	WARN_ON_ONCE(test_bit(PG_CLEAN, &req->wb_flags));
 
 	/* If there is a fatal error that covers this write, just exit */
-	mapping = page_file_mapping(page);
 	ret = pgio->pg_error;
 	if (nfs_error_is_fatal_on_server(ret))
 		goto out_launder;
-- 
2.7.4


