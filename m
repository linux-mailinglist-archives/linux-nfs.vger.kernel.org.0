Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDE86D9935
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 16:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbjDFOLZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 10:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbjDFOLA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 10:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A753A5ED
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680790212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tnsNxdQEZC7vQus465DcOx9VIXBa//NgGizP6y3E330=;
        b=AzDhP+7CP/t9FTlnjSoXDYrx3C529T5uYT+Rqp+coifjvJqCy56FNlHA0kEatK/tuHQZa4
        +SjYiKQUAa+nRv0/7O/DFHxr312OdbisImbidf9doBArLvr4aDMqLf39cXGy3JqHMQp51v
        vLkWfMhaHIfJBacSUFsIZ+wQVD6J1i4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-OCOYcHf_OTGkEYiYNKjhYA-1; Thu, 06 Apr 2023 10:10:09 -0400
X-MC-Unique: OCOYcHf_OTGkEYiYNKjhYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0C61380406B;
        Thu,  6 Apr 2023 14:10:08 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.10.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 529302166B26;
        Thu,  6 Apr 2023 14:10:08 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@netapp.com, Olga.Kornievskaia@netapp.com
Subject: [PATCH 6/6] NFS: add a sysfs link to the acl rpc_client
Date:   Thu,  6 Apr 2023 10:10:04 -0400
Message-Id: <9b6dde0e6024ffdb3d4d5d62e20a59d8784512d9.1680786859.git.bcodding@redhat.com>
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
2.39.2

