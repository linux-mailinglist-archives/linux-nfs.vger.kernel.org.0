Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86295BB3FF
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Sep 2022 23:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiIPVic (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Sep 2022 17:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiIPVib (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Sep 2022 17:38:31 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97116AB41F
        for <linux-nfs@vger.kernel.org>; Fri, 16 Sep 2022 14:38:29 -0700 (PDT)
From:   Sam James <sam@gentoo.org>
To:     Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
Cc:     Sam James <sam@gentoo.org>
Subject: [PATCH] Fix more function prototypes
Date:   Fri, 16 Sep 2022 22:38:09 +0100
Message-Id: <20220916213809.2777820-1-sam@gentoo.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

```
regex.c:545:43: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
struct trans_func *libnfsidmap_plugin_init()
                                          ^
                                           void
1 error generated.
```

See: 167f2336b06e1bcbf26f45f2ddc4a535fed4d393
Signed-off-by: Sam James <sam@gentoo.org>
---
 support/nfsidmap/regex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/support/nfsidmap/regex.c b/support/nfsidmap/regex.c
index 958b4ac8..8424179f 100644
--- a/support/nfsidmap/regex.c
+++ b/support/nfsidmap/regex.c
@@ -542,7 +542,7 @@ struct trans_func regex_trans = {
 	.gss_princ_to_grouplist	= regex_gss_princ_to_grouplist,
 };
 
-struct trans_func *libnfsidmap_plugin_init()
+struct trans_func *libnfsidmap_plugin_init(void)
 {
 	return (&regex_trans);
 }
-- 
2.37.3

