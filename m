Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C7F2C9002
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 22:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbgK3V0W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 16:26:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388558AbgK3V0W (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Nov 2020 16:26:22 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E07BB208DB;
        Mon, 30 Nov 2020 21:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606771504;
        bh=N9/OPaZzIYV3a+AYR28ltm5smWP8Pti1uo38sJCxOt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bw1XRI0RFZPV1+jPSsVBRG28TJ3unnVnStIT2ZGWS3DZ7IldJ48qFQmte/DSxadaq
         V+fBYB/C/d9mYtttP7fzCNYVTKIGrOVqwo/0mxxSF4POx2T0wEDZ9mPOnKSgzlLNlu
         Cxsv7/aBpAKnVWy3OzXUJHvV/X9TcnaXYZL5x+uM=
From:   trondmy@kernel.org
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/6] nfsd: Fix up nfsd to ensure that timeout errors don't result in ESTALE
Date:   Mon, 30 Nov 2020 16:24:54 -0500
Message-Id: <20201130212455.254469-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130212455.254469-5-trondmy@kernel.org>
References: <20201130212455.254469-1-trondmy@kernel.org>
 <20201130212455.254469-2-trondmy@kernel.org>
 <20201130212455.254469-3-trondmy@kernel.org>
 <20201130212455.254469-4-trondmy@kernel.org>
 <20201130212455.254469-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the underlying filesystem times out, then we want knfsd to return
NFSERR_JUKEBOX/DELAY rather than NFSERR_STALE.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfsfh.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 0c2ee65e46f3..46c86f7bc429 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -268,12 +268,20 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	if (fileid_type == FILEID_ROOT)
 		dentry = dget(exp->ex_path.dentry);
 	else {
-		dentry = exportfs_decode_fh(exp->ex_path.mnt, fid,
-				data_left, fileid_type,
-				nfsd_acceptable, exp);
-		if (IS_ERR_OR_NULL(dentry))
+		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
+						data_left, fileid_type,
+						nfsd_acceptable, exp);
+		if (IS_ERR_OR_NULL(dentry)) {
 			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
 					dentry ?  PTR_ERR(dentry) : -ESTALE);
+			switch (PTR_ERR(dentry)) {
+			case -ENOMEM:
+			case -ETIMEDOUT:
+				break;
+			default:
+				dentry = ERR_PTR(-ESTALE);
+			}
+		}
 	}
 	if (dentry == NULL)
 		goto out;
-- 
2.28.0

