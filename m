Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91505B291C
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Sep 2022 00:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiIHWOX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 18:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiIHWOW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 18:14:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0051FB
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 15:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1892A61E2E
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 22:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A82C433D6
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 22:14:20 +0000 (UTC)
Subject: [PATCH v4 7/8] NFSD: Make nfsd4_rename() wait before returning
 NFS4ERR_DELAY
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 08 Sep 2022 18:14:19 -0400
Message-ID: <166267525948.1842.17093479396791635591.stgit@manet.1015granger.net>
In-Reply-To: <166267495153.1842.14474564029477470642.stgit@manet.1015granger.net>
References: <166267495153.1842.14474564029477470642.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
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

nfsd_rename() can kick off a CB_RECALL (via
vfs_rename() -> leases_conflict()) if a delegation is present.
Before returning NFS4ERR_DELAY, give the client holding that
delegation a chance to return it and then retry the nfsd_rename()
again, once.

This version of the patch handles renaming an existing file,
but does not deal with renaming onto an existing file. That
case will still always trigger an NFS4ERR_DELAY.

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=354
Tested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 03a826ccc165..b597cb2af949 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1681,7 +1681,15 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 			.new_dir	= tdir,
 			.new_dentry	= ndentry,
 		};
-		host_err = vfs_rename(&rd);
+		int retries;
+
+		for (retries = 1;;) {
+			host_err = vfs_rename(&rd);
+			if (host_err != -EAGAIN || !retries--)
+				break;
+			if (!nfsd_wait_for_delegreturn(rqstp, d_inode(odentry)))
+				break;
+		}
 		if (!host_err) {
 			host_err = commit_metadata(tfhp);
 			if (!host_err)


