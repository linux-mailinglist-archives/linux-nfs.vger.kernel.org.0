Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A65E3F6D6E
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Aug 2021 04:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbhHYCgt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Aug 2021 22:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbhHYCgs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Aug 2021 22:36:48 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E79CC061757
        for <linux-nfs@vger.kernel.org>; Tue, 24 Aug 2021 19:36:04 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A1CB47C78; Tue, 24 Aug 2021 22:36:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A1CB47C78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1629858963;
        bh=uBGEbN8TRudqZXHdDGf0ZwSYkoREcNzUB1rTezR3oSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=soVFmlXUtrpRiMBySiG/qOhmLAlRvRx9GyhuCsoq0Z/TFLVG8RSHC7IgGxJ4/M28Q
         zlR+iT2wHlaV+yLBwGeRO+qrZxuputiCALavEy+Adeh/ygPAjGNes8EQeOSbau6Z5I
         XpNSEIL3sNacVCXIYT3oBjGlljqcswVQjCeDbleE=
Date:   Tue, 24 Aug 2021 22:36:03 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>, daire@dneg.com,
        linux-nfs@vger.kernel.org
Subject: [PATCH 9/8] nfsd: fix crash on LOCKT on reexported NFSv3
Message-ID: <20210825023603.GB13681@fieldses.org>
References: <1629493326-28336-1-git-send-email-bfields@redhat.com>
 <20210825023519.GA13681@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825023519.GA13681@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Unlike other filesystems, NFSv3 tries to use fl_file in the GETLK case.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1b6a7f48982e..4b6d60b46b0a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7043,8 +7043,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 /*
  * The NFSv4 spec allows a client to do a LOCKT without holding an OPEN,
  * so we do a temporary open here just to get an open file to pass to
- * vfs_test_lock.  (Arguably perhaps test_lock should be done with an
- * inode operation.)
+ * vfs_test_lock.
  */
 static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file_lock *lock)
 {
@@ -7059,7 +7058,9 @@ static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct
 							NFSD_MAY_READ));
 	if (err)
 		goto out;
+	lock->fl_file = nf->nf_file;
 	err = nfserrno(vfs_test_lock(nf->nf_file, lock));
+	lock->fl_file = NULL;
 out:
 	fh_unlock(fhp);
 	nfsd_file_put(nf);
-- 
2.31.1

