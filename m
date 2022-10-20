Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A1B605758
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Oct 2022 08:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJTGd3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Oct 2022 02:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJTGd0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Oct 2022 02:33:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A96E182C47
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 23:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666247602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fMA1E2Hw3MC8hEokEoRIXv/YOYeMtvblIFcNBzR0+JI=;
        b=NjhyP+mwfZQeascQcaSIe3alhXTiECSW8qBhhdOe/153YpnGUsXRNqVjSoSz/XumSeSlZe
        9pPpTpfQTgV2+UKREGkcqfE4aH5Mvy3ew1VaUhe+NlXPphCpVLA5Slul1b3ekfCA42qtm0
        dMJ4EQAXo5VrGRToQQBhRaD1QYnFvV8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-Ao9OlWxWNY2wMoEinQ_8dA-1; Thu, 20 Oct 2022 02:33:21 -0400
X-MC-Unique: Ao9OlWxWNY2wMoEinQ_8dA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7C8286E91F
        for <linux-nfs@vger.kernel.org>; Thu, 20 Oct 2022 06:33:20 +0000 (UTC)
Received: from localhost (unknown [10.66.60.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0DEE4047A8;
        Thu, 20 Oct 2022 06:33:18 +0000 (UTC)
From:   Zhi Li <yieli@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Zhi Li <yieli@redhat.com>
Subject: [PATCH] [nfs/nfs-utils/libtirpc] bindresvport.c: fix a potential resource leakage
Date:   Thu, 20 Oct 2022 14:33:09 +0800
Message-Id: <20221020063309.3674419-1-yieli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Close the FILE *fp of load_blacklist() in another
return path to avoid potential resource leakage.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2135405
Signed-off-by: Zhi Li <yieli@redhat.com>
---
 src/bindresvport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bindresvport.c b/src/bindresvport.c
index 5c0ddcf..efeb1cc 100644
--- a/src/bindresvport.c
+++ b/src/bindresvport.c
@@ -130,6 +130,7 @@ load_blacklist (void)
 	  if (list == NULL)
 	    {
 	      free (buf);
+	      fclose (fp);
 	      return;
 	    }
 	}
-- 
2.31.1

