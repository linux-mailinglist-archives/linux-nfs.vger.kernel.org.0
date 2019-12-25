Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2196D12A5C5
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2019 04:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLYDMZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Dec 2019 22:12:25 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726332AbfLYDMZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Dec 2019 22:12:25 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 313856BB07F85F4E1640;
        Wed, 25 Dec 2019 11:12:23 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Dec 2019
 11:12:16 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 3/3] nfsd: use true,false for bool variable in nfssvc.c
Date:   Wed, 25 Dec 2019 11:19:36 +0800
Message-ID: <1577243976-46389-4-git-send-email-zhengbin13@huawei.com>
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

fs/nfsd/nfssvc.c:394:2-14: WARNING: Assignment of 0/1 to bool variable
fs/nfsd/nfssvc.c:407:2-14: WARNING: Assignment of 0/1 to bool variable
fs/nfsd/nfssvc.c:422:2-14: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/nfsd/nfssvc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index e8bee8f..decfda0 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -391,7 +391,7 @@ static int nfsd_startup_net(int nrservs, struct net *net, const struct cred *cre
 		ret = lockd_up(net, cred);
 		if (ret)
 			goto out_socks;
-		nn->lockd_up = 1;
+		nn->lockd_up = true;
 	}

 	ret = nfs4_state_start_net(net);
@@ -404,7 +404,7 @@ static int nfsd_startup_net(int nrservs, struct net *net, const struct cred *cre
 out_lockd:
 	if (nn->lockd_up) {
 		lockd_down(net);
-		nn->lockd_up = 0;
+		nn->lockd_up = false;
 	}
 out_socks:
 	nfsd_shutdown_generic();
@@ -419,7 +419,7 @@ static void nfsd_shutdown_net(struct net *net)
 	nfs4_state_shutdown_net(net);
 	if (nn->lockd_up) {
 		lockd_down(net);
-		nn->lockd_up = 0;
+		nn->lockd_up = false;
 	}
 	nn->nfsd_net_up = false;
 	nfsd_shutdown_generic();
--
2.7.4

