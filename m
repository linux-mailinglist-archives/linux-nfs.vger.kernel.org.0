Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE842C2AB
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 11:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfE1JHL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 05:07:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17595 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727322AbfE1JHL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 May 2019 05:07:11 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 86761B8F878AA4309DF5;
        Tue, 28 May 2019 17:07:08 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 28 May 2019
 17:07:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bfields@fieldses.org>, <jlayton@kernel.org>,
        <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] lockd: Make two symbols static
Date:   Tue, 28 May 2019 17:06:52 +0800
Message-ID: <20190528090652.13288-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix sparse warnings:

fs/lockd/clntproc.c:57:6: warning: symbol 'nlmclnt_put_lockowner' was not declared. Should it be static?
fs/lockd/svclock.c:409:35: warning: symbol 'nlmsvc_lock_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/lockd/clntproc.c | 2 +-
 fs/lockd/svclock.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index 0ff8ad4..b11f2af 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -54,7 +54,7 @@ nlmclnt_get_lockowner(struct nlm_lockowner *lockowner)
 	return lockowner;
 }
 
-void nlmclnt_put_lockowner(struct nlm_lockowner *lockowner)
+static void nlmclnt_put_lockowner(struct nlm_lockowner *lockowner)
 {
 	if (!refcount_dec_and_lock(&lockowner->count, &lockowner->host->h_lock))
 		return;
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 5f9f19b..61d3cc2 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -406,7 +406,7 @@ static void nlmsvc_locks_release_private(struct file_lock *fl)
 	nlmsvc_put_lockowner((struct nlm_lockowner *)fl->fl_owner);
 }
 
-const struct file_lock_operations nlmsvc_lock_ops = {
+static const struct file_lock_operations nlmsvc_lock_ops = {
 	.fl_copy_lock = nlmsvc_locks_copy_lock,
 	.fl_release_private = nlmsvc_locks_release_private,
 };
-- 
2.7.4


