Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62C6477A02
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Dec 2021 18:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhLPRJP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 12:09:15 -0500
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49]:49709 "EHLO
        out162-62-57-49.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233306AbhLPRJP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 12:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639674547;
        bh=tjKHXXEjU3sKf2goSt2YNqs3z3pdfcMFkWIxWqWb0C8=;
        h=From:To:Cc:Subject:Date;
        b=LI6paDp+PNVP5T8J4iRnzRURmzkWGwQrX2H+2HMtmb2UV5ZI/LOokILqbGCGPTZcI
         bJXLGGT8+PKAH3aHr3KVncO8cqvVn3hk6X87Lm6qqieib82VMWUSDyL33/JRd4sl6W
         YVRX5PeatjpKyeMhA3GsG1NNylEuGSzDSM++Oqtw=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id 6F062EE; Fri, 17 Dec 2021 01:01:47 +0800
X-QQ-mid: xmsmtpt1639674107tshdj533p
Message-ID: <tencent_818AD07038A58DFF31107CE6BB5C498E3607@qq.com>
X-QQ-XMAILINFO: Nb6LX7dsrQEkQ8o5jRoUl5e1+gwZ7Fbhk13K+cWhDcw7/GcMVask92ps8o1iW5
         ea4lYTaJ5MzcMKwQW+NrWPz4KYoTGhNBFtseAVkDDJoeTs9de/PWCbZmMPL37wx8DC+sUSzzmWhW
         IRviO82E/XI8zwu9ETSb10IePbtSajtHR2qnn/QjdEs5N2JmXQYuj6MoI/fvujHCQiARk+pPZ8Jy
         bnKOX5h3YFM/R+/oHnVTbSsoqyjReZTLC0+OgNHpT6EkbJeb5XF6+jXxVcp8kRgy8WRp5QBYE6qn
         xAAdxfencfqbCgvGH/Dsvoc9931cwucMLXD20jG0fRUrpkUMm2xADM4kkYAo98hDYL7oBnmv0kU+
         prmuCbBgq8gQO9qFnG1NdYjJAvEeW3Pm3DWsDQVcNz5Ypd2zzrDRb2sr8u30vZy6Fsj4omnCWj5D
         55eGbLzcZh9TVZ1PXYQNB7Gw3dgZZoP9IvGAmhGSpc7mcwun8VRMr01xI6S+k7RATCWD/WvDvmwf
         TjCtGlMX7a5hBcDMiZe44y5GM/6FcuWxXO1Y8y9nTsoq4m6iyv0UtPhQrba4j7iHayXhmb+ALgGD
         gulLCMscegrWNCbZob7w5VdvSOUVtiKs1pfD7NNZoBwJvDkwKX5ZJSi/bxRNkTdS1darUHPMkIAt
         sqI0OY0Zjd9bpcftfNCKx0deFqcsrb3GKeCk0+co1PK9lz+7Q2Dwz2av859xqnX5wRLOFjzQT3s9
         g7ty78BdPgrLnnDMHMcsbAoa45XNyJ6gNety9ixWQ+HNc0HBsJlRJTE/KfhBTVRpWqW24X4NWXL9
         I6XGmEAS5nnFha26VbK7H2flEC1Dy5CTLwE32XriutC5SAluxRK19/HRBX/fBbAZRHm/wI6CG6AC
         yb7Ed4uo4q
From:   xkernel.wang@foxmail.com
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] nfs: nfs4clinet: check the return value of kstrdup()
Date:   Fri, 17 Dec 2021 01:01:33 +0800
X-OQ-MSGID: <20211216170133.342-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kstrdup() returns NULL when some internal memory errors happen, it is
better to check the return value of it so to catch the memory error in
time.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
Changelogs:
move the check under if block.
---
 fs/nfs/nfs4client.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index af57332..ed06b68 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1368,8 +1368,11 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
 	}
 	nfs_put_client(clp);
 
-	if (server->nfs_client->cl_hostname == NULL)
+	if (server->nfs_client->cl_hostname == NULL) {
 		server->nfs_client->cl_hostname = kstrdup(hostname, GFP_KERNEL);
+		if (server->nfs_client->cl_hostname == NULL)
+			return -ENOMEM;
+	}
 	nfs_server_insert_lists(server);
 
 	return nfs_probe_destination(server);
-- 
