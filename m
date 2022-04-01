Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203B24EF798
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Apr 2022 18:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346814AbiDAQLh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Apr 2022 12:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349537AbiDAQI5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Apr 2022 12:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36D441A2A35
        for <linux-nfs@vger.kernel.org>; Fri,  1 Apr 2022 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648827164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hT1eCpJ2y59hfRLRGJ/ytsvTYn8oYfO+eHH4/oNgNVI=;
        b=issB8I64MhI8oM/2arN1DtEbieinCSSV948gLD4gxegp5eZYndpq/4S3pOnF/8uXWJLPL8
        VcI/io3VjSEVvGlJya6XuIUQyfG5GTYUwg/TgO7fHZVxHkd3LaohyTVUWnQE6ByV0TLJLI
        wRSEdNUBbeFrmI78QFpw9nanam0ev9I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-GIzMUgl5O_6BRUW9WOEnjg-1; Fri, 01 Apr 2022 11:32:43 -0400
X-MC-Unique: GIzMUgl5O_6BRUW9WOEnjg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E53848517C3;
        Fri,  1 Apr 2022 15:32:38 +0000 (UTC)
Received: from nyarly.redhat.com (ovpn-116-139.gru2.redhat.com [10.97.116.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 749847ADD;
        Fri,  1 Apr 2022 15:32:33 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [PATCH v4 3/7] nfsrahead: only set readahead for nfs devices.
Date:   Fri,  1 Apr 2022 12:32:04 -0300
Message-Id: <20220401153208.3120851-4-tbecker@redhat.com>
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

Limit setting the readahead for nfs devices.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 tools/nfsrahead/99-nfs.rules.in |   2 +-
 tools/nfsrahead/Makefile.am     |   1 +
 tools/nfsrahead/main.c          | 128 ++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/tools/nfsrahead/99-nfs.rules.in b/tools/nfsrahead/99-nfs.rules.in
index 7d55b407..648813c5 100644
--- a/tools/nfsrahead/99-nfs.rules.in
+++ b/tools/nfsrahead/99-nfs.rules.in
@@ -1 +1 @@
-SUBSYSTEM=="bdi", ACTION=="add", PROGRAM="_libexecdir_/nfsrahead", ATTR{read_ahead_kb}="%c"
+SUBSYSTEM=="bdi", ACTION=="add", PROGRAM="_libexecdir_/nfsrahead %k", ATTR{read_ahead_kb}="%c"
diff --git a/tools/nfsrahead/Makefile.am b/tools/nfsrahead/Makefile.am
index 58a2ea29..0daddc4b 100644
--- a/tools/nfsrahead/Makefile.am
+++ b/tools/nfsrahead/Makefile.am
@@ -1,5 +1,6 @@
 libexec_PROGRAMS = nfsrahead
 nfsrahead_SOURCES = main.c
+nfsrahead_LDFLAGS= -lmount
 
 udev_rulesdir = /usr/lib/udev/rules.d/
 udev_rules_DATA = 99-nfs.rules
diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index 0359aced..8fe6d648 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -1,7 +1,135 @@
 #include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#include <libmount/libmount.h>
+#include <sys/sysmacros.h>
+
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
 
 int main(int argc, char **argv)
 {
+	int ret = 0;
+	struct device_info device;
 	unsigned int readahead = 128;
+
+	if (argc != 2) {
+		return -EINVAL;
+	}
+
+	if ((ret = get_device_info(argv[1], &device)) != 0) {
+		goto out;
+	}
+
+	if (strncmp("nfs", device.fstype, 3) != 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	printf("%d\n", readahead);
+
+out:
+	free_device_info(&device);
+	return ret;
 }
-- 
2.35.1

