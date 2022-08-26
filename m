Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4177F5A25C8
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Aug 2022 12:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbiHZKZJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 06:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343528AbiHZKZD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 06:25:03 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5F052E6F
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 03:24:59 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id RWWFoZTcKez1rRWWGoYyY8; Fri, 26 Aug 2022 12:24:57 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 26 Aug 2022 12:24:57 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: Fix a memory leak in an error handling path
Date:   Fri, 26 Aug 2022 12:24:54 +0200
Message-Id: <122a5729fdcd76e23641c7d1853de2a632f6a742.1661509473.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If this memdup_user() call fails, the memory allocated in a previous call
a few lines above should be freed. Otherwise it leaks.

Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Speculative, untested.
---
 fs/nfsd/nfs4recover.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index b29d27eaa8a6..248ff9f4141c 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -815,8 +815,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 				princhash.data = memdup_user(
 						&ci->cc_princhash.cp_data,
 						princhashlen);
-				if (IS_ERR_OR_NULL(princhash.data))
+				if (IS_ERR_OR_NULL(princhash.data)) {
+					kfree(name.data);
 					return -EFAULT;
+				}
 				princhash.len = princhashlen;
 			} else
 				princhash.len = 0;
-- 
2.34.1

