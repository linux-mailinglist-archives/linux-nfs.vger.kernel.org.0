Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A2559B5C2
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Aug 2022 20:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiHUSDX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Aug 2022 14:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiHUSDW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 21 Aug 2022 14:03:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5D3766C
        for <linux-nfs@vger.kernel.org>; Sun, 21 Aug 2022 11:03:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF83160F1A
        for <linux-nfs@vger.kernel.org>; Sun, 21 Aug 2022 18:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252ACC433C1;
        Sun, 21 Aug 2022 18:03:19 +0000 (UTC)
Subject: [PATCH RFC] NFSD: Process some operations before returning
 NFS4ERR_RESOURCE
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     don.brady@delphix.com
Date:   Sun, 21 Aug 2022 14:03:18 -0400
Message-ID: <166110487595.12503.10743719436399570590.stgit@manet.1015granger.net>
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

If an NFS server returns RESOURCE on the first operation in an NFSv4
COMPOUND, there's no way for a client to make forward progress.
Instead, make the server process as many operations in a large
COMPOUND as it can before returning NFS4ERR_RESOURCE on the first
operation it did not process.

Suggested-by: Bruce Fields <bfields@fieldses.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216383
Fixes: 0078117c6d91 ("nfsd: return RESOURCE not GARBAGE_ARGS on too many ops")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Hi-

Request for comments, compile-tested only.

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a72ab97f77ef..094cf4520931 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2633,9 +2633,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	status = nfserr_minor_vers_mismatch;
 	if (nfsd_minorversion(nn, args->minorversion, NFSD_TEST) <= 0)
 		goto out;
-	status = nfserr_resource;
-	if (args->opcnt > NFSD_MAX_OPS_PER_COMPOUND)
-		goto out;
 
 	status = nfs41_check_op_ordering(args);
 	if (status) {
@@ -2650,6 +2647,11 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 
 	trace_nfsd_compound(rqstp, args->opcnt);
 	while (!status && resp->opcnt < args->opcnt) {
+		if (unlikely(resp->opcnt > NFSD_MAX_OPS_PER_COMPOUND)) {
+			status = nfserr_resource;
+			break;
+		}
+
 		op = &args->ops[resp->opcnt++];
 
 		/*


