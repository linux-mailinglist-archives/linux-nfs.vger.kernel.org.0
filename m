Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1464F2D7205
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 09:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436964AbgLKImh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 03:42:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9593 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436949AbgLKImS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Dec 2020 03:42:18 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cskl93X2QzM3Qd;
        Fri, 11 Dec 2020 16:40:53 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:41:29 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <bfields@fieldses.org>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] fs/lockd: convert comma to semicolon
Date:   Fri, 11 Dec 2020 16:41:58 +0800
Message-ID: <20201211084158.1984-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 fs/lockd/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index 0afb6d59bad0..497520bc00a7 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -163,7 +163,7 @@ static struct nlm_host *nlm_alloc_host(struct nlm_lookup_host_info *ni,
 	host->h_nsmhandle  = nsm;
 	host->h_addrbuf    = nsm->sm_addrbuf;
 	host->net	   = ni->net;
-	host->h_cred	   = get_cred(ni->cred),
+	host->h_cred	   = get_cred(ni->cred);
 	strlcpy(host->nodename, utsname()->nodename, sizeof(host->nodename));
 
 out:
-- 
2.22.0

