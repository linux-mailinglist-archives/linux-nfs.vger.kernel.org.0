Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FBA4AE376
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 23:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbiBHWWc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 17:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386300AbiBHUEB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 15:04:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 369ADC0613CB
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 12:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644350639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0S269LCjxWcMpGdhNWI0ipeissCmHiVKApI+iSPJoa4=;
        b=RNgPN17awCJiB3KP8IJqzD7qaPqvA87+1nU06Gbn3I2s1cgkYftnI15mKB6Xaw/ETf/2jX
        cjDWLzgnSRbGR9rWHV1MYasZxU2ZFxSg5A/mLq+TacWZ5yWSNBIoQ1kqeaR1vBDytNzGo5
        Agu2MGXkBzt6VOSn8CMMw8LUbbWwK/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-EsehiE6HMS2AB9vZjrxXDQ-1; Tue, 08 Feb 2022 15:03:56 -0500
X-MC-Unique: EsehiE6HMS2AB9vZjrxXDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C93A2F44;
        Tue,  8 Feb 2022 20:03:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1B0D6AB83;
        Tue,  8 Feb 2022 20:03:54 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 4042410C30F0; Tue,  8 Feb 2022 15:03:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: use unique client identifiers in network namespaces
Date:   Tue,  8 Feb 2022 15:03:54 -0500
Message-Id: <6e05bf321ff50785360e6c339d111db368e7dfda.1644349990.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
index 8cb70755e3c9..9b811323fd7f 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -167,6 +167,18 @@ static struct nfs_netns_client *nfs_netns_client_alloc(struct kobject *parent,
 	return NULL;
 }
 
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
 void nfs_netns_sysfs_setup(struct nfs_net *netns, struct net *net)
 {
 	struct nfs_netns_client *clp;
@@ -174,6 +186,8 @@ void nfs_netns_sysfs_setup(struct nfs_net *netns, struct net *net)
 	clp = nfs_netns_client_alloc(nfs_client_kobj, net);
 	if (clp) {
 		netns->nfs_client = clp;
+		if (net != &init_net)
+			assign_unique_clientid(clp);
 		kobject_uevent(&clp->kobject, KOBJ_ADD);
 	}
 }
-- 
2.31.1

