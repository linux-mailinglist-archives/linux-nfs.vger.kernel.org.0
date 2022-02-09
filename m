Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00ED4AF3A0
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 15:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiBIOHG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Feb 2022 09:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiBIOHG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Feb 2022 09:07:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7189C061355
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 06:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644415628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ogt/gClpGSLdJk7Fhx8WqpIAlEtkn1/rbWZyb8V5vRA=;
        b=elcfErKX5aad5w7YgGpHrjrZ1sWBJGLzDDPiippRxSEZeAK6mYlCFN0ZJk9fPGbKokfM6y
        Ja9NLHUyvRMS8cQjx/mFbFzlt1HFuEQ3PwDyLN9X/fzj7mUUDjqKwzDGioStLJGPCR9Y8A
        BIvyWBWCeMp9QoPoq31mK+Aqf42VlwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-qerw7t1PPK2nzCv4oB6tWA-1; Wed, 09 Feb 2022 09:07:05 -0500
X-MC-Unique: qerw7t1PPK2nzCv4oB6tWA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A26BE344E6;
        Wed,  9 Feb 2022 14:07:02 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A04C105C88C;
        Wed,  9 Feb 2022 14:07:02 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id BA4AF10C30F0; Wed,  9 Feb 2022 09:07:01 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSv4: use unique client identifiers in network namespaces
Date:   Wed,  9 Feb 2022 09:07:01 -0500
Message-Id: <7761eea51000e542e4304c32430e332b6ecac5a5.1644415460.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In order to differentiate client state, assign a random uuid to the
uniquifing portion of the client identifier when a network namespace is
created.  Containers may still override this value if they wish to maintain
stable client identifiers by writing to /sys/fs/nfs/net/client/identifier,
either by udev rules or other means.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/sysfs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 8cb70755e3c9..be05522a2c8b 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -150,6 +150,18 @@ static struct kobj_type nfs_netns_client_type = {
 	.namespace = nfs_netns_client_namespace,
 };
 
+static void assign_unique_clientid(struct nfs_netns_client *clp)
+{
+	unsigned char client_uuid[16];
+	char *uuid_str = kmalloc(UUID_STRING_LEN + 1, GFP_KERNEL);
+
+	if (uuid_str) {
+		generate_random_uuid(client_uuid);
+		sprintf(uuid_str, "%pU", client_uuid);
+		rcu_assign_pointer(clp->identifier, uuid_str);
+	}
+}
+
 static struct nfs_netns_client *nfs_netns_client_alloc(struct kobject *parent,
 		struct net *net)
 {
@@ -157,6 +169,8 @@ static struct nfs_netns_client *nfs_netns_client_alloc(struct kobject *parent,
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (p) {
+		if (net != &init_net)
+			assign_unique_clientid(p);
 		p->net = net;
 		p->kobject.kset = nfs_client_kset;
 		if (kobject_init_and_add(&p->kobject, &nfs_netns_client_type,
-- 
2.31.1

