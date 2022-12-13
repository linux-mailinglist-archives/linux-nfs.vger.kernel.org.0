Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F3664B2EE
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 11:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbiLMKEB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 05:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiLMKEA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 05:04:00 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA691A3A0
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 02:03:57 -0800 (PST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5BB3344338
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 10:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670925836;
        bh=YG7rlE/EMOLSbzpL9I4FeUBH1+ohVGxDgEkNY/kOJ3M=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=tIaAZ+FMUtPKOlohV6S5A+muaUN8Cf9SeF1xcJyexpLdT2DdjhsK/h2Qh6/8B7PKs
         jUU4XIS54rBZKbM5cB6OxCz9+jf2LGdVHb+fkemIM2UfcnMueMbzdr9nltagyTGT7B
         iceM8IWZSujENF3PmSTi8+jirfTr8QlQ1xhBZIWudNtNucjsNLN6oCDPCzofvh6YSx
         UAy8h1cvjzzYW4BEOAx+OxUIiXZH8/9FPzyDfoEu0G7x89TQRiLSVOv32bdpkpnW3I
         nnM33SYBl0rW5KJjHQ6HxYt7Z7fqCQbOqcfJtZFQqEsfw1/SYwbLwuT+sg//XTUlqF
         GerIBo31NgGHg==
Received: by mail-pj1-f69.google.com with SMTP id oj5-20020a17090b4d8500b00219e1abad17so2065365pjb.1
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 02:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YG7rlE/EMOLSbzpL9I4FeUBH1+ohVGxDgEkNY/kOJ3M=;
        b=4NbBF+E6QHoNhmEdKu+aeW4SUZGOHNo9cDvJ8F3fzdLMOPJki+f6bjPUJ56QU+OsV5
         vBP8qenpntm6ARE3FCfmnsFLN0xgNrNMP+c+LdY3wyY0IDIzFBgv0tCrUuqUlq3ze5xu
         mq9ncGCxe2NLLGkIWk41s4n9nvmn5Xdv25z6dHAXEHvYen5iPaN1Sg5mpC55SGltfuG+
         BsYYfgv/06S/V67ZTpFbgmF4o03ST0dadsRo1OrMSj/yeF+aXT97wMAhISSVXnaNMDgS
         3aT03Ju9mxaLFq7IhSZ6oDE3BU9vaHWTW5Gxhe1QxEA3IKCikt1SDv7oaPmlCWD/7oHg
         ArVw==
X-Gm-Message-State: ANoB5pkSaKf+W91LcrP/tbE5DMugWQlqoE+lKfPlXVIIDaZb4je2d2dv
        bfAyG7kWKUqct6aeP+1nrWB9bTL7d7kCAc/E13b3t6NrYldByeus/omgZpycp5Xu1BxeXtmHkcb
        KlWwZ+UCHPipVeh00+t7PIIWcwIYQXgAguuv+Uw==
X-Received: by 2002:aa7:9e02:0:b0:578:f60:6fac with SMTP id y2-20020aa79e02000000b005780f606facmr16712226pfq.26.1670925834403;
        Tue, 13 Dec 2022 02:03:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4kYSAycex5Q+tZZnrijueEvmZzbiZZuAIV/cpJYehTklrLEoOLZPkOfSDmzjAlVP4zyVLvFw==
X-Received: by 2002:aa7:9e02:0:b0:578:f60:6fac with SMTP id y2-20020aa79e02000000b005780f606facmr16712209pfq.26.1670925834170;
        Tue, 13 Dec 2022 02:03:54 -0800 (PST)
Received: from chengendu.. (111-248-150-79.dynamic-ip.hinet.net. [111.248.150.79])
        by smtp.gmail.com with ESMTPSA id l6-20020a622506000000b00576e75e753asm7304353pfl.27.2022.12.13.02.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 02:03:53 -0800 (PST)
From:   Chengen Du <chengen.du@canonical.com>
To:     trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengen Du <chengen.du@canonical.com>
Subject: [PATCH] NFS: fix client permission error after adding user to permissible group
Date:   Tue, 13 Dec 2022 18:02:41 +0800
Message-Id: <20221213100241.254681-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The access cache only expires if either NFS_INO_INVALID_ACCESS flag is on
or timeout (without delegation).
Adding a user to a group in the NFS server will not cause any file
attributes to change.
The client will encounter permission errors until other file attributes
are changed or the memory cache is dropped.

Steps to reproduce the issue:
1.[client side] testuser is not part of testgroup
  testuser@kinetic:~$ ls -ld /mnt/private/
  drwxrwx--- 2 root testgroup 4096 Nov 24 08:23 /mnt/private/
  testuser@kinetic:~$ mktemp -p /mnt/private/
  mktemp: failed to create file via template
  ‘/mnt/private/tmp.XXXXXXXXXX’: Permission denied
2.[server side] add testuser into testgroup, which has access to folder
  root@kinetic:~$ usermod -aG testgroup testuser &&
  echo `date +'%s'` > /proc/net/rpc/auth.unix.gid/flush
3.[client side] create a file again but still fail
  testuser@kinetic:~$ mktemp -p /mnt/private/
  mktemp: failed to create file via template
  ‘/mnt/private/tmp.XXXXXXXXXX’: Permission denied

Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 fs/nfs/dir.c            |  2 +-
 fs/nfs/inode.c          | 12 ++++++++++++
 fs/nfs/nfs4_fs.h        |  3 +++
 fs/nfs/nfs4proc.c       |  5 +++--
 fs/nfs/nfs4xdr.c        | 25 +++++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c       | 21 +++++++++++++++++++++
 fs/nfsd/nfsd.h          |  3 ++-
 include/linux/nfs4.h    |  1 +
 include/linux/nfs_xdr.h |  2 ++
 9 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f594dac436a7..966f680ebbc8 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2929,7 +2929,7 @@ static int access_cmp(const struct cred *a, const struct nfs_access_entry *b)
 	return 0;
 }
 
