Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A1554EB2D
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jun 2022 22:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378666AbiFPU3H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jun 2022 16:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378653AbiFPU3G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jun 2022 16:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4934C5B3E3
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jun 2022 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655411344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5Hr2VYvXX1tdApUxGfR+NIaa3qtnHHAMnCbLPFlMupg=;
        b=T4ru5CIyCQDaRK0ZrbReELGohMnP3Nb+320Qzdu/mCNwL46s4ifJEMYgEBL5QkDcEik6vS
        Ugbpr+f0ROcGaYNtqAzDRZO70jqMnz9uUqGSRsq++ZcuFiKo26+vYQ4is2vL8ecbOBfZUA
        J9b8BvOgf1n8bwycJpnXeyvis7Ubofw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-IGTBrLQPNRy-gJjYj9yY8Q-1; Thu, 16 Jun 2022 16:29:03 -0400
X-MC-Unique: IGTBrLQPNRy-gJjYj9yY8Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5D441D33866
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jun 2022 20:29:02 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (unknown [10.2.16.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8AE840334E
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jun 2022 20:29:02 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/4] Makefile: Added the creation of config.guess and config.sub
Date:   Thu, 16 Jun 2022 16:28:59 -0400
Message-Id: <20220616202902.53969-1-steved@redhat.com>
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
 .gitignore | 2 ++
 Makefile   | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/.gitignore b/.gitignore
index df58159..72bdb22 100644
--- a/.gitignore
+++ b/.gitignore
@@ -6,6 +6,8 @@
 aclocal.m4
 autom4te.cache/
 config.log
+config.guess
+config.sub
 config.status
 configure
 include/builddefs
diff --git a/Makefile b/Makefile
index 5302e11..be7454d 100644
--- a/Makefile
+++ b/Makefile
@@ -60,6 +60,7 @@ clean:	# if configure hasn't run, nothing to clean
 endif
 
 $(CONFIGURE): aclocal.m4
+	autoreconf --install
 	autoconf
 	./configure \
 		--prefix=/ \
@@ -96,3 +97,5 @@ install-lib: default
 realclean distclean: clean
 	rm -f $(LDIRT) $(CONFIGURE)
 	rm -rf autom4te.cache Logs
+	rm -rf config.guess config.sub configure~
+
-- 
2.36.1

