Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DDF5BB40E
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Sep 2022 23:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiIPVnH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Sep 2022 17:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiIPVnF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Sep 2022 17:43:05 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F33AB36
        for <linux-nfs@vger.kernel.org>; Fri, 16 Sep 2022 14:43:04 -0700 (PDT)
From:   Sam James <sam@gentoo.org>
To:     Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
Cc:     Sam James <sam@gentoo.org>
Subject: [PATCH v2] Fix more function prototypes
Date:   Fri, 16 Sep 2022 22:43:00 +0100
Message-Id: <20220916214300.2820117-1-sam@gentoo.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 utils/idmapd/idmapd.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index e79c124d..cd9a965f 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -867,7 +867,7 @@ nfsdreopen_one(struct idmap_client *ic)
 }
 
 static void
-nfsdreopen()
+nfsdreopen(void)
 {
 	nfsdreopen_one(&nfsd_ic[IC_NAMEID]);
 	nfsdreopen_one(&nfsd_ic[IC_IDNAME]);
-- 
2.37.3

