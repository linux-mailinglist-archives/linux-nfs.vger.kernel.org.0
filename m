Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA0D170CB3
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Feb 2020 00:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgBZXn0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Feb 2020 18:43:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35935 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgBZXn0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Feb 2020 18:43:26 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j76Kn-0006bS-6f; Wed, 26 Feb 2020 23:43:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: check for allocation failure from mempool_alloc
Date:   Wed, 26 Feb 2020 23:43:20 +0000
Message-Id: <20200226234320.7722-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

It is possible for mempool_alloc to return null when using
the GFP_KERNEL flag, so return NULL and avoid a null pointer
dereference on the following memset of the null pointer.

Addresses-Coverity: ("Dereference null return")
Fixes: 2b17d725f9be ("NFS: Clean up writeback code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/nfs/write.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index c478b772cc49..7ca036660dd1 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -106,6 +106,9 @@ static struct nfs_pgio_header *nfs_writehdr_alloc(void)
 {
 	struct nfs_pgio_header *p = mempool_alloc(nfs_wdata_mempool, GFP_KERNEL);
 
+	if (!p)
+		return NULL;
+
 	memset(p, 0, sizeof(*p));
 	p->rw_mode = FMODE_WRITE;
 	return p;
-- 
2.25.0

