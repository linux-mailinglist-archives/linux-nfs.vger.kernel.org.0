Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19651527221
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiENOny (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiENOnu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C5D186DE
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:43:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F59F60F69
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4363CC34118;
        Sat, 14 May 2022 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652539428;
        bh=rpvHvY20I59IgEIIuFFTC9dY1GCZwR+tFi2FWbpaPcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbKRhyF5JkFf35UP6zb7WHLG4pMviD+MTd5igFy2IzVAC44RFZmvGkk4k0Ftp3pz8
         kM+IVNvTFzieQLK18JiqeX4o5thxucpb7HMjz6cfxTqRfRy10PKo5aYrGJcDnJBsAy
         DD5QP0yJlkSUkiKgPFZRLBea0TQi7KRaPMbRchkrDMxPahAwq1QXSO/372sP2YB2qw
         JwWoHeTeo70V1wK2xTAEZvWr7atNaob/tFNLmDE2d0inJjxAINu4Edx43HIjUwUZhG
         FCjDbDyCqA3L0ze4fE+e038B2faqwc8KvgwKOzAzae24K1GqYKrgdCcGx96q70s1Ux
         KhxRUFIsYeIMg==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFSv4.1: Enable access to the NFSv4.1 'dacl' and 'sacl' attributes
Date:   Sat, 14 May 2022 10:37:00 -0400
Message-Id: <20220514143700.4263-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514143700.4263-3-trondmy@kernel.org>
References: <20220514143700.4263-1-trondmy@kernel.org>
 <20220514143700.4263-2-trondmy@kernel.org>
 <20220514143700.4263-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Enable access to the NFSv4 acl via the NFSv4.1 'dacl' and 'sacl'
attributes.
This allows the server to authenticate the DACL and the SACL operations
separately, since reading and/or editing the SACL is usually considered
to be a privileged operation.
It also allows the propagation of automatic inheritance information that
was not supported by the NFSv4.0 'acl' attribute.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b2ddbaf32a95..0dfdbb406f96 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7698,6 +7698,55 @@ static bool nfs4_xattr_list_nfs4_acl(struct dentry *dentry)
 	return nfs4_server_supports_acls(NFS_SB(dentry->d_sb), NFS4ACL_ACL);
 }
 
+#if defined(CONFIG_NFS_V4_1)
+#define XATTR_NAME_NFSV4_DACL "system.nfs4_dacl"
+
+static int nfs4_xattr_set_nfs4_dacl(const struct xattr_handler *handler,
+				    struct user_namespace *mnt_userns,
+				    struct dentry *unused, struct inode *inode,
+				    const char *key, const void *buf,
+				    size_t buflen, int flags)
+{
+	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_DACL);
+}
+
+static int nfs4_xattr_get_nfs4_dacl(const struct xattr_handler *handler,
+				    struct dentry *unused, struct inode *inode,
+				    const char *key, void *buf, size_t buflen)
+{
+	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_DACL);
+}
+
+static bool nfs4_xattr_list_nfs4_dacl(struct dentry *dentry)
+{
+	return nfs4_server_supports_acls(NFS_SB(dentry->d_sb), NFS4ACL_DACL);
+}
+
+#define XATTR_NAME_NFSV4_SACL "system.nfs4_sacl"
+
+static int nfs4_xattr_set_nfs4_sacl(const struct xattr_handler *handler,
+				    struct user_namespace *mnt_userns,
+				    struct dentry *unused, struct inode *inode,
+				    const char *key, const void *buf,
+				    size_t buflen, int flags)
+{
+	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_SACL);
+}
+
+static int nfs4_xattr_get_nfs4_sacl(const struct xattr_handler *handler,
+				    struct dentry *unused, struct inode *inode,
+				    const char *key, void *buf, size_t buflen)
+{
+	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_SACL);
+}
+
+static bool nfs4_xattr_list_nfs4_sacl(struct dentry *dentry)
+{
+	return nfs4_server_supports_acls(NFS_SB(dentry->d_sb), NFS4ACL_SACL);
+}
+
+#endif
+
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 
 static int nfs4_xattr_set_nfs4_label(const struct xattr_handler *handler,
@@ -10615,6 +10664,22 @@ static const struct xattr_handler nfs4_xattr_nfs4_acl_handler = {
 	.set	= nfs4_xattr_set_nfs4_acl,
 };
 
+#if defined(CONFIG_NFS_V4_1)
+static const struct xattr_handler nfs4_xattr_nfs4_dacl_handler = {
+	.name	= XATTR_NAME_NFSV4_DACL,
+	.list	= nfs4_xattr_list_nfs4_dacl,
+	.get	= nfs4_xattr_get_nfs4_dacl,
+	.set	= nfs4_xattr_set_nfs4_dacl,
+};
+
+static const struct xattr_handler nfs4_xattr_nfs4_sacl_handler = {
+	.name	= XATTR_NAME_NFSV4_SACL,
+	.list	= nfs4_xattr_list_nfs4_sacl,
+	.get	= nfs4_xattr_get_nfs4_sacl,
+	.set	= nfs4_xattr_set_nfs4_sacl,
+};
+#endif
+
 #ifdef CONFIG_NFS_V4_2
 static const struct xattr_handler nfs4_xattr_nfs4_user_handler = {
 	.prefix	= XATTR_USER_PREFIX,
@@ -10625,6 +10690,10 @@ static const struct xattr_handler nfs4_xattr_nfs4_user_handler = {
 
 const struct xattr_handler *nfs4_xattr_handlers[] = {
 	&nfs4_xattr_nfs4_acl_handler,
+#if defined(CONFIG_NFS_V4_1)
+	&nfs4_xattr_nfs4_dacl_handler,
+	&nfs4_xattr_nfs4_sacl_handler,
+#endif
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 	&nfs4_xattr_nfs4_label_handler,
 #endif
-- 
2.36.1

