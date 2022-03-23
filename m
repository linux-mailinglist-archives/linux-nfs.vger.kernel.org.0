Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F724E59C2
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Mar 2022 21:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiCWUUn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Mar 2022 16:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbiCWUUm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Mar 2022 16:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E93071D326
        for <linux-nfs@vger.kernel.org>; Wed, 23 Mar 2022 13:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648066751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uveqk269buC83REhtEYbV8V7SeNs/Lmku709rCSUKxM=;
        b=UspclhEdVJXSjdHHa2bcc1/vWEiR6Kj+3XwsBfJV3/xsgHwSDvxQIQcgKQB5+qCW+BKjOf
        ve1yw2KLhLurJgFVqqAW97sKf3qoq5BwS2aUAW3DgT1lczQ6EVoiqtFYlH2C58RY/VPfjA
        lNzO0nnK1uotZRxxuxKmC2UeMwS6uow=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-Q_5xvPIDNIeYe2QfiRCsEg-1; Wed, 23 Mar 2022 16:19:08 -0400
X-MC-Unique: Q_5xvPIDNIeYe2QfiRCsEg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38D573803917;
        Wed, 23 Mar 2022 20:19:07 +0000 (UTC)
Received: from nyarly.redhat.com (ovpn-116-121.gru2.redhat.com [10.97.116.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D48FC401E24;
        Wed, 23 Mar 2022 20:19:03 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [PATCH RFC v3 3/6] nfsrahead: only set readahead for nfs devices.
Date:   Wed, 23 Mar 2022 17:18:38 -0300
Message-Id: <20220323201841.4166549-4-tbecker@redhat.com>
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

Limit setting the readahead for nfs devices.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 tools/nfsrahead/Makefile.am |   1 +
 tools/nfsrahead/main.c      | 130 ++++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/tools/nfsrahead/Makefile.am b/tools/nfsrahead/Makefile.am
index b598bec3..afccc520 100644
--- a/tools/nfsrahead/Makefile.am
+++ b/tools/nfsrahead/Makefile.am
@@ -1,5 +1,6 @@
 libexec_PROGRAMS = nfsrahead
 nfsrahead_SOURCES = main.c
+nfsrahead_LDFLAGS= -lmount
 
 udev_rulesdir = /etc/udev/rules.d
 udev_rules_DATA = 99-nfs_bdi.rules
diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index e454108e..2cf77424 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -1,7 +1,137 @@
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
 
 int main(int argc, char **argv, char **envp)
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
+	info("Setting %s readahead to 128\n", device.mountpoint);
+
 	printf("%d\n", readahead);
+
+out:
+	free_device_info(&device);
+	return ret;
 }
-- 
2.35.1

