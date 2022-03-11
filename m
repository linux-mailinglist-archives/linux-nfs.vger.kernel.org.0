Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B944D68E5
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Mar 2022 20:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351026AbiCKTHs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Mar 2022 14:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351024AbiCKTHs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Mar 2022 14:07:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CED681AE66C
        for <linux-nfs@vger.kernel.org>; Fri, 11 Mar 2022 11:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647025604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aDKX0WZ52rP/HykjpKnFRpyuaJa1s0f5xox0oENgJEA=;
        b=TrjFt+RlGvC4HDXevKWGQxKiquR4gQhMbxeGTZPNWf/Wa6ZOaQdaAPu3jkKhkw/BnqK59r
        lg+O2NZ/P1rBZTbAxc24CEIB6aRfzCpBhpCVSOkqhx7iwv1Bo2cX8gqDnVCtNlbC/DjgbC
        RoaLutcJkyDtmdirqVREK25ZZ373Ijw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259--BZsfN4wNZ2-TAU9bdGcuQ-1; Fri, 11 Mar 2022 14:06:40 -0500
X-MC-Unique: -BZsfN4wNZ2-TAU9bdGcuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74136801AFE;
        Fri, 11 Mar 2022 19:06:39 +0000 (UTC)
Received: from nyarly.rlyeh.local (ovpn-116-72.gru2.redhat.com [10.97.116.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6989C60BF4;
        Fri, 11 Mar 2022 19:06:34 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [RFC v2 PATCH 2/7] readahead: configure udev
Date:   Fri, 11 Mar 2022 16:06:12 -0300
Message-Id: <20220311190617.3294919-3-tbecker@redhat.com>
In-Reply-To: <20220311190617.3294919-1-tbecker@redhat.com>
References: <20220311190617.3294919-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Set the udev rule to call the readahead utility.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 tools/nfs-readahead-udev/99-nfs_bdi.rules.in | 1 +
 tools/nfs-readahead-udev/Makefile.am         | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100644 tools/nfs-readahead-udev/99-nfs_bdi.rules.in

diff --git a/tools/nfs-readahead-udev/99-nfs_bdi.rules.in b/tools/nfs-readahead-udev/99-nfs_bdi.rules.in
new file mode 100644
index 00000000..15f8a995
--- /dev/null
+++ b/tools/nfs-readahead-udev/99-nfs_bdi.rules.in
@@ -0,0 +1 @@
+SUBSYSTEM=="bdi", ACTION=="add", PROGRAM="_libexecdir_/nfs-readahead-udev", ATTR{read_ahead_kb}="%c"
diff --git a/tools/nfs-readahead-udev/Makefile.am b/tools/nfs-readahead-udev/Makefile.am
index 5455e954..873cc175 100644
--- a/tools/nfs-readahead-udev/Makefile.am
+++ b/tools/nfs-readahead-udev/Makefile.am
@@ -1,3 +1,11 @@
 libexec_PROGRAMS = nfs-readahead-udev
 nfs_readahead_udev_SOURCES = main.c
 
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

