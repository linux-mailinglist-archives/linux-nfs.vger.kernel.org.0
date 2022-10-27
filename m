Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DC860F25E
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 10:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiJ0If5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 04:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiJ0Ifz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 04:35:55 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Oct 2022 01:35:53 PDT
Received: from haproxy.adestotech.com (haproxy.adestotech.com [217.163.77.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13838B2CD
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 01:35:52 -0700 (PDT)
Received: from skynet19.adestotech.com (unknown [192.168.129.19])
        by haproxy.adestotech.com (Postfix) with ESMTP id CD74FA154A;
        Thu, 27 Oct 2022 09:18:50 +0100 (IST)
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     chuck.lever@oracle.com,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Subject: [PATCH 1/1] nfs: Move ACL xattr definitions to linux/xattr.h 
Date:   Thu, 27 Oct 2022 10:18:16 +0200
Message-Id: <20221027081816.812452-1-ondrej.valousek.xm@renesas.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Short description:
The XATTR_NAME_NFSV4_ACL definition is also useful for
userspace (i.e. nfs4_acl_tools/libacl/coreutils) so makes a sense to move the
definition to the linux/xattr.h

Signed-off-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
---
 fs/nfs/nfs4proc.c          | 2 --
 include/uapi/linux/xattr.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e2efcd26336c..07c3d8572912 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7680,8 +7680,6 @@ nfs4_release_lockowner(struct nfs_server *server, struct nfs4_lock_state *lsp)
 	rpc_call_async(server->client, &msg, 0, &nfs4_release_lockowner_ops, data);
 }
 
-#define XATTR_NAME_NFSV4_ACL "system.nfs4_acl"
-
 static int nfs4_xattr_set_nfs4_acl(const struct xattr_handler *handler,
 				   struct user_namespace *mnt_userns,
 				   struct dentry *unused, struct inode *inode,
diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index 9463db2dfa9d..77eb8c885861 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -81,5 +81,7 @@
 #define XATTR_POSIX_ACL_DEFAULT  "posix_acl_default"
 #define XATTR_NAME_POSIX_ACL_DEFAULT XATTR_SYSTEM_PREFIX XATTR_POSIX_ACL_DEFAULT
 
+#define XATTR_NFSV4_ACL "nfs4_acl"
+#define XATTR_NAME_NFSV4_ACL XATTR_SYSTEM_PREFIX XATTR_NFSV4_ACL
 
 #endif /* _UAPI_LINUX_XATTR_H */
-- 
2.37.3

