Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED3B5150F5
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 18:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbiD2Qjg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 12:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiD2Qje (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 12:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D15DD95E0
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 09:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651250175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L7FTrF/yPZzmSwhUZJ73xkpPE9UAiqxcprGWHSAIFZo=;
        b=GhmVdDsmLf9pPFW3G/HwOyJgCtJOiYkWFseM38wBCEhle/WC2N6QVRt6ZoFSIWQeR9Q9+x
        OyId2tJgciN9VcfL7naobAzT5z53y7H9/YUb9mTxVglrDnyCzuestbYaAaWzX5rmOISOgT
        zQCX7pnBQM4ygAgHkARami1/rycQle8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-sJ8I6IoOOrKK0yU45XnzQg-1; Fri, 29 Apr 2022 12:36:13 -0400
X-MC-Unique: sJ8I6IoOOrKK0yU45XnzQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 461638015BA
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 16:36:13 +0000 (UTC)
Received: from nyarly.redhat.com (ovpn-116-126.gru2.redhat.com [10.97.116.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0439840CF8E5;
        Fri, 29 Apr 2022 16:36:10 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Thiago Becker <tbecker@redhat.com>
Subject: [PATCH] nfsrahead: fix and improve logging.
Date:   Fri, 29 Apr 2022 13:36:04 -0300
Message-Id: <20220429163604.1645422-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Logging was not working properly wrt verbosity, it is changed by
changing the facilities used. While at logging, add some extra logs when
verbose that may be important.

Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 tools/nfsrahead/main.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index 83a389f7..5fae941c 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -85,8 +85,10 @@ static int get_mountinfo(const char *device_number, struct device_info *device_i
 
 	mnttbl = mnt_new_table();
 
-	if ((ret = mnt_table_parse_file(mnttbl, mountinfo_path)) < 0)
+	if ((ret = mnt_table_parse_file(mnttbl, mountinfo_path)) < 0) {
+		xlog(D_GENERAL, "Failed to parse %s\n", mountinfo_path);
 		goto out_free_tbl;
+	}
 
 	if ((fs = mnt_table_find_devno(mnttbl, device_info->dev, MNT_ITER_FORWARD)) == NULL) {
 		ret = ENOENT;
@@ -130,19 +132,20 @@ static int conf_get_readahead(const char *kind) {
 	
 	return readahead;
 }
-#define L_DEFAULT (L_WARNING | L_ERROR | L_FATAL)
 
 int main(int argc, char **argv)
 {
 	int ret = 0, retry;
 	struct device_info device;
-	unsigned int readahead = 128, verbose = 0, log_stderr = 0;
+	unsigned int readahead = 128, log_level, log_stderr = 0;
 	char opt;
 
+
+	log_level = D_ALL & ~D_GENERAL;
 	while((opt = getopt(argc, argv, "dF")) != -1) {
 		switch (opt) {
 		case 'd':
-			verbose = 1;
+			log_level = D_ALL;
 			break;
 		case 'F':
 			log_stderr = 1;
@@ -154,7 +157,7 @@ int main(int argc, char **argv)
 
 	xlog_stderr(log_stderr);
 	xlog_syslog(~log_stderr);
-	xlog_config(L_DEFAULT | (L_NOTICE & verbose), 1);
+	xlog_config(log_level, 1);
 	xlog_open(CONF_NAME);
 
 	// xlog_err causes the system to exit
@@ -166,12 +169,12 @@ int main(int argc, char **argv)
 			break;
 
 	if (ret != 0) {
-		xlog(L_ERROR, "unable to find device %s\n", argv[optind]);
+		xlog(D_GENERAL, "unable to find device %s\n", argv[optind]);
 		goto out;
 	}
 
 	if (strncmp("nfs", device.fstype, 3) != 0) {
-		xlog(L_NOTICE,
+		xlog(D_GENERAL,
 			"not setting readahead for non supported fstype %s on device %s\n",
 			device.fstype, argv[optind]);
 		ret = -EINVAL;
@@ -180,7 +183,7 @@ int main(int argc, char **argv)
 
 	readahead = conf_get_readahead(device.fstype);
 
-	xlog(L_WARNING, "setting %s readahead to %d\n", device.mountpoint, readahead);
+	xlog(D_FAC7, "setting %s readahead to %d\n", device.mountpoint, readahead);
 
 	printf("%d\n", readahead);
 
-- 
2.35.1

