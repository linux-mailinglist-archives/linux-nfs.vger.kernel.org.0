Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8551730204
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jun 2023 16:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244513AbjFNObu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jun 2023 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbjFNObu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Jun 2023 10:31:50 -0400
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D99A51FE2;
        Wed, 14 Jun 2023 07:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=cVYBIIX2d+Sp028MpQT1pWWikq80tjf85aI3HAg24s4=; b=D
        TxCIWK49FaWNmX1vnevmckF6M1UUErRGU4kPT/Igk+/4rfxdVnB7kUq5gDQqaAlm
        D9IlN7TeGq0KPnCd1idA//BZVaynneYFmlYHFeMks4rqB4vpa3LmDdeC4V0X4Eb3
        S5AP0IXxIfUTM+ZTbLJaTJkwJzqFmVH6vVVxjR5esk=
Received: from ubuntu.localdomain (unknown [10.230.35.76])
        by app1 (Coremail) with SMTP id XAUFCgBHT78jz4lk5ajrAA--.65257S2;
        Wed, 14 Jun 2023 22:31:00 +0800 (CST)
From:   Chenyuan Mi <cymi20@fudan.edu.cn>
To:     trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chenyuan Mi <cymi20@fudan.edu.cn>
Subject: [PATCH] nfsroot: Fix missing check for return value of strsep()
Date:   Wed, 14 Jun 2023 07:30:58 -0700
Message-Id: <20230614143058.112300-1-cymi20@fudan.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: XAUFCgBHT78jz4lk5ajrAA--.65257S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF15Wr4kKw4kZF4fZFy3CFg_yoWfJFbEk3
        yrJF429w4rtF4DCF1jkrW0yF9FvF4vkr1xur4093ZIk34YvF1Ykr9rJrZ5XF97uwsIvry3
        Cws0yryrtryakjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbs8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbdgA7UUUUU==
X-CM-SenderInfo: isqsiiisuqikmt6i3vldqovvfxof0/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The strsep() function in root_nfs_parse_options() may return NULL 
if argument 'incoming' is NULL. Since 'incoming' has Null check in 
this function, it is also need to add Null check for return value
 of strsep().

Found by our static analysis tool.

Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
---
 fs/nfs/nfsroot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
index 620329b7e6ae..55c594dede9f 100644
--- a/fs/nfs/nfsroot.c
+++ b/fs/nfs/nfsroot.c
@@ -198,7 +198,7 @@ static int __init root_nfs_parse_options(char *incoming, char *exppath,
 	 * Set the NFS remote path
 	 */
 	p = strsep(&incoming, ",");
-	if (*p != '\0' && strcmp(p, "default") != 0)
+	if (p != NULL && *p != '\0' && strcmp(p, "default") != 0)
 		if (root_nfs_copy(exppath, p, exppathlen))
 			return -1;
 
-- 
2.17.1

