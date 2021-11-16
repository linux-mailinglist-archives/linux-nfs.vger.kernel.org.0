Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2095453334
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 14:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhKPNw1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 08:52:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236865AbhKPNwZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 08:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637070567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=08Mrs2tLLVnsc2mYIfRx3fG7YEdO5U/oVZRmqsFLKUA=;
        b=aoPx9Osyv7ECa6O8TO8lxWyE1PD79mnF1F+DjjTlMKaPnZrfRXOFsFaiK6onZ0cMm/K0DA
        4X15kFbz8bXyyDgwhXQOefgwefksl159+49XTZl+lKvfm68zQOleLu92ndhst5MIG5t6G9
        3yOaRI82sejvm9/qQIPYVHItBbBR6kk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-AlLTmKSoOKKonc59Dt7IoA-1; Tue, 16 Nov 2021 08:49:26 -0500
X-MC-Unique: AlLTmKSoOKKonc59Dt7IoA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F6B21006AB2;
        Tue, 16 Nov 2021 13:49:25 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E807A19E7E;
        Tue, 16 Nov 2021 13:49:24 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 76C3510C3106; Tue, 16 Nov 2021 08:49:24 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: Add a tracepoint to show the results of nfs_set_cache_invalid()
Date:   Tue, 16 Nov 2021 08:49:24 -0500
Message-Id: <04e061ea58bdb9b170ddace02c37e03b32ffce7e.1637069577.git.bcodding@redhat.com>
In-Reply-To: <cover.1637069577.git.bcodding@redhat.com>
References: <cover.1637069577.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This provides some insight into the client's invalidation behavior to show
both when the client uses the helper, and the results of calling the
helper which can vary depending on how the helper is called.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/inode.c    | 1 +
 fs/nfs/nfstrace.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 296ed8ea3273..e4b092e40178 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -216,6 +216,7 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 		flags &= ~(NFS_INO_INVALID_DATA|NFS_INO_DATA_INVAL_DEFER);
 	flags &= ~(NFS_INO_REVAL_PAGECACHE | NFS_INO_REVAL_FORCED);
 	nfsi->cache_validity |= flags;
+	trace_nfs_set_cache_invalid(inode, 0);
 }
 EXPORT_SYMBOL_GPL(nfs_set_cache_invalid);
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 8a224871be74..76bea172dce0 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -209,6 +209,7 @@ DEFINE_NFS_INODE_EVENT_DONE(nfs_writeback_inode_exit);
 DEFINE_NFS_INODE_EVENT(nfs_fsync_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_fsync_exit);
 DEFINE_NFS_INODE_EVENT(nfs_access_enter);
+DEFINE_NFS_INODE_EVENT_DONE(nfs_set_cache_invalid);
 
 TRACE_EVENT(nfs_access_exit,
 		TP_PROTO(
-- 
2.31.1

