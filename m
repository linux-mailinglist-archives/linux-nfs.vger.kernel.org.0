Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA6564E6D6
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Dec 2022 06:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiLPFMg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Dec 2022 00:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiLPFM0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Dec 2022 00:12:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AEA19C29
        for <linux-nfs@vger.kernel.org>; Thu, 15 Dec 2022 21:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671167497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pxjl/oAE6RzM07KJ581i8Rf7gzBIXul6YUa9IBovkKk=;
        b=do19fnZGZgs7xEwqyJlY9/EwTrdNM4dcf+EFQ9FL/5+CtoTV6pehiQywfWIh2CEC9YpMZv
        kuBNy4fKbYhgO544b+ikYHKK69/Scpc2Eli0rcJt6vCfcFSp7UDnMjaWfoRUQ3vYSUg+Ev
        ae9WDlb175pqmC/5rt7xAMbE4wFvX18=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-Kk8TaQYWNjmij9XwBB6yxw-1; Fri, 16 Dec 2022 00:11:36 -0500
X-MC-Unique: Kk8TaQYWNjmij9XwBB6yxw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21A95101A55E
        for <linux-nfs@vger.kernel.org>; Fri, 16 Dec 2022 05:11:36 +0000 (UTC)
Received: from localhost (unknown [10.66.60.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75F10400F5A;
        Fri, 16 Dec 2022 05:11:35 +0000 (UTC)
From:   Zhi Li <yieli@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Zhi Li <yieli@redhat.com>
Subject: [PATCH] [nfs/nfs-utils/libtirpc] getnetconfigent: avoid potential DoS issue by removing unnecessary sleep
Date:   Fri, 16 Dec 2022 13:11:32 +0800
Message-Id: <20221216051132.2569403-1-yieli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Zhi Li <yieli@redhat.com>
---
 src/getnetconfig.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/getnetconfig.c b/src/getnetconfig.c
index cfd33c2..9acd8c7 100644
--- a/src/getnetconfig.c
+++ b/src/getnetconfig.c
@@ -439,7 +439,6 @@ getnetconfigent(netid)
 	fprintf(stderr, "See UPDATING entry 20021216 for details.\n");
 	fprintf(stderr, "Continuing in 10 seconds\n\n");
 	fprintf(stderr, "This warning will be removed 20030301\n");
-	sleep(10);
 
     }
 
-- 
2.38.1

