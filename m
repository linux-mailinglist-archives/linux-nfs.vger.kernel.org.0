Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DEE6D9936
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 16:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbjDFOL3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 10:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbjDFOLE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 10:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F9F83C1
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680790210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYSAvzEb8NccSDE67japw1gjUZXABwNGTmwr1o2RpJE=;
        b=HHuGoZeMhXhzQ2uytXZVApMLabj7NkM2B233ZvzHpJDQ/4Hx92M6124rV7pJ7pJlff1Ts2
        FN28licRu/jiWNviRdOsMxty/9mckVypMWK7uhLokHdhqun+aKYJYjUIZoweQhlavV8u6N
        79v2VMq6T+5m1hmgWPj8AnPo4LHN+X8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-EanTkk85Ovuskz89a6Q0yQ-1; Thu, 06 Apr 2023 10:10:07 -0400
X-MC-Unique: EanTkk85Ovuskz89a6Q0yQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9278438041DB;
        Thu,  6 Apr 2023 14:10:06 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.10.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35FB72166B26;
        Thu,  6 Apr 2023 14:10:06 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@netapp.com, Olga.Kornievskaia@netapp.com
Subject: [PATCH 2/6] NFS: rename nfs_client_kobj to nfs_net_kobj
Date:   Thu,  6 Apr 2023 10:10:00 -0400
Message-Id: <75aec6f877a89c63478073861cf277bbfcb90453.1680786859.git.bcodding@redhat.com>
In-Reply-To: <cover.1680786859.git.bcodding@redhat.com>
References: <cover.1680786859.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Match the variable names to the sysfs structure.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 81d98727b79f..a496e26fcfb7 100644
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
+	if  (!nfs_net_kobj) {
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
-- 
2.39.2

