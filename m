Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F364E59C3
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Mar 2022 21:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbiCWUUr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Mar 2022 16:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344602AbiCWUUq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Mar 2022 16:20:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31C7E1D328
        for <linux-nfs@vger.kernel.org>; Wed, 23 Mar 2022 13:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648066755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CxnKz8MXVcB+ULznW1aSErNm4XmV2M7ep1zvMLv3XrI=;
        b=AvmmjQyjrotJMYEPWxcGF3EnNf1XqgXkDQR9xC29zBRJiG7A6KedQE+JhUxbk21naacubP
        nKXZrQKjc1pl+tr+YwEABKWI3IBH8MGixMlZOgL+mw44ss5tuRyKSXVCCayHqT8QP4Cqph
        sojSecZfXNUBvQugvrdfS8bJ8lBk9N0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-UdnNw1FVM4WgwSC5V2Zq9Q-1; Wed, 23 Mar 2022 16:19:12 -0400
X-MC-Unique: UdnNw1FVM4WgwSC5V2Zq9Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89F6D3803917;
        Wed, 23 Mar 2022 20:19:11 +0000 (UTC)
Received: from nyarly.redhat.com (ovpn-116-121.gru2.redhat.com [10.97.116.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 276A0401E2A;
        Wed, 23 Mar 2022 20:19:07 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [PATCH RFC v3 4/6] nfsrahead: add logging
Date:   Wed, 23 Mar 2022 17:18:39 -0300
Message-Id: <20220323201841.4166549-5-tbecker@redhat.com>
In-Reply-To: <20220323201841.4166549-1-tbecker@redhat.com>
References: <20220323201841.4166549-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 tools/nfsrahead/Makefile.am |  1 +
 tools/nfsrahead/main.c      | 40 +++++++++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/tools/nfsrahead/Makefile.am b/tools/nfsrahead/Makefile.am
index afccc520..d0b5d170 100644
--- a/tools/nfsrahead/Makefile.am
+++ b/tools/nfsrahead/Makefile.am
@@ -1,6 +1,7 @@
 libexec_PROGRAMS = nfsrahead
 nfsrahead_SOURCES = main.c
 nfsrahead_LDFLAGS= -lmount
+nfsrahead_LDADD = ../../support/nfs/libnfsconf.la
 
 udev_rulesdir = /etc/udev/rules.d
 udev_rules_DATA = 99-nfs_bdi.rules
diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index 2cf77424..86c71a67 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -2,14 +2,19 @@
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <unistd.h>
 
 #include <libmount/libmount.h>
 #include <sys/sysmacros.h>
 
+#include "xlog.h"
+
 #ifndef MOUNTINFO_PATH
 #define MOUNTINFO_PATH "/proc/self/mountinfo"
 #endif
 
+#define CONF_NAME "nfsrahead"
+
 /* Device information from the system */
 struct device_info {
 	char *device_number;
@@ -108,26 +113,49 @@ static int get_device_info(const char *device_number, struct device_info *device
 	return ret;
 }
 
+#define L_DEFAULT (L_WARNING | L_ERROR | L_FATAL)
+
 int main(int argc, char **argv, char **envp)
 {
 	int ret = 0;
 	struct device_info device;
-	unsigned int readahead = 128;
-
-	if (argc != 2) {
-		return -EINVAL;
+	unsigned int readahead = 128, verbose = 0, log_stderr = 0;
+	char opt;
+
+	while((opt = getopt(argc, argv, "dF")) != -1) {
+		switch (opt) {
+		case 'd':
+			verbose = 1;
+			break;
+		case 'F':
+			log_stderr = 1;
+			break;
+		}
 	}
 
-	if ((ret = get_device_info(argv[1], &device)) != 0) {
+	xlog_stderr(log_stderr);
+	xlog_syslog(~log_stderr);
+	xlog_config(L_DEFAULT | (L_NOTICE & verbose), 1);
+	xlog_open(CONF_NAME);
+
+	// xlog_err causes the system to exit
+	if ((argc - optind) != 1)
+		xlog_err("expected the device number of a BDI; is udev ok?");
+
+	if ((ret = get_device_info(argv[optind], &device)) != 0) {
+		xlog(L_ERROR, "unable to find device %s\n", argv[optind]);
 		goto out;
 	}
 
 	if (strncmp("nfs", device.fstype, 3) != 0) {
+		xlog(L_NOTICE,
+			"not setting readahead for non supported fstype %s on device %s\n",
+			device.fstype, argv[optind]);
 		ret = -EINVAL;
 		goto out;
 	}
 
-	info("Setting %s readahead to 128\n", device.mountpoint);
+	xlog(L_WARNING, "setting %s readahead to %d\n", device.mountpoint, readahead);
 
 	printf("%d\n", readahead);
 
-- 
2.35.1

