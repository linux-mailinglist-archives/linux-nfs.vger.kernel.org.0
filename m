Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98059731FBD
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 20:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbjFOSJU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 14:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbjFOSJL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 14:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DABF2966
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 11:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686852459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5d62LYF124oeb/BesGsQXSjeTeKHA5VtqDdajWVJ29s=;
        b=f6TeQg+p3gFJYgKGZkJFW7CaTFdK/ElwC6lXbqfdNq4B/44lrQMKCUOBI6AQbQ5+TRoHdu
        c2OmQkrxYI1k8idUyj4YgU1po/3ouOlnMK/a5AzYVP5rwdWT2LDfbdsLzdollzpn+pxymK
        rVzCpKeOhT6VP1sx+TeEzrsmo8JT1i4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-PMPYv6cXPKO1B0WE-jiJKg-1; Thu, 15 Jun 2023 14:07:36 -0400
X-MC-Unique: PMPYv6cXPKO1B0WE-jiJKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AECE802A55
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:36 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F8B82166B25
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:36 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 08/11] NFS: add a sysfs link to the acl rpc_client
Date:   Thu, 15 Jun 2023 14:07:29 -0400
Message-Id: <25a56c714773dba74f034a132f08529d07eed063.1686851158.git.bcodding@redhat.com>
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

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs3client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index 669cda757a5c..d6726b830c7c 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -4,6 +4,8 @@
 #include <linux/sunrpc/addr.h>
 #include "internal.h"
 #include "nfs3_fs.h"
+#include "netns.h"
+#include "sysfs.h"
 
 #ifdef CONFIG_NFS_V3_ACL
 static struct rpc_stat		nfsacl_rpcstat = { &nfsacl_program };
@@ -31,6 +33,8 @@ static void nfs_init_server_aclclient(struct nfs_server *server)
 	if (IS_ERR(server->client_acl))
 		goto out_noacl;
 
+	nfs_sysfs_link_rpc_client(server, server->client_acl, NULL);
+
 	/* No errors! Assume that Sun nfsacls are supported */
 	server->caps |= NFS_CAP_ACLS;
 	return;
-- 
2.40.1

