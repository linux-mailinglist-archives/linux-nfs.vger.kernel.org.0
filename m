Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F032C9653
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 05:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgLAEPK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 23:15:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbgLAEPJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Nov 2020 23:15:09 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2FF32073C;
        Tue,  1 Dec 2020 04:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606796069;
        bh=WkRXVMGuVl3KYYtb+GbOribXJZ0BvJN+p50CbCiAzfM=;
        h=From:To:Cc:Subject:Date:From;
        b=CNqIfZq770+lMlzdEkMUP9DT1lorXp0NXVAxLcYlUU96jbCoX1ngtH0tL0Ak1e/MR
         JHK31qYU/aBH966+84OW8nHFbuSDszzaWppSsH9mtO5lBc/EAXYAp0v8WeNSboiRE+
         EFFGz5PHRwY0W9SHqM1ZXMPsqOCslEI//bk9/LyE=
From:   trondmy@kernel.org
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfsd: Avoid /* Fallthrough */
Date:   Mon, 30 Nov 2020 23:14:26 -0500
Message-Id: <20201201041427.756749-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The '/* Fallthrough */' comment is already deprecated. Avoid it.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfsfh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 46c86f7bc429..e80a7525561d 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -302,9 +302,9 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 
 	switch (rqstp->rq_vers) {
 	case 3:
-		if (!(dentry->d_sb->s_export_op->flags & EXPORT_OP_NOWCC))
-			break;
-		/* Fallthrough */
+		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOWCC)
+			fhp->fh_no_wcc = true;
+		break;
 	case 2:
 		fhp->fh_no_wcc = true;
 	}
-- 
2.28.0

