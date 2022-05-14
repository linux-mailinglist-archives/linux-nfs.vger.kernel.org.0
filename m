Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0136D527238
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiENOvQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiENOvD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:51:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875533466E
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2570360F47
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D94C34115;
        Sat, 14 May 2022 14:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652539844;
        bh=odlxsU29+JDC0Rk+rXa/UZjb+s1xQTrvBiI3D4noiOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHSCLUFn15LnWbcsIaNdo4TLIO4yGL7yQ3Knn1VmkoUU4efVHqTkv06LHCY29f/tL
         wysCv0FpVIIqBWcefiO5H11CVssbnR4ErjsGmNZ04k2k34fptMvH9wSaYjaIU7zdZn
         7q+8C93/IVC1jAPI2sEwtXcUC5/u8AUqbQNxJtG+t/iBBySEEu16p4w8zGQRaGCB7z
         vWsKRqVsZ+amxuw+/78Vjt/DpDfA/F1kG2voVQvOWCOEyVBklNVjDSGNqPlvvIPbBI
         S9X4meRhozHm3ESWOpRrtcK6VpNaI/yVsRZMCJgLy++4Jbcl0Jbewj8bavS5Fo1zao
         pJBDKRHJGSoAA==
From:   trondmy@kernel.org
To:     Steve Dickson <SteveD@redhat.com>,
        "J.Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/6] The NFSv41 DACL and SACL prepend an extra field to the acl
Date:   Sat, 14 May 2022 10:44:33 -0400
Message-Id: <20220514144436.4298-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514144436.4298-3-trondmy@kernel.org>
References: <20220514144436.4298-1-trondmy@kernel.org>
 <20220514144436.4298-2-trondmy@kernel.org>
 <20220514144436.4298-3-trondmy@kernel.org>
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

The ACL flags describe the inheritance mode of the acl:
- AUTO_INHERIT
- PROTECTED
- DEFAULTED

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/libacl_nfs4.h            |  8 ++++++++
 include/nfs4.h                   |  5 +++++
 libnfs4acl/acl_nfs4_copy_acl.c   |  2 ++
 libnfs4acl/acl_nfs4_xattr_load.c | 14 +++++++++++++-
 libnfs4acl/acl_nfs4_xattr_pack.c | 22 +++++++++++++++++-----
 libnfs4acl/nfs4_getacl.c         | 11 ++++++-----
 libnfs4acl/nfs4_new_acl.c        |  1 +
 libnfs4acl/nfs4_setacl.c         | 10 +++++-----
 8 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/include/libacl_nfs4.h b/include/libacl_nfs4.h
index d54d82f94f97..a486390ac170 100644
--- a/include/libacl_nfs4.h
+++ b/include/libacl_nfs4.h
@@ -142,6 +142,12 @@
 
 typedef u_int32_t u32;
 
+enum acl_type {
+	ACL_TYPE_ACL,
+	ACL_TYPE_DACL,
+	ACL_TYPE_SACL
+};
+
 enum {	ACL_NFS4_NOT_USED = 0,
 		ACL_NFS4_USED
 };
@@ -166,7 +172,9 @@ extern int			nfs4_setsacl(const char *path, struct nfs4_acl *acl);
 extern int			acl_nfs4_set_who(struct nfs4_ace*, int, char*);
 extern struct nfs4_acl *	acl_nfs4_copy_acl(struct nfs4_acl *);
 extern struct nfs4_acl *	acl_nfs4_xattr_load(char *, int, u32);
+extern struct nfs4_acl *	acl_nfs41_xattr_load(char *, int, u32, enum acl_type);
 extern int			acl_nfs4_xattr_pack(struct nfs4_acl *, char**);
+extern int			acl_nfs41_xattr_pack(struct nfs4_acl *, char**, enum acl_type);
 extern int			acl_nfs4_xattr_size(struct nfs4_acl *);
 
 extern void			nfs4_free_acl(struct nfs4_acl *);
diff --git a/include/nfs4.h b/include/nfs4.h
index 20bfa6b99634..d15482e8a720 100644
--- a/include/nfs4.h
+++ b/include/nfs4.h
@@ -55,6 +55,10 @@
 #define ACL4_SUPPORT_AUDIT_ACL 0x04
 #define ACL4_SUPPORT_ALARM_ACL 0x08
 
+#define NFS4_ACL_AUTO_INHERIT	0x00000001
+#define NFS4_ACL_PROTECTED	0x00000002
+#define NFS4_ACL_DEFAULTED	0x00000004
+
 #define NFS4_ACE_FILE_INHERIT_ACE             0x00000001
 #define NFS4_ACE_DIRECTORY_INHERIT_ACE        0x00000002
 #define NFS4_ACE_NO_PROPAGATE_INHERIT_ACE     0x00000004
