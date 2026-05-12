Return-Path: <linux-nfs+bounces-21522-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFm9LXhSA2qn4gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21522-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:16:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 540A55247D3
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF57C301A527
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 16:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139223CB919;
	Tue, 12 May 2026 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXnyBjth"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A73CB8FB;
	Tue, 12 May 2026 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602378; cv=none; b=RIswXdq9nJA6cBfrtXKEsVg4PcAbjoSXG5HYdd44q9lXvOaftK0FOr4x8gJ9ep9KN+vJV0dP4DZPb1yMVW9TyDJpl1MV1qxAWWCThXA62W2LMPVlPUM6aNzPgdWxrkk95H5HfPBNLleznjzA0WDw9Jpz7zMQTU2cmZqTEev3t9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602378; c=relaxed/simple;
	bh=cgcE1HWrmofLgMn+CBox+LmXA2jqLJ864+I//yGbd1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ibs6jrF2N3c035OOAOhPim47QTTVtvh7Vrer9dBpTeDPls8/kbbLZDXU4Xdx5FqCm/jVcC2VTqYBeuQwwko3gArgaQ4j3oOLlWt0CBx14d10uckmDm1Q1vyCV5xQUhBli4b+4zWqTVCr6EoBfpjatsPv5PsdmrjMhGezB55m1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXnyBjth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE73C2BCC7;
	Tue, 12 May 2026 16:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602377;
	bh=cgcE1HWrmofLgMn+CBox+LmXA2jqLJ864+I//yGbd1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZXnyBjthfMXaYLda+Sor6DkNQ2DCYzr+fINYWIdPNjgbS7fC7UVYNjAkMA/1f1elu
	 ELXGDM/BSrBakHj5kN/mgYeEn8B/Z2/V3x4+ScYLOZWXAlbYSkqncb70mF8h1IfebU
	 UgSNfirdkreOwlrpXC6yL7j/uCkMEeKKMcVasb6vjxflidetzLwM+fAqePtDOJ4SHp
	 ke+bV+mrz4QtIEB1txwRyS1Kgtuq7Mfxf3FAKLyQ9j1rmSHEIRD1rrVKqMuqRVrbye
	 Py9nh5Th345bg1Lfw0V5p3ftqX4VeYFmL+InmhQ6hQRYQDfNUdmj59z5DKH2/9FjkH
	 shhhlcKgZA/Dw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 12 May 2026 12:12:42 -0400
Subject: [PATCH 1/4] nfs: store the full NFS fileid in inode->i_ino
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nfsino-v1-1-284720522f4c@kernel.org>
References: <20260512-nfsino-v1-0-284720522f4c@kernel.org>
In-Reply-To: <20260512-nfsino-v1-0-284720522f4c@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5075; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cgcE1HWrmofLgMn+CBox+LmXA2jqLJ864+I//yGbd1c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqA1GHnWZYs9HOiLeDsP0C6a9A01xAgzdvG3lHy
 CPoYWION0eJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCagNRhwAKCRAADmhBGVaC
 FXYxEADF3Wf1FQl+4xsgQEPe42ieLseAHlbxRQFW5dnhKRxU5oMliajgSOGfspHDcstHYcTQd3V
 4BSxRt1op1x8AeTxMIeaB9CqL4NgxIQI5vyzNEB3Qub8WQDsrwrrZs1iMMXTOlvBeeI4+zARdox
 Ep7LEJfajev0Q/gzUhV2WJRk4xp+vLC2y+gPb9o0U9ukYqzgRFIh6CmFhvW/nM4cYHVejrmpOQ/
 /DV2rHRKrm+kAblMGl+bC/PijGHNz3+Mfz9M/ecbAAob1rMXfXck/BygpxhseDN5EEDQ5Sak+/L
 5hfGXSK3A3baSnNZLqspBMUt4Kp5RCCFWigdNWYBzFaYR+Gz9Ey4zwZchFG1xlHAp3bMAtRdYPF
 6LM9g70QK/3A5Fh+9TgQr6f6NqqVgQsKCPMgIVmRn2K7IevPy3N8PEZVckBnctiQHr/Za1IJQ+w
 9Gmf2BqeLEMaTP756RDnMYrSXPLbsfZYQ4HJ15ba3CfMu6upUowi4+LG25byJPowX8X6E/4OqKe
 fiUI+X9geK0DCwQqPTxp5+bStCftfP6mOgExrsoZY86KmIGYwb0WWwH1URihgUWkteVbL6cKz+L
 K8aP+Ix8JjKG0HTOMbHcA622upRJalVTJbZ0I2VhQBLE8fvKahhP1NNa3zd0gwKNNBxq2iRagxQ
 E0dxqH7IZhoO4Pw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 540A55247D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-21522-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Now that inode->i_ino is a 64-bit value, store the full NFS fileid in
it directly instead of an XOR-folded hash. This makes NFS_FILEID() and
set_nfs_fileid() operate on inode->i_ino rather than the separate
nfsi->fileid field.

