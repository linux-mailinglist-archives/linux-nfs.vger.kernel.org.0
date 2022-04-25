Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7746250E9D9
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Apr 2022 22:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245049AbiDYUEE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Apr 2022 16:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiDYUEE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Apr 2022 16:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78BA490CCA
        for <linux-nfs@vger.kernel.org>; Mon, 25 Apr 2022 13:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650916857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2c+M7J/C99EHmRZ2ed7WZCBt5ls8UbJ2QrJdqTRJXeU=;
        b=RZfmfyZP5d3Se2DdTOwppboTFzQxWpL0UYVzJ7n2Xu8qHpsWhGXCWyw7k/SIzU95+PE1EF
        7yrLeutrU8FPprp3EMZoNGSNv7Y55huOSh9x+ivxeLIx+rY8vtY2V9E+pI4wOdVKTVqSB+
        rAe5XnB9t9CncPtP4+gj2uI881EN6Ko=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-jh7GzwaGNtyvvl3A-3CSOw-1; Mon, 25 Apr 2022 16:00:56 -0400
X-MC-Unique: jh7GzwaGNtyvvl3A-3CSOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4B66381A827;
        Mon, 25 Apr 2022 20:00:55 +0000 (UTC)
Received: from nyarly.redhat.com (ovpn-116-126.gru2.redhat.com [10.97.116.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10DE8141511F;
        Mon, 25 Apr 2022 20:00:52 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org, steved@redhat.com
Cc:     trbecker@gmail.com, Thiago Becker <tbecker@redhat.com>
Subject: [PATCH] nfsrahead: fix oops caused by non-starndard naming schemes
Date:   Mon, 25 Apr 2022 16:59:49 -0300
Message-Id: <20220425195948.2627428-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

brtfs uses a non standard naming scheme for its fs structures, which
causes nfsrahead to take a long time scanning all the memory
available and then crashes. This causes the udev to take forever to
quiesce and delays the system startup.

This t=patch refactors the way the device number is obtained to handle
this situation.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2078147
Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 tools/nfsrahead/main.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index b3af3aa8..83a389f7 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -26,27 +26,31 @@ struct device_info {
 };
 
 /* Convert a string in the format n:m to a device number */
-static dev_t dev_from_arg(const char *device_number)
+static int fill_device_number(struct device_info *info)
 {
-	char *s = strdup(device_number), *p;
+	char *s = strdup(info->device_number), *p;
 	char *maj_s, *min_s;
 	unsigned int maj, min;
-	dev_t dev;
+	int err = -EINVAL;
 
 	maj_s = p = s;
-	for ( ; *p != ':'; p++)
+	for ( ; *p != ':' && *p != '\0'; p++)
 		;
 
+	if (*p == '\0')
+		goto out_free;
+
+	err = 0;
 	*p = '\0';
 	min_s = p + 1;
 
 	maj = strtol(maj_s, NULL, 10);
 	min = strtol(min_s, NULL, 10);
 
-	dev = makedev(maj, min);
-
+	info->dev = makedev(maj, min);
+out_free:
 	free(s);
-	return dev;
+	return err;
 }
 
 #define sfree(ptr) if (ptr) free(ptr)
@@ -55,7 +59,7 @@ static dev_t dev_from_arg(const char *device_number)
 static void init_device_info(struct device_info *di, const char *device_number)
 {
 	di->device_number = strdup(device_number);
-	di->dev = dev_from_arg(device_number);
+	di->dev = 0;
 	di->mountpoint = NULL;
 	di->fstype = NULL;
 }
@@ -76,6 +80,8 @@ static int get_mountinfo(const char *device_number, struct device_info *device_i
 	char *target;
 
 	init_device_info(device_info, device_number);
+	if ((ret = fill_device_number(device_info)) < 0)
+		goto out_free_device_info;
 
 	mnttbl = mnt_new_table();
 
@@ -101,6 +107,7 @@ out_free_fs:
 	mnt_free_fs(fs);
 out_free_tbl:
 	mnt_free_table(mnttbl);
+out_free_device_info:
 	free(device_info->device_number);
 	device_info->device_number = NULL;
 	return ret;
-- 
2.35.1

