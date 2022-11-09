Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1541A622C70
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Nov 2022 14:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKINeE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Nov 2022 08:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKINeD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Nov 2022 08:34:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E048252BF
        for <linux-nfs@vger.kernel.org>; Wed,  9 Nov 2022 05:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668000788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yXE9vD2TJaCu8qozK0+vGwX3oMbEoxhG0BUA/K911xQ=;
        b=ekdiZENgkKg5JNUXgac7FKPfuaYLLhP+qYmODH8rD9OMrA6Ribr4fNueAXgAiyGdnJtsm1
        L0i5fqLlBA6p90gT0hgkSyjrYTeskbfx4sy1fXYFtiw3VqnMAjM8nxRNxVNpcd92/Cgy6K
        xrM+i0FmRZT9Mq48T/nJffm9xtcl5fo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-GBG0d9ZSO8OBFjej4KEFpg-1; Wed, 09 Nov 2022 08:33:07 -0500
X-MC-Unique: GBG0d9ZSO8OBFjej4KEFpg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 735231C14346;
        Wed,  9 Nov 2022 13:33:07 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.32.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 485E44B400F;
        Wed,  9 Nov 2022 13:33:07 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] Documentation: Fix sysfs path for the NFSv4 client identifier
Date:   Wed,  9 Nov 2022 08:33:06 -0500
Message-Id: <20221109133306.167037-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The sysfs path for the NFS4 client identfier should start with
the path component of 'nfs' for the kset, and then the 'net'
path component for the netns object, followed by the
'nfs_client' path component for the NFS client kobject,
and ending with 'identifier' for the netns_client_id
kobj_attribute.

Fixes: a28faaddb2be ("Documentation: Add an explanation of NFSv4 client identifiers")
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 Documentation/filesystems/nfs/client-identifier.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/nfs/client-identifier.rst b/Documentation/filesystems/nfs/client-identifier.rst
index 5147e15815a1..a94c7a9748d7 100644
--- a/Documentation/filesystems/nfs/client-identifier.rst
+++ b/Documentation/filesystems/nfs/client-identifier.rst
@@ -152,7 +152,7 @@ string:
       via the kernel command line, or when the "nfs" module is
       loaded.
 
-    /sys/fs/nfs/client/net/identifier
+    /sys/fs/nfs/net/nfs_client/identifier
       This virtual file, available since Linux 5.3, is local to the
       network namespace in which it is accessed and so can provide
       distinction between network namespaces (containers) when the
@@ -164,7 +164,7 @@ then that uniquifier can be used. For example, a uniquifier might
 be formed at boot using the container's internal identifier:
 
     sha256sum /etc/machine-id | awk '{print $1}' \\
-        > /sys/fs/nfs/client/net/identifier
+        > /sys/fs/nfs/net/nfs_client/identifier
 
 Security considerations
 -----------------------
-- 
2.31.1

