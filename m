Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35F7731FB2
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbjFOSI1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 14:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbjFOSIY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 14:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E8295E
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686852455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOnTFTtf4uACONN9wRMJEN7Rg2Z4ONqw3pzQkh21PjE=;
        b=Kxpx4Wj9eBWfPkrowVB3g4fbluSoo6madXBkhYkjZN98+mbSwuXsVPc1ILyvucR6oMqshE
        /UhcFDI1mU+zsy+5eq9PfLuSOyCm4elNeCQx/jHB8ButBtVi9BwZkHexKU92cabPLxup4I
        cOsks5vVSqfF1cT+Zh6nlm7cPKSPICw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-Yr3yt7W_N9Gyl6aaaaWONQ-1; Thu, 15 Jun 2023 14:07:34 -0400
X-MC-Unique: Yr3yt7W_N9Gyl6aaaaWONQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90F9E1C05146
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:33 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 537402166B27
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:33 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 01/11] NFS: rename nfs_client_kset to nfs_kset
Date:   Thu, 15 Jun 2023 14:07:22 -0400
Message-Id: <698994379a2d17dded9f853bbdf3649345808126.1686851158.git.bcodding@redhat.com>
In-Reply-To: <cover.1686851158.git.bcodding@redhat.com>
References: <cover.1686851158.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Be brief and match the subsystem name.  There's no need to distinguish this
kset variable from the server.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/sysfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 0cbcd2dfa732..81d98727b79f 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -18,7 +18,7 @@
 #include "sysfs.h"
 
 struct kobject *nfs_client_kobj;
-static struct kset *nfs_client_kset;
+static struct kset *nfs_kset;
 
 static void nfs_netns_object_release(struct kobject *kobj)
 {
@@ -55,13 +55,13 @@ static struct kobject *nfs_netns_object_alloc(const char *name,
 
 int nfs_sysfs_init(void)
 {
-	nfs_client_kset = kset_create_and_add("nfs", NULL, fs_kobj);
-	if (!nfs_client_kset)
+	nfs_kset = kset_create_and_add("nfs", NULL, fs_kobj);
+	if (!nfs_kset)
 		return -ENOMEM;
-	nfs_client_kobj = nfs_netns_object_alloc("net", nfs_client_kset, NULL);
+	nfs_client_kobj = nfs_netns_object_alloc("net", nfs_kset, NULL);
 	if  (!nfs_client_kobj) {
-		kset_unregister(nfs_client_kset);
-		nfs_client_kset = NULL;
+		kset_unregister(nfs_kset);
+		nfs_kset = NULL;
 		return -ENOMEM;
 	}
 	return 0;
@@ -70,7 +70,7 @@ int nfs_sysfs_init(void)
 void nfs_sysfs_exit(void)
 {
 	kobject_put(nfs_client_kobj);
-	kset_unregister(nfs_client_kset);
+	kset_unregister(nfs_kset);
 }
 
 static ssize_t nfs_netns_identifier_show(struct kobject *kobj,
@@ -159,7 +159,7 @@ static struct nfs_netns_client *nfs_netns_client_alloc(struct kobject *parent,
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (p) {
 		p->net = net;
-		p->kobject.kset = nfs_client_kset;
+		p->kobject.kset = nfs_kset;
 		if (kobject_init_and_add(&p->kobject, &nfs_netns_client_type,
 					parent, "nfs_client") == 0)
 			return p;
-- 
2.40.1

