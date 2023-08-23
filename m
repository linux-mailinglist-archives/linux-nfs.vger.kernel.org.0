Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C75378626E
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Aug 2023 23:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbjHWVfw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Aug 2023 17:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbjHWVff (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Aug 2023 17:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4FA10EB
        for <linux-nfs@vger.kernel.org>; Wed, 23 Aug 2023 14:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692826440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a6joEGKWnnjVY5UbKUjhUBMyK3LpAKMDMx1lRCkXV9w=;
        b=LIXI0JuLcChgNlRqDwViGDtJW5v9PpwT9w3LUHorH+PKgCS2y90MJk6h4vOfYDMGBvBAMj
        oQva5Nyyfwf7vmCqZATu2GBOYrgqyL4NfBbc9HIHZUgzH0cjbBYQGF2l16J7RzJb/FC6jl
        7P8tFzP06x1tBO6RjpA9KZbMPXlA5t0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-LFaibqAEPq-WPmG8rfnF6Q-1; Wed, 23 Aug 2023 17:33:56 -0400
X-MC-Unique: LFaibqAEPq-WPmG8rfnF6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E3D11C05122;
        Wed, 23 Aug 2023 21:33:55 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA62040C6F4C;
        Wed, 23 Aug 2023 21:33:54 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: [PATCH 4/7] lockd: add doc to enable EXPORT_OP_SAFE_ASYNC_LOCK
Date:   Wed, 23 Aug 2023 17:33:49 -0400
Message-Id: <20230823213352.1971009-5-aahringo@redhat.com>
In-Reply-To: <20230823213352.1971009-1-aahringo@redhat.com>
References: <20230823213352.1971009-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch adds a note to enable EXPORT_OP_SAFE_ASYNC_LOCK for
asynchronous lock request handling.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/locks.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index df8b26a42524..edee02d1ca93 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2255,11 +2255,13 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
  * To avoid blocking kernel daemons, such as lockd, that need to acquire POSIX
  * locks, the ->lock() interface may return asynchronously, before the lock has
  * been granted or denied by the underlying filesystem, if (and only if)
- * lm_grant is set. Callers expecting ->lock() to return asynchronously
- * will only use F_SETLK, not F_SETLKW; they will set FL_SLEEP if (and only if)
- * the request is for a blocking lock. When ->lock() does return asynchronously,
- * it must return FILE_LOCK_DEFERRED, and call ->lm_grant() when the lock
- * request completes.
+ * lm_grant is set. Additionally EXPORT_OP_SAFE_ASYNC_LOCK in export_operations
+ * flags need to be set.
+ *
+ * Callers expecting ->lock() to return asynchronously will only use F_SETLK,
+ * not F_SETLKW; they will set FL_SLEEP if (and only if) the request is for a
+ * blocking lock. When ->lock() does return asynchronously, it must return
+ * FILE_LOCK_DEFERRED, and call ->lm_grant() when the lock request completes.
  * If the request is for non-blocking lock the file system should return
  * FILE_LOCK_DEFERRED then try to get the lock and call the callback routine
  * with the result. If the request timed out the callback routine will return a
-- 
2.31.1