-static struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode, const struct cred *cred)
+struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode, const struct cred *cred)
 {
 	struct rb_node *n = NFS_I(inode)->access_cache.rb_node;
 
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 6b2cfa59a1a2..8f952f86b126 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2177,6 +2177,18 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_NLINK;
 
+	if (fattr->valid & NFS_ATTR_FATTR_ACCESS) {
+		if (!(invalid & NFS_INO_INVALID_ACCESS)) {
+			const struct cred *cred = current_cred();
+			struct nfs_access_entry *cache;
+
+			cache = nfs_access_search_rbtree(inode, cred);
+			if (cache != NULL && cache->mask != fattr->access) {
+				invalid |= NFS_INO_INVALID_ACCESS;
+			}
+		}
+	}
+
 	if (fattr->valid & NFS_ATTR_FATTR_SPACE_USED) {
 		/*
 		 * report the blocks in 512byte units
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index cfef738d765e..68ed8d4f95a9 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -272,6 +272,9 @@ extern const struct dentry_operations nfs4_dentry_operations;
 int nfs_atomic_open(struct inode *, struct dentry *, struct file *,
 		    unsigned, umode_t);
 
+extern struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode,
+				const struct cred *cred);
+
 /* fs_context.c */
 extern struct file_system_type nfs4_fs_type;
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 86ed5c0142c3..7f8790ab5c7a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -206,7 +206,8 @@ const u32 nfs4_fattr_bitmap[3] = {
 	| FATTR4_WORD1_TIME_ACCESS
 	| FATTR4_WORD1_TIME_METADATA
 	| FATTR4_WORD1_TIME_MODIFY
-	| FATTR4_WORD1_MOUNTED_ON_FILEID,
+	| FATTR4_WORD1_MOUNTED_ON_FILEID
+	| FATTR4_WORD1_ACCESS,
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 	FATTR4_WORD2_SECURITY_LABEL
 #endif
@@ -3820,7 +3821,7 @@ static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 		nfs4_close_state(ctx->state, _nfs4_ctx_to_openmode(ctx));
 }
 
-#define FATTR4_WORD1_NFS40_MASK (2*FATTR4_WORD1_MOUNTED_ON_FILEID - 1UL)
+#define FATTR4_WORD1_NFS40_MASK (2*FATTR4_WORD1_ACCESS - 1UL)
 #define FATTR4_WORD2_NFS41_MASK (2*FATTR4_WORD2_SUPPATTR_EXCLCREAT - 1UL)
 #define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_XATTR_SUPPORT - 1UL)
 
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index acfe5f4bda48..cf651e9b4a5d 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4296,6 +4296,26 @@ static int decode_attr_xattrsupport(struct xdr_stream *xdr, uint32_t *bitmap,
 	return 0;
 }
 
+static int decode_attr_access(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *access)
+{
+	__be32 *p;
+	int ret = 0;
+
+	*access = 0;
+	if (unlikely(bitmap[1] & (FATTR4_WORD1_ACCESS - 1U)))
+		return -EIO;
+	if (likely(bitmap[1] & FATTR4_WORD1_ACCESS)) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+		*access = be32_to_cpup(p);
+		bitmap[1] &= ~FATTR4_WORD1_ACCESS;
+		ret = NFS_ATTR_FATTR_ACCESS;
+	}
+	dprintk("%s: access=%u\n", __func__, (unsigned int)*access);
+	return ret;
+}
+
 static int verify_attr_len(struct xdr_stream *xdr, unsigned int savep, uint32_t attrlen)
 {
 	unsigned int attrwords = XDR_QUADLEN(attrlen);
@@ -4747,6 +4767,11 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
 		goto xdr_error;
 	fattr->valid |= status;
 
+	status = decode_attr_access(xdr, bitmap, &fattr->access);
+	if (status < 0)
+		goto xdr_error;
+	fattr->valid |= status;
+
 	status = -EIO;
 	if (unlikely(bitmap[1]))
 		goto xdr_error;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2b4ae858c89b..788e9faaa6e5 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3396,6 +3396,27 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		}
 		p = xdr_encode_hyper(p, ino);
 	}
