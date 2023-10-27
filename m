Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6304B7D9DDA
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 18:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjJ0QS1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 12:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0QS1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 12:18:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4676FCE
        for <linux-nfs@vger.kernel.org>; Fri, 27 Oct 2023 09:18:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03AEC433CA;
        Fri, 27 Oct 2023 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698423504;
        bh=FP4VHWF3u9Bl6WxIbI7FRKj88kdcVsxJgkOlt5BXI1M=;
        h=Subject:From:To:Cc:Date:From;
        b=j6ezMuWBPQCNajcZgNZUg5Rbjvaqt5K+TP7e+t0pnkYri4HDk/bfObZ3KvuvzWML9
         1wdeZwEETrzvqBnnyxpHFwHwgj51oAaOinjbV9oh/F0g+Q3vZCycQr1i+RkJHaZXU5
         yRqoMNDw3vDe2yU6aH1lHQPP0vVitU3ZF0REH39lLREHqkyhRo4pEG2d+fVVMeO95e
         2p8EWVPM0O/fakN1OnAu5DAQ9VYDNQOXfE9MwtIoJiSWr8abqCQsV7H7u5uOmiKD7N
         7VRqe1CIcg7D1xS++OR0s/GftBZlMHntomIuSAam2FKiC9v+j65BKTkrzXSonREMmo
         vynGxYSFEvCoQ==
Subject: [PATCH v1] NFSD: Make the file_delayed_close workqueue UNBOUND
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 27 Oct 2023 12:18:22 -0400
Message-ID: <169842348186.2229.12310023447613634527.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

workqueue: nfsd_file_delayed_close [nfsd] hogged CPU for >13333us 8
	times, consider switching to WQ_UNBOUND

There's no harm in closing a cached file descriptor on another core.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Fodder for v6.8.


diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 07bf219f9ae4..eb0d3fa0e0f9 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -721,7 +721,7 @@ nfsd_file_cache_init(void)
 		return ret;
 
 	ret = -ENOMEM;
-	nfsd_filecache_wq = alloc_workqueue("nfsd_filecache", 0, 0);
+	nfsd_filecache_wq = alloc_workqueue("nfsd_filecache", WQ_UNBOUND, 0);
 	if (!nfsd_filecache_wq)
 		goto out;
 


