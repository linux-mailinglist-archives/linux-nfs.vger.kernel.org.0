Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0184573F9D1
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jun 2023 12:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjF0KNj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Jun 2023 06:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjF0KNJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Jun 2023 06:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D77E74
        for <linux-nfs@vger.kernel.org>; Tue, 27 Jun 2023 03:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687860734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uNrSge6DownQBq9KG23QEHLMINFdPUhYmAFbqqQOwxk=;
        b=XahR+aqT90Ijj4rh3tESTxhGksBstNX8yxeUgmlvEqua9KpxfDWurWlrK2ut/qvCoYgql5
        Ta0XcxGSlyuAoqEEY+CQvZYl/QouZJ9NSeY8FTOyntNOFexlSqdKTgvNs5rM0x6AIYzTWc
        VANf/bPENQHQMYrKd63ZN0qX+bbrPdQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-NMDFkyMKOUKPGcokh44G_A-1; Tue, 27 Jun 2023 06:12:12 -0400
X-MC-Unique: NMDFkyMKOUKPGcokh44G_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 363951C06918;
        Tue, 27 Jun 2023 10:12:12 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA90140C2063;
        Tue, 27 Jun 2023 10:12:11 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Don't cleanup sysfs superblock entry if uninitialized
Date:   Tue, 27 Jun 2023 06:12:11 -0400
Message-Id: <47876afaea6c83f172bca3b1333989bbcca1aef9.1687860625.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Its possible to end up in nfs_free_server() before the server's superblock
sysfs entry has been initialized, in which case calling kobject_put() will
emit a WARNING.  Check if the kobject has been initialized before cleaning
it up.

Fixes: 1c7251187dc0 ("NFS: add superblock sysfs entries")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/client.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 9aea938e4bf2..ed68aee87606 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1010,8 +1010,10 @@ void nfs_free_server(struct nfs_server *server)
 
 	nfs_put_client(server->nfs_client);
 
-	nfs_sysfs_remove_server(server);
-	kobject_put(&server->kobj);
+	if (server->kobj.state_initialized) {
+		nfs_sysfs_remove_server(server);
+		kobject_put(&server->kobj);
+	}
 	ida_free(&s_sysfs_ids, server->s_sysfs_id);
 
 	ida_destroy(&server->lockowner_id);
-- 
2.40.1

