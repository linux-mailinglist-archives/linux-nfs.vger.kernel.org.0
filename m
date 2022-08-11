Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A3059067A
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Aug 2022 20:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbiHKSrL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Aug 2022 14:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235871AbiHKSrL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Aug 2022 14:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B4999DB55
        for <linux-nfs@vger.kernel.org>; Thu, 11 Aug 2022 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660243629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tKa8Zo8DnnxZqw1wSkCNDC6gtaPhUL/XYbFFI8FC8cA=;
        b=QxKQaMTIqFiNS5kiUw+21NxozRnGvRKo7LVSZfMJdQPxTD2QBGPyD+8PkbZ5hPU/3iMcyc
        0S+RbZaXe0IU8rX6h1S+liNGeC3WuTzTq37YJMtMgjii8lk2ANa6KErDbUhDMTmRxBNyz3
        iwE8/nG1GIPWKngo+48eiuB2jFe0xDA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-AXKOIH3_NvqzjehBKwQuyg-1; Thu, 11 Aug 2022 14:47:08 -0400
X-MC-Unique: AXKOIH3_NvqzjehBKwQuyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AADA380A0B9
        for <linux-nfs@vger.kernel.org>; Thu, 11 Aug 2022 18:47:07 +0000 (UTC)
Received: from kdsouza.com (vm-238-64.vmware.gsslab.pnq2.redhat.com [10.74.238.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E35F2026D64;
        Thu, 11 Aug 2022 18:47:06 +0000 (UTC)
From:   Kenneth D'souza <kdsouza@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, kdsouza@redhat.com
Subject: [PATCH] libnfs4acl: Check file mode before getxattr call
Date:   Thu, 11 Aug 2022 13:46:45 -0500
Message-Id: <20220811184645.467066-1-kdsouza@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently we are checking file mode after getxattr call.
Due to this the return value would be 0, which would change the getxattr return value.
As xattr_size will be 0, nfs4_getfacl will fail with error EINVAL.
This patch fixes this issue by moving the file mode check before
getxattr call.

Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
---
 libnfs4acl/nfs4_getacl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/libnfs4acl/nfs4_getacl.c b/libnfs4acl/nfs4_getacl.c
index 7821da3..f9c5831 100644
--- a/libnfs4acl/nfs4_getacl.c
+++ b/libnfs4acl/nfs4_getacl.c
@@ -39,6 +39,13 @@ static struct nfs4_acl *nfs4_getacl_byname(const char *path,
 		return NULL;
 	}
 
+	ret = stat(path, &st);
+	if (ret == -1)
+		goto err_free;
+
+	if (S_ISDIR(st.st_mode))
+		iflags = NFS4_ACL_ISDIR;
+
 	/* find necessary buffer size */
 	ret = getxattr(path, xattr_name, NULL, 0);
 	if (ret == -1)
@@ -53,13 +60,6 @@ static struct nfs4_acl *nfs4_getacl_byname(const char *path,
 	if (ret == -1)
 		goto err_free;
 
-	ret = stat(path, &st);
-	if (ret == -1)
-		goto err_free;
-
-	if (S_ISDIR(st.st_mode))
-		iflags = NFS4_ACL_ISDIR;
-
 	acl = acl_nfs41_xattr_load(buf, ret, iflags, type);
 
 	free(buf);
-- 
2.31.1

