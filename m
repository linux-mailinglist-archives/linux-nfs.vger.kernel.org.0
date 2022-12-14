Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5701F64C53E
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Dec 2022 09:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbiLNIsG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Dec 2022 03:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbiLNIsF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Dec 2022 03:48:05 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DF018E2A
        for <linux-nfs@vger.kernel.org>; Wed, 14 Dec 2022 00:48:03 -0800 (PST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D2E4C4432C
        for <linux-nfs@vger.kernel.org>; Wed, 14 Dec 2022 08:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1671007681;
        bh=NLbdKjkintWMihiJs64K9GFOoHQQvvLC9QSEL2SRRSg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=NamEgNXlsQ3XNABaqJiPqIQq1txurWPJY8hyH4YNba9XKiNTEP1d7jDQzGIQQK9Ew
         NCCiFQbF/QtbL1fw9wCnw53Lbd38920UgxDHDsUKeYb1hp/aa1Qu8zwSmEdMCU6k9h
         YO7ynEv89xCVOHertRXjszz+KLR+COxvP2XNODPpZ9zfmB13z3zCIAk6gRWL/jpq4p
         rABx9hlVHEyDsGUC7dmvEGswfXdTSuUTLzonI5YzvWPgVTBRHTTsQ7vf8sx7Sh4mtZ
         dhjRMqWPGAWpujDEwwMGbQEnT5AstxTvqyJFDjbOGUtUFXSFPc6FR5RXDpuYodb4O/
         r5CD36ngUdC8Q==
Received: by mail-pj1-f69.google.com with SMTP id mg21-20020a17090b371500b00219767e0175so3570241pjb.1
        for <linux-nfs@vger.kernel.org>; Wed, 14 Dec 2022 00:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLbdKjkintWMihiJs64K9GFOoHQQvvLC9QSEL2SRRSg=;
        b=77YYn2YFuvc2P9T/rdRkGELjvMERBYD27nbpAtXrjRLRgGXonDQWG9UzyzLWw+/3IO
         jsF1NLGOZZxnr7amQml2PdaO5V0O5HUF4MhurG4k68AeMiUIkXiVvMfTAXAtdtMUJkNB
         l0IhHrvUksded5QZ33F3+rV69BPfMTFwWw7cgPpu/S5aVWWLxJKC7/cX1b5mb32uPLLv
         I8BHN7lBuOZ8T90Bo9gupkOLvwKxhNmDybWY2FALT/EReXuujaABfwYdMwbOWNkuaqW1
         CFYC3+mlbKDYFpRbZU84W57WVBWlzkEn2OG0eNxQnXNisEgCFzDoax3d3/Yc+2lyoMgt
         ngsQ==
X-Gm-Message-State: ANoB5pmIYqCe7lbky0QGyKQKEelT253AJEZT1cRIEWI/wg6VtH4B1T51
        +RAhdcgsApmEyhPahWqy3BDQF89Tf0RYdLTO8cbocOslgCdgiAs4s5jvQ0pGBUROrxCjEt33Iy7
        9GHGBuH34Ak3Fl5ZFF7QsyaZbPXa404SaVnORoA==
X-Received: by 2002:aa7:978a:0:b0:576:e4c7:97bf with SMTP id o10-20020aa7978a000000b00576e4c797bfmr25047246pfp.15.1671007679997;
        Wed, 14 Dec 2022 00:47:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6dQFkC6U3NNys4YYAUoy8tQfr06bjItsWx+qhVodObQPsNj35DSwoUjVcC/n3Wv6pJGtgMRg==
X-Received: by 2002:aa7:978a:0:b0:576:e4c7:97bf with SMTP id o10-20020aa7978a000000b00576e4c797bfmr25047228pfp.15.1671007679656;
        Wed, 14 Dec 2022 00:47:59 -0800 (PST)
Received: from chengendu.. (111-248-150-79.dynamic-ip.hinet.net. [111.248.150.79])
        by smtp.gmail.com with ESMTPSA id b25-20020a62a119000000b00574d38f4d37sm8935709pff.45.2022.12.14.00.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 00:47:59 -0800 (PST)
From:   Chengen Du <chengen.du@canonical.com>
To:     trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengen Du <chengen.du@canonical.com>
Subject: [PATCH] NFS: fix client permission error after adding user to permissible group
Date:   Wed, 14 Dec 2022 16:47:30 +0800
Message-Id: <20221214084730.296936-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 fs/nfs/internal.h       |  2 ++
 fs/nfs/nfs4proc.c       |  5 +++--
 fs/nfs/nfs4xdr.c        | 25 +++++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c       | 21 +++++++++++++++++++++
 fs/nfsd/nfsd.h          |  3 ++-
 include/linux/nfs4.h    |  1 +
 include/linux/nfs_xdr.h |  2 ++
 9 files changed, 69 insertions(+), 4 deletions(-)

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
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 647fc3f547cb..10c271fe2c35 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -382,6 +382,8 @@ extern unsigned long nfs_access_cache_count(struct shrinker *shrink,
 					    struct shrink_control *sc);
 extern unsigned long nfs_access_cache_scan(struct shrinker *shrink,
 					   struct shrink_control *sc);
+extern struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode,
+					const struct cred *cred);
 struct dentry *nfs_lookup(struct inode *, struct dentry *, unsigned int);
 void nfs_d_prune_case_insensitive_aliases(struct inode *inode);
 int nfs_create(struct user_namespace *, struct inode *, struct dentry *,
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
index 2b4ae858c89b..a338b3d9a872 100644
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
+					NFS4_ACCESS_XAWRITE;
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

