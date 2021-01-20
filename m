Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB092FD670
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 18:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391303AbhATRFW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 12:05:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391595AbhATRBe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 12:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611161998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzrRtz5V8A4NaYeaCtWq+mw9BQEKROnYxMUcqfY3/Es=;
        b=UJrgX1v1sD9/uoj8Fy82wWBidXkXOvf496SgcwazDwKlZBKhxXADbS+VJWYeeusaKAc340
        0Uqa5kfPE86ZNP1dzIOhzeHPv+7HIPNfITkE4roFfDAaGYpP5jbdCt1PAV2IaBkHc5Ta7Q
        Tndaf5nA04fqRwFAl7rIzOwNp3u4Ogk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-gSxLPl3QPCqcA01liJzGog-1; Wed, 20 Jan 2021 11:59:56 -0500
X-MC-Unique: gSxLPl3QPCqcA01liJzGog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 875F4192CC41
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D6C35D74A
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id D684210E5BE2; Wed, 20 Jan 2021 11:59:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 08/10] NFS: Reset pagecache cursor on llseek
Date:   Wed, 20 Jan 2021 11:59:52 -0500
Message-Id: <24014d0e4f7119c76193eda5c5104a69bcaa30dd.1611160121.git.bcodding@redhat.com>
In-Reply-To: <cover.1611160120.git.bcodding@redhat.com>
References: <cover.1611160120.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Unless we reset the cursor, a series of lseek() getdents() calls will
continue filling the pagecache indefinitely.  Instead, reset the cursor so
that we always start filling at the beginning of the pagecache.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index d6101e45fd66..7ca79d4b25ec 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1284,6 +1284,8 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 			dir_ctx->pgc.index_cookie = offset;
 		else
 			dir_ctx->pgc.index_cookie = 0;
+		dir_ctx->pgc.page_index = 0;
+		dir_ctx->pgc.entry_index = 0;
 		if (offset == 0)
 			memset(dir_ctx->verf, 0, sizeof(dir_ctx->verf));
 		dir_ctx->duped = 0;
-- 
2.25.4

