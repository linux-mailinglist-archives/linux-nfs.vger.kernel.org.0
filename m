Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99BA612A5C4
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2019 04:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfLYDMZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Dec 2019 22:12:25 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfLYDMZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Dec 2019 22:12:25 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 39A73636251883F0981A;
        Wed, 25 Dec 2019 11:12:23 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Dec 2019
 11:12:15 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 1/3] nfsd: use true,false for bool variable in vfs.c
Date:   Wed, 25 Dec 2019 11:19:34 +0800
Message-ID: <1577243976-46389-2-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577243976-46389-1-git-send-email-zhengbin13@huawei.com>
References: <1577243976-46389-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes coccicheck warning:

fs/nfsd/vfs.c:1389:5-13: WARNING: Assignment of 0/1 to bool variable
fs/nfsd/vfs.c:1398:5-13: WARNING: Assignment of 0/1 to bool variable
fs/nfsd/vfs.c:1415:2-10: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/nfsd/vfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c0dc491..891e09f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1386,7 +1386,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			    && d_inode(dchild)->i_atime.tv_sec == v_atime
 			    && d_inode(dchild)->i_size  == 0 ) {
 				if (created)
-					*created = 1;
+					*created = true;
 				break;
 			}
 			/* fall through */
@@ -1395,7 +1395,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			    && d_inode(dchild)->i_atime.tv_sec == v_atime
 			    && d_inode(dchild)->i_size  == 0 ) {
 				if (created)
-					*created = 1;
+					*created = true;
 				goto set_attr;
 			}
 			/* fall through */
@@ -1412,7 +1412,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out_nfserr;
 	}
 	if (created)
-		*created = 1;
+		*created = true;

 	nfsd_check_ignore_resizing(iap);

--
2.7.4

