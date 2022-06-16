Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5A054EB2E
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jun 2022 22:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378653AbiFPU3I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jun 2022 16:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378664AbiFPU3G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jun 2022 16:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDCE85C74F
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jun 2022 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655411345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c95RB5sUuj8zeo/zntmmgVuTfefS+E+oCIeWB3YYEGE=;
        b=Rxtk9kA0bK+wGeLRCXHUXMgHMOBqRHcU1w6OCEiSFEFdLvSQJWn86lfVvxDYSIikmnTTLX
        ouxjBolqtYNA7X1HFJf52y4lC83fopTCIbp8TyxU8RhRbENU701Lie6R8Foh0U6/8q2KWI
        fcfFYihDn1HDGc4LBoDOcJ4pfm68AD0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-a_ZC7cADM-Ga5QPTueNQng-1; Thu, 16 Jun 2022 16:29:03 -0400
X-MC-Unique: a_ZC7cADM-Ga5QPTueNQng-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 702C485A580
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jun 2022 20:29:03 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (unknown [10.2.16.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4224E40334E
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jun 2022 20:29:03 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 3/4] nfs4_print_ace_verbose: Removed a differ in signedness warning
Date:   Thu, 16 Jun 2022 16:29:01 -0400
Message-Id: <20220616202902.53969-3-steved@redhat.com>
In-Reply-To: <20220616202902.53969-1-steved@redhat.com>
References: <20220616202902.53969-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 libnfs4acl/nfs4_print_ace_verbose.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libnfs4acl/nfs4_print_ace_verbose.c b/libnfs4acl/nfs4_print_ace_verbose.c
index 96a6573..ef87e89 100644
--- a/libnfs4acl/nfs4_print_ace_verbose.c
+++ b/libnfs4acl/nfs4_print_ace_verbose.c
@@ -64,7 +64,7 @@ int nfs4_print_ace_verbose(struct nfs4_ace * ace, u32 is_dir)
 	char * whotype_s;
 	char * type_s;
 	u32 flag;
-	u32 whotype;
+	int whotype;
 	u32 mask;
 
 
-- 
2.36.1

