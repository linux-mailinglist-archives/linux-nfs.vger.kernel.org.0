Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10422A2C0F
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 14:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgKBNvc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 08:51:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725971AbgKBNuU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 08:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604325019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=AT49TBC/qONh0mFaANQBF4Wz/J/y8viuZKlidItHO8Q=;
        b=feKrbNmbnugvCmFh41l3UAEHpxjHIi194tXKFrPiPprbssPxo5jRW4ZYC31YLpQPuD3sr4
        MEQCpRL0o9sPvrqgClXhSqE+SlZ8bvr2yGRcMhxDW0lnEI4EgSxSdB5NuViePIR1sHjIV0
        SdSGh6pv7wCydi6tA4iVAF+0JYpPreE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-sV-g7fXCMXCgJKMVUzkERg-1; Mon, 02 Nov 2020 08:50:18 -0500
X-MC-Unique: sV-g7fXCMXCgJKMVUzkERg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDC7F5719E;
        Mon,  2 Nov 2020 13:50:16 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-255.rdu2.redhat.com [10.10.113.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84F065D9DD;
        Mon,  2 Nov 2020 13:50:16 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 06/11] NFS: Add tracepoints for nfs_readdir_xdr_filler enter and exit
Date:   Mon,  2 Nov 2020 08:50:06 -0500
Message-Id: <1604325011-29427-7-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add tracepoints for entry and exit to nfs_readdir_xdr_filler.
Note the exit trace event captures the results of over the wire
READDIR operations, regardless of NFS version.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/dir.c      | 2 ++
 fs/nfs/nfstrace.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e4cd9789ebb5..d1e9ba28c4a0 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -361,6 +361,7 @@ int nfs_readdir_xdr_filler(struct page **pages, nfs_readdir_descriptor_t *desc,
 	int		error;
 
  again:
+	trace_nfs_readdir_xdr_filler_enter(desc);
 	timestamp = jiffies;
 	gencount = nfs_inc_attr_generation_counter();
 	desc->dir_verifier = nfs_save_change_attribute(inode);
@@ -379,6 +380,7 @@ int nfs_readdir_xdr_filler(struct page **pages, nfs_readdir_descriptor_t *desc,
 	desc->timestamp = timestamp;
 	desc->gencount = gencount;
 error:
+	trace_nfs_readdir_xdr_filler_exit(desc, error);
 	return error;
 }
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 0ed330f323bb..5dbadd2718e3 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -926,6 +926,8 @@
 DEFINE_NFS_READDIR_DESCRIPTOR_EVENT_EXIT(nfs_readdir_search_pagecache_exit);
 DEFINE_NFS_READDIR_DESCRIPTOR_EVENT(nfs_readdir_search_array_enter);
 DEFINE_NFS_READDIR_DESCRIPTOR_EVENT_EXIT(nfs_readdir_search_array_exit);
+DEFINE_NFS_READDIR_DESCRIPTOR_EVENT(nfs_readdir_xdr_filler_enter);
+DEFINE_NFS_READDIR_DESCRIPTOR_EVENT_EXIT(nfs_readdir_xdr_filler_exit);
 
 TRACE_EVENT(nfs_link_enter,
 		TP_PROTO(
-- 
1.8.3.1