@@ -126,6 +130,7 @@ struct nfs4_acl {
 	u_int32_t		naces;
 	u_int32_t		is_directory;
 	struct ace_list_head	ace_head;
+	u_int32_t		aclflag;
 };
 
 typedef struct { char data[NFS4_VERIFIER_SIZE]; } nfs4_verifier;
diff --git a/libnfs4acl/acl_nfs4_copy_acl.c b/libnfs4acl/acl_nfs4_copy_acl.c
index cf09173badc0..7a6d83b1ca64 100644
--- a/libnfs4acl/acl_nfs4_copy_acl.c
+++ b/libnfs4acl/acl_nfs4_copy_acl.c
@@ -54,6 +54,8 @@ struct nfs4_acl * acl_nfs4_copy_acl(struct nfs4_acl * acl)
 	if (new_acl == NULL)
 		goto failed;
 
+	new_acl->aclflag = acl->aclflag;
+
 	ace = nfs4_get_first_ace(acl);
 	nace = 1;
 
diff --git a/libnfs4acl/acl_nfs4_xattr_load.c b/libnfs4acl/acl_nfs4_xattr_load.c
index 089a139142b1..c747e8dac225 100644
--- a/libnfs4acl/acl_nfs4_xattr_load.c
+++ b/libnfs4acl/acl_nfs4_xattr_load.c
@@ -38,7 +38,8 @@
 #include "libacl_nfs4.h"
 
 
-struct nfs4_acl * acl_nfs4_xattr_load(char *xattr_v, int xattr_size, u32 is_dir)
+struct nfs4_acl *acl_nfs41_xattr_load(char *xattr_v, int xattr_size, u32 is_dir,
+				      enum acl_type acl_type)
 {
 	struct nfs4_acl *acl;
 	struct nfs4_ace *ace;
@@ -61,6 +62,12 @@ struct nfs4_acl * acl_nfs4_xattr_load(char *xattr_v, int xattr_size, u32 is_dir)
 		return NULL;
 	}
 
+	if (acl_type == ACL_TYPE_DACL || acl_type == ACL_TYPE_SACL) {
+		acl->aclflag = (u32)ntohl(*((u32*)(bufp)));
+		bufp += sizeof(u32);
+		bufs -= sizeof(u32);
+	}
+
 	/* Grab the number of aces in the acl */
 	num_aces = (u32)ntohl(*((u32*)(bufp)));
 
@@ -180,3 +187,8 @@ err1:
 	nfs4_free_acl(acl);
 	return NULL;
 }
+
+struct nfs4_acl *acl_nfs4_xattr_load(char *xattr_v, int xattr_size, u32 is_dir)
+{
+	return acl_nfs41_xattr_load(xattr_v, xattr_size, is_dir, ACL_TYPE_ACL);
+}
diff --git a/libnfs4acl/acl_nfs4_xattr_pack.c b/libnfs4acl/acl_nfs4_xattr_pack.c
index 7c281feed496..2bd3b1b1a229 100644
--- a/libnfs4acl/acl_nfs4_xattr_pack.c
+++ b/libnfs4acl/acl_nfs4_xattr_pack.c
@@ -37,11 +37,12 @@
 #include "libacl_nfs4.h"
 #include <stdio.h>
 
