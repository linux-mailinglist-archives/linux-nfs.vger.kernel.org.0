Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01120634D6A
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Nov 2022 02:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiKWBrD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Nov 2022 20:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKWBrC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Nov 2022 20:47:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F2774CDD
        for <linux-nfs@vger.kernel.org>; Tue, 22 Nov 2022 17:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669167968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YYPEk6DCV4s0DXwDFMXIAyeEVIlPhBVzUu+RgpdPU1w=;
        b=PZybKJ/8bEGHPzJUZBsSUjG2iV45XCURtAHB6KMwUX9yJ+DmEBYtoAkxQKdxOzOGQdiMKd
        oJVtEA84m30ZcohCvW6NAHneV3varg7jwXFGz99XReSArjRWIVdyR0xCXmYcyEViaHfilI
        kPzQXsU3lbngaSSTkO+w/RRQmvAbSmA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-35lav5jRO0q9E4MweHtwJQ-1; Tue, 22 Nov 2022 20:45:59 -0500
X-MC-Unique: 35lav5jRO0q9E4MweHtwJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA34F3811F2D;
        Wed, 23 Nov 2022 01:45:58 +0000 (UTC)
Received: from localhost (yoyang-vm.hosts.qa.psi.pek2.redhat.com [10.73.149.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CBF917595;
        Wed, 23 Nov 2022 01:45:57 +0000 (UTC)
From:   Yongcheng Yang <yongcheng.yang@gmail.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        Yongcheng Yang <yongcheng.yang@gmail.com>
Subject: [PATCH] nfs4_setfacl: man page example should use the new option index
Date:   Wed, 23 Nov 2022 09:45:50 +0800
Message-Id: <20221123014550.525927-1-yongcheng.yang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
---
 man/man1/nfs4_setfacl.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man1/nfs4_setfacl.1 b/man/man1/nfs4_setfacl.1
index 61699ae..c4b4dbb 100644
--- a/man/man1/nfs4_setfacl.1
+++ b/man/man1/nfs4_setfacl.1
@@ -210,7 +210,7 @@ named `newacl.txt':
 .IP - 2
 delete the first ACE, but only print the resulting ACL (does not save changes):
 .br
-	$ nfs4_setfacl --test -x 1 foo
+	$ nfs4_setfacl --test -x -i 1 foo
 .IP - 2
 delete the last two ACEs above:
 .br
-- 
2.31.1

