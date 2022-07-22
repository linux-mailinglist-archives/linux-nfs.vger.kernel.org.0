Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9E57E839
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 22:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbiGVUUC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 16:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGVUUB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 16:20:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91347F50A
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 13:20:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85AE761EFE
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66A2C341C6
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:19:59 +0000 (UTC)
Subject: [PATCH v1 10/11] NFSD: Add nfsd4_send_cb_offload()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 22 Jul 2022 16:19:58 -0400
Message-ID: <165852119889.11403.10050200899557112410.stgit@manet.1015granger.net>
In-Reply-To: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
References: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
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

Refactor for legibility.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |   37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0365a5575236..c82944042dc5 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1763,6 +1763,27 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
 	nfs4_put_copy(copy);
 }
 
+static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
+{
+	struct nfsd4_copy *cb_copy;
+
+	cb_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
+	if (!cb_copy)
+		return;
+
+	refcount_set(&cb_copy->refcount, 1);
+	memcpy(&cb_copy->cp_res, &copy->cp_res, sizeof(copy->cp_res));
+	cb_copy->cp_clp = copy->cp_clp;
+	cb_copy->nfserr = copy->nfserr;
+	memcpy(&cb_copy->fh, &copy->fh, sizeof(copy->fh));
+
+	nfsd4_init_cb(&cb_copy->cp_cb, cb_copy->cp_clp,
+			&nfsd4_cb_offload_ops, NFSPROC4_CLNT_CB_OFFLOAD);
+	trace_nfsd_cb_offload(copy->cp_clp, &copy->cp_res.cb_stateid,
+			      &copy->fh, copy->cp_count, copy->nfserr);
+	nfsd4_run_cb(&cb_copy->cp_cb);
+}
+
 /**
  * nfsd4_do_async_copy - kthread function for background server-side COPY
  * @data: arguments for COPY operation
@@ -1773,7 +1794,6 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
 static int nfsd4_do_async_copy(void *data)
 {
 	struct nfsd4_copy *copy = (struct nfsd4_copy *)data;
-	struct nfsd4_copy *cb_copy;
 
 	if (nfsd4_ssc_is_inter(copy)) {
 		struct file *filp;
@@ -1795,20 +1815,7 @@ static int nfsd4_do_async_copy(void *data)
 	}
 
 do_callback:
-	cb_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
-	if (!cb_copy)
-		goto out;
-	refcount_set(&cb_copy->refcount, 1);
-	memcpy(&cb_copy->cp_res, &copy->cp_res, sizeof(copy->cp_res));
-	cb_copy->cp_clp = copy->cp_clp;
-	cb_copy->nfserr = copy->nfserr;
-	memcpy(&cb_copy->fh, &copy->fh, sizeof(copy->fh));
-	nfsd4_init_cb(&cb_copy->cp_cb, cb_copy->cp_clp,
-			&nfsd4_cb_offload_ops, NFSPROC4_CLNT_CB_OFFLOAD);
-	trace_nfsd_cb_offload(copy->cp_clp, &copy->cp_res.cb_stateid,
-			      &copy->fh, copy->cp_count, copy->nfserr);
-	nfsd4_run_cb(&cb_copy->cp_cb);
-out:
+	nfsd4_send_cb_offload(copy);
 	cleanup_async_copy(copy);
 	return 0;
 }


