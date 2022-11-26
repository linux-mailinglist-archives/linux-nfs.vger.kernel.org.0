Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3D7639838
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Nov 2022 21:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiKZUzg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Nov 2022 15:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKZUzf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Nov 2022 15:55:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D44A17AA6
        for <linux-nfs@vger.kernel.org>; Sat, 26 Nov 2022 12:55:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 721AFCE0A28
        for <linux-nfs@vger.kernel.org>; Sat, 26 Nov 2022 20:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91598C433C1
        for <linux-nfs@vger.kernel.org>; Sat, 26 Nov 2022 20:55:31 +0000 (UTC)
Subject: [PATCH 3/4] NFSD: Use only RQ_DROPME to signal the need to drop a
 reply
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 26 Nov 2022 15:55:30 -0500
Message-ID: <166949613071.106845.17616057590483899090.stgit@klimt.1015granger.net>
In-Reply-To: <166949601705.106845.10614964159272504008.stgit@klimt.1015granger.net>
References: <166949601705.106845.10614964159272504008.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: NFSv2 has the only two usages of rpc_drop_reply in the
NFSD code base. Since NFSv2 is going away at some point, replace
these in order to simplify the "drop this reply?" check in
nfsd_dispatch().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c |    4 ++--
 fs/nfsd/nfssvc.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 82b3ddeacc33..24f15ddb68dd 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -211,7 +211,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 	if (resp->status == nfs_ok)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
-		return rpc_drop_reply;
+		__set_bit(RQ_DROPME, &rqstp->rq_flags);
 	return rpc_success;
 }
 
@@ -246,7 +246,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 	if (resp->status == nfs_ok)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
-		return rpc_drop_reply;
+		__set_bit(RQ_DROPME, &rqstp->rq_flags);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index bfbd9f672f59..00b6eb72d1c9 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1054,7 +1054,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	svcxdr_init_encode(rqstp);
 
 	*statp = proc->pc_func(rqstp);
-	if (*statp == rpc_drop_reply || test_bit(RQ_DROPME, &rqstp->rq_flags))
+	if (test_bit(RQ_DROPME, &rqstp->rq_flags))
 		goto out_update_drop;
 
 	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))


