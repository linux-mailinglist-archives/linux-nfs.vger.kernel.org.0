Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1626514E69
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359351AbiD2O5E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 10:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377978AbiD2O5D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 10:57:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108A9B6D28
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 07:53:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DA2961F91
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F0CC385A7
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:53:43 +0000 (UTC)
Subject: [PATCH 2/6] NFSD: Fix whitespace
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 29 Apr 2022 10:53:42 -0400
Message-ID: <165124402284.1060.14113150646693423766.stgit@bazille.1015granger.net>
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

Clean up: Pull case arms back one tab stop to conform every other
switch statement in fs/nfsd/nfs4proc.c.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |   50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0c5c0a685f02..05ec878b005d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -600,33 +600,33 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 
 	switch (open->op_claim_type) {
-		case NFS4_OPEN_CLAIM_DELEGATE_CUR:
-		case NFS4_OPEN_CLAIM_NULL:
-			status = do_open_lookup(rqstp, cstate, open, &resfh);
-			if (status)
-				goto out;
-			break;
-		case NFS4_OPEN_CLAIM_PREVIOUS:
-			status = nfs4_check_open_reclaim(cstate->clp);
-			if (status)
-				goto out;
-			open->op_openowner->oo_flags |= NFS4_OO_CONFIRMED;
-			reclaim = true;
-			fallthrough;
-		case NFS4_OPEN_CLAIM_FH:
-		case NFS4_OPEN_CLAIM_DELEG_CUR_FH:
-			status = do_open_fhandle(rqstp, cstate, open);
-			if (status)
-				goto out;
-			resfh = &cstate->current_fh;
-			break;
-		case NFS4_OPEN_CLAIM_DELEG_PREV_FH:
-             	case NFS4_OPEN_CLAIM_DELEGATE_PREV:
-			status = nfserr_notsupp;
+	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
+	case NFS4_OPEN_CLAIM_NULL:
+		status = do_open_lookup(rqstp, cstate, open, &resfh);
+		if (status)
 			goto out;
-		default:
-			status = nfserr_inval;
+		break;
+	case NFS4_OPEN_CLAIM_PREVIOUS:
+		status = nfs4_check_open_reclaim(cstate->clp);
+		if (status)
 			goto out;
+		open->op_openowner->oo_flags |= NFS4_OO_CONFIRMED;
+		reclaim = true;
+		fallthrough;
+	case NFS4_OPEN_CLAIM_FH:
+	case NFS4_OPEN_CLAIM_DELEG_CUR_FH:
+		status = do_open_fhandle(rqstp, cstate, open);
+		if (status)
+			goto out;
+		resfh = &cstate->current_fh;
+		break;
+	case NFS4_OPEN_CLAIM_DELEG_PREV_FH:
+	case NFS4_OPEN_CLAIM_DELEGATE_PREV:
+		status = nfserr_notsupp;
+		goto out;
+	default:
+		status = nfserr_inval;
+		goto out;
 	}
 	/*
 	 * nfsd4_process_open2() does the actual opening of the file.  If


