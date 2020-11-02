Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5642A2C0D
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 14:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgKBNvb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 08:51:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbgKBNuV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 08:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604325020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=VxPTrUye+bYbghXaNfiAm7OUF6lNMht9A5/loK+xyYc=;
        b=KyluO8l85fmBHUO6iP16+U9hT+7oK3HL26TY3DPT/8Qq58Jwt1RFHuV1oYp3u+MX1CKu8I
        2y4jN27Pf1LBzybdDnE7AiKscaTXxygUNAmdggNPORi14MvpGsgYqvxuzgSUWD8Cfbet0O
        6u5qFNG6T/ECNqFMGhwwE9/ho8Wtawo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-y8Zfj4AxNnqW1DllDxNRng-1; Mon, 02 Nov 2020 08:50:18 -0500
X-MC-Unique: y8Zfj4AxNnqW1DllDxNRng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6076157208;
        Mon,  2 Nov 2020 13:50:17 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-255.rdu2.redhat.com [10.10.113.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0778D5D9DD;
        Mon,  2 Nov 2020 13:50:16 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 07/11] NFS: Add tracepoint to entry and exit of nfs_do_filldir
Date:   Mon,  2 Nov 2020 08:50:07 -0500
Message-Id: <1604325011-29427-8-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add tracepoints to nfs_do_filldir and remove one more dfprintk.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/dir.c      | 4 ++--
 fs/nfs/nfstrace.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index d1e9ba28c4a0..d8c3c3fdea75 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -794,6 +794,7 @@ int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
 	struct nfs_cache_array *array = NULL;
 	struct nfs_open_dir_context *ctx = file->private_data;
 
+	trace_nfs_do_filldir_enter(desc);
 	array = kmap(desc->page);
 	for (i = desc->cache_entry_index; i < array->size; i++) {
 		struct nfs_cache_array_entry *ent;
@@ -819,8 +820,7 @@ int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
 		desc->eof = true;
 
 	kunmap(desc->page);
-	dfprintk(DIRCACHE, "NFS: nfs_do_filldir() filling ended @ cookie %Lu; returning = %d\n",
-			(unsigned long long)*desc->dir_cookie, res);
+	trace_nfs_do_filldir_exit(desc, res);
 	return res;
 }
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 5dbadd2718e3..e28551f70eab 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -928,6 +928,8 @@
 DEFINE_NFS_READDIR_DESCRIPTOR_EVENT_EXIT(nfs_readdir_search_array_exit);
 DEFINE_NFS_READDIR_DESCRIPTOR_EVENT(nfs_readdir_xdr_filler_enter);
 DEFINE_NFS_READDIR_DESCRIPTOR_EVENT_EXIT(nfs_readdir_xdr_filler_exit);
+DEFINE_NFS_READDIR_DESCRIPTOR_EVENT(nfs_do_filldir_enter);
+DEFINE_NFS_READDIR_DESCRIPTOR_EVENT_EXIT(nfs_do_filldir_exit);
 
 TRACE_EVENT(nfs_link_enter,
 		TP_PROTO(
-- 
1.8.3.1

