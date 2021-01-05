Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0BF2EAC83
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 15:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbhAEN6b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 08:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728591AbhAEN6a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 08:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609855024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5/SZddYcUuqG24+hPd+zbMwqzxWnzvWdefe4nEYcIis=;
        b=JnF7rMrtAfTiby50gXBi5z2M/FWX9MnD3i8u8Jw72e83y9V7whCq+Jveu7SnNzEFp7uOP/
        13jzVpuSOZqnA6tSZeAF5cKyfaQHOGJwpXLrBFKoWQtM+l8LYb8QPuODJ8i7vN8yq28wMJ
        Hz1jM+znfx2ywEeBBJIPxfMzjhQ4aEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-3rX-t22OMVm3Bcz-6BSYVg-1; Tue, 05 Jan 2021 08:54:35 -0500
X-MC-Unique: 3rX-t22OMVm3Bcz-6BSYVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A71F1801817;
        Tue,  5 Jan 2021 13:54:33 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-112-71.rdu2.redhat.com [10.10.112.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 69E046060F;
        Tue,  5 Jan 2021 13:54:33 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 6B5911A0058; Tue,  5 Jan 2021 08:54:32 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Adjust fs_context error logging
Date:   Tue,  5 Jan 2021 08:54:32 -0500
Message-Id: <20210105135432.1605419-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Several existing dprink()/dfprintk() calls were converted to use the new
mount API logging macros by commit ce8866f0913f ("NFS: Attach
supplementary error information to fs_context").  If the fs_context was
not created using fsopen() then it will not have had a log buffer
allocated for it, and the new mount API logging macros will wind up
calling printk().

This can result in syslog messages being logged where previously there
were none... most notably "NFS4: Couldn't follow remote path", which can
happen if the client is auto-negotiating a protocol version with an NFS
server that doesn't support the higher v4.x versions.

Convert the nfs_errorf(), nfs_invalf(), and nfs_warnf() macros to check
for the existence of the fs_context's log buffer and call dprintk() if
it doesn't exist.  Add nfs_ferrorf(), nfs_finvalf(), and nfs_warnf(),
which do the same thing but take an NFS debug flag as an argument and
call dfprintk().  Finally, modify the "NFS4: Couldn't follow remote
path" message to use nfs_ferrorf().

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207385
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/internal.h  | 26 +++++++++++++++++++++++---
 fs/nfs/nfs4super.c |  4 ++--
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index b840d0a91c9d..6bdee7ab3a6c 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -136,9 +136,29 @@ struct nfs_fs_context {
 	} clone_data;
 };
 
-#define nfs_errorf(fc, fmt, ...) errorf(fc, fmt, ## __VA_ARGS__)
-#define nfs_invalf(fc, fmt, ...) invalf(fc, fmt, ## __VA_ARGS__)
-#define nfs_warnf(fc, fmt, ...) warnf(fc, fmt, ## __VA_ARGS__)
+#define nfs_errorf(fc, fmt, ...) ((fc)->log.log ?		\
+	errorf(fc, fmt, ## __VA_ARGS__) :			\
+	({ dprintk(fmt "\n", ## __VA_ARGS__); }))
+
+#define nfs_ferrorf(fc, fac, fmt, ...) ((fc)->log.log ?		\
+	errorf(fc, fmt, ## __VA_ARGS__) :			\
+	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__); }))
+
+#define nfs_invalf(fc, fmt, ...) ((fc)->log.log ?		\
+	invalf(fc, fmt, ## __VA_ARGS__) :			\
+	({ dprintk(fmt "\n", ## __VA_ARGS__);  -EINVAL; }))
+
+#define nfs_finvalf(fc, fac, fmt, ...) ((fc)->log.log ?		\
+	invalf(fc, fmt, ## __VA_ARGS__) :			\
+	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__);  -EINVAL; }))
+
+#define nfs_warnf(fc, fmt, ...) ((fc)->log.log ?		\
+	warnf(fc, fmt, ## __VA_ARGS__) :			\
+	({ dprintk(fmt "\n", ## __VA_ARGS__); }))
+
+#define nfs_fwarnf(fc, fac, fmt, ...) ((fc)->log.log ?		\
+	warnf(fc, fmt, ## __VA_ARGS__) :			\
+	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__); }))
 
 static inline struct nfs_fs_context *nfs_fc2context(const struct fs_context *fc)
 {
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 984cc42ee54d..d09bcfd7db89 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -227,7 +227,7 @@ int nfs4_try_get_tree(struct fs_context *fc)
 			   fc, ctx->nfs_server.hostname,
 			   ctx->nfs_server.export_path);
 	if (err) {
-		nfs_errorf(fc, "NFS4: Couldn't follow remote path");
+		nfs_ferrorf(fc, MOUNT, "NFS4: Couldn't follow remote path");
 		dfprintk(MOUNT, "<-- nfs4_try_get_tree() = %d [error]\n", err);
 	} else {
 		dfprintk(MOUNT, "<-- nfs4_try_get_tree() = 0\n");
@@ -250,7 +250,7 @@ int nfs4_get_referral_tree(struct fs_context *fc)
 			    fc, ctx->nfs_server.hostname,
 			    ctx->nfs_server.export_path);
 	if (err) {
-		nfs_errorf(fc, "NFS4: Couldn't follow remote path");
+		nfs_ferrorf(fc, MOUNT, "NFS4: Couldn't follow remote path");
 		dfprintk(MOUNT, "<-- nfs4_get_referral_tree() = %d [error]\n", err);
 	} else {
 		dfprintk(MOUNT, "<-- nfs4_get_referral_tree() = 0\n");
-- 
2.25.4

