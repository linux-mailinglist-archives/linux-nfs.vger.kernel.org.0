Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371A16EB071
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 19:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjDURTd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 13:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjDURT3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 13:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC3A30FB
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682097523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RjShONusOdEpIJwGrDOuO3fRc0vE5MoNwmON3dpd1WA=;
        b=Lv7r5SZUN3+eaoJ76TUMQZpFB9jogPKDlhnn/I8ewKB73Atq89eNbVruYfQcDj2N6T0eHO
        fbu3HR28QYSOAEwSaj0bRjlbpaYKcp2yQB7ceVJKreLtv1mYn1NuPN4neH9FWX5Zx0ayXE
        HZTaWYwQ8LVfp7slDty76cKmf3ARpYA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-ogkn5ZLYNoWNRv2yHdd7og-1; Fri, 21 Apr 2023 13:18:42 -0400
X-MC-Unique: ogkn5ZLYNoWNRv2yHdd7og-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A63B7800047
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:18:41 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 501D240C2064
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:18:41 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/9] NFS: rename nfs_client_kobj to nfs_net_kobj
Date:   Fri, 21 Apr 2023 13:18:32 -0400
Message-Id: <af2abf7f9623ca23968f442626dc2cc421964918.1682097420.git.bcodding@redhat.com>
In-Reply-To: <cover.1682097420.git.bcodding@redhat.com>
References: <cover.1682097420.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
2.39.2

