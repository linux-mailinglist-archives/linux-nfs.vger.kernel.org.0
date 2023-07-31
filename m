Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C5E7694BA
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 13:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjGaLXi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 07:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjGaLXf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 07:23:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6596E5
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jul 2023 04:23:34 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RDwnh54Nlz1GDNf;
        Mon, 31 Jul 2023 19:22:32 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 19:23:31 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
        <kolga@netapp.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
        <linux-nfs@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next] exportfs: remove kernel-doc warnings in exportfs
Date:   Mon, 31 Jul 2023 19:23:00 +0800
Message-ID: <20230731112300.213602-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Remove kernel-doc warning in exportfs:

fs/exportfs/expfs.c:395: warning: Function parameter or member 'parent'
not described in 'exportfs_encode_inode_fh'

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 fs/exportfs/expfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 40e624cf7e92..5074e29f087c 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -386,6 +386,7 @@ static int export_encode_fh(struct inode *inode, struct fid *fid,
  * @inode:   the object to encode
  * @fid:     where to store the file handle fragment
  * @max_len: maximum length to store there
+ * @parent:  parent directory inode, if wanted
  * @flags:   properties of the requested file handle
  *
  * Returns an enum fid_type or a negative errno.
-- 
2.17.1

