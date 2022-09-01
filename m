Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676D85A8D4D
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 07:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiIAF1R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 01:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiIAF1Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 01:27:16 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6211090B9
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 22:27:15 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id TcjQoTjxou8plTcjQoThk9; Thu, 01 Sep 2022 07:27:13 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 01 Sep 2022 07:27:13 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/3] nfsd: Avoid some useless tests
Date:   Thu,  1 Sep 2022 07:27:11 +0200
Message-Id: <567c75570345fee506fb56d0c13cf9369931100a.1662009844.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <14d802144c88da0eb9e201b3acbf4bde376b2473.1662009844.git.christophe.jaillet@wanadoo.fr>
References: <14d802144c88da0eb9e201b3acbf4bde376b2473.1662009844.git.christophe.jaillet@wanadoo.fr>
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

memdup_user() can't return NULL, so there is no point for checking for it.

Simplify some tests accordingly.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/nfsd/nfs4recover.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 248ff9f4141c..2968cf604e3b 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -807,7 +807,7 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 			if (get_user(namelen, &ci->cc_name.cn_len))
 				return -EFAULT;
 			name.data = memdup_user(&ci->cc_name.cn_id, namelen);
-			if (IS_ERR_OR_NULL(name.data))
+			if (IS_ERR(name.data))
 				return -EFAULT;
 			name.len = namelen;
 			get_user(princhashlen, &ci->cc_princhash.cp_len);
@@ -815,7 +815,7 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 				princhash.data = memdup_user(
 						&ci->cc_princhash.cp_data,
 						princhashlen);
-				if (IS_ERR_OR_NULL(princhash.data)) {
+				if (IS_ERR(princhash.data)) {
 					kfree(name.data);
 					return -EFAULT;
 				}
@@ -829,7 +829,7 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 			if (get_user(namelen, &cnm->cn_len))
 				return -EFAULT;
 			name.data = memdup_user(&cnm->cn_id, namelen);
-			if (IS_ERR_OR_NULL(name.data))
+			if (IS_ERR(name.data))
 				return -EFAULT;
 			name.len = namelen;
 		}
-- 
2.34.1

