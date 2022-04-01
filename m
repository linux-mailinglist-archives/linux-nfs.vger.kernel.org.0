Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DD04EF7B3
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Apr 2022 18:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345613AbiDAQLa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Apr 2022 12:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349490AbiDAQI4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Apr 2022 12:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABDE61A2A30
        for <linux-nfs@vger.kernel.org>; Fri,  1 Apr 2022 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648827156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxpdjddWsu965voiUt3RDLYE0ZMWuHvFAPmZcNyp+BY=;
        b=LwMTD6tf+Olbxp+GZRS/yrgHB7fEuWZ2nFIEzlNPyAp0VkrDWr5eYfu+nt+pqmGafywtrc
        +wDWu+5/twcxoO+30s9g64bpp8q/+uzMdf0lImFS5n8C3mSHTUQJzxi9vqwAhkS9pcVLg0
        hSYCnLJWEpWYC/ph3UBBTtZKKdRe8Ao=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-07JyOUMpM-eQM4ODuZ56Pw-1; Fri, 01 Apr 2022 11:32:33 -0400
X-MC-Unique: 07JyOUMpM-eQM4ODuZ56Pw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E34A10AF627;
        Fri,  1 Apr 2022 15:32:32 +0000 (UTC)
Received: from nyarly.redhat.com (ovpn-116-139.gru2.redhat.com [10.97.116.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EA277ADD;
        Fri,  1 Apr 2022 15:32:29 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [PATCH v4 2/7] nfsrahead: configure udev
Date:   Fri,  1 Apr 2022 12:32:03 -0300
Message-Id: <20220401153208.3120851-3-tbecker@redhat.com>
In-Reply-To: <20220401153208.3120851-1-tbecker@redhat.com>
References: <20220401153208.3120851-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Set the udev rule to call the readahead utility.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 .gitignore                      | 1 +
 tools/nfsrahead/99-nfs.rules.in | 1 +
 tools/nfsrahead/Makefile.am     | 8 ++++++++
 3 files changed, 10 insertions(+)
 create mode 100644 tools/nfsrahead/99-nfs.rules.in

diff --git a/.gitignore b/.gitignore
index 38ab1d39..df791a83 100644
--- a/.gitignore
+++ b/.gitignore
@@ -62,6 +62,7 @@ tools/locktest/testlk
 tools/getiversion/getiversion
 tools/nfsconf/nfsconf
 tools/nfsrahead/nfsrahead
+tools/nfsrahead/99-nfs_bdi.rules
 support/export/mount.h
 support/export/mount_clnt.c
 support/export/mount_xdr.c
diff --git a/tools/nfsrahead/99-nfs.rules.in b/tools/nfsrahead/99-nfs.rules.in
new file mode 100644
index 00000000..7d55b407
--- /dev/null
+++ b/tools/nfsrahead/99-nfs.rules.in
@@ -0,0 +1 @@
+SUBSYSTEM=="bdi", ACTION=="add", PROGRAM="_libexecdir_/nfsrahead", ATTR{read_ahead_kb}="%c"
diff --git a/tools/nfsrahead/Makefile.am b/tools/nfsrahead/Makefile.am
index edff7921..58a2ea29 100644
--- a/tools/nfsrahead/Makefile.am
+++ b/tools/nfsrahead/Makefile.am
@@ -1,3 +1,11 @@
 libexec_PROGRAMS = nfsrahead
 nfsrahead_SOURCES = main.c
 
+udev_rulesdir = /usr/lib/udev/rules.d/
+udev_rules_DATA = 99-nfs.rules
+
+99-nfs.rules: 99-nfs.rules.in $(builddefs)
+	$(SED) "s|_libexecdir_|@libexecdir@|g" 99-nfs.rules.in > $@
+
+clean-local:
+	$(RM) 99-nfs.rules
-- 
2.35.1

