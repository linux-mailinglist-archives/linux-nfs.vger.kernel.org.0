Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E477731FB1
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbjFOSIZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 14:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbjFOSIY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 14:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D8A2961
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686852456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fT8ul1K/mQ3T0AwnZLmNWm35RcgN5+/lAAAbW3Or/38=;
        b=cj99owB2PgktIMb+mabJo102dxInIecv83Icp/Aw8vRuVyJvAYCAgvTA4hJsoJG0bZph9J
        QmmF3tJqQAHogSUFj3uRMNpIZmxBZ4OxKJQsONgXyVvIBFjS4vSo30mRLlh/FaQmL+OMEo
        Juqf+Fzqtlx19PW2342eePDSSRfvmpQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-CoOtIV3jPgi50XO2o1tFyQ-1; Thu, 15 Jun 2023 14:07:34 -0400
X-MC-Unique: CoOtIV3jPgi50XO2o1tFyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64446185A795
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:34 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24FFB2166B25
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:34 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 03/11] NFS: Open-code the nfs_kset kset_create_and_add()
Date:   Thu, 15 Jun 2023 14:07:24 -0400
Message-Id: <5324b8f02f6abda62fc6e59382791e48af8be4d3.1686851158.git.bcodding@redhat.com>
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

In preparation to make objects below /sys/fs/nfs namespace aware, we need
to define our own kobj_type for the nfs kset so that we can add the
.child_ns_type member in a following patch.  No functional change here, only
the unrolling of kset_create_and_add().

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/sysfs.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 8f89aeca6272..9adb8ac08d9a 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -25,12 +25,23 @@ static void nfs_netns_object_release(struct kobject *kobj)
 	kfree(kobj);
 }
 
+static void nfs_kset_release(struct kobject *kobj)
+{
+	struct kset *kset = container_of(kobj, struct kset, kobj);
+	kfree(kset);
+}
+
 static const struct kobj_ns_type_operations *nfs_netns_object_child_ns_type(
 		const struct kobject *kobj)
 {
 	return &net_ns_type_operations;
 }
 
+static struct kobj_type nfs_kset_type = {
+	.release = nfs_kset_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
 static struct kobj_type nfs_netns_object_type = {
 	.release = nfs_netns_object_release,
 	.sysfs_ops = &kobj_sysfs_ops,
@@ -55,13 +66,32 @@ static struct kobject *nfs_netns_object_alloc(const char *name,
 
 int nfs_sysfs_init(void)
 {
-	nfs_kset = kset_create_and_add("nfs", NULL, fs_kobj);
+	int ret;
+
+	nfs_kset = kzalloc(sizeof(*nfs_kset), GFP_KERNEL);
 	if (!nfs_kset)
 		return -ENOMEM;
+
+	ret = kobject_set_name(&nfs_kset->kobj, "nfs");
+	if (ret) {
+		kfree(nfs_kset);
+		return ret;
+	}
+
+	nfs_kset->kobj.parent = fs_kobj;
+	nfs_kset->kobj.ktype = &nfs_kset_type;
+	nfs_kset->kobj.kset = NULL;
+
+	ret = kset_register(nfs_kset);
+	if (ret) {
+		kfree(nfs_kset);
+		return ret;
+	}
+
 	nfs_net_kobj = nfs_netns_object_alloc("net", nfs_kset, NULL);
 	if (!nfs_net_kobj) {
 		kset_unregister(nfs_kset);
-		nfs_kset = NULL;
+		kfree(nfs_kset);
 		return -ENOMEM;
 	}
 	return 0;
-- 
2.40.1

