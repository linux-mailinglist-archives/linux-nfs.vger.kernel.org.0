Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4546B1B52
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Mar 2023 07:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCIGVR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Mar 2023 01:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCIGVQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Mar 2023 01:21:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853B662DB5
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 22:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678342830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JFokQHIjXYFyeTHYgRE3xFYltw7h+XQtRMZf1xTco78=;
        b=GcBBFvtEBrtCmvNrQKVFVOrLLlqBKTki07g9ppZ69fvQ8Kp5WffN5wag9i0Ifbjw/nE/Ti
        qomu3vQ6USmwwZ37karMuiQOTh4fvwg7VBNz1bqcJQGPOCu2eT6HcEnoakeV87aX0EOiyO
        Sdvx3yV0xyVPl1r1AqV/82sTpUiqCyA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-XXFSNnuxMJm74qIArlrutA-1; Thu, 09 Mar 2023 01:20:29 -0500
X-MC-Unique: XXFSNnuxMJm74qIArlrutA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 528D7101A52E
        for <linux-nfs@vger.kernel.org>; Thu,  9 Mar 2023 06:20:29 +0000 (UTC)
Received: from localhost (unknown [10.66.60.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB42A4024CA3;
        Thu,  9 Mar 2023 06:20:28 +0000 (UTC)
From:   Zhi Li <yieli@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Zhi Li <yieli@redhat.com>
Subject: [PATCH] [nfs/nfs-utils] rpcdebug: avoid buffer underflow if read() returns 0
Date:   Thu,  9 Mar 2023 14:20:25 +0800
Message-Id: <20230309062025.731671-1-yieli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2176740

Signed-off-by: Zhi Li <yieli@redhat.com>
---
 tools/rpcdebug/rpcdebug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rpcdebug/rpcdebug.c b/tools/rpcdebug/rpcdebug.c
index 68206cc5..ec05179e 100644
--- a/tools/rpcdebug/rpcdebug.c
+++ b/tools/rpcdebug/rpcdebug.c
@@ -257,7 +257,7 @@ get_flags(char *module)
 		perror(filename);
 		exit(1);
 	}
-	if ((len = read(sysfd, buffer, sizeof(buffer))) < 0) {
+	if ((len = read(sysfd, buffer, sizeof(buffer))) <= 0) {
 		perror("read");
 		exit(1);
 	}
-- 
2.39.0

