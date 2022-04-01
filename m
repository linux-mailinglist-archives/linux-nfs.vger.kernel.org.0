Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BDC4EE6BC
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Apr 2022 05:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244560AbiDADb0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 23:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiDADbZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 23:31:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B37C58828;
        Thu, 31 Mar 2022 20:29:34 -0700 (PDT)
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KV5CV5xdyzBrbk;
        Fri,  1 Apr 2022 11:25:26 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 11:29:31 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 1 Apr
 2022 11:29:31 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <smayhew@redhat.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <liuyongqiang13@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH -next,v2 1/3] NFS: return more nuanced writeback errors in nfs_file_write()
Date:   Fri, 1 Apr 2022 11:44:07 +0800
Message-ID: <20220401034409.256770-2-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220401034409.256770-1-chenxiaosong2@huawei.com>
References: <20220401034409.256770-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently, writeback error in address_space flags will not be set in
nfs_mapping_set_error(), return value of nfs_wb_all() is always 0 even if
there is new writeback error. And error from filemap_check_wb_err() is just
used to check, will not be reported to userspace.

Furthermore, filemap_sample_wb_err() always return 0 if old writeback error
have not been consumed. filemap_check_wb_err() will return the old error
even if there is no new writeback error between filemap_sample_wb_err() and
filemap_check_wb_err().

So we still need record writeback error in address_space flags. The writeback
error in address_space flags is not used to be reported to userspace, it is just
used to detect if there is new error while writeback.

generic_perform_write() detect wb error by calling filemap_check_errors():
  generic_perform_write
    nfs_write_end
      nfs_wb_all
        filemap_write_and_wait
          filemap_write_and_wait_range
            filemap_check_errors

filemap_fdatawait_range() detect wb error by calling filemap_check_errors():
  filemap_fdatawait_range
    __filemap_fdatawait_range
    filemap_check_errors

As filemap_check_errors() only report -EIO or -ENOSPC, we must use the more nuanced
writeback error for -EIO by returning -(file->f_mapping->wb_err & MAX_ERRNO).

Fixes: 6c984083ec24 ("NFS: Use of mapping_set_error() results in spurious errors")
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/nfs/file.c  | 3 +++
 fs/nfs/write.c | 5 +----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index b0ca244c50d0..5513ab63c108 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -683,6 +683,9 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 	nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, written);
 out:
+	/* Use the more nuanced writeback error for -EIO */
+	if (result == -EIO)
+		result = filemap_check_wb_err(file->f_mapping, 0);
 	return result;
 
 out_swapfile:
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index f00d45cf80ef..eec15efb41ab 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -312,10 +312,7 @@ static void nfs_mapping_set_error(struct page *page, int error)
 	struct address_space *mapping = page_file_mapping(page);
 
 	SetPageError(page);
-	filemap_set_wb_err(mapping, error);
-	if (mapping->host)
-		errseq_set(&mapping->host->i_sb->s_wb_err,
-			   error == -ENOSPC ? -ENOSPC : -EIO);
+	mapping_set_error(mapping, error);
 	nfs_set_pageerror(mapping);
 }
 
-- 
2.31.1

