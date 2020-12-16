Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B922DC042
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Dec 2020 13:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725274AbgLPMZ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Dec 2020 07:25:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44549 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgLPMZ7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Dec 2020 07:25:59 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kpVrl-00072t-RF; Wed, 16 Dec 2020 12:25:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Frank van der Linden <fllinden@amazon.com>,
        linux-nfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] NFSv4.2: fix error return on memory allocation failure
Date:   Wed, 16 Dec 2020 12:25:13 +0000
Message-Id: <20201216122513.15004-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when an alloc_page fails the error return is not set in
variable err and a garbage initialized value is returned. Fix this
by setting err to -ENOMEM before taking the error return path.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: a1f26739ccdc ("NFSv4.2: improve page handling for GETXATTR")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/nfs/nfs42proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index b9836e2ce4a2..f3fd935620fc 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1301,6 +1301,7 @@ ssize_t nfs42_proc_getxattr(struct inode *inode, const char *name,
 		pages[i] = alloc_page(GFP_KERNEL);
 		if (!pages[i]) {
 			np = i + 1;
+			err = -ENOMEM;
 			goto out;
 		}
 	}
-- 
2.29.2

