Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE984CE4C2
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Mar 2022 13:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiCEMc3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Mar 2022 07:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiCEMcZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Mar 2022 07:32:25 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3EB24004A;
        Sat,  5 Mar 2022 04:31:35 -0800 (PST)
Received: from kwepemi100011.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K9kYy17jSzBryw;
        Sat,  5 Mar 2022 20:29:42 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi100011.china.huawei.com (7.221.188.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 5 Mar 2022 20:31:34 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 20:31:33 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <smayhew@redhat.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <liuyongqiang13@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH -next 2/2] nfs: nfs_file_write() check writeback errors correctly
Date:   Sat, 5 Mar 2022 20:46:36 +0800
Message-ID: <20220305124636.2002383-3-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220305124636.2002383-1-chenxiaosong2@huawei.com>
References: <20220305124636.2002383-1-chenxiaosong2@huawei.com>
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

If nobody has seen the writeback error yet, then filemap_sample_wb_err()
always return 0. Even if there is no new writeback error between
filemap_sample_wb_err() and filemap_check_wb_err(),
filemap_check_wb_err() will return the old error.

Fix this by using file->f_mapping->wb_err as the old error.

Fixes: ce368536dd61 ("nfs: nfs_file_write() should check for writeback errors")
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/nfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 83d63bce9596..8763f89c176a 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -635,7 +635,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 
 	nfs_clear_invalid_mapping(file->f_mapping);
 
-	since = filemap_sample_wb_err(file->f_mapping);
+	since = file->f_mapping->wb_err;
 	nfs_start_io_write(inode);
 	result = generic_write_checks(iocb, from);
 	if (result > 0) {
@@ -669,7 +669,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 
 	/* Return error values */
-	error = filemap_check_wb_err(file->f_mapping, since);
+	error = errseq_check(&file->f_mapping->wb_err, since);
 	if (nfs_need_check_write(file, inode, error)) {
 		int err = nfs_wb_all(inode);
 		if (err < 0)
-- 
2.31.1

