Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28F64D68E7
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Mar 2022 20:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351025AbiCKTIA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Mar 2022 14:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351052AbiCKTH6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Mar 2022 14:07:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35A831AE650
        for <linux-nfs@vger.kernel.org>; Fri, 11 Mar 2022 11:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647025613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Apo17SFTV9dOPZLNaybzvszIuETY629ibw6t+ujy1GE=;
        b=DdtFC1tHAj7LkhQw1ZHW9CyIzXaSf85AsJ1QPqsUAEkypaBcLMt8qs8fb2GeGWdej8inSW
        3B9786WrtSsk4aZGnpC9bDn6RXh9Gznq8BDBGe+7wup0QaxSXe4uRlGbtDlQKlP4A1+YUr
        tidfchOPXeZ/Wmt10BDNdTA3o97yle0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-WUGyyc3MPB2l2BFD_YjIsA-1; Fri, 11 Mar 2022 14:06:50 -0500
X-MC-Unique: WUGyyc3MPB2l2BFD_YjIsA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F12BF51DC;
        Fri, 11 Mar 2022 19:06:48 +0000 (UTC)
Received: from nyarly.rlyeh.local (ovpn-116-72.gru2.redhat.com [10.97.116.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A77C60BF4;
        Fri, 11 Mar 2022 19:06:44 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [RFC v2 PATCH 4/7] readahead: only set readahead for nfs devices.
Date:   Fri, 11 Mar 2022 16:06:14 -0300
Message-Id: <20220311190617.3294919-5-tbecker@redhat.com>
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

Limit setting the readahead for nfs devices.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 tools/nfs-readahead-udev/99-nfs_bdi.rules.in |   2 +-
 tools/nfs-readahead-udev/Makefile.am         |   1 +
 tools/nfs-readahead-udev/main.c              | 132 ++++++++++++++++++-
 3 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/tools/nfs-readahead-udev/99-nfs_bdi.rules.in b/tools/nfs-readahead-udev/99-nfs_bdi.rules.in
index 15f8a995..744c59be 100644
--- a/tools/nfs-readahead-udev/99-nfs_bdi.rules.in
+++ b/tools/nfs-readahead-udev/99-nfs_bdi.rules.in
@@ -1 +1 @@
-SUBSYSTEM=="bdi", ACTION=="add", PROGRAM="_libexecdir_/nfs-readahead-udev", ATTR{read_ahead_kb}="%c"
+SUBSYSTEM=="bdi", ACTION=="add", PROGRAM="_libexecdir_/nfs-readahead-udev %k", ATTR{read_ahead_kb}="%c"
diff --git a/tools/nfs-readahead-udev/Makefile.am b/tools/nfs-readahead-udev/Makefile.am
index 5078db9a..551d22e9 100644
--- a/tools/nfs-readahead-udev/Makefile.am
+++ b/tools/nfs-readahead-udev/Makefile.am
@@ -1,5 +1,6 @@
 libexec_PROGRAMS = nfs-readahead-udev
 nfs_readahead_udev_SOURCES = main.c syslog.c
+nfs_readahead_udev_LDFLAGS= -lmount
 
 udev_rulesdir = /etc/udev/rules.d
 udev_rules_DATA = 99-nfs_bdi.rules
diff --git a/tools/nfs-readahead-udev/main.c b/tools/nfs-readahead-udev/main.c
index dd2c9f8c..bbb408c0 100644
--- a/tools/nfs-readahead-udev/main.c
+++ b/tools/nfs-readahead-udev/main.c
@@ -1,15 +1,145 @@
 #include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#include <libmount/libmount.h>
+#include <sys/sysmacros.h>
 
 #include "log.h"
 
+#ifndef MOUNTINFO_PATH
+#define MOUNTINFO_PATH "/proc/self/mountinfo"
+#endif
+
+/* Device information from the system */
+struct device_info {
+	char *device_number;
+	dev_t dev;
+	char *mountpoint;
+	char *fstype;
+};
+
+/* Convert a string in the format n:m to a device number */
+static dev_t dev_from_arg(const char *device_number)
+{
+	char *s = strdup(device_number), *p;
+	char *maj_s, *min_s;
+	unsigned int maj, min;
+	dev_t dev;
+
+	maj_s = p = s;
+	for ( ; *p != ':'; p++)
+		;
+
+	*p = '\0';
+	min_s = p + 1;
+
+	maj = strtol(maj_s, NULL, 10);
+	min = strtol(min_s, NULL, 10);
+
+	dev = makedev(maj, min);
+
+	free(s);
+	return dev;
+}
+
+#define sfree(ptr) if (ptr) free(ptr)
+
+/* device_info maintenance */
+static void init_device_info(struct device_info *di, const char *device_number)
+{
+	di->device_number = strdup(device_number);
+	di->dev = dev_from_arg(device_number);
+	di->mountpoint = NULL;
+	di->fstype = NULL;
+}
+
+
+static void free_device_info(struct device_info *di)
+{
+	sfree(di->mountpoint);
+	sfree(di->fstype);
+	sfree(di->device_number);
+}
+
+static int get_mountinfo(const char *device_number, struct device_info *device_info, const char *mountinfo_path)
+{
+	int ret = 0;
+	struct libmnt_table *mnttbl;
+	struct libmnt_fs *fs;
+	char *target;
+
+	init_device_info(device_info, device_number);
+
+	mnttbl = mnt_new_table();
+
+	if ((ret = mnt_table_parse_file(mnttbl, mountinfo_path)) < 0)
+		goto out_free_tbl;
+
+	if ((fs = mnt_table_find_devno(mnttbl, device_info->dev, MNT_ITER_FORWARD)) == NULL) {
+		ret = ENOENT;
+		goto out_free_tbl;
+	}
+
+	if ((target = (char *)mnt_fs_get_target(fs)) == NULL) {
+		ret = ENOENT;
+		goto out_free_fs;
+	}
+
+	device_info->mountpoint = strdup(target);
+	target = (char *)mnt_fs_get_fstype(fs);
+	if (target)
+		device_info->fstype = strdup(target);
+
+out_free_fs:
+	mnt_free_fs(fs);
+out_free_tbl:
+	mnt_free_table(mnttbl);
+	free(device_info->device_number);
+	device_info->device_number = NULL;
+	return ret;
+}
+
+static int get_device_info(const char *device_number, struct device_info *device_info)
+{
+	int ret = ENOENT;
+	for (int retry_count = 0; retry_count < 10 && ret != 0; retry_count++)
+		ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
+
+	return ret;
+}
+
 int main(int argc, char **argv, char **envp)
 {
+	int ret = 0;
+	struct device_info device;
 	unsigned int readahead = 128;
 
 	log_open();
 
-	info("Setting the readahead to 128\n");
+	if (argc != 2) {
+		err("Expected device number as argument, got none\n");
+		return -EINVAL;
+	}
+
+	if ((ret = get_device_info(argv[1], &device)) != 0) {
+		err("Failed to find device %s (%d)\n", argv[1], ret);
+		goto out;
+	}
+
+	if (strncmp("nfs", device.fstype, 3) != 0) {
+		ret = -EINVAL;
+		info("Not setting the readahead for fstype %s\n", device.fstype);
+		goto out;
+	}
+
+	info("Setting %s readahead to 128\n", device.mountpoint);
 
 	log_close();
 	printf("%d\n", readahead);
+
+out:
+	free_device_info(&device);
+	return ret;
 }
-- 
2.35.1

