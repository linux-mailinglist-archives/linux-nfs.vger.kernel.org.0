Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161D63D4D87
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jul 2021 14:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhGYMIg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Jul 2021 08:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230192AbhGYMIg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 25 Jul 2021 08:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627217345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eT9azpBbqgg18yvgWLMHeLhrEaWxCAZt9m4s3nJLbt4=;
        b=XiUx86ms+2pn8/nH6NMjEP/Maqzv8ZFDgsUJTIUOHnsyVEl0lCauxOKuP9u0mUJaEgxkzH
        M+7Gdfn8bj86+hyINnS06hDnhFGbN7GOkNm00LnIXXTPwwMuIznErtvGswjXPAXQsfWqGX
        gEzQNxIQ5IZr7Jx7qp3RdAFG+Y7UucM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-1_FtA1RIPe-L4guu9SJ_MA-1; Sun, 25 Jul 2021 08:49:04 -0400
X-MC-Unique: 1_FtA1RIPe-L4guu9SJ_MA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1032C824F83;
        Sun, 25 Jul 2021 12:49:03 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BED7A60C59;
        Sun, 25 Jul 2021 12:49:02 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 0B70D10E6876; Sun, 25 Jul 2021 08:49:02 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] lockd: Fix invalid lockowner cast after vfs_test_lock
Date:   Sun, 25 Jul 2021 08:49:01 -0400
Message-Id: <f94e02c019495fea4495fbef7498f342d5848dac.1627217317.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After calling vfs_test_lock() the pointer to a conflicting lock can be
returned, and that lock is not garunteed to owned by nlm.  In that case, we
cannot cast it to struct nlm_lockowner.  Instead, return the pid of that
conflicting lock.

Fixes: 646d73e91b42 ("lockd: Show pid of lockd for remote locks")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/lockd/svclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 61d3cc2283dc..498cb70c2c0d 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -634,7 +634,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 	conflock->caller = "somehost";	/* FIXME */
 	conflock->len = strlen(conflock->caller);
 	conflock->oh.len = 0;		/* don't return OH info */
-	conflock->svid = ((struct nlm_lockowner *)lock->fl.fl_owner)->pid;
+	conflock->svid = lock->fl.fl_pid;
 	conflock->fl.fl_type = lock->fl.fl_type;
 	conflock->fl.fl_start = lock->fl.fl_start;
 	conflock->fl.fl_end = lock->fl.fl_end;
-- 
2.30.2

