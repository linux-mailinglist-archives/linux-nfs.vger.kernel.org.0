Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84054D38C8
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 19:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbiCIS2c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 13:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiCIS2b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 13:28:31 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681B631206
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 10:27:32 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 17-20020a9d0611000000b005b251571643so2381925otn.2
        for <linux-nfs@vger.kernel.org>; Wed, 09 Mar 2022 10:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cw3iv6XGjibkRbBqnfX3hpJe85HzX3v3mvg/CBrmEqs=;
        b=BXbId7WCi0ZTqZRT7ETj4G0yxAwdMxv0IIN9TDIbxzISSgrPFwxyUGgAlD1NLWdH8/
         vl/nx+OlE1+O6hjA0vNJNiAjbcfwbAQYYkW2BigBoV9CnOnAoayZ8/Fb2/nvBhsK8UQP
         hb9gve297DkAdGEEgdtTnXQXf8tM+5Me1p7OWPodfAmV0SWazJ1tXuTjXgDhXKfMwbB9
         xYcUm14meLy2tsSZLcgp/0mx77LV63j0bx+ci/OQjnFk2qDJJwZOwaSdg/I2hftG2g8S
         UmJ3rw1mR1XgzDMCL+1Bm30Q+kYFcVnF4tuEU948xoPKNACqVxfwGqfXcw82bdGBlTQt
         g5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cw3iv6XGjibkRbBqnfX3hpJe85HzX3v3mvg/CBrmEqs=;
        b=0GKSE4MYnb217F+ktJEvTFf33ZH+7OV2cGCkISx5rHsCPceOfLfKa+5CfLP0X811Uo
         AJp51e997myWc+BmYAhCzqZsflKopWdxCsLv1aOVjt9FcudjVJw6TATFtDV7xiVnxXbt
         pTCReNv7iZBoN5J3NrOhJkSu2CaLpRGWmYROKqUW9Exnylah11HHb6Iky7WSbrWMBIVT
         H2gCj1MEy1E/vjXuOoUS78McurjjlwvrYFxntg9rlR+fHwRPporu/9E/9PNpJl+kE26d
         rJ7rWqyP/ibBRpRZ8vJJ4+7eHnVW/+pHIgLF/AIGdmEmr08GojQZZq57re9wk8red1/y
         UZqg==
X-Gm-Message-State: AOAM530t02+5e75rVI4fR6Hq8g1IbdlKfNVeP51kwhSPlHy4rbC6nsFM
        Wt39XEwUa+3wQGfv4nc04jQX+Q5E4jc=
X-Google-Smtp-Source: ABdhPJxv4VJA7riglE0SiCex14eQMYm3UZVThg3hZQ59Ub8D2hlPYaGcZWys+AcYpjRkHy0MKWiS9g==
X-Received: by 2002:a9d:4686:0:b0:5ae:e472:2dda with SMTP id z6-20020a9d4686000000b005aee4722ddamr545117ote.317.1646850451534;
        Wed, 09 Mar 2022 10:27:31 -0800 (PST)
Received: from nyarly.redhat.com ([179.233.246.234])
        by smtp.gmail.com with ESMTPSA id k5-20020a056870a4c500b000d9c2216692sm1213270oal.24.2022.03.09.10.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:27:30 -0800 (PST)
From:   Thiago Rafael Becker <trbecker@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     tbecker@redhat.com, steved@redhat.com, chuck.lever@oracle.com,
        Thiago Rafael Becker <trbecker@gmail.com>
Subject: [RFC PATCH 4/7] readahead: only set readahead for nfs devices.
Date:   Wed,  9 Mar 2022 15:26:50 -0300
Message-Id: <20220309182653.1885252-5-trbecker@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309182653.1885252-1-trbecker@gmail.com>
References: <20220309182653.1885252-1-trbecker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Limit setting the readahead for nfs devices.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Rafael Becker <trbecker@gmail.com>
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

