Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A02C5B291A
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Sep 2022 00:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiIHWOR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 18:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiIHWOQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 18:14:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FDF1098DE
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 15:14:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D747961E2E
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 22:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A79DC433C1
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 22:14:14 +0000 (UTC)
Subject: [PATCH v4 6/8] NFSD: Make nfsd4_setattr() wait before returning
 NFS4ERR_DELAY
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 08 Sep 2022 18:14:13 -0400
Message-ID: <166267525333.1842.10708885965116635193.stgit@manet.1015granger.net>
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

nfsd_setattr() can kick off a CB_RECALL (via
notify_change() -> break_lease()) if a delegation is present. Before
returning NFS4ERR_DELAY, give the client holding that delegation a
chance to return it and then retry the nfsd_setattr() again, once.

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=354
Tested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 02f31d8c727a..03a826ccc165 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -394,6 +394,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	int		host_err;
 	bool		get_write_count;
 	bool		size_change = (iap->ia_valid & ATTR_SIZE);
+	int		retries;
 
 	if (iap->ia_valid & ATTR_SIZE) {
 		accmode |= NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
@@ -455,7 +456,13 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	inode_lock(inode);
-	host_err = __nfsd_setattr(dentry, iap);
+	for (retries = 1;;) {
+		host_err = __nfsd_setattr(dentry, iap);
+		if (host_err != -EAGAIN || !retries--)
+			break;
+		if (!nfsd_wait_for_delegreturn(rqstp, inode))
+			break;
+	}
 	if (attr->na_seclabel && attr->na_seclabel->len)
 		attr->na_labelerr = security_inode_setsecctx(dentry,
 			attr->na_seclabel->data, attr->na_seclabel->len);


