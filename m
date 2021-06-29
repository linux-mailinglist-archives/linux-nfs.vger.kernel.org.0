Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8DB3B6FEA
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 11:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhF2JOE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 05:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232618AbhF2JOC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 05:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624957895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=tL9Z/PbjNPbkMWTfB7ebYC6h9CXDQboRLkcJ8jLFFIY=;
        b=ieFNHXfj9PVImNl8GN+36WXlIjn1UO0b7ANzS7py5ZuL7tpmL1/SFlUoCvyBTmG/FFGd/J
        V7i8lNzZIX673KJVMiGFAO82GgMiCOZ32Ggmv5OAyQttH5EITVj0hQGWycOg/k7r/bW4N+
        L99zeiVUYgB52vFnj6Ev3IQO8SYEut4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-qCwKgV1SP9CJZ_iwOt6XkQ-1; Tue, 29 Jun 2021 05:11:31 -0400
X-MC-Unique: qCwKgV1SP9CJZ_iwOt6XkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A6BF802922;
        Tue, 29 Jun 2021 09:11:30 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2F5B19D9D;
        Tue, 29 Jun 2021 09:11:29 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/4] NFS: Ensure nfs_readpage returns promptly when internal error occurs
Date:   Tue, 29 Jun 2021 05:11:28 -0400
Message-Id: <1624957888-31361-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A previous refactoring of nfs_readpage() might end up calling
wait_on_page_locked_killable() even if readpage_async_filler() failed
with an internal error and pg_error was non-zero (for example, if
nfs_create_request() failed).  In the case of an internal error,
skip over wait_on_page_locked_killable() as this is only needed
when the read is sent and an error occurs during completion handling.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/read.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 684a730f6670..eb390eb618b3 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -373,10 +373,10 @@ int nfs_readpage(struct file *file, struct page *page)
 			     &nfs_async_read_completion_ops);
 
 	ret = readpage_async_filler(&desc, page);
+	if (ret)
+		goto out;
 
-	if (!ret)
-		nfs_pageio_complete_read(&desc.pgio);
-
+	nfs_pageio_complete_read(&desc.pgio);
 	ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
 	if (!ret) {
 		ret = wait_on_page_locked_killable(page);
-- 
1.8.3.1

