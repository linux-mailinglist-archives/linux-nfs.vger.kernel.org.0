Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 875B361EFA
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 14:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfGHMy1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 08:54:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43508 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728117AbfGHMy1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Jul 2019 08:54:27 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B35FCDBAD8ECC974D6EF;
        Mon,  8 Jul 2019 20:54:19 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 8 Jul 2019
 20:54:11 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] nfsd: Make __get_nfsdfs_client() static
Date:   Mon, 8 Jul 2019 20:54:08 +0800
Message-ID: <20190708125408.56016-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix sparse warning:

fs/nfsd/nfsctl.c:1221:22: warning:
 symbol '__get_nfsdfs_client' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/nfsd/nfsctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 53833b3..0a9a49d 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1218,7 +1218,7 @@ static void clear_ncl(struct inode *inode)
 }
 
 
-struct nfsdfs_client *__get_nfsdfs_client(struct inode *inode)
+static struct nfsdfs_client *__get_nfsdfs_client(struct inode *inode)
 {
 	struct nfsdfs_client *nc = inode->i_private;
 
-- 
2.7.4


