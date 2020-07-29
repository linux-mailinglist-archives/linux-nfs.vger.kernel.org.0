Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A01232002
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jul 2020 16:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgG2OMw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jul 2020 10:12:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41776 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726711AbgG2OMv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jul 2020 10:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596031971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=RI8NCjNNWkQ8EXfK1J+lr5kGTU+hrcfiRK+HTOx5ddM=;
        b=C6+gDT3xCh7WY9X9JFtAKGwFV7rv8UWs5e/Vtdk7po4ZzKuwrclQ75rqXRkqVWfCd3oE6y
        jyQIfz1oAO++st4CpLr6SE1Kx4jIh5DWds4i8b85f6z2+mD8VxnwSan0BTl0cw7qganE68
        LC4Codr0M7Z0prYwAmJ1rjdcgvbeSog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-7M0emaA_MoirDWWc3E2Xdw-1; Wed, 29 Jul 2020 10:12:49 -0400
X-MC-Unique: 7M0emaA_MoirDWWc3E2Xdw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A70110CE78A;
        Wed, 29 Jul 2020 14:12:48 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-23.rdu2.redhat.com [10.10.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C623E71906;
        Wed, 29 Jul 2020 14:12:47 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v2 11/14] NFS: Call nfs_fscache_invalidate() when write extends the size of the file
Date:   Wed, 29 Jul 2020 10:12:26 -0400
Message-Id: <1596031949-26793-12-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
References: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a write extends the size of the file and fscache is enabled, we
need to invalidate the object with the new size.  Otherwise, the next
read from the cache may fail inside cachefiles_shape_extent() due to
cookie->zero_point being smaller than the size of the file.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 005eea29e0ec..2da99814da51 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -290,6 +290,7 @@ static void nfs_grow_file(struct page *page, unsigned int offset, unsigned int c
 		goto out;
 	i_size_write(inode, end);
 	NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_SIZE;
+	nfs_fscache_invalidate(inode);
 	nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);
 out:
 	spin_unlock(&inode->i_lock);
-- 
1.8.3.1

