Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2299962621A
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 20:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiKKTgo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 14:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiKKTgn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 14:36:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0034A787B8
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 11:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F3C0620C3
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 19:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96ABFC433D6;
        Fri, 11 Nov 2022 19:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668195402;
        bh=iPU2ya7vrzgXAOb87/v2umBwtkGSZt9BZbUd7t73RfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=paBcyv9PTBQaCumnFg5+dRWJJAmXL1FVcxBhNu4xwBhgW5nQPcq0B0J5ku/2tRbyB
         eFMSfzBnJFeY5QEN/GrHFSkVZH09lEW1Qij2yVeIpvJ44Pn7uBFcNa5I8nLIgSCJSg
         ktwZYvV/dZsGgWhn6hDNNTXZP4YdkXATliVSHnu4iihFhVo9AjC/C4ICnZ+8BraoV5
         RZk/Fi4qRd+Jtv7cpluz7/u2msZSP2Wgm+QZubxQPPDG1vxoOJZrEYp2xsPaAheQ5V
         dHLEov/TBzKVu/kILcOuQRlBDbkktk0mSuRGaUxXz+qhWxuzcKmZUVlkltnwhq2kWu
         BCgrvhWH0BByw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] lockd: set missing fl_flags field when retrieving args
Date:   Fri, 11 Nov 2022 14:36:36 -0500
Message-Id: <20221111193639.346992-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193639.346992-1-jlayton@kernel.org>
References: <20221111193639.346992-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svc4proc.c | 1 +
 fs/lockd/svcproc.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 284b019cb652..b72023a6b4c1 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -52,6 +52,7 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 		*filp = file;
 
 		/* Set up the missing parts of the file_lock structure */
+		lock->fl.fl_flags = FL_POSIX;
 		lock->fl.fl_file  = file->f_file[mode];
 		lock->fl.fl_pid = current->tgid;
 		lock->fl.fl_start = (loff_t)lock->lock_start;
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index e35c05e27806..32784f508c81 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -77,6 +77,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
 		/* Set up the missing parts of the file_lock structure */
 		mode = lock_to_openmode(&lock->fl);
+		lock->fl.fl_flags = FL_POSIX;
 		lock->fl.fl_file  = file->f_file[mode];
 		lock->fl.fl_pid = current->tgid;
 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
-- 
2.38.1

