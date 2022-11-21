Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EE9632CC6
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Nov 2022 20:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiKUTPk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Nov 2022 14:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKUTPZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Nov 2022 14:15:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC1DF34
        for <linux-nfs@vger.kernel.org>; Mon, 21 Nov 2022 11:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669058072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V+2MiGaSKUhWiPgDG1qKJ1PXk53XtOIju9AXxShg4os=;
        b=SpaJlgHUYh7PkRFQi5i9oJxpZ9OEBWeU6tR275kpE7REYEvNeN9U06+/N3Hvvw7KCJbuhf
        B/0hD7l2pUnDfA5atCuGLj/9DCeM027KJ6RqWYUnm/0jVzNbUltuSRpNzHlslYw4snYtcW
        vnyl1iFGciocFJgp8Neyuqw8HacuQXY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-oIVZY6BmMAeoeCQAB3LFPQ-1; Mon, 21 Nov 2022 14:14:30 -0500
X-MC-Unique: oIVZY6BmMAeoeCQAB3LFPQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E8B5833A09
        for <linux-nfs@vger.kernel.org>; Mon, 21 Nov 2022 19:14:30 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.8.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31C5A40C2087
        for <linux-nfs@vger.kernel.org>; Mon, 21 Nov 2022 19:14:30 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfs4_getfacl: Initialize acl pointer to NULL
Date:   Mon, 21 Nov 2022 14:14:27 -0500
Message-Id: <20221121191427.132409-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs4_getfacl.c: scope_hint: In function 'print_acl_from_path'
nfs4_getfacl.c:168:17: warning[-Wmaybe-uninitialized]:
    'acl' may be used uninitialized in this function

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 nfs4_getfacl/nfs4_getfacl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4_getfacl/nfs4_getfacl.c b/nfs4_getfacl/nfs4_getfacl.c
index 954cf7e..ddb3005 100644
--- a/nfs4_getfacl/nfs4_getfacl.c
+++ b/nfs4_getfacl/nfs4_getfacl.c
@@ -148,7 +148,7 @@ out:
 
 static void print_acl_from_path(const char *fpath, enum acl_type type)
 {
-	struct nfs4_acl *acl;
+	struct nfs4_acl *acl = NULL;
 
 	switch (type) {
 	case ACL_TYPE_ACL:
-- 
2.38.1

