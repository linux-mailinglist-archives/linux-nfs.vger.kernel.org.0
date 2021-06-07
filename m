Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303D639D4DE
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jun 2021 08:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhFGGX7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Jun 2021 02:23:59 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3078 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGGX6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Jun 2021 02:23:58 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fz37G2kFDzWsmN;
        Mon,  7 Jun 2021 14:17:14 +0800 (CST)
Received: from dggemi758-chm.china.huawei.com (10.1.198.144) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 14:22:03 +0800
Received: from huawei.com (10.175.101.6) by dggemi758-chm.china.huawei.com
 (10.1.198.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 14:22:03 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <chenxiaosong2@huawei.com>
Subject: [PATCH -next] nfs_common: fix doc warning
Date:   Mon, 7 Jun 2021 14:28:23 +0800
Message-ID: <20210607062823.328716-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggemi758-chm.china.huawei.com (10.1.198.144)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix gcc W=1 warning:

fs/nfs_common/grace.c:91: warning: Function parameter or member 'net' not described in 'locks_in_grace'

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/nfs_common/grace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs_common/grace.c b/fs/nfs_common/grace.c
index 26f2a50eceac..edec45831585 100644
--- a/fs/nfs_common/grace.c
+++ b/fs/nfs_common/grace.c
@@ -82,6 +82,7 @@ __state_in_grace(struct net *net, bool open)
 
 /**
  * locks_in_grace
+ * @net: network namespace
  *
  * Lock managers call this function to determine when it is OK for them
  * to answer ordinary lock requests, and when they should accept only
-- 
2.25.4

