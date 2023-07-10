Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577C174DD88
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 20:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjGJSmr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 14:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGJSmq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 14:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A6AB7
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 11:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689014522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hX43wX5YZh6iHzSCX1+t92V+mCCfDYrt7xXXyg9RNFQ=;
        b=Sman5wYf1vlZ8k/ulgjDGgME8WIh31luWVr8XaflfNHywM8v+vBUJgxopWkt1WTEpNaIrC
        /S5wv7aBoV/ScukNs5Yij/NIgWMMAtvyfnrSHhbCnm9wxeU4RHHNAceogZ4qa+H/Pva7GP
        4mPMA+WoWd3q1obGHiBMHnp7g3pw4nQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-R_an3UnWPY--gblrUcNqcg-1; Mon, 10 Jul 2023 14:41:59 -0400
X-MC-Unique: R_an3UnWPY--gblrUcNqcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26C263C34662;
        Mon, 10 Jul 2023 18:41:59 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA183C09A09;
        Mon, 10 Jul 2023 18:41:58 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     aahringo@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Fix sysfs server name memory leak
Date:   Mon, 10 Jul 2023 14:41:58 -0400
Message-Id: <6702796fee0365bf399800326bbe6c88e5f73f68.1689014440.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Free the formatted server index string after it has been duplicated by
kobject_rename().

Fixes: 1c7251187dc0 ("NFS: add superblock sysfs entries")
Reported-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index acda8f033d30..bf378ecd5d9f 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -345,8 +345,10 @@ void nfs_sysfs_move_sb_to_server(struct nfs_server *server)
 	int ret = -ENOMEM;
 
 	s = kasprintf(GFP_KERNEL, "server-%d", server->s_sysfs_id);
-	if (s)
+	if (s) {
 		ret = kobject_rename(&server->kobj, s);
+		kfree(s);
+	}
 	if (ret < 0)
 		pr_warn("NFS: rename sysfs %s failed (%d)\n",
 					server->kobj.name, ret);
-- 
2.40.1

