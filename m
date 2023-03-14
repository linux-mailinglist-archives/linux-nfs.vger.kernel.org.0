Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11D46B8B38
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Mar 2023 07:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjCNGa7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Mar 2023 02:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCNGa7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Mar 2023 02:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C9C8E3C6
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 23:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678775410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KQ1+YRo7HYdcCxZJ40gVJ913WNiB2tJFEiczX6jMlDY=;
        b=Wq+LGm4v84f1otqBUfIJ6EAj0aicxjROlEt26XkVg4U+Ln09OUpGuFudGRTiqIALddSML0
        i3YhMjPl+Wg66ffwEwAXmHvsJbG98+LDt/1CdCR25zqEUUV8W362UvJUkJeyRr/fEve7sY
        6/jsSfHcS99Ernf74pbRMvLVtgFIa7k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-5bOs5to-NC68BcDexOqRnA-1; Tue, 14 Mar 2023 02:30:08 -0400
X-MC-Unique: 5bOs5to-NC68BcDexOqRnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62F1A85A5A3;
        Tue, 14 Mar 2023 06:30:08 +0000 (UTC)
Received: from localhost (yoyang-vm.hosts.qa.psi.pek2.redhat.com [10.73.149.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAEFD140E95F;
        Tue, 14 Mar 2023 06:30:07 +0000 (UTC)
From:   Yongcheng Yang <yongcheng.yang@gmail.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        Yongcheng Yang <yongcheng.yang@gmail.com>
Subject: [PATCH nfs-utils v2] nfsmount.conf: Fix typo of the attribute name
Date:   Tue, 14 Mar 2023 14:30:04 +0800
Message-Id: <20230314063004.3660-1-yongcheng.yang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
 utils/mount/nfsmount.conf | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/utils/mount/nfsmount.conf b/utils/mount/nfsmount.conf
index 342063f7..c498eb80 100644
--- a/utils/mount/nfsmount.conf
+++ b/utils/mount/nfsmount.conf
@@ -59,13 +59,13 @@
 # acregmin=30
 #
 # The Maximum time (in seconds) file attributes are cached
-# acregmin=60
+# acregmax=60
 #
 # The minimum time (in seconds) directory attributes are cached
-# acregmin=30
+# acdirmin=30
 #
 # The Maximum time (in seconds) directory attributes are cached
-# acregmin=60
+# acdirmax=60
 #
 # Enable Access  Control  Lists
 # Acl=False
-- 
2.31.1

