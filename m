Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB4461DAA4
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Nov 2022 14:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiKENtb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Nov 2022 09:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKENtb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Nov 2022 09:49:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8CF12613
        for <linux-nfs@vger.kernel.org>; Sat,  5 Nov 2022 06:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7722E60B45
        for <linux-nfs@vger.kernel.org>; Sat,  5 Nov 2022 13:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A052C433C1;
        Sat,  5 Nov 2022 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667656168;
        bh=z9U6FXSsDJfcG7IWTtRzElXSpoEX/TjKdF3j7No7uug=;
        h=From:To:Cc:Subject:Date:From;
        b=sTaFy11iq5oDEYlEeUbagDo0tyf4VZwmRctAo+ZhgyA1CVoWxmAEniFwn+Tk477SM
         hjc6mmsqVU4ZbMEuF3JsHw3gi5BOKoT+HmoVkqidS3m6C20S7hOa0pjXOG2Ym6Xz+A
         6vgzNiiB5J5zHkPw7FUUJdjnlLkmUUm24PiPoEOoFpKjv97F8PmQ7GJMTu2wi4kav5
         t0lADr8ydb7J9lJida3kH/OGihB2Wx/7qFYjA2owkBhlix5WC4YAb3wGMu+5nRkg5Q
         ODhL9a7hs21epb+Xr+DsSKPWx75Tg/hmCUD2Q4lqZCGMpsmRh1OQ7CdFqrU6WvMNMr
         NuwMZBhs62vWQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH] nfsd: fix use-after-free in nfsd_file_do_acquire tracepoint
Date:   Sat,  5 Nov 2022 09:49:26 -0400
Message-Id: <20221105134926.23726-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When we fail to insert into the hashtable with a non-retryable error,
we'll free the object and then goto out_status. If the tracepoint is
enabled, it'll end up accessing the freed object when it tries to
grab the fields out of it.

Set nf to NULL after freeing it to avoid the issue.

Fixes: 243a5263014a ("nfsd: rework hashtable handling in nfsd_do_file_acquire")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 687ab814b678..02c1454dfe50 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1124,6 +1124,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto open_file;
 
 	nfsd_file_slab_free(&nf->nf_rcu);
+	nf = NULL;
 	if (ret == -EEXIST)
 		goto retry;
 	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
-- 
2.38.1

