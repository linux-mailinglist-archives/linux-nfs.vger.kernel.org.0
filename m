Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEB232C68F
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355509AbhCDA3O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34821 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1447322AbhCCNss (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 08:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614779241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AwJ40+AdYDTqQ0fFjl1C2PaVSMYoVzXUwEeZrt7BDCY=;
        b=ghwINKJgYi2Jum6/81+e/TSYlgGh30DI0/aXAcTZ+q3FBNZpzNfvGys+9fmH2XaSPY5ZnM
        Yp8belIBXbKthPh+RU5RUVX3OslX7IKEsTRR3Kh/UkUYn2Ubeq2B9cGyy7J6xyz3EgA12i
        KjyUMB30XJaR8JzzNZveyPVvHDcMxTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-87QUq1DFPMGERTNX-tybGw-1; Wed, 03 Mar 2021 08:47:20 -0500
X-MC-Unique: 87QUq1DFPMGERTNX-tybGw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15F1618B9ECA;
        Wed,  3 Mar 2021 13:47:18 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A8626F999;
        Wed,  3 Mar 2021 13:47:17 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id E730710C30F7; Wed,  3 Mar 2021 08:47:16 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Set memalloc_nofs_save() for sync tasks
Date:   Wed,  3 Mar 2021 08:47:16 -0500
Message-Id: <cfe95384d2a48eac40191969531e4e89bbdf6328.1614779136.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We could recurse into NFS doing memory reclaim while sending a sync task,
which might result in a deadlock.  Set memalloc_nofs_save for sync task
execution.

Fixes: a1231fda7e94 ("SUNRPC: Set memalloc_nofs_save() on all rpciod/xprtiod jobs")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 net/sunrpc/sched.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index cf702a5f7fe5..39ed0e0afe6d 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -963,8 +963,11 @@ void rpc_execute(struct rpc_task *task)
 
 	rpc_set_active(task);
 	rpc_make_runnable(rpciod_workqueue, task);
-	if (!is_async)
+	if (!is_async) {
+		unsigned int pflags = memalloc_nofs_save();
 		__rpc_execute(task);
+		memalloc_nofs_restore(pflags);
+	}
 }
 
 static void rpc_async_schedule(struct work_struct *work)
-- 
2.29.2

