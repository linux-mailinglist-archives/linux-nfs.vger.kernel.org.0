Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5125F4E6A7F
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Mar 2022 23:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353507AbiCXWJk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 18:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355231AbiCXWJj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 18:09:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD2910FD
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 15:08:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 507D2B8269E
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 22:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B50C340EC;
        Thu, 24 Mar 2022 22:08:02 +0000 (UTC)
Subject: [PATCH RFC] NFSD: Instantiate a filecache entry when creating a file
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     jlayton@kernel.org, linux-nfs@vger.kernel.org
Date:   Thu, 24 Mar 2022 18:08:01 -0400
Message-ID: <164815968129.1809.12154191330176123202.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There have been reports of races that cause NFSv4 OPEN(CREATE) to
return an error even though the requested file was created. NFSv4
does not seem to provide a status code for this case.

There are plenty of things that can go wrong between the
vfs_create() call in do_nfsd_create() and nfs4_vfs_get_file(), but
one of them is another client looking up and modifying the file's
mode bits in that window. If that happens, the creator might lose
access to the file before it can be opened.

Instead of opening the newly created file in nfsd4_process_open2(),
open it as soon as the file is created, and leave it sitting in the
file cache.

This patch is not optimal, of course - we should replace the
vfs_create() call in do_nfsd_create() with a call that creates the
file and returns a "struct file *" that can be planted immediately
in nf->nf_file.

But first, I would like to hear opinions about the approach
suggested above.

BugLink: https://bugzilla.linux-nfs.org/show_bug.cgi?id=382
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 02a544645b52..80b568fa12f1 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1410,6 +1410,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32		err;
 	int		host_err;
 	__u32		v_mtime=0, v_atime=0;
+	struct nfsd_file *nf;
 
 	/* XXX: Shouldn't this be nfserr_inval? */
 	err = nfserr_perm;
@@ -1535,6 +1536,14 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		iap->ia_atime.tv_nsec = 0;
 	}
 
+	/* Attempt to instantiate a filecache entry while we still hold
+	 * the parent's inode mutex. */
+	err = nfsd_file_acquire(rqstp, resfhp, NFSD_MAY_WRITE, &nf);
+	if (err)
+		/* This would be bad */
+		goto out;
+	nfsd_file_put(nf);
+
  set_attr:
 	err = nfsd_create_setattr(rqstp, resfhp, iap);
 


