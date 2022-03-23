Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1DE4E59C4
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Mar 2022 21:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344608AbiCWUUv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Mar 2022 16:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344336AbiCWUUu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Mar 2022 16:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 230161CB3A
        for <linux-nfs@vger.kernel.org>; Wed, 23 Mar 2022 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648066759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmpjH70Xsoa09i6Q8FK/McGA4ZVZb+tiUFW984XvYLE=;
        b=e05qGbKwTyWMFuxNi9fZr/A87y5Q5gX9UI81kaPmzUyCkIBOxELotrJk5A6iRd9B0LAbrz
        jqJZBJcrmug89j0JGkX2gagYmey/lR5jNInPG0vehFGKU+rWAgw9Moz0hr6ZnrVEiNScos
        5bD6gtNUoJLcJcl0mTNNKmVaoNpiFrk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-j5d-ldpWNi-OtdWEIuePJw-1; Wed, 23 Mar 2022 16:19:16 -0400
X-MC-Unique: j5d-ldpWNi-OtdWEIuePJw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1838185A7BA;
        Wed, 23 Mar 2022 20:19:15 +0000 (UTC)
Received: from nyarly.redhat.com (ovpn-116-121.gru2.redhat.com [10.97.116.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AB78401E8C;
        Wed, 23 Mar 2022 20:19:11 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [PATCH RFC v3 5/6] hfsrahead: get the information from the config file.
Date:   Wed, 23 Mar 2022 17:18:40 -0300
Message-Id: <20220323201841.4166549-6-tbecker@redhat.com>
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
 tools/nfsrahead/main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index 86c71a67..bead9f5c 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -8,12 +8,14 @@
 #include <sys/sysmacros.h>
 
 #include "xlog.h"
+#include "conffile.h"
 
 #ifndef MOUNTINFO_PATH
 #define MOUNTINFO_PATH "/proc/self/mountinfo"
 #endif
 
 #define CONF_NAME "nfsrahead"
+#define NFS_DEFAULT_READAHEAD 128
 
 /* Device information from the system */
 struct device_info {
@@ -113,6 +115,14 @@ static int get_device_info(const char *device_number, struct device_info *device
 	return ret;
 }
 
+static int conf_get_readahead(const char *kind) {
+	int readahead = 0;
+
+	if((readahead = conf_get_num(CONF_NAME, kind, -1)) == -1)
+		readahead = conf_get_num(CONF_NAME, "default", NFS_DEFAULT_READAHEAD);
+	
+	return readahead;
+}
 #define L_DEFAULT (L_WARNING | L_ERROR | L_FATAL)
 
 int main(int argc, char **argv, char **envp)
@@ -133,6 +143,8 @@ int main(int argc, char **argv, char **envp)
 		}
 	}
 
+	conf_init_file(NFS_CONFFILE);
+
 	xlog_stderr(log_stderr);
 	xlog_syslog(~log_stderr);
 	xlog_config(L_DEFAULT | (L_NOTICE & verbose), 1);
@@ -155,6 +167,8 @@ int main(int argc, char **argv, char **envp)
 		goto out;
 	}
 
+	readahead = conf_get_readahead(device.fstype);
+
 	xlog(L_WARNING, "setting %s readahead to %d\n", device.mountpoint, readahead);
 
 	printf("%d\n", readahead);
-- 
2.35.1

