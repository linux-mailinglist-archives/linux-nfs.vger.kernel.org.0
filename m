Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8A191A8D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2020 21:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgCXUJE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 16:09:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:50336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgCXUJD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 16:09:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9BD49ACCA;
        Tue, 24 Mar 2020 20:09:02 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <Trond.Myklebust@netapp.com>,
        "J . Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/1] NFS: Don't specify NFS version in "UDP not supported" error
Date:   Tue, 24 Mar 2020 21:08:49 +0100
Message-Id: <20200324200849.5331-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

UDP was originally disabled in 6da1a034362f for NFSv4. Later in
b24ee6c64ca7 UDP is by default disabled by NFS_DISABLE_UDP_SUPPORT=y for
all NFS versions. Therefore remove v4 from error message.

Fixes: b24ee6c64ca7 ("NFS: allow deprecation of NFS UDP protocol")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

although on NFS_DISABLE_UDP_SUPPORT=n it might be confusing that
version is not specified, IMHO it's less confusing than "NFSv4" for
NFSv3. But if you like I can distinguish these two cases.

Kind regards,
Petr

 fs/nfs/fs_context.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index e113fcb4bb4c..566dd59570e6 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1135,7 +1135,7 @@ static int nfs4_parse_monolithic(struct fs_context *fc,
 	return nfs_invalf(fc, "NFS4: mount program didn't pass remote address");
 
 out_invalid_transport_udp:
-	return nfs_invalf(fc, "NFSv4: Unsupported transport protocol udp");
+	return nfs_invalf(fc, "NFS: Unsupported transport protocol udp");
 }
 #endif
 
@@ -1257,7 +1257,7 @@ static int nfs_fs_context_validate(struct fs_context *fc)
 	nfs_errorf(fc, "NFS: NFSv4 is not compiled into kernel");
 	return -EPROTONOSUPPORT;
 out_invalid_transport_udp:
-	return nfs_invalf(fc, "NFSv4: Unsupported transport protocol udp");
+	return nfs_invalf(fc, "NFS: Unsupported transport protocol udp");
 out_no_address:
 	return nfs_invalf(fc, "NFS: mount program didn't pass remote address");
 out_mountproto_mismatch:
-- 
2.25.1

