Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C2B6E3109
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Apr 2023 13:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjDOLIN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Apr 2023 07:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjDOLIM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Apr 2023 07:08:12 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7A435AE
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 04:08:10 -0700 (PDT)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 33FB7rq4082153;
        Sat, 15 Apr 2023 20:07:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Sat, 15 Apr 2023 20:07:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 33FB7rCZ082150
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 15 Apr 2023 20:07:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
Date:   Sat, 15 Apr 2023 20:07:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Frank van der Linden <fllinden@amazon.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since GFP_KERNEL is GFP_NOFS | __GFP_FS, usage like GFP_KERNEL | GFP_NOFS
does not make sense. Drop __GFP_FS flag in order to avoid deadlock.

Fixes: 32119446bb65 ("nfsd: define xattr functions to call into their vfs counterparts")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/nfsd/vfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5783209f17fc..109b31246666 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2164,7 +2164,7 @@ nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 		goto out;
 	}
 
-	buf = kvmalloc(len, GFP_KERNEL | GFP_NOFS);
+	buf = kvmalloc(len, GFP_NOFS);
 	if (buf == NULL) {
 		err = nfserr_jukebox;
 		goto out;
@@ -2230,7 +2230,7 @@ nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char **bufp,
 	/*
 	 * We're holding i_rwsem - use GFP_NOFS.
 	 */
-	buf = kvmalloc(len, GFP_KERNEL | GFP_NOFS);
+	buf = kvmalloc(len, GFP_NOFS);
 	if (buf == NULL) {
 		err = nfserr_jukebox;
 		goto out;
-- 
2.34.1
