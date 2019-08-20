Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8484395362
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 03:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfHTB3F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 21:29:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728734AbfHTB3F (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Aug 2019 21:29:05 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 508F9CBD5AA2E501DB37;
        Tue, 20 Aug 2019 09:29:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 20 Aug 2019 09:28:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jeff.layton@primarydata.com>,
        Weston Andros Adamson <dros@primarydata.com>,
        Richard Sharpe <richard.sharpe@primarydata.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Chuck Lever <chuck.lever@oracle.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-nfs@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] nfsd: remove duplicated include from filecache.c
Date:   Tue, 20 Aug 2019 01:32:43 +0000
Message-ID: <20190820013243.129865-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/nfsd/filecache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 4759fdc8a07e..07939f4834e8 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -6,7 +6,6 @@
 
 #include <linux/hash.h>
 #include <linux/slab.h>
-#include <linux/hash.h>
 #include <linux/file.h>
 #include <linux/sched.h>
 #include <linux/list_lru.h>



