Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1684EF7B1
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Apr 2022 18:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345171AbiDAQL3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Apr 2022 12:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349668AbiDAQI5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Apr 2022 12:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16BDD1A2A36
        for <linux-nfs@vger.kernel.org>; Fri,  1 Apr 2022 08:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648827165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sYqGNoeKyNfXy/k1csUcqU5ZARls3XYh8BgaVvO+Lk4=;
        b=FL8tzJyIBt9QdbFqoRS9kYtGpxbBt6Nj3Nqc4//F+2l16On3QUiUF1OgM32BaeeWmlybrj
        3GREP3NK9A2ayxv5hsbDFz0REnsPPWDtc4bYfNGJLJMa5diDThpje5KMLLULc38dEDImRB
        KLPcBo68f7XWGbvWRi9SIN6dN21ucuk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-1tWw3ybWMZGZM0SwzAzn9g-1; Fri, 01 Apr 2022 11:32:43 -0400
X-MC-Unique: 1tWw3ybWMZGZM0SwzAzn9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 109192A2AD70;
        Fri,  1 Apr 2022 15:32:43 +0000 (UTC)
Received: from nyarly.redhat.com (ovpn-116-139.gru2.redhat.com [10.97.116.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4ADC9D45;
        Fri,  1 Apr 2022 15:32:39 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [PATCH v4 4/7] nfsrahead: add logging
Date:   Fri,  1 Apr 2022 12:32:05 -0300
Message-Id: <20220401153208.3120851-5-tbecker@redhat.com>
In-Reply-To: <20220401153208.3120851-1-tbecker@redhat.com>
References: <20220401153208.3120851-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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
 tools/nfsrahead/main.c      | 40 ++++++++++++++++++++++++++++++++-----
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/tools/nfsrahead/Makefile.am b/tools/nfsrahead/Makefile.am
index 0daddc4b..60a1102a 100644
--- a/tools/nfsrahead/Makefile.am
+++ b/tools/nfsrahead/Makefile.am
@@ -1,6 +1,7 @@
 libexec_PROGRAMS = nfsrahead
 nfsrahead_SOURCES = main.c
 nfsrahead_LDFLAGS= -lmount
+nfsrahead_LDADD = ../../support/nfs/libnfsconf.la
 
 udev_rulesdir = /usr/lib/udev/rules.d/
 udev_rules_DATA = 99-nfs.rules
diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index 8fe6d648..b630b92f 100644
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
@@ -108,25 +113,50 @@ static int get_device_info(const char *device_number, struct device_info *device
 	return ret;
 }
 
+#define L_DEFAULT (L_WARNING | L_ERROR | L_FATAL)
+
 int main(int argc, char **argv)
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
 
+	xlog(L_WARNING, "setting %s readahead to %d\n", device.mountpoint, readahead);
+
 	printf("%d\n", readahead);
 
 out:
-- 
2.35.1

