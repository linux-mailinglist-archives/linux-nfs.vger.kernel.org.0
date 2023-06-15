Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CD6731FAF
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 20:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjFOSIY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 14:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjFOSIY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 14:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD30A2960
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686852456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5InrBQgPjdorrQx8bstvql7JkCBTYczKXkCkqsj5HQU=;
        b=ZDq7QSmBq30Th6DgJqoEECXm//Wmg3GoftqQzAvIgOv/l9Lp/urXTyMyP7xQB0z8TAR4HL
        AomIFhalTOm9CL/YrM0Vq5boK4gmlBUpSUpIHbjQ8Xt4l691Jpkp1IPiwuKZqLLWprmSfs
        DTvJZUV7utrz1k7Okff4eMQNW50rO7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-e8z-gtM5P5ux_D4EP8cKSw-1; Thu, 15 Jun 2023 14:07:34 -0400
X-MC-Unique: e8z-gtM5P5ux_D4EP8cKSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F37808007CE
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:33 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B59FA2166B25
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:33 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 02/11] NFS: rename nfs_client_kobj to nfs_net_kobj
Date:   Thu, 15 Jun 2023 14:07:23 -0400
Message-Id: <5ce62bff4fe6a234371a8f7e9cfb599c6a53c9e9.1686851158.git.bcodding@redhat.com>
In-Reply-To: <cover.1686851158.git.bcodding@redhat.com>
References: <cover.1686851158.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Match the variable names to the sysfs structure.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/sysfs.c | 10 +++++-----
 fs/nfs/sysfs.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 81d98727b79f..8f89aeca6272 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -17,7 +17,7 @@
 #include "netns.h"
 #include "sysfs.h"
 
-struct kobject *nfs_client_kobj;
+struct kobject *nfs_net_kobj;
 static struct kset *nfs_kset;
 
 static void nfs_netns_object_release(struct kobject *kobj)
@@ -58,8 +58,8 @@ int nfs_sysfs_init(void)
 	nfs_kset = kset_create_and_add("nfs", NULL, fs_kobj);
 	if (!nfs_kset)
 		return -ENOMEM;
-	nfs_client_kobj = nfs_netns_object_alloc("net", nfs_kset, NULL);
-	if  (!nfs_client_kobj) {
+	nfs_net_kobj = nfs_netns_object_alloc("net", nfs_kset, NULL);
+	if (!nfs_net_kobj) {
 		kset_unregister(nfs_kset);
 		nfs_kset = NULL;
 		return -ENOMEM;
@@ -69,7 +69,7 @@ int nfs_sysfs_init(void)
 
 void nfs_sysfs_exit(void)
 {
-	kobject_put(nfs_client_kobj);
+	kobject_put(nfs_net_kobj);
 	kset_unregister(nfs_kset);
 }
 
@@ -172,7 +172,7 @@ void nfs_netns_sysfs_setup(struct nfs_net *netns, struct net *net)
 {
 	struct nfs_netns_client *clp;
 
-	clp = nfs_netns_client_alloc(nfs_client_kobj, net);
+	clp = nfs_netns_client_alloc(nfs_net_kobj, net);
 	if (clp) {
 		netns->nfs_client = clp;
 		kobject_uevent(&clp->kobject, KOBJ_ADD);
diff --git a/fs/nfs/sysfs.h b/fs/nfs/sysfs.h
index 5501ef573c32..0423aaf388c9 100644
--- a/fs/nfs/sysfs.h
+++ b/fs/nfs/sysfs.h
@@ -14,7 +14,7 @@ struct nfs_netns_client {
 	const char __rcu *identifier;
 };
 
-extern struct kobject *nfs_client_kobj;
+extern struct kobject *nfs_net_kobj;
 
 extern int nfs_sysfs_init(void);
 extern void nfs_sysfs_exit(void);
-- 
2.40.1

