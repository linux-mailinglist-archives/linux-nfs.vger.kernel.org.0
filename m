Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCF21CAA6B
	for <lists+linux-nfs@lfdr.de>; Fri,  8 May 2020 14:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEHMS4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 May 2020 08:18:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4355 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726627AbgEHMSz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 8 May 2020 08:18:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AD35CC208295E0642456;
        Fri,  8 May 2020 20:18:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 20:18:47 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next] NFS: remove duplicate headers
Date:   Fri, 8 May 2020 20:22:41 +0800
Message-ID: <20200508122241.168268-1-chenzhou10@huawei.com>
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

Remove duplicate headers which are included twice.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 fs/nfs/dns_resolve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/dns_resolve.c b/fs/nfs/dns_resolve.c
index 963800037609..e87d500ad95a 100644
--- a/fs/nfs/dns_resolve.c
+++ b/fs/nfs/dns_resolve.c
@@ -39,7 +39,6 @@ ssize_t nfs_dns_resolve_name(struct net *net, char *name, size_t namelen,
 #include <linux/string.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
-#include <linux/module.h>
 #include <linux/socket.h>
 #include <linux/seq_file.h>
 #include <linux/inet.h>
-- 
2.20.1