Since iget5_locked() and ilookup5() now accept a u64 hashval, pass the
full fileid as the hash parameter directly.

Convert direct nfsi->fileid accesses in nfs_check_inode_attributes(),
nfs_update_inode(), and nfs_same_file() to use inode->i_ino.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/dir.c           |  2 +-
 fs/nfs/inode.c         | 25 ++++++++++---------------
 include/linux/nfs_fs.h |  4 ++--
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e9ce1883288c..5f8c3ea0bce3 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -650,7 +650,7 @@ int nfs_same_file(struct dentry *dentry, struct nfs_entry *entry)
 		return 0;
 
 	nfsi = NFS_I(inode);
-	if (entry->fattr->fileid != nfsi->fileid)
+	if (entry->fattr->fileid != inode->i_ino)
 		return 0;
 	if (entry->fh->size && nfs_compare_fh(entry->fh, &nfsi->fh) != 0)
 		return 0;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index e26030e73696..dd9e378c36fb 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -66,10 +66,10 @@ static int nfs_update_inode(struct inode *, struct nfs_fattr *);
 
 static struct kmem_cache * nfs_inode_cachep;
 
-static inline unsigned long
+static inline u64
 nfs_fattr_to_ino_t(struct nfs_fattr *fattr)
 {
-	return nfs_fileid_to_ino_t(fattr->fileid);
+	return fattr->fileid;
 }
 
 int nfs_wait_bit_killable(struct wait_bit_key *key, int mode)
@@ -313,8 +313,7 @@ struct nfs_find_desc {
 };
 
 /*
- * In NFSv3 we can have 64bit inode numbers. In order to support
- * this, and re-exported directories (also seen in NFSv2)
+ * For re-exported directories (also seen in NFSv2)
  * we are forced to allow 2 different inodes to have the same
  * i_ino.
  */
@@ -413,7 +412,7 @@ nfs_ilookup(struct super_block *sb, struct nfs_fattr *fattr, struct nfs_fh *fh)
 		.fattr	= fattr,
 	};
 	struct inode *inode;
-	unsigned long hash;
+	u64 hash;
 
 	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID) ||
 	    !(fattr->valid & NFS_ATTR_FATTR_TYPE))
@@ -456,7 +455,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 	};
 	struct inode *inode = ERR_PTR(-ENOENT);
 	u64 fattr_supported = NFS_SB(sb)->fattr_valid;
-	unsigned long hash;
+	u64 hash;
 
 	nfs_attr_check_mountpoint(sb, fattr);
 
@@ -479,10 +478,6 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		struct nfs_inode *nfsi = NFS_I(inode);
 		unsigned long now = jiffies;
 
-		/* We set i_ino for the few things that still rely on it,
-		 * such as stat(2) */
-		inode->i_ino = hash;
-
 		/* We can't support update_atime(), since the server will reset it */
 		inode->i_flags |= S_NOATIME|S_NOCMTIME;
 		inode->i_mode = fattr->mode;
@@ -1672,10 +1667,10 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 		if (fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID)
 			return 0;
 	/* Has the inode gone and changed behind our back? */
-	} else if (nfsi->fileid != fattr->fileid) {
+	} else if (inode->i_ino != fattr->fileid) {
 		/* Is this perhaps the mounted-on fileid? */
 		if ((fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID) &&
-		    nfsi->fileid == fattr->mounted_on_fileid)
+		    inode->i_ino == fattr->mounted_on_fileid)
 			return 0;
 		return -ESTALE;
 	}
@@ -2262,15 +2257,15 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		if (fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID)
 			return 0;
 	/* Has the inode gone and changed behind our back? */
-	} else if (nfsi->fileid != fattr->fileid) {
+	} else if (inode->i_ino != fattr->fileid) {
 		/* Is this perhaps the mounted-on fileid? */
 		if ((fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID) &&
-		    nfsi->fileid == fattr->mounted_on_fileid)
+		    inode->i_ino == fattr->mounted_on_fileid)
 			return 0;
 		printk(KERN_ERR "NFS: server %s error: fileid changed\n"
 			"fsid %s: expected fileid 0x%Lx, got 0x%Lx\n",
 			NFS_SERVER(inode)->nfs_client->cl_hostname,
-			inode->i_sb->s_id, (long long)nfsi->fileid,
+			inode->i_sb->s_id, (long long)inode->i_ino,
 			(long long)fattr->fileid);
 		goto out_err;
 	}
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 4623262da3c0..8e48053b3069 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -396,12 +396,12 @@ static inline int NFS_STALE(const struct inode *inode)
 
 static inline __u64 NFS_FILEID(const struct inode *inode)
 {
-	return NFS_I(inode)->fileid;
+	return inode->i_ino;
 }
 
 static inline void set_nfs_fileid(struct inode *inode, __u64 fileid)
 {
-	NFS_I(inode)->fileid = fileid;
+	inode->i_ino = fileid;
 }
 
 static inline void nfs_mark_for_revalidate(struct inode *inode)

-- 
2.54.0


