Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9501425FE2
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Oct 2021 00:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhJGWcq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 18:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233370AbhJGWcp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 18:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633645851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Yh48u7kZGpMcWIBMnksUa2p1rEHfVEL82DyEpqEquZE=;
        b=BneSNKTNXIFEyO1RNmeLj0E9b0I3VukYcOGDnZxtkhGvdEHoeEyvdkrSXrCTOsVaUtcxtx
        dmtAC+evZe9gBcO1JA3pykcIVP+FhGVMQbgY0N0VuHfK8DxdvXd4EOKyWRqvU9K7WYJROR
        iVNQGzxntE6xNVQJW9F7F2wxS2I15eg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-8ykm1hUfM8eAFX7edqWD9w-1; Thu, 07 Oct 2021 18:30:50 -0400
X-MC-Unique: 8ykm1hUfM8eAFX7edqWD9w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12D3C1005E68;
        Thu,  7 Oct 2021 22:30:49 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 741215D9C6;
        Thu,  7 Oct 2021 22:30:48 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH v2  7/7] NFS: Remove remaining usages of NFSDBG_FSCACHE
Date:   Thu,  7 Oct 2021 18:30:23 -0400
Message-Id: <1633645823-31235-8-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1633645823-31235-1-git-send-email-dwysocha@redhat.com>
References: <1633645823-31235-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The NFS fscache interface has removed all dfprintks so remove the
NFSDBG_FSCACHE defines.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache-index.c      | 2 --
 fs/nfs/fscache.c            | 2 --
 include/uapi/linux/nfs_fs.h | 2 +-
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/nfs/fscache-index.c b/fs/nfs/fscache-index.c
index 4bd5ce736193..71bb4270641f 100644
--- a/fs/nfs/fscache-index.c
+++ b/fs/nfs/fscache-index.c
@@ -17,8 +17,6 @@
 #include "internal.h"
 #include "fscache.h"
 
-#define NFSDBG_FACILITY		NFSDBG_FSCACHE
-
 /*
  * Define the NFS filesystem for FS-Cache.  Upon registration FS-Cache sticks
  * the cookie for the top-level index object for NFS into here.  The top-level
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 06c4d8ee7281..57cc242ae916 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -21,8 +21,6 @@
 #include "fscache.h"
 #include "nfstrace.h"
 
-#define NFSDBG_FACILITY                NFSDBG_FSCACHE
-
 static struct rb_root nfs_fscache_keys = RB_ROOT;
 static DEFINE_SPINLOCK(nfs_fscache_keys_lock);
 
diff --git a/include/uapi/linux/nfs_fs.h b/include/uapi/linux/nfs_fs.h
index 3afe3767c55d..ae0de165c014 100644
--- a/include/uapi/linux/nfs_fs.h
+++ b/include/uapi/linux/nfs_fs.h
@@ -52,7 +52,7 @@
 #define NFSDBG_CALLBACK		0x0100
 #define NFSDBG_CLIENT		0x0200
 #define NFSDBG_MOUNT		0x0400
-#define NFSDBG_FSCACHE		0x0800
+#define NFSDBG_FSCACHE		0x0800 /* unused */
 #define NFSDBG_PNFS		0x1000
 #define NFSDBG_PNFS_LD		0x2000
 #define NFSDBG_STATE		0x4000
-- 
1.8.3.1

