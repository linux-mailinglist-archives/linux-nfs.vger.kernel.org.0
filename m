Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7013D1E42C7
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2020 14:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgE0M4Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 May 2020 08:56:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60159 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbgE0M4P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 May 2020 08:56:15 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jdvbP-0000Yq-SZ; Wed, 27 May 2020 12:56:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: remove redundant initialization of variable result
Date:   Wed, 27 May 2020 13:56:11 +0100
Message-Id: <20200527125611.174291-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable result is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/nfs/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index a57e7c72c7f4..bb63e2b93ff7 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -446,7 +446,7 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter)
 	struct inode *inode = mapping->host;
 	struct nfs_direct_req *dreq;
 	struct nfs_lock_context *l_ctx;
-	ssize_t result = -EINVAL, requested;
+	ssize_t result, requested;
 	size_t count = iov_iter_count(iter);
 	nfs_add_stats(mapping->host, NFSIOS_DIRECTREADBYTES, count);
 
-- 
2.25.1

