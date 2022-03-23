Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20B74E59C0
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Mar 2022 21:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240576AbiCWUUk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Mar 2022 16:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbiCWUUi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Mar 2022 16:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 277581D326
        for <linux-nfs@vger.kernel.org>; Wed, 23 Mar 2022 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648066746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bscHmgw0OZbi6DZ+A6tyxhJLvQ2/1p1aAPJTdVqgpDs=;
        b=EaN3hZ1rtIsQ/TdiZcAwaJcUBnIa8aSyexH0RpuDpUG++Qas/M72v5ovEzY44MGyEKy16D
        cbvuxY70A1yphrP3eUP6dEOFeEBXkT0Pb2DqeLZ5eqwqI2xd/nNAcqrbvX8a2fYpQtC2PN
        t+o7iXydwfENFWTtzelvPlyvRkcEQjE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-hnBsdI67PKmusLni_o_b2g-1; Wed, 23 Mar 2022 16:19:03 -0400
X-MC-Unique: hnBsdI67PKmusLni_o_b2g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E99621C0337C;
        Wed, 23 Mar 2022 20:19:02 +0000 (UTC)
Received: from nyarly.redhat.com (ovpn-116-121.gru2.redhat.com [10.97.116.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 89562401E24;
        Wed, 23 Mar 2022 20:18:59 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [PATCH RFC v3 2/6] nfsrahead: configure udev
Date:   Wed, 23 Mar 2022 17:18:37 -0300
Message-Id: <20220323201841.4166549-3-tbecker@redhat.com>
In-Reply-To: <20220323201841.4166549-1-tbecker@redhat.com>
References: <20220323201841.4166549-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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
 .gitignore                          | 1 +
 tools/nfsrahead/99-nfs_bdi.rules.in | 1 +
 tools/nfsrahead/Makefile.am         | 8 ++++++++
 3 files changed, 10 insertions(+)
 create mode 100644 tools/nfsrahead/99-nfs_bdi.rules.in

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
diff --git a/tools/nfsrahead/99-nfs_bdi.rules.in b/tools/nfsrahead/99-nfs_bdi.rules.in
new file mode 100644
index 00000000..7d55b407
--- /dev/null
+++ b/tools/nfsrahead/99-nfs_bdi.rules.in
@@ -0,0 +1 @@
+SUBSYSTEM=="bdi", ACTION=="add", PROGRAM="_libexecdir_/nfsrahead", ATTR{read_ahead_kb}="%c"
diff --git a/tools/nfsrahead/Makefile.am b/tools/nfsrahead/Makefile.am
index edff7921..b598bec3 100644
--- a/tools/nfsrahead/Makefile.am
+++ b/tools/nfsrahead/Makefile.am
@@ -1,3 +1,11 @@
 libexec_PROGRAMS = nfsrahead
 nfsrahead_SOURCES = main.c
 
+udev_rulesdir = /etc/udev/rules.d
+udev_rules_DATA = 99-nfs_bdi.rules
+
+99-nfs_bdi.rules: 99-nfs_bdi.rules.in $(builddefs)
+	$(SED) "s|_libexecdir_|@libexecdir@|g" 99-nfs_bdi.rules.in > $@
+
+clean-local:
+	$(RM) 99-nfs_bdi.rules
-- 
2.35.1

