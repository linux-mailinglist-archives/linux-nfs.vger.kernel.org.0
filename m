Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA64F7D81FC
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Oct 2023 13:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjJZLqe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Oct 2023 07:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJZLqd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Oct 2023 07:46:33 -0400
Received: from smtpdh19-2.aruba.it (smtpdh19-2.aruba.it [62.149.155.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F0B1AA
        for <linux-nfs@vger.kernel.org>; Thu, 26 Oct 2023 04:46:29 -0700 (PDT)
Received: from localhost.localdomain ([146.241.115.208])
        by Aruba Outgoing Smtp  with ESMTPSA
        id vynjq3v5QpgXYvynkqNRmW; Thu, 26 Oct 2023 13:45:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1698320724; bh=jlJtLNeYYvrH/ejRagp39LOLG/wo5TAnJrPDTCu4WZM=;
        h=From:To:Subject:Date:MIME-Version;
        b=AXUd3v+BDOzZTFdVWoUrRZDQ1NYbZ64z8qWqPj1CaOITkqtnJQm/StEafMKRHCHm8
         Oot9w7e2vNSEXARCBqGbY4bykdHIcBSf8azCZjmJ+PbAa141ji9VGIzI3xJSwqrkNG
         jkEMIYL7XHvZ7ZSNnz4R/BAAUtlukh514Qsv17w8N9yEd1CJMDbHhjfSSa54MeqSfo
         pNdkTFF0IW/DvTjps4Z5YE+KL833XjsU5fgWbX//xN5ojk7I0XHaIkNkRrkWzQdJp5
         HLQFtniuPGcmbzcS1Ja+t56Kqb3usS6riFkyDGZgL0n8kYEC1YBltMr8yNwZQsMhcH
         BUEXShoS2VbFA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-nfs@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [nfs-utils 2/2] Drop unused <sys/random.h>
Date:   Thu, 26 Oct 2023 13:45:22 +0200
Message-Id: <20231026114522.567140-2-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026114522.567140-1-giulio.benetti@benettiengineering.com>
References: <20231026114522.567140-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBnFJPwrl4qZ93xF+YbgNxlS5bjEzWrXp9fcU/XlXFmw6h7cFTHQeWaXsNoRl+ViXeqkENgUpjqWkM84hBvYGLxqYCfdfgEhDH5x/EQf6yLV0hIfz6/T
 7iFHGNxb4RD3LGx2HMpMdOpIjnkhmUwaknCJ6TW0kUs/U1FV/kVmmUw2OJnFcqBbFdiJx9QzhCCrbKUIKC9/25KTrVxD0de7jh5UM+rI49HFHcx7NDiOPHg8
 lgllnoKP2qfbbYgurwN114AKWzudGxde7upU6BrfKyCbhKXgmodKare8/m6yiLQL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 support/reexport/fsidd.c    | 1 -
 support/reexport/reexport.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
index d4b245e8..352de1be 100644
--- a/support/reexport/fsidd.c
+++ b/support/reexport/fsidd.c
@@ -10,7 +10,6 @@
 #include <limits.h>
 #include <stdint.h>
 #include <stdio.h>
-#include <sys/random.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
 #include <sys/types.h>
diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
index d9a700af..c59e6b2f 100644
--- a/support/reexport/reexport.c
+++ b/support/reexport/reexport.c
@@ -7,7 +7,6 @@
 #endif
 #include <stdint.h>
 #include <stdio.h>
-#include <sys/random.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/vfs.h>
-- 
2.34.1

