Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F40514E6B
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 16:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377978AbiD2O5X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 10:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377330AbiD2O5Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 10:57:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45D3C3EBE
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 07:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69E2BB835DB
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4A0C385A4
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:53:50 +0000 (UTC)
Subject: [PATCH 3/6] NFSD: Move documenting comment for nfsd4_process_open2()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 29 Apr 2022 10:53:49 -0400
Message-ID: <165124402926.1060.11916783684271494269.stgit@bazille.1015granger.net>
In-Reply-To: <165124376329.1060.17013198516228928515.stgit@bazille.1015granger.net>
References: <165124376329.1060.17013198516228928515.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
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

Clean up nfsd4_open() by converting a large comment at the only
call site for nfsd4_process_open2() to a kerneldoc comment in
front of that function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c  |    6 +-----
 fs/nfsd/nfs4state.c |   12 ++++++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 05ec878b005d..9dbce52f0f33 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -628,11 +628,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		status = nfserr_inval;
 		goto out;
 	}
-	/*
-	 * nfsd4_process_open2() does the actual opening of the file.  If
-	 * successful, it (1) truncates the file if open->op_truncate was
-	 * set, (2) sets open->op_stateid, (3) sets open->op_delegation.
-	 */
+
 	status = nfsd4_process_open2(rqstp, resfh, open);
 	WARN(status && open->op_created,
 	     "nfsd4_process_open2 failed to open newly-created file! status=%u\n",
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e7c28ddf2538..899bcf9cd612 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5332,6 +5332,18 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
 	 */
 }
 
+/**
+ * nfsd4_process_open2 - finish open processing
+ * @rqstp: the RPC transaction being executed
+ * @current_fh: NFSv4 COMPOUND's current filehandle
+ * @open: OPEN arguments
+ *
+ * If successful, (1) truncate the file if open->op_truncate was
+ * set, (2) set open->op_stateid, (3) set open->op_delegation.
+ *
+ * Returns %nfs_ok on success; otherwise an nfs4stat value in
+ * network byte order is returned.
+ */
 __be32
 nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
 {


