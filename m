Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6D7626B61
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Nov 2022 21:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiKLUGL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 12 Nov 2022 15:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKLUGK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 12 Nov 2022 15:06:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF0311A25
        for <linux-nfs@vger.kernel.org>; Sat, 12 Nov 2022 12:06:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79E0F603F4
        for <linux-nfs@vger.kernel.org>; Sat, 12 Nov 2022 20:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37D5C433D6
        for <linux-nfs@vger.kernel.org>; Sat, 12 Nov 2022 20:06:08 +0000 (UTC)
Subject: [PATCH] NFSD: Fix trace_nfsd_fh_verify_err() crasher
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 12 Nov 2022 15:06:07 -0500
Message-ID: <166828356768.42842.2412588018662481301.stgit@klimt.1015granger.net>
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

Now that the nfsd_fh_verify_err() tracepoint is always called on
error, it needs to handle cases where the filehandle is not yet
fully formed.

Fixes: 93c128e709ae ("nfsd: ensure we always call fh_verify_error tracepoint")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index ef01ecd3eec6..331a33a8f1f8 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -254,7 +254,10 @@ TRACE_EVENT_CONDITION(nfsd_fh_verify_err,
 				  rqstp->rq_xprt->xpt_remotelen);
 		__entry->xid = be32_to_cpu(rqstp->rq_xid);
 		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
-		__entry->inode = d_inode(fhp->fh_dentry);
+		if (fhp->fh_dentry)
+			__entry->inode = d_inode(fhp->fh_dentry);
+		else
+			__entry->inode = NULL;
 		__entry->type = type;
 		__entry->access = access;
 		__entry->error = be32_to_cpu(error);


