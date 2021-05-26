Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5BD390ED5
	for <lists+linux-nfs@lfdr.de>; Wed, 26 May 2021 05:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhEZD17 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 23:27:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3972 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhEZD16 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 May 2021 23:27:58 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FqbqV0LlKzQslS;
        Wed, 26 May 2021 11:22:46 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 11:26:23 +0800
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 11:26:22 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <zhangxiaoxu5@huawei.com>, <yukuai3@huawei.com>,
        <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <bfields@redhat.com>, <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFSv4: Fix v4.0/v4.1 SEEK_DATA return -ENOTSUPP when set NFS_V4_2 config
Date:   Tue, 25 May 2021 23:32:35 -0400
Message-ID: <20210526033235.1298266-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit bdcc2cd14e4e ("NFSv4.2: handle NFS-specific llseek errors"),
nfs42_proc_llseek would return -EOPNOTSUPP rather than -ENOTSUPP when
SEEK_DATA on NFSv4.0/v4.1.

This will lead xfstests generic/285 not run on NFSv4.0/v4.1 when set the
CONFIG_NFS_V4_2, rather than run failed.

Fixes: bdcc2cd14e4e ("NFSv4.2: handle NFS-specific llseek errors")
Cc: <stable.vger.kernel.org> # 4.2
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/nfs/nfs4file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 57b3821d975a..a1e5c6b85ded 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -211,7 +211,7 @@ static loff_t nfs4_file_llseek(struct file *filep, loff_t offset, int whence)
 	case SEEK_HOLE:
 	case SEEK_DATA:
 		ret = nfs42_proc_llseek(filep, offset, whence);
-		if (ret != -ENOTSUPP)
+		if (ret != -EOPNOTSUPP)
 			return ret;
 		fallthrough;
 	default:
-- 
2.25.4

