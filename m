Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA2479EBC
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 02:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhLSBoz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Dec 2021 20:44:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54020 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbhLSBoz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Dec 2021 20:44:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B5D1B80BA8
        for <linux-nfs@vger.kernel.org>; Sun, 19 Dec 2021 01:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E96C36AEA;
        Sun, 19 Dec 2021 01:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639878291;
        bh=thcxrZL9ujNH8aHpmoqJoe5Dmbw4qiY9pDab0Oti7dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hN0rene+lHsGrb+J2T3ioW5QfQ0aRKodMRLAHcMEXg7iGywcEte6i5qF1VOEFubuW
         bYSNhWuJyCswVY6VfSopsEleoHGpeQxdOkaAIpBFyEPEPaLCjucWpvABLq5AtmofgF
         yRWGla7CCo0jeYwg5gBgiftzLlFwj03GlM56OSU2OaIcGmcGcGUX3eaEkrXyVVVboH
         +mN914Dc76VkQndOIjvORLT+mQ9qBT6T1RWMhFKLINptqtUh0kutBlg2Kg9ZVQReoH
         +vWa0QpsNRvgjHEAIZwcv62au2ae+T96XAXIP4e0X1OXW0pzIe7T/7nQuZBKPXH+CE
         OmF+Z75HgDuUw==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 03/10] nfsd: Retry once in nfsd_open on an -EOPENSTALE return
Date:   Sat, 18 Dec 2021 20:37:56 -0500
Message-Id: <20211219013803.324724-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211219013803.324724-3-trondmy@kernel.org>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

If we get back -EOPENSTALE from an NFSv4 open, then we either got some
unhandled error or the inode we got back was not the same as the one
associated with the dentry.

We really have no recourse in that situation other than to retry the
open, and if it fails to just return nfserr_stale back to the client.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfsproc.c |  1 +
 fs/nfsd/vfs.c     | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 83bd11be8406..01c1e8f7b766 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -880,6 +880,7 @@ nfserrno (int errno)
 		{ nfserr_serverfault, -ESERVERFAULT },
 		{ nfserr_serverfault, -ENFILE },
 		{ nfserr_io, -EREMOTEIO },
+		{ nfserr_stale, -EOPENSTALE },
 		{ nfserr_io, -EUCLEAN },
 		{ nfserr_perm, -ENOKEY },
 		{ nfserr_no_grace, -ENOGRACE},
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c99857689e2c..0faa3839ea6c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -777,6 +777,7 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 		int may_flags, struct file **filp)
 {
 	__be32 err;
+	bool retried = false;
 
 	validate_process_creds();
 	/*
@@ -792,9 +793,16 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 	 */
 	if (type == S_IFREG)
 		may_flags |= NFSD_MAY_OWNER_OVERRIDE;
+retry:
 	err = fh_verify(rqstp, fhp, type, may_flags);
-	if (!err)
+	if (!err) {
 		err = __nfsd_open(rqstp, fhp, type, may_flags, filp);
+		if (err == nfserr_stale && !retried) {
+			retried = true;
+			fh_put(fhp);
+			goto retry;
+		}
+	}
 	validate_process_creds();
 	return err;
 }
-- 
2.33.1