+	if (bmval1 & FATTR4_WORD1_ACCESS) {
+		u32 access;
+		u32 supported;
+
+		access = NFS3_ACCESS_READ | NFS3_ACCESS_MODIFY | NFS3_ACCESS_EXTEND;
+		if (minorversion >= 2) {
+			access |= NFS4_ACCESS_XALIST | NFS4_ACCESS_XAREAD |
+								NFS4_ACCESS_XAWRITE;
+		}
+		if (S_ISDIR(d_inode(dentry)->i_mode))
+			access |= NFS3_ACCESS_DELETE | NFS3_ACCESS_LOOKUP;
+		else
+			access |= NFS3_ACCESS_EXECUTE;
+		status = nfsd_access(rqstp, fhp, &access, &supported);
+		if (status)
+			goto out;
+		p = xdr_reserve_space(xdr, 4);
+		if (!p)
+			goto out_resource;
+		*p++ = cpu_to_be32(access);
+	}
 #ifdef CONFIG_NFSD_PNFS
 	if (bmval1 & FATTR4_WORD1_FS_LAYOUT_TYPES) {
 		status = nfsd4_encode_layout_types(xdr, exp->ex_layout_types);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 93b42ef9ed91..648a4ec3e2d4 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -378,7 +378,8 @@ void		nfsd_lockd_shutdown(void);
  | FATTR4_WORD1_SPACE_AVAIL     | FATTR4_WORD1_SPACE_FREE   | FATTR4_WORD1_SPACE_TOTAL      \
  | FATTR4_WORD1_SPACE_USED      | FATTR4_WORD1_TIME_ACCESS  | FATTR4_WORD1_TIME_ACCESS_SET  \
  | FATTR4_WORD1_TIME_DELTA      | FATTR4_WORD1_TIME_METADATA   | FATTR4_WORD1_TIME_CREATE      \
- | FATTR4_WORD1_TIME_MODIFY     | FATTR4_WORD1_TIME_MODIFY_SET | FATTR4_WORD1_MOUNTED_ON_FILEID)
+ | FATTR4_WORD1_TIME_MODIFY     | FATTR4_WORD1_TIME_MODIFY_SET | FATTR4_WORD1_MOUNTED_ON_FILEID \
+ | FATTR4_WORD1_ACCESS)
 
 #define NFSD4_SUPPORTED_ATTRS_WORD2 0
 
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 730003c4f4af..63d0e31c6552 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -451,6 +451,7 @@ enum lock_type4 {
 #define FATTR4_WORD1_TIME_MODIFY        (1UL << 21)
 #define FATTR4_WORD1_TIME_MODIFY_SET    (1UL << 22)
 #define FATTR4_WORD1_MOUNTED_ON_FILEID  (1UL << 23)
+#define FATTR4_WORD1_ACCESS             (1UL << 24)
 #define FATTR4_WORD1_DACL               (1UL << 26)
 #define FATTR4_WORD1_SACL               (1UL << 27)
 #define FATTR4_WORD1_FS_LAYOUT_TYPES    (1UL << 30)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index e86cf6642d21..4626e27588de 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -78,6 +78,7 @@ struct nfs_fattr {
 	struct nfs4_string	*group_name;
 	struct nfs4_threshold	*mdsthreshold;	/* pNFS threshold hints */
 	struct nfs4_label	*label;
+	__u32 access;
 };
 
 #define NFS_ATTR_FATTR_TYPE		(1U << 0)
@@ -106,6 +107,7 @@ struct nfs_fattr {
 #define NFS_ATTR_FATTR_OWNER_NAME	(1U << 23)
 #define NFS_ATTR_FATTR_GROUP_NAME	(1U << 24)
 #define NFS_ATTR_FATTR_V4_SECURITY_LABEL (1U << 25)
+#define NFS_ATTR_FATTR_ACCESS (1U << 26)
 
 #define NFS_ATTR_FATTR (NFS_ATTR_FATTR_TYPE \
 		| NFS_ATTR_FATTR_MODE \
-- 
2.37.2

