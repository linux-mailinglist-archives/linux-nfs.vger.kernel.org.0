Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BC34796A2
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 22:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhLQV5Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 16:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhLQV5P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 16:57:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88627C061574
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 13:57:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 274E4623C1
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 21:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAB7C36AE8;
        Fri, 17 Dec 2021 21:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639778234;
        bh=XVLGTTpZHBH/Ie0RwNGUQ8kQJR+Jbm/swzH2/zsjdF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AA7ucdqi1b6UkY05H3qREmxhHkEO/mrohlG+71AL5Am1+K2eDJSWOogaT2i0jhHhq
         Z9izqznwWdaICAwJwrV8PfxtbWwCcnj1QD+KeWzO9QxU709lHkAiEzrbS2q9aZDCq9
         vCEGo0PegGX7p35SVfXgh9WJyRG3ekNR54WkFAVTCmehiph/4VSGyvlU5S1BwGHKTF
         ebMpA/btvXtjDpKzg523e+soUnx4AnT3Gend+jG0VnTm1/aeV4U5ioAJWIVp7gWsVs
         9gY414I8bI5CAOs2vtd8o26ur5iB+y6lmVBuKaH6EEsnHm797J6czTfu05kunmZCgg
         rJXwqexkaOUhw==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/9] nfsd: Retry once in nfsd_open on an -EOPENSTALE return
Date:   Fri, 17 Dec 2021 16:50:40 -0500
Message-Id: <20211217215046.40316-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217215046.40316-3-trondmy@kernel.org>
References: <20211217215046.40316-1-trondmy@kernel.org>
 <20211217215046.40316-2-trondmy@kernel.org>
 <20211217215046.40316-3-trondmy@kernel.org>
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
index 1ebf02123368..458307876ead 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -881,6 +881,7 @@ nfserrno (int errno)
 		{ nfserr_serverfault, -ESERVERFAULT },
 		{ nfserr_serverfault, -ENFILE },
 		{ nfserr_io, -EREMOTEIO },
+		{ nfserr_stale, -EOPENSTALE },
 		{ nfserr_io, -EUCLEAN },
 		{ nfserr_perm, -ENOKEY },
 		{ nfserr_no_grace, -ENOGRACE},
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 738d564ca4ce..a90cc08211a3 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -779,6 +779,7 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 		int may_flags, struct file **filp)
 {
 	__be32 err;
+	bool retried = false;
 
 	validate_process_creds();
 	/*
@@ -794,9 +795,16 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
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