-int acl_nfs4_xattr_pack(struct nfs4_acl * acl, char** bufp)
+int acl_nfs41_xattr_pack(struct nfs4_acl * acl, char** bufp,
+			 enum acl_type acl_type)
 {
 	struct nfs4_ace * ace;
 	int buflen;
-	int rbuflen;
+	int rbuflen = 0;
 	int num_aces;
 	int ace_num;
 	int wholen;
@@ -58,6 +59,9 @@ int acl_nfs4_xattr_pack(struct nfs4_acl * acl, char** bufp)
 	if (buflen < 0)
 		goto failed;
 
+	if (acl_type == ACL_TYPE_DACL || acl_type == ACL_TYPE_SACL)
+		buflen += sizeof(u32);
+
 	*bufp = (char*) malloc(buflen);
 	if (*bufp == NULL) {
 		errno = ENOMEM;
@@ -67,11 +71,17 @@ int acl_nfs4_xattr_pack(struct nfs4_acl * acl, char** bufp)
 
 	p = *bufp;
 
+	if (acl_type == ACL_TYPE_DACL || acl_type == ACL_TYPE_SACL) {
+		*((u32*)p) = htonl(acl->aclflag);
+		rbuflen += sizeof(u32);
+		p += sizeof(u32);
+	}
+
 	num_aces = acl->naces;
 
 	*((u32*)p) = htonl(num_aces);
 
-	rbuflen = sizeof(u32);
+	rbuflen += sizeof(u32);
 	p += sizeof(u32);
 
 	ace = nfs4_get_first_ace(acl);
@@ -140,5 +150,7 @@ failed:
 	return -1;
 }
 
-
-
+int acl_nfs4_xattr_pack(struct nfs4_acl * acl, char** bufp)
+{
+	return acl_nfs41_xattr_pack(acl, bufp, ACL_TYPE_ACL);
+}
diff --git a/libnfs4acl/nfs4_getacl.c b/libnfs4acl/nfs4_getacl.c
index 753ba9167459..7821da3885fe 100644
--- a/libnfs4acl/nfs4_getacl.c
+++ b/libnfs4acl/nfs4_getacl.c
@@ -25,7 +25,8 @@
 
 /* returns a newly-allocated struct nfs4_acl or NULL on error. */
 static struct nfs4_acl *nfs4_getacl_byname(const char *path,
-					   const char *xattr_name)
+					   const char *xattr_name,
+					   enum acl_type type)
 {
 	struct nfs4_acl *acl;
 	struct stat st;
@@ -59,7 +60,7 @@ static struct nfs4_acl *nfs4_getacl_byname(const char *path,
 	if (S_ISDIR(st.st_mode))
 		iflags = NFS4_ACL_ISDIR;
 
-	acl = acl_nfs4_xattr_load(buf, ret, iflags);
+	acl = acl_nfs41_xattr_load(buf, ret, iflags, type);
 
 	free(buf);
 	return acl;
@@ -71,13 +72,13 @@ err:
 
 struct nfs4_acl *nfs4_getacl(const char *path)
 {
-	return nfs4_getacl_byname(path, ACL_NFS4_XATTR);
+	return nfs4_getacl_byname(path, ACL_NFS4_XATTR, ACL_TYPE_ACL);
 }
 struct nfs4_acl *nfs4_getdacl(const char *path)
 {
-	return nfs4_getacl_byname(path, DACL_NFS4_XATTR);
+	return nfs4_getacl_byname(path, DACL_NFS4_XATTR, ACL_TYPE_DACL);
 }
 struct nfs4_acl *nfs4_getsacl(const char *path)
 {
-	return nfs4_getacl_byname(path, SACL_NFS4_XATTR);
+	return nfs4_getacl_byname(path, SACL_NFS4_XATTR, ACL_TYPE_SACL);
 }
diff --git a/libnfs4acl/nfs4_new_acl.c b/libnfs4acl/nfs4_new_acl.c
index 78d4c28e474b..0a5583af3bc5 100644
--- a/libnfs4acl/nfs4_new_acl.c
+++ b/libnfs4acl/nfs4_new_acl.c
@@ -50,6 +50,7 @@ nfs4_new_acl(u32 is_dir)
 
 	acl->naces = 0;
 	acl->is_directory = is_dir;
+	acl->aclflag = 0;
 
 	TAILQ_INIT(&acl->ace_head);
 
diff --git a/libnfs4acl/nfs4_setacl.c b/libnfs4acl/nfs4_setacl.c
index 298365ec67c5..d68450220757 100644
--- a/libnfs4acl/nfs4_setacl.c
+++ b/libnfs4acl/nfs4_setacl.c
@@ -23,12 +23,12 @@
 #include "libacl_nfs4.h"
 
 static int nfs4_setacl_byname(const char *path, const char *xattr_name,
-			      struct nfs4_acl *acl)
+			      struct nfs4_acl *acl, enum acl_type type)
 {
 	char *xdrbuf = NULL;
 	int ret;
 
-	ret = acl_nfs4_xattr_pack(acl, &xdrbuf);
+	ret = acl_nfs41_xattr_pack(acl, &xdrbuf, type);
 	if (ret != -1)
 		ret = setxattr(path, xattr_name, xdrbuf, ret, XATTR_REPLACE);
 	free(xdrbuf);
@@ -37,13 +37,13 @@ static int nfs4_setacl_byname(const char *path, const char *xattr_name,
 
 int nfs4_setacl(const char *path, struct nfs4_acl *acl)
 {
-	return nfs4_setacl_byname(path, ACL_NFS4_XATTR, acl);
+	return nfs4_setacl_byname(path, ACL_NFS4_XATTR, acl, ACL_TYPE_ACL);
 }
 int nfs4_setdacl(const char *path, struct nfs4_acl *acl)
 {
-	return nfs4_setacl_byname(path, DACL_NFS4_XATTR, acl);
+	return nfs4_setacl_byname(path, DACL_NFS4_XATTR, acl, ACL_TYPE_DACL);
 }
 int nfs4_setsacl(const char *path, struct nfs4_acl *acl)
 {
-	return nfs4_setacl_byname(path, SACL_NFS4_XATTR, acl);
+	return nfs4_setacl_byname(path, SACL_NFS4_XATTR, acl, ACL_TYPE_SACL);
 }
-- 
2.36.1

