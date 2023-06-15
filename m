Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8E731FBB
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 20:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbjFOSJT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 14:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFOSJL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 14:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF5E295C
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686852457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pnv9FB6MTSHu49gbt7VVxfb2Ih5s5uzLL1A7cYQm/bw=;
        b=ST+rbKoCPxiYwteeabe8XWyE+DNizKOdQGZBv0Kmc+Si/HqeqIqd4rfOeGtAiaM0ud54Nj
        B2G8/8/3FyGqZz2iLiMrvEyQ3p+mAmxXyzEKiMoNCeaweGeH9zNHbJVupisph7MGeAOBFm
        QHZAAkW+8zowyk8gOlU35t2UCgKLmBY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-L6yCiJgaPISIlFvMam_EEw-1; Thu, 15 Jun 2023 14:07:35 -0400
X-MC-Unique: L6yCiJgaPISIlFvMam_EEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6DDF811E9E
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:34 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88EF12166B25
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:34 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 04/11] NFS: Make all of /sys/fs/nfs network-namespace unique
Date:   Thu, 15 Jun 2023 14:07:25 -0400
Message-Id: <330aaf5f8e731e08a0ee0894de3ade8d66f5fd53.1686851158.git.bcodding@redhat.com>
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

Expand the NFS network-namespaced sysfs from /sys/fs/nfs/net down one level
into /sys/fs/nfs by moving the "net" kobject onto struct
nfs_netns_client and setting it up during network namespace init.

This prepares the way for superblock kobjects within /sys/fs/nfs that will
only be visible to matching network namespaces.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/sysfs.c | 69 +++++++++++++++++++++++---------------------------
 fs/nfs/sysfs.h |  1 +
 2 files changed, 33 insertions(+), 37 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 9adb8ac08d9a..90256a3a714e 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -17,14 +17,8 @@
 #include "netns.h"
 #include "sysfs.h"
 
-struct kobject *nfs_net_kobj;
 static struct kset *nfs_kset;
 
-static void nfs_netns_object_release(struct kobject *kobj)
-{
-	kfree(kobj);
-}
-
 static void nfs_kset_release(struct kobject *kobj)
 {
 	struct kset *kset = container_of(kobj, struct kset, kobj);
@@ -40,30 +34,9 @@ static const struct kobj_ns_type_operations *nfs_netns_object_child_ns_type(
 static struct kobj_type nfs_kset_type = {
 	.release = nfs_kset_release,
 	.sysfs_ops = &kobj_sysfs_ops,
-};
-
-static struct kobj_type nfs_netns_object_type = {
-	.release = nfs_netns_object_release,
-	.sysfs_ops = &kobj_sysfs_ops,
 	.child_ns_type = nfs_netns_object_child_ns_type,
 };
 
-static struct kobject *nfs_netns_object_alloc(const char *name,
-		struct kset *kset, struct kobject *parent)
-{
-	struct kobject *kobj;
-
-	kobj = kzalloc(sizeof(*kobj), GFP_KERNEL);
-	if (kobj) {
-		kobj->kset = kset;
-		if (kobject_init_and_add(kobj, &nfs_netns_object_type,
-					parent, "%s", name) == 0)
-			return kobj;
-		kobject_put(kobj);
-	}
-	return NULL;
-}
-
 int nfs_sysfs_init(void)
 {
 	int ret;
@@ -88,18 +61,11 @@ int nfs_sysfs_init(void)
 		return ret;
 	}
 
-	nfs_net_kobj = nfs_netns_object_alloc("net", nfs_kset, NULL);
-	if (!nfs_net_kobj) {
-		kset_unregister(nfs_kset);
-		kfree(nfs_kset);
-		return -ENOMEM;
-	}
 	return 0;
 }
 
 void nfs_sysfs_exit(void)
 {
-	kobject_put(nfs_net_kobj);
 	kset_unregister(nfs_kset);
 }
 
@@ -157,7 +123,6 @@ static void nfs_netns_client_release(struct kobject *kobj)
 			kobject);
 
 	kfree(rcu_dereference_raw(c->identifier));
-	kfree(c);
 }
 
 static const void *nfs_netns_client_namespace(const struct kobject *kobj)
@@ -181,6 +146,25 @@ static struct kobj_type nfs_netns_client_type = {
 	.namespace = nfs_netns_client_namespace,
 };
 
+static void nfs_netns_object_release(struct kobject *kobj)
+{
+	struct nfs_netns_client *c = container_of(kobj,
+			struct nfs_netns_client,
+			nfs_net_kobj);
+	kfree(c);
+}
+
+static const void *nfs_netns_namespace(const struct kobject *kobj)
+{
+	return container_of(kobj, struct nfs_netns_client, nfs_net_kobj)->net;
+}
+
+static struct kobj_type nfs_netns_object_type = {
+	.release = nfs_netns_object_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.namespace =  nfs_netns_namespace,
+};
+
 static struct nfs_netns_client *nfs_netns_client_alloc(struct kobject *parent,
 		struct net *net)
 {
@@ -190,9 +174,18 @@ static struct nfs_netns_client *nfs_netns_client_alloc(struct kobject *parent,
 	if (p) {
 		p->net = net;
 		p->kobject.kset = nfs_kset;
+		p->nfs_net_kobj.kset = nfs_kset;
+
+		if (kobject_init_and_add(&p->nfs_net_kobj, &nfs_netns_object_type,
+					parent, "net") != 0) {
+			kobject_put(&p->nfs_net_kobj);
+			return NULL;
+		}
+
 		if (kobject_init_and_add(&p->kobject, &nfs_netns_client_type,
-					parent, "nfs_client") == 0)
+					&p->nfs_net_kobj, "nfs_client") == 0)
 			return p;
+
 		kobject_put(&p->kobject);
 	}
 	return NULL;
@@ -202,7 +195,7 @@ void nfs_netns_sysfs_setup(struct nfs_net *netns, struct net *net)
 {
 	struct nfs_netns_client *clp;
 
-	clp = nfs_netns_client_alloc(nfs_net_kobj, net);
+	clp = nfs_netns_client_alloc(&nfs_kset->kobj, net);
 	if (clp) {
 		netns->nfs_client = clp;
 		kobject_uevent(&clp->kobject, KOBJ_ADD);
@@ -217,6 +210,8 @@ void nfs_netns_sysfs_destroy(struct nfs_net *netns)
 		kobject_uevent(&clp->kobject, KOBJ_REMOVE);
 		kobject_del(&clp->kobject);
 		kobject_put(&clp->kobject);
+		kobject_del(&clp->nfs_net_kobj);
+		kobject_put(&clp->nfs_net_kobj);
 		netns->nfs_client = NULL;
 	}
 }
diff --git a/fs/nfs/sysfs.h b/fs/nfs/sysfs.h
index 0423aaf388c9..dc4cc9809d1b 100644
--- a/fs/nfs/sysfs.h
+++ b/fs/nfs/sysfs.h
@@ -10,6 +10,7 @@
 
 struct nfs_netns_client {
 	struct kobject kobject;
+	struct kobject nfs_net_kobj;
 	struct net *net;
 	const char __rcu *identifier;
 };
-- 
2.40.1

