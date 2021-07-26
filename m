Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35BE3D5A65
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 15:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhGZMxI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 08:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230421AbhGZMxH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jul 2021 08:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627306416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6RPrhDMbNnYmtjHAqPh6yoGljuGoLf82R3LgFU407I=;
        b=SpQ1vUMYgQjMl8o+TnOI3wS8uDPmDZh4hWcRLfjN9motDrNqna9P+mQow7itaHErLZA/w9
        MMJPJZ2YJO16rzahX0U810JkHWSNztGeiJsCGhtrvQLZfPtuSxKtJf97r83d0yVn9A4980
        demAepRwDuelhaXIEvvKoCAbHrJ9D+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-dmgTvxQ1OJyzYkBR282crQ-1; Mon, 26 Jul 2021 09:33:32 -0400
X-MC-Unique: dmgTvxQ1OJyzYkBR282crQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 091776118D;
        Mon, 26 Jul 2021 13:33:30 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3E8978C00;
        Mon, 26 Jul 2021 13:33:29 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id F248E10E8049; Mon, 26 Jul 2021 09:33:28 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH V2] lockd: Fix invalid lockowner cast after vfs_test_lock
Date:   Mon, 26 Jul 2021 09:33:28 -0400
Message-Id: <a060024e4cde48b224a7b4aecae7d20423ce506f.1627306204.git.bcodding@redhat.com>
In-Reply-To: <f94e02c019495fea4495fbef7498f342d5848dac.1627217317.git.bcodding@redhat.com>
References: <f94e02c019495fea4495fbef7498f342d5848dac.1627217317.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

V2: fix typos in patch header

8<-------------------------------------------------------

After calling vfs_test_lock() the pointer to a conflicting lock can be
returned, and that lock is not guarunteed to be owned by nlm.  In that
case, we cannot cast it to struct nlm_lockowner.  Instead return the pid
of that conflicting lock.

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

