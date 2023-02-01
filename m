Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F576864DD
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Feb 2023 11:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjBAK6P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Feb 2023 05:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBAK6P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Feb 2023 05:58:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B65CDD7
        for <linux-nfs@vger.kernel.org>; Wed,  1 Feb 2023 02:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675249050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J+C9U/BbzHtjpC4uZcIYnW7RXFdIpm7vvdmLAYNajOs=;
        b=PGD7ljQJiH+Uz84RYbVhcuq9SCD8MiIb3b8RixuwPiNYkJq9+IVoUv+xCULR04TPzOtOOh
        XE4dJC25ou4g/bXN127E2bdlpTCMBhn/4RzOSdaFb/E1RZSgijmbbWzZlz81m7Q5KAqU4a
        3VuYU2Dlwxfl1kmGqlBJ47mWfKsuqK4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-36wqC79rNUWtUlgHVGFZTw-1; Wed, 01 Feb 2023 05:57:29 -0500
X-MC-Unique: 36wqC79rNUWtUlgHVGFZTw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 397448027ED
        for <linux-nfs@vger.kernel.org>; Wed,  1 Feb 2023 10:57:29 +0000 (UTC)
Received: from localhost (unknown [10.66.60.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97B93140EBF4;
        Wed,  1 Feb 2023 10:57:28 +0000 (UTC)
From:   Zhi Li <yieli@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Zhi Li <yieli@redhat.com>
Subject: [PATCH] [nfs/nfs-utils/libtirpc] getnetconfig.c: free linep to avoid memory leakage
Date:   Wed,  1 Feb 2023 18:57:25 +0800
Message-Id: <20230201105725.3500063-1-yieli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
 src/getnetconfig.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/getnetconfig.c b/src/getnetconfig.c
index 9acd8c7..afbf8b5 100644
--- a/src/getnetconfig.c
+++ b/src/getnetconfig.c
@@ -507,9 +507,7 @@ getnetconfigent(netid)
 	    break;
 	}
     } while (stringp != NULL);
-    if (ncp == NULL) {
-	free(linep);
-    }
+    free(linep);
     fclose(file);
     return(ncp);
 }
-- 
2.39.0

