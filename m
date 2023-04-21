Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9D96EB047
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjDURJa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 13:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjDURJ2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 13:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6542F40EF
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 10:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682096895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mUqPpBsJy9yXuVdRMY7+DV0E3whm/8u/LqgfTtzlFHI=;
        b=aXw+cEOc1dgldhqiWAh3++sehLB39b01DcPKwGHs+QX43CbmqqiFoWlCHy7aML9+LVTXcT
        LzQGsg2hqsBNl3bJBdN5R24i76CYtk+DUHtM7Z/cgaPIdGpc7uY0VKRHK2dwSUKyLGxOon
        azrjyMiAB/6NyMIfUlSg6jrJcwsQ5kk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-9TTIVe26P5qM6KT-5XvqZg-1; Fri, 21 Apr 2023 13:08:14 -0400
X-MC-Unique: 9TTIVe26P5qM6KT-5XvqZg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CCE0185A78B
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:08:14 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E939D492C13
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:08:13 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/9] NFS: rename nfs_client_kset to nfs_kset
Date:   Fri, 21 Apr 2023 13:08:04 -0400
Message-Id: <698994379a2d17dded9f853bbdf3649345808126.1682096307.git.bcodding@redhat.com>
In-Reply-To: <cover.1682096307.git.bcodding@redhat.com>
References: <cover.1682096307.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
2.39.2

