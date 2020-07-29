Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BB423200D
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jul 2020 16:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgG2OM4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jul 2020 10:12:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58440 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgG2OMz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jul 2020 10:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596031974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=9cPsDpNRYj6sWk/9xwqY1oMjDMLW81UpxpOM+60Y8ac=;
        b=O8mAvcwndM3ScJJKzpVK3dV7VaSwbFQVhTxJOVfIuUify/0TW93L9ymT8COpb8hkTnz2aI
        /FHOQXqLd23nZuxDwyJ15CBZPEMr66zeBlaKehZ12X/f32mTWlM1Rdx4IhMsEPNRM4nvTN
        yIwwBhYEGjEGbYUU+JUbkrxDYncwGbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-bYfQQkdVNjWo34wKnfYiFA-1; Wed, 29 Jul 2020 10:12:50 -0400
X-MC-Unique: bYfQQkdVNjWo34wKnfYiFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BE1B80046F;
        Wed, 29 Jul 2020 14:12:49 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-23.rdu2.redhat.com [10.10.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 13B2271906;
        Wed, 29 Jul 2020 14:12:49 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v2 13/14] NFS: Call fscache_resize_cookie() when inode size changes due to setattr
Date:   Wed, 29 Jul 2020 10:12:28 -0400
Message-Id: <1596031949-26793-14-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
References: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Handle truncate / setattr when fscache is enabled by calling
fscache_resize_cookie().

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 45067303348c..6b814246d07d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -667,6 +667,7 @@ static int nfs_vmtruncate(struct inode * inode, loff_t offset)
 	spin_unlock(&inode->i_lock);
 	truncate_pagecache(inode, offset);
 	spin_lock(&inode->i_lock);
+	fscache_resize_cookie(nfs_i_fscache(inode), i_size_read(inode));
 out:
 	return err;
 }
-- 
1.8.3.1

