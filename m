Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96F18150057
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2020 02:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgBCBto (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Feb 2020 20:49:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbgBCBto (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 2 Feb 2020 20:49:44 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BE35A203AA8A78D46FA5;
        Mon,  3 Feb 2020 09:49:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Mon, 3 Feb 2020 09:49:30 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yaohongbo@huawei.com>, <chenzhou10@huawei.com>
Subject: [PATCH -next] nfsd: make nfsd_filecache_wq variable static
Date:   Mon, 3 Feb 2020 09:43:57 +0800
Message-ID: <20200203014357.114717-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix sparse warning:

fs/nfsd/filecache.c:55:25: warning:
	symbol 'nfsd_filecache_wq' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 fs/nfsd/filecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 23c1fa5..22e77ed 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -52,7 +52,7 @@ struct nfsd_fcache_disposal {
 	struct rcu_head rcu;
 };
 
-struct workqueue_struct *nfsd_filecache_wq __read_mostly;
+static struct workqueue_struct *nfsd_filecache_wq __read_mostly;
 
 static struct kmem_cache		*nfsd_file_slab;
 static struct kmem_cache		*nfsd_file_mark_slab;
-- 
2.7.4

