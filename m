Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34CC72B353
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Jun 2023 19:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjFKRqQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Jun 2023 13:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjFKRqP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Jun 2023 13:46:15 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Jun 2023 10:46:12 PDT
Received: from smtpdh16-2.aruba.it (smtpdh16-2.aruba.it [62.149.155.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F25B1B7
        for <linux-nfs@vger.kernel.org>; Sun, 11 Jun 2023 10:46:12 -0700 (PDT)
Received: from localhost.localdomain ([146.241.109.39])
        by Aruba Outgoing Smtp  with ESMTPSA
        id 8P7lqAnlZgE4H8P7lqw6vm; Sun, 11 Jun 2023 19:45:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1686505509; bh=/u2UIhs06EIdaw0lKNg8GbbMsebWmhpyhvCbLKiRVD0=;
        h=From:To:Subject:Date:MIME-Version;
        b=bv/Qh8ynFQUiOHjce3Yr61qJkFrb3XZ+FonG1QeQLlw42dpdd4THcTadxoCi09h8K
         G1mR+feHLL8fzgD9fN61hhwyZLgvUKdB4wQoNqEHzDQRkw1Rq8cEZSLhEHJd2k+9dU
         fjmOd5w86uQ6RmkdB1nMqpqdpvVm8E74Uka9xg2oT+aWXJ6yu9piJScB0LS5kt0l8C
         +WoKdgWu4DID8feYd9B2qFulIuSpOvkTx453kvdWwmHOq3BrktVEuSpZ4+iG58VLpv
         PnZrhSHS47qCmusWcXFrOfMdZUBK1Ys6zD7jiBAudi2+kkq3WSYEmYC/xNhEcN0GaX
         a63FzUmKTVp0w==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-nfs@vger.kernel.org
Cc:     Bernd Kuhls <bernd.kuhls@t-online.de>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH] support/reexport: guard dlfcn.h include with HAVE_DLFCN_H
Date:   Sun, 11 Jun 2023 19:45:06 +0200
Message-Id: <20230611174506.3432934-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNJ8hWLk+SeiB5BVAf+pnazzSw6W/Pm6Q8XFCiRwVt5odQzZSxEPJlu0+ZRUDv1xmdpJDRECJBRMeu2Rc17/zlFjKqIQzl+iyC5dGyWdHDOr0g6tUSRc
 We7KTxCWY9j4zUJRqqMeUVCVpdSeV8AoN9pzanlUVF7pyWfd2iKbqmG+MFiZ/wV5EhS83z8VIw5CB/PR4CWKNRtsEdaHuVuGnWET9puBckbay0VVI9vZcpYl
 KgYe3eI1w5sHkuMs1TUI5Ry96fh2O0vDfWwMBsE0tK6ARjhtFuBI/nAND4QoKS9m1n92w2xJmMNIC4YlvgEsh+Y740PDTdI03Nczl4Lp4Mc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Bernd Kuhls <bernd.kuhls@t-online.de>

Signed-off-by: Bernd Kuhls <bernd.kuhls@t-online.de>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 support/reexport/fsidd.c    | 2 ++
 support/reexport/reexport.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
index 37649d06..d4b245e8 100644
--- a/support/reexport/fsidd.c
+++ b/support/reexport/fsidd.c
@@ -3,7 +3,9 @@
 #endif
 
 #include <assert.h>
+#ifdef HAVE_DLFCN_H
 #include <dlfcn.h>
+#endif
 #include <event2/event.h>
 #include <limits.h>
 #include <stdint.h>
diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
index d597a2f7..d9a700af 100644
--- a/support/reexport/reexport.c
+++ b/support/reexport/reexport.c
@@ -2,7 +2,9 @@
 #include <config.h>
 #endif
 
+#ifdef HAVE_DLFCN_H
 #include <dlfcn.h>
+#endif
 #include <stdint.h>
 #include <stdio.h>
 #include <sys/random.h>
-- 
2.34.1

