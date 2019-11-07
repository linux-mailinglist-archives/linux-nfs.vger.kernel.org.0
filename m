Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1907CF3B8F
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Nov 2019 23:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfKGWkJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Nov 2019 17:40:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45942 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfKGWkJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Nov 2019 17:40:09 -0500
Received: from [82.43.126.140] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iSqRg-0006cw-Mh; Thu, 07 Nov 2019 22:40:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH] NFSv4: fix spelling mistake "requeueing" -> "requeuing"
Date:   Thu,  7 Nov 2019 22:40:04 +0000
Message-Id: <20191107224004.417163-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a debug message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/nfs/nfs4renewd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4renewd.c b/fs/nfs/nfs4renewd.c
index 6ea431b067dd..396045633077 100644
--- a/fs/nfs/nfs4renewd.c
+++ b/fs/nfs/nfs4renewd.c
@@ -120,7 +120,7 @@ nfs4_schedule_state_renewal(struct nfs_client *clp)
 		- (long)jiffies;
 	if (timeout < 5 * HZ)
 		timeout = 5 * HZ;
-	dprintk("%s: requeueing work. Lease period = %ld\n",
+	dprintk("%s: requeuing work. Lease period = %ld\n",
 			__func__, (timeout + HZ - 1) / HZ);
 	mod_delayed_work(system_wq, &clp->cl_renewd, timeout);
 	set_bit(NFS_CS_RENEWD, &clp->cl_res_state);
-- 
2.20.1

