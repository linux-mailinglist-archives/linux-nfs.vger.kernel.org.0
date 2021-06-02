Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1C4399134
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 19:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFBRO7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 13:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36857 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229604AbhFBRO6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 13:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622653994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m6UD0Z6nHK3YDkkfOvodJoOHgm5H6FJhg0YFJHI+dKU=;
        b=P+qPmsqPWEFEY9fXXZVWqap3mk1JEwo9wuBQBTHNB4StTyRqvppFlS29+NXoJhFG9KaHie
        7hCK5IkRat9JBfp74qLzhr0QRMmC0TKwZaI+hiX64XY+JIZT8hZOqlzekKbtE5VBW5vSF6
        rvH8uciyOGyO+bw/6JWgXj2Suk9pUns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-xwvGhraaOKepu4_M4jZZaQ-1; Wed, 02 Jun 2021 13:13:13 -0400
X-MC-Unique: xwvGhraaOKepu4_M4jZZaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50FBF107ACED;
        Wed,  2 Jun 2021 17:13:12 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-114-18.rdu2.redhat.com [10.10.114.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E848E19CAB;
        Wed,  2 Jun 2021 17:13:11 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 0E4DC1A003D; Wed,  2 Jun 2021 13:13:11 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Ensure the NFS_CAP_SECURITY_LABEL capability is set when appropriate
Date:   Wed,  2 Jun 2021 13:13:11 -0400
Message-Id: <20210602171311.1674469-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit ce62b114bbad ("NFS: Split attribute support out from the server
capabilities") removed the logic from _nfs4_server_capabilities() that
sets the NFS_CAP_SECURITY_LABEL capability based on the presence of
FATTR4_WORD2_SECURITY_LABEL in the attr_bitmask of the server's response.
Now NFS_CAP_SECURITY_LABEL is never set, which breaks labelled NFS.

This was replaced with logic that clears the NFS_ATTR_FATTR_V4_SECURITY_LABEL
bit in the newly added fattr_valid field based on the absence of
FATTR4_WORD2_SECURITY_LABEL in the attr_bitmask of the server's response.
This essentially has no effect since there's nothing looks for that bit
in fattr_supported.

So revert that part of the commit, but adding the logic that sets
NFS_CAP_SECURITY_LABEL near where the other capabilities are set in
_nfs4_server_capabilities().

Fixes: ce62b114bbad ("NFS: Split attribute support out from the server capabilities")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/nfs4proc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 0cd965882232..31b145043544 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3878,6 +3878,10 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			server->caps |= NFS_CAP_HARDLINKS;
 		if (res.has_symlinks != 0)
 			server->caps |= NFS_CAP_SYMLINKS;
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+		if (res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL)
+			server->caps |= NFS_CAP_SECURITY_LABEL;
+#endif
 		if (!(res.attr_bitmask[0] & FATTR4_WORD0_FILEID))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_FILEID;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_MODE))
@@ -3898,10 +3902,6 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			server->fattr_valid &= ~NFS_ATTR_FATTR_CTIME;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_MODIFY))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_MTIME;
-#ifdef CONFIG_NFS_V4_SECURITY_LABEL
-		if (!(res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL))
-			server->fattr_valid &= ~NFS_ATTR_FATTR_V4_SECURITY_LABEL;
-#endif
 		memcpy(server->attr_bitmask_nl, res.attr_bitmask,
 				sizeof(server->attr_bitmask));
 		server->attr_bitmask_nl[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
-- 
2.30.2

